package com.tickets.controller.theater;

import com.tickets.model.Order;
import com.tickets.model.OrderSeat;
import com.tickets.model.Show;
import com.tickets.model.ShowTime;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.util.OrderState;
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
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/theater")
public class CheckTicketsController {

    @Autowired
    OrderService orderService;
    @Autowired
    ShowService showService;

    @RequestMapping(value = "/j{theaterid}/checkTickets", method = RequestMethod.GET)
    public String checkTicketsPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String orderid=request.getParameter("orderid");
        if(orderid!=null){
            Order order=orderService.getOrder(orderid);
            if(order!=null) {
                if(OrderState.values()[order.getState()]== OrderState.WaitCheck||OrderState.values()[order.getState()]== OrderState.HaveChecked) {
                    List<OrderSeat> orderSeatList=null;
                    if(OrderState.values()[order.getState()]== OrderState.WaitCheck) {
                        orderSeatList = orderService.checkTickets(orderid);
                    }else{
                        orderSeatList = orderService.getOrderSeatList(orderid);
                        modelMap.addAttribute("message",OrderState.values()[order.getState()]);
                    }
                    ShowTime showTime = showService.getShowTime(order.getShowtimeid());
                    Show show = showService.getShow(showTime.getShowid());
                    SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
                    SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
                    String dateTimeStr = sdfDate.format(showTime.getDate()) + " " + sdfTime.format(showTime.getTime());

                    modelMap.addAttribute("order", order);
                    modelMap.addAttribute("orderSeatList", orderSeatList);
                    modelMap.addAttribute("show", show);
                    modelMap.addAttribute("dateTimeStr", dateTimeStr);
                }else{
                    modelMap.addAttribute("message",OrderState.values()[order.getState()]);
                }
            }
        }
        return "theater/checkTickets";
    }

//    @RequestMapping(value = "/j{theaterid}/checkTickets", method = RequestMethod.POST)
//    @ResponseBody
//    public Boolean checkTickets(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
//        String orderid=request.getParameter("orderid");
//        return orderService.checkTickets(orderid);
//    }

}
