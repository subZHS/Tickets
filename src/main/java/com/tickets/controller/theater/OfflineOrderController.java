package com.tickets.controller.theater;

import com.tickets.model.*;
import com.tickets.service.MemberService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
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
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/theater")
public class OfflineOrderController {

    @Autowired
    ShowService showService;
    @Autowired
    TheaterService theaterService;
    @Autowired
    MemberService memberService;

    @RequestMapping(value = "/j{theaterid}/show/j{showid}/offlineOrder", method = RequestMethod.GET)
    public String offlineOrderPage(@PathVariable String theaterid,@PathVariable String showid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        modelMap.addAttribute("theaterid",((Theater)request.getSession().getAttribute("theater")).getTheaterid());
        Show show = showService.getShow(Integer.valueOf(showid));
        modelMap.addAttribute("show",show);

        List<ShowTime> showTimeList = showService.getShowTimeList(Integer.valueOf(showid));
        int index=Integer.valueOf(request.getParameter("dateIndex"));
        String showtimeid=showTimeList.get(index).getShowtimeid();
        modelMap.addAttribute("showtimeid",showtimeid);

        List<String> dateTimeList=new ArrayList<String>();
        for(ShowTime showTime:showTimeList){
            SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
            String dateTimeStr=sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime());
            dateTimeList.add(dateTimeStr);
        }
        modelMap.addAttribute("dateTimeList",dateTimeList);

        //得到价钱分界线
        Theater theater = theaterService.getTheater(theaterid);
        modelMap.addAttribute("divide1",theater.getRowdivide1());
        modelMap.addAttribute("divide2",theater.getRowdivide2());

        //座位情况
        List<String[]> seatList=SeatFormat.formatSeat(showTimeList);
        modelMap.addAttribute("seat", new JSONArray(seatList.get(index)));
        return "theater/offlineOrder";
    }

    @RequestMapping(value = "/j{theaterid}/show/j{showid}/offlineOrder", method = RequestMethod.POST)
    @ResponseBody
    public boolean offlineOrder(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response){
        String showtimeid=request.getParameter("showtimeid");
        Double price=Double.parseDouble(request.getParameter("price"));
        JSONArray jsonArray=new JSONArray(request.getParameter("seats"));
        List<OrderSeat> orderSeatList = new ArrayList<OrderSeat>();
        for(int i=0;i<jsonArray.length();i++){
            String seatid=jsonArray.get(i).toString();
            int row=Integer.valueOf(seatid.split("_")[0]);
            int column=Integer.valueOf(seatid.split("_")[1]);
            OrderSeat orderSeat=new OrderSeat();
            orderSeat.setSeatRow(row);
            orderSeat.setSeatColumn(column);
            orderSeatList.add(orderSeat);
        }

        return showService.offlineOrder(showtimeid,orderSeatList);
    }

    @RequestMapping(value = "/getMemberDiscount", method = RequestMethod.GET)
    @ResponseBody
    public Double getMemberDiscount(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response){
        String memberid=request.getParameter("memberid");
        return memberService.getDiscount(memberid);
    }

}
