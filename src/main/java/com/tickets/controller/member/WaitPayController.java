package com.tickets.controller.member;

import com.tickets.model.*;
import com.tickets.service.*;
import com.tickets.util.CancelOrder;
import com.tickets.util.PayMessage;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/member")
public class WaitPayController {

    @Autowired
    OrderService orderService;
    @Autowired
    MemberService memberService;
    @Autowired
    ShowService showService;
    @Autowired
    TheaterService theaterService;
    @Autowired
    AlipayService alipayService;

    @RequestMapping(value = "/j{memberid}/order/j{orderid}/waitPay", method = RequestMethod.GET)
    public String waitPayOrderPage(@PathVariable String orderid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        Order order=orderService.getOrder(orderid);

        List<OrderSeat> orderSeatList=orderService.getOrderSeatList(orderid);
        ShowTime showTime = showService.getShowTime(order.getShowtimeid());
        Show show=showService.getShow(showTime.getShowid());
        SimpleDateFormat sdfDate= new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfTime= new SimpleDateFormat("HH:mm");
        String showTimeStr=sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime());
        Theater theater = theaterService.getTheater(show.getTheaterid());
        modelMap.addAttribute("order",order);
        modelMap.addAttribute("orderSeatList",orderSeatList);
        modelMap.addAttribute("show",show);
        modelMap.addAttribute("showTimeStr",showTimeStr);
        modelMap.addAttribute("theaterName",theater.getName());
        modelMap.addAttribute("theaterId",theater.getTheaterid());
        return "member/waitPay";
    }

    @RequestMapping(value = "/j{memberid}/order/j{orderid}/payOrder", method = RequestMethod.POST)
    @ResponseBody
    public Object payOrder(@PathVariable String orderid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String alipayid=request.getParameter("alipayid");
        String password=request.getParameter("password");
        PayMessage payMessage=alipayService.payOrder(orderid,alipayid,password);
        Map<String,String> payResult=new HashMap<String, String>();
        if(payMessage==PayMessage.Success){
            payResult.put("sucess","true");
        }else{
            payResult.put("success","false");
            payResult.put("message",payMessage.name());
        }
        return payResult;
    }

    @RequestMapping(value = "/j{memberid}/order/j{orderid}/cancelOrder", method = RequestMethod.POST)
    @ResponseBody
    public Boolean cancelOrder(@PathVariable String orderid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        boolean cancelResult = orderService.cancelOrder(orderid);
        return cancelResult;
    }

}
