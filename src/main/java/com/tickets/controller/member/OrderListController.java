package com.tickets.controller.member;

import com.tickets.model.*;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.OrderState;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/member")
public class OrderListController {

    @Autowired
    OrderService orderService;
    @Autowired
    ShowService showService;
    @Autowired
    TheaterService theaterService;

    @RequestMapping(value = "/j{memberid}/orderList", method = RequestMethod.GET)
    public String loginMemberPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        String memberid=((Member)request.getSession().getAttribute("member")).getMemberid();
        OrderState orderState = OrderState.valueOf(request.getParameter("orderState"));
        List<Order> orderList = orderService.getOrderList(memberid,orderState);
        List<Show> showList = new ArrayList<Show>();
        List<String> dateTimeList=new ArrayList<String>();
        List<String> theaterNameList=new ArrayList<String>();
        List<String> theaterIdList=new ArrayList<String>();
        List<List<OrderSeat>> orderSeatsList=new ArrayList<List<OrderSeat>>();
        SimpleDateFormat sdfDate= new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfTime= new SimpleDateFormat("HH:mm");
        for(Order order:orderList){
            ShowTime showTime=showService.getShowTime(order.getShowtimeid());
            Show show=showService.getShow(showTime.getShowid());
            showList.add(show);
            dateTimeList.add(sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime()));
            Theater theater=theaterService.getTheater(show.getTheaterid());
            theaterNameList.add(theater.getName());
            theaterIdList.add(theater.getTheaterid());
            List<OrderSeat> orderSeatList=orderService.getOrderSeatList(order.getOrderid());
            orderSeatsList.add(orderSeatList);
        }
        modelMap.addAttribute("theaterNameList",theaterNameList);
        modelMap.addAttribute("theaterIdList",theaterIdList);
        modelMap.addAttribute("showList",showList);
        modelMap.addAttribute("dateTimeList",dateTimeList);
        modelMap.addAttribute("orderSeatsList",orderSeatsList);
        modelMap.addAttribute("orderList",orderList);
        return "member/orderList";
    }

}
