package com.tickets.controller.theater;

import com.tickets.dao.BaseDao;
import com.tickets.model.*;
import com.tickets.service.BalanceService;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.OrderState;
import com.tickets.util.SeatFormat;
import com.tickets.util.ShowType;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/theater")
public class ShowController {

    @Autowired
    ShowService showService;
    @Autowired
    BalanceService balanceService;
    @Autowired
    OrderService orderService;

    /*
    某影院的演出列表页面
     */
    @RequestMapping(value = "/j{theaterid}/showList", method = RequestMethod.GET)
    public String showListPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        String theaterid=((Theater)request.getSession().getAttribute("theater")).getTheaterid();
        String showState = request.getParameter("showState");//All,NotOnSale,OnSale,NotPay,Payed
        List<Show> showArrayList=null;
        if(showState==null){
            showArrayList=new ArrayList<Show>();
        }else if(showState.equals("All")){
            showArrayList=showService.getShowList(theaterid);
        }else if(showState.equals("NotOnSale")){
            showArrayList=showService.getNotOnSaleList(theaterid);
        }else if(showState.equals("OnSale")){
            showArrayList=showService.getOnSaleList(theaterid);
        }else if(showState.equals("NotPay")){
            showArrayList=balanceService.getNotPayShowList(theaterid);
        }else if(showState.equals("Payed")){
            showArrayList=balanceService.getPayedShowList(theaterid);
        }
        modelMap.addAttribute("showList",showArrayList);
        return "theater/showList";
    }

    /*
    某演出的详情页面
     */
    @RequestMapping(value = "/j{theaterid}/show/j{showid}",method = RequestMethod.GET)
    public String showDetailPage(@PathVariable String showid, HttpServletRequest request, ModelMap modelMap,HttpServletResponse response){
        Show show = showService.getShow(Integer.valueOf(showid));
        modelMap.addAttribute("show",show);
        String showState=null;
        if(!show.isIsopen()){
            showState = "NotOnSale";
        }
        Balance balance=balanceService.getBalance(Integer.valueOf(showid));
        if(balance==null){
            showState = "OnSale";
        }else if(!balance.isState()){
            showState="Notpay";
        }else{
            showState="Payed";
        }
        modelMap.addAttribute("showState",showState);
        
        int showType = show.getType();
        String showTypeStr=null;
        if(showType==0){
            showTypeStr="电影";
        }else if(showType==1) {
            showTypeStr="音乐剧";
        }else if(showType==2) {
            showTypeStr="话剧";
        }else if(showType==3){
            showTypeStr="舞蹈";
        }else if(showType==4){
            showTypeStr="体育比赛";
        }else if(showType==5){
            showTypeStr="演唱会";
        }
        modelMap.addAttribute("showTypeStr",showTypeStr);
        
        List<ShowTime> showTimeList = showService.getShowTimeList(Integer.valueOf(showid));
        modelMap.addAttribute("showTimeList",showTimeList);
        
        List<String> dateTimeList=new ArrayList<String>();
        for(ShowTime showTime:showTimeList){
            SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
            String dateTimeStr=sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime());
            dateTimeList.add(dateTimeStr);
        }
        modelMap.addAttribute("dateTimeList",dateTimeList);

        //获得当前选择的场次
        int dateIndex = Integer.valueOf(request.getParameter("dateIndex"));
        ShowTime showTime =showTimeList.get(dateIndex);
        modelMap.addAttribute("showTime",showTime);

        List<String[]> seatList= SeatFormat.formatSeat(showTimeList);
        modelMap.addAttribute("seat", new JSONArray(seatList.get(dateIndex)));

        //获得当前场次的订单
        List<Order> orderList = orderService.getShowTimeOrderList(showTime.getShowtimeid());
        modelMap.addAttribute("orderList",orderList);
        List<List<OrderSeat>> orderSeatsList=new ArrayList<List<OrderSeat>>();
        for(Order order:orderList){
            List<OrderSeat> orderSeatList=orderService.getOrderSeatList(order.getOrderid());
            orderSeatsList.add(orderSeatList);
        }
        modelMap.addAttribute("orderSeatsList",orderSeatsList);

        //该演出的结算情况
        if(balance!=null) {
            modelMap.addAttribute("balance", balance);
            Double showIncome = orderService.getShowIncome(show.getShowid());
            modelMap.addAttribute("showIncome", showIncome);
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
            modelMap.addAttribute("showtimeIncomeList", showtimeIncomeList);
            modelMap.addAttribute("showtimeSeatNumList",showtimeSeatNumList);
        }
        return "theater/showDetail";
    }



}
