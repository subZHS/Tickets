package com.tickets.controller.manager;

import com.tickets.model.*;
import com.tickets.service.BalanceService;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
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
import java.util.ArrayList;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/ticketsManager")
public class BalanceDetailController {

    @Autowired
    TheaterService theaterService;
    @Autowired
    BalanceService balanceService;
    @Autowired
    ShowService showService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/j{managerid}/balance/j{showid}", method = RequestMethod.GET)
    public String balanceDetailPage(@PathVariable String managerid,@PathVariable String showid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        modelMap.addAttribute("managerid",managerid);
        Balance balance = balanceService.getBalance(Integer.valueOf(showid));
        Show show = showService.getShow(Integer.valueOf(showid));

        String showTypeStr = null;
        int showType = show.getType();
        if(showType==0){
            showTypeStr="电影";
        }else if(showType==1) {
            showTypeStr="舞台剧";
        }else if(showType==2) {
            showTypeStr="戏剧";
        }else if(showType==3){
            showTypeStr="舞蹈";
        }else if(showType==4){
            showTypeStr="体育比赛";
        }else if(showType==5){
            showTypeStr="演唱会";
        }

        List<ShowTime> showTimeList = showService.getShowTimeList(Integer.valueOf(showid));

        List<String> dateTimeList=new ArrayList<String>();
        for(ShowTime showTime:showTimeList){
            SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
            String dateTimeStr=sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime());
            dateTimeList.add(dateTimeStr);
        }

        Theater theater =theaterService.getTheater(show.getTheaterid());

        List<Double> showtimeIncomeList = new ArrayList<Double>();
        List<Integer> showtimeSeatNumList = new ArrayList<Integer>();
        for (ShowTime showTime1 : showTimeList) {
            List<Order> orderList1 = orderService.getShowTimeOrderList(showTime1.getShowtimeid());
            double showtimeIncome = 0;
            int seatNum=0;
            for (Order order : orderList1) {
                if (OrderState.values()[order.getState()] == OrderState.WaitCheck || OrderState.values()[order.getState()] == OrderState.HaveChecked) {
                    showtimeIncome += order.getPrice();
                    seatNum+=order.getNumber();
                }
            }
            showtimeIncomeList.add(showtimeIncome);
            showtimeSeatNumList.add(seatNum);
        }

        modelMap.addAttribute("balance",balance);
        modelMap.addAttribute("show",show);
        modelMap.addAttribute("showTypeStr",showTypeStr);
        modelMap.addAttribute("dateTimeList",dateTimeList);
        modelMap.addAttribute("theater",theater);
        modelMap.addAttribute("showtimeIncomeList",showtimeIncomeList);
        modelMap.addAttribute("showtimeSeatNumList",showtimeSeatNumList);

        return "manager/balanceDetail";
    }

    @RequestMapping(value = "/j{managerid}/balance/j{showid}/pay", method = RequestMethod.POST)
    @ResponseBody
    public Boolean payBalance(@PathVariable String showid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String password = request.getParameter("password");
        return balanceService.payBalance(Integer.valueOf(showid),password);
    }

}
