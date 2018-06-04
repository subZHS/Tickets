package com.tickets.controller.member;

import com.tickets.model.*;
import com.tickets.service.MemberService;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.CancelOrder;
import com.tickets.util.SeatFormat;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/member")
public class BuyTicketsController {

    @Autowired
    MemberService memberService;
    @Autowired
    ShowService showService;
    @Autowired
    TheaterService theaterService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/j{memberid}/buyTickets/j{showtimeid}", method = RequestMethod.GET)
    public String offlineOrderPage(@PathVariable String showtimeid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String memberid=((Member)request.getSession().getAttribute("member")).getMemberid();
        Member member=memberService.getMember(memberid);
        request.getSession().setAttribute("member",member);

        Double discount=memberService.getDiscount(memberid);
        modelMap.addAttribute("discount",discount);

        ShowTime showTime = showService.getShowTime(showtimeid);
        Show show=showService.getShow(showTime.getShowid());
        modelMap.addAttribute("show",show);
        modelMap.addAttribute("showtimeid",showtimeid);

        SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
        String dateTime=sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime());
        modelMap.addAttribute("dateTime",dateTime);

        Theater theater = theaterService.getTheater(show.getTheaterid());
        modelMap.addAttribute("divide1",theater.getRowdivide1());
        modelMap.addAttribute("divide2",theater.getRowdivide2());

        //得到当前场次的座位情况
        ArrayList<ShowTime> showTimeList=new ArrayList<ShowTime>();
        showTimeList.add(showTime);
        List<String[]> seatList= SeatFormat.formatSeat(showTimeList);
        modelMap.addAttribute("seat", new JSONArray(seatList.get(0)));

        return "/member/buyTickets";
    }

    //计算选座购买的价格
    @RequestMapping(value = "/j{memberid}/buyTickets/j{showtimeid}/calculateSeatPrice", method = RequestMethod.GET)
    @ResponseBody
    public Double calculateOrderSeatPrice(@PathVariable String showtimeid, HttpServletRequest request, HttpServletResponse response) {
        String memberid = ((Member)request.getSession().getAttribute("member")).getMemberid();
        int couponType = Integer.valueOf(request.getParameter("couponType"));
        List<OrderSeat> orderSeatList=transformOrderSeatFromString(request.getParameter("seats"));

        return orderService.calculatePrice(showtimeid,orderSeatList.size(), orderSeatList,memberid,couponType);
    }

    @RequestMapping(value = "/j{memberid}/buyTickets/j{showtimeid}/submitSeatOrder", method = RequestMethod.POST)
    @ResponseBody
    public String submitSeatOrder(@PathVariable String showtimeid, HttpServletRequest request, HttpServletResponse response) {
        String memberid = ((Member)request.getSession().getAttribute("member")).getMemberid();
        int couponType = Integer.valueOf(request.getParameter("couponType"));
        List<OrderSeat> orderSeatList=transformOrderSeatFromString(request.getParameter("seats"));

        //生成订单
        Order order=new Order();
        order.setMemberid(memberid);
        order.setShowtimeid(showtimeid);
        order.setOrdertype(true);//选座购买
        order.setNumber(orderSeatList.size());
        order.setState(0);//待支付
        order.setTime(new Date());
        order.setDiscount(memberService.getDiscount(memberid));
        order.setCoupontype(couponType);

        String orderid = orderService.newOrder(order,orderSeatList);

        //开始定时任务
        new Thread(new CancelOrder(orderid,orderService)).start();

        if(orderid==null){
            return "null";
        }
        return orderid;
    }

    //计算非选座购买的价格
    @RequestMapping(value = "/j{memberid}/buyTickets/j{showtimeid}/calculateNoSeatPrice", method = RequestMethod.GET)
    @ResponseBody
    public Double calculateNoSeatPrice(@PathVariable String showtimeid, HttpServletRequest request, HttpServletResponse response) {
        String memberid = ((Member)request.getSession().getAttribute("member")).getMemberid();
        int couponType = Integer.valueOf(request.getParameter("couponType"));
        int number = Integer.valueOf(request.getParameter("number"));

        return orderService.calculatePrice(showtimeid,number, null,memberid,couponType);
    }

    @RequestMapping(value = "/j{memberid}/buyTickets/j{showtimeid}/submitNoSeatOrder", method = RequestMethod.POST)
    @ResponseBody
    public String submitNoSeatOrder(@PathVariable String showtimeid, HttpServletRequest request, HttpServletResponse response) {
        String memberid = ((Member)request.getSession().getAttribute("member")).getMemberid();
        int couponType = Integer.valueOf(request.getParameter("couponType"));
        int number = Integer.valueOf(request.getParameter("number"));

        //生成订单
        Order order=new Order();
        order.setMemberid(memberid);
        order.setShowtimeid(showtimeid);
        order.setOrdertype(false);//选座购买
        order.setNumber(number);
        order.setState(0);//待支付
        order.setTime(new Date());
        order.setDiscount(memberService.getDiscount(memberid));
        order.setCoupontype(couponType);

        String orderid = orderService.newOrder(order,null);
        if(orderid==null){
            return "null";
        }
        return orderid;
    }

    private List<OrderSeat> transformOrderSeatFromString(String seats){
        JSONArray jsonArray=new JSONArray(seats);
        List<OrderSeat> orderSeatList = new ArrayList<OrderSeat>();
        for(int i=0;i<jsonArray.length();i++){
            String seatid=jsonArray.get(i).toString();
            OrderSeat orderSeat=new OrderSeat();
            orderSeat.setSeatRow(Integer.valueOf(seatid.split("_")[0]));
            orderSeat.setSeatColumn(Integer.valueOf(seatid.split("_")[1]));
            orderSeatList.add(orderSeat);
        }
        return orderSeatList;
    }

}
