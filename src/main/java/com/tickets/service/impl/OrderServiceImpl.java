package com.tickets.service.impl;

import com.tickets.dao.OrderDao;
import com.tickets.model.*;
import com.tickets.service.*;
import com.tickets.util.OrderState;
import com.tickets.util.RefundMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private ShowService showService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private AlipayService alipayService;

	@Autowired
	ManagerService managerService;

	/*
	计算所选择的订单的金额，如果是不选座购买，座位列表为null，在order中设置金额(调用ShowService的getPrice)，
	需要考虑会员等级优惠(调用MemberService的getDiscount)，和优惠券使用优惠(0表示没有)
	 */
	public double calculatePrice(String showtimeid, int number, List<OrderSeat> orderSeatList, String memberid, int couponType) {
		//得到原始价格
		double originalPrice=0;
		if(orderSeatList!=null&&orderSeatList.size()!=0){//选座购买
			orderSeatList = showService.calculateSeatPrice(showtimeid,orderSeatList);
			for(OrderSeat orderSeat:orderSeatList){
				originalPrice+=orderSeat.getPrice();
			}
		}else{//不选座购买
			originalPrice = showService.calculateNoSeatPrice(showtimeid,number);
		}
		//计算会员优惠
		double memberDiscount = memberService.getDiscount(memberid);
		//优惠券使用
		double couponDiscount=0;
		int[] couponTypeArray={1,2,3};
		int[] baseMoneyArray={10,30,50};
		int[] discountMoneyArray={1,5,10};
		for(int i=0;i<couponTypeArray.length;i++){
			if(couponType==couponTypeArray[i]&&originalPrice>baseMoneyArray[i]){
				couponDiscount=discountMoneyArray[i];
			}
		}

		//计算最终价格
		double finalPrice = originalPrice * memberDiscount - couponDiscount;
		return finalPrice;
	}

	/*
	生成订单，如果是不选座购买，座位列表为null，需要先调用计算金额确保是最新的状态，此时为未支付，
	然后先完善订单：生成订单号,再存储订单，订单座，需要添加消费总金额和积分,减去优惠券,然后在对应场次占位，返回订单号
	 */
	public String newOrder(Order order, List<OrderSeat> orderSeatList) {
		//生成订单号:用户邮箱@前部+showtimeid+time
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmm");
		String orderid = order.getMemberid().split("@")[0]+order.getShowtimeid()+sdf.format(order.getTime());
		order.setOrderid(orderid);

		//计算金额
		double price = calculatePrice(order.getShowtimeid(), order.getNumber(), orderSeatList, order.getMemberid(), order.getCoupontype());
		order.setPrice(price);

        //去对应位置占位
        if(!order.isOrdertype()){//非选座购买
            if(!showService.noSeatOccupy(order.getShowtimeid(),order.getNumber())){
                return null;
            }
        }else {
            if (!showService.occupySeat(order.getShowtimeid(), orderSeatList)) {
                return null;
            }
        }
		//存储订单
		if(!orderDao.save(order)){
			return null;
		}
		//存储订单座位
		if(orderSeatList!=null) {
			for (int i = 0; i < orderSeatList.size(); i++) {
				orderSeatList.get(i).setOrderid(orderid);
			}
			if (!orderDao.saveSeat(orderSeatList)) {
				return null;
			}
		}
		//添加积分,总金额，减去优惠券
		if(!memberService.afterConsume(order.getMemberid(), price, order.getCoupontype())){
			return null;
		}
		return orderid;
	}

	/*
	退订，先判断是否满足退订条件（未过演出时间，orderType是已付款），然后添加orderRefund记录，然后退款到该订单的付款的alipay，然后修改订单状态，最后释放占座
	 */
	public RefundMessage refundOrder(String orderid) {
		//判断是否满足退订条件（未过演出时间，orderType是已付款）
		Order order=getOrder(orderid);
		if(order.getState()!= OrderState.WaitCheck.ordinal()){
			return RefundMessage.NOTPayedAndUnChecked;
		}

		ShowTime showTime = showService.getShowTime(order.getShowtimeid());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdfTime = new SimpleDateFormat("HHmmss");
		Date showDate=null;
		try {
			showDate = sdf.parse(sdfDate.format(showTime.getDate())+sdfTime.format(showTime.getTime()));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(showDate.before(new Date())){
			return RefundMessage.PassShowTime;
		}

		//添加orderRefund记录
		OrderRefund orderRefund=new OrderRefund();
		orderRefund.setOrderid(orderid);
		Date curDate=new Date();
		orderRefund.setTime(curDate);
		//计算退票费
		Long betweenTime = showDate.getTime() - curDate.getTime();
		double feePercent=0;
		if(betweenTime < 15 * 1000 * 60){//15分钟内，不得退款
			return RefundMessage.InMinutes15;
		}else if(betweenTime>=15*1000*60&&betweenTime<2*1000*3600) {//15分钟前，2小时内，退款百分比10%
			feePercent=0.1;
		}else if(betweenTime>=2*1000*3600&&betweenTime<1000*3600*24){//2小时前，1天内，退款百分比5%
			feePercent=0.05;
		}else{//1天外，退款费0
			feePercent=0;
		}
		orderRefund.setFee(order.getPrice()*feePercent);
		if(!orderDao.saveRefund(orderRefund)){
			return RefundMessage.SaveFail;
		}

		//退款
		String fromAlipayid = managerService.getManager().getAlipayid();
		if(!alipayService.transferMoney(fromAlipayid,order.getAlipayid(),order.getPrice()-orderRefund.getFee())){
			return RefundMessage.NotEnoughMoney;
		}
		//修改订单状态
		changeOrderState(orderid,OrderState.Refunded.ordinal());
		//恢复优惠券,消费金额，积分
		if(!memberService.recoverConsume(order.getMemberid(),order.getPrice(),order.getCoupontype())){
			return RefundMessage.SaveFail;
		}
		//释放占座
		List<OrderSeat> orderSeatList = orderDao.findSeat(orderid);
		if(!showService.releaseOccupy(order.getShowtimeid(), orderSeatList,order.getNumber())){
			return RefundMessage.SaveFail;
		}
		return RefundMessage.Success;
	}

	/*
	支付时间超时，执行订单取消，修改订单状态，恢复总金额积分和优惠券,然后释放占座
	 */
	public boolean cancelOrder(String orderid) {
		Order order = getOrder(orderid);
		if(order.getState()!=0){
			return true;
		}
		//修改订单状态
		if(!changeOrderState(orderid, OrderState.PassPayTime.ordinal())){
			return false;
		}
		//恢复优惠券,消费金额，积分
		if(!memberService.recoverConsume(order.getMemberid(),order.getPrice(),order.getCoupontype())){
			return false;
		}
		//释放占座
		List<OrderSeat> orderSeatList = orderDao.findSeat(orderid);
		if(!showService.releaseOccupy(order.getShowtimeid(), orderSeatList,order.getNumber())){
			return false;
		}
		return true;
	}

	/*
	检票，给立即购买的分配座位且占座且保存所占的座位，然后修改订单状态
	 */
	public List<OrderSeat> checkTickets(String orderid) {
		Order order = getOrder(orderid);
		//修改订单状态
		if(!changeOrderState(orderid,OrderState.HaveChecked.ordinal())){
			return null;
		}
		List<OrderSeat> orderSeatList=getOrderSeatList(orderid);
		//如果是立即购买
		if(!order.isOrdertype()){
			orderSeatList=showService.distributeSeat(orderid,order.getNumber());
		}
		return orderSeatList;
	}

	public boolean changeOrderState(String orderid, int state) {
		Order order=getOrder(orderid);
		order.setState(state);
		return orderDao.updateById(order);
	}

	public List<Order> getShowTimeOrderList(String showtimeid){
		List<Order> orderList = orderDao.find("showtimeid", showtimeid);
		if(orderList==null){
			orderList=new ArrayList<Order>();
		}
		return orderList;
	}

	/*
	按订单状态获取订单列表（state为5是指全部状态）
	 */
	public List<Order> getOrderList(String memberid, OrderState state) {
		//检查超时订单
		cancelPassTimeOrder(memberid);
		List<Order> orderList;
		if(state==OrderState.All){
			orderList= orderDao.find("memberid",memberid);
		}else{
			orderList= orderDao.find("memberid",memberid,"state",state.ordinal());
		}
		if(orderList==null){
			orderList=new ArrayList<Order>();
		}
		return orderList;
	}

	public Order getOrder(String orderid) {
		return orderDao.find(orderid);
	}

	public List<OrderSeat> getOrderSeatList(String orderid) {
		return orderDao.findSeat(orderid);
	}

	public OrderRefund getOrderRefund(String orderid) {
		return orderDao.findRefund(orderid);
	}

	public Double getShowIncome(int showid) {
		List<Order> orderList=orderDao.findValidOrderListInOneShow(showid);
		double totalIncome = 0;
		if(orderList==null){
			orderList=new ArrayList<Order>();
		}
		for(Order order:orderList){
			if(OrderState.values()[order.getState()]==OrderState.WaitCheck||OrderState.values()[order.getState()]==OrderState.HaveChecked) {
				totalIncome += order.getPrice();
			}
		}
		return totalIncome;
	}

	public boolean saveOrderSeatList(List<OrderSeat> orderSeatList) {
		return orderDao.saveSeat(orderSeatList);
	}

	public boolean setOrderAlipay(String orderid, String alipayid) {
		Order order=getOrder(orderid);
		order.setAlipayid(alipayid);
		return orderDao.updateById(order);
	}

	public int getTheaterSaleSeatNum(String theaterid) {
		return orderDao.findSeatNumInOneTheater(theaterid);
	}

	public int getValidSeatNumInOneShow(int showid) {
		List<Order> orderList=orderDao.findValidOrderListInOneShow(showid);
		int seatNum=0;
		if(orderList==null){
			return seatNum;
		}else{
			for(Order order:orderList){
				seatNum+=order.getNumber();
			}
			return seatNum;
		}
	}

	/*
	访问个人订单列表时，循环等待支付订单，如果超时取消订单
	 */
	public void cancelPassTimeOrder(String memberid){
		List<Order> passTimeOrderList=orderDao.find("memberid",memberid,"state",0);
		Date curDate=new Date();
		for(Order order:passTimeOrderList){
			if(curDate.getTime()-order.getTime().getTime()>1000*60*5){
				cancelOrder(order.getOrderid());
			}
		}
	}
}
