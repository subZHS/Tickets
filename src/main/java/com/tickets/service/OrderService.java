package com.tickets.service;

import com.tickets.model.Order;
import com.tickets.model.OrderRefund;
import com.tickets.model.OrderSeat;
import com.tickets.util.OrderState;
import com.tickets.util.RefundMessage;

import java.util.List;

public interface OrderService {
	/*
	计算所选择的订单的金额，如果是不选座购买，座位列表为null，在order中设置金额(调用ShowService的getSeatPrice)，
	需要考虑会员等级优惠(调用MemberService的getDiscount)，和优惠券使用优惠(0表示没有)
	 */
	public double calculatePrice(String showtimeid, int number, List<OrderSeat> orderSeatList, String memberid, int couponType);

	/*
	生成订单，如果是不选座购买，座位列表为null，需要先调用计算金额确保是最新的状态，此时为未支付，再生成订单，需要减去优惠券,然后在对应场次占位,返回订单号
	 */
	public String newOrder(Order order, List<OrderSeat> orderSeatList);

	/*
	退订，先判断是否满足退订条件（未过演出时间，orderType是已付款），然后添加orderRefund记录，然后退款到该订单的付款的alipay，然后修改订单状态，最后释放占座
	 */
	public RefundMessage refundOrder(String orderid);

	/*
	支付时间超时，执行订单取消，修改订单状态，恢复优惠券,然后释放占座
	 */
	public boolean cancelOrder(String orderid);

	/*
	检票，给立即购买的分配座位且占座且保存所占的座位，然后修改订单状态
	 */
	public List<OrderSeat> checkTickets(String orderid);

	/*
	修改订单状态，情况：支付后，检票后，15分钟失效后，退订后
	 */
	public boolean changeOrderState(String orderid, int state);

	/*
	得到某场次的订单
	 */
	public List<Order> getShowTimeOrderList(String showtimeid);

	/*
	按订单类型，订单状态获取订单列表（state为5是指全部状态）
	 */
	public List<Order> getOrderList(String memberid, OrderState state);

	/*
	得到某个订单详情
	 */
	public Order getOrder(String orderid);

	/*
	得到某订单的座位列表
	 */
	public List<OrderSeat> getOrderSeatList(String orderid);

	/*
	得到某个退款订单的详情
	 */
	public OrderRefund getOrderRefund(String orderid);

	//同层调用

	public Double getShowIncome(int showid);

	/*
	在检票分配不选座购买的座位时调用，来保存分配的座位
	 */
	public boolean saveOrderSeatList(List<OrderSeat> orderSeatList);

	/*在订单支付时调用*/
	public boolean setOrderAlipay(String orderid, String alipayid);

	/*
	场馆出售的座位数量，即场馆热度
	 */
	public int getTheaterSaleSeatNum(String theaterid);

	public int getValidSeatNumInOneShow(int showid);

}
