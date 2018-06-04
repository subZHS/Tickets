package com.tickets.controller.manager;

import com.tickets.model.Balance;
import com.tickets.model.Show;
import com.tickets.model.ShowTime;
import com.tickets.model.Theater;
import com.tickets.service.BalanceService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/ticketsManager")
public class BalanceListController {

    @Autowired
    TheaterService theaterService;
    @Autowired
    BalanceService balanceService;
    @Autowired
    ShowService showService;

    @RequestMapping(value = "/j{managerid}/balanceList", method = RequestMethod.GET)
    public String balanceListPage(@PathVariable String managerid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        modelMap.addAttribute("managerid",managerid);
        String balanceType = request.getParameter("balanceType");
        List<Balance> balanceList=null;
        if(balanceType.equals("notPay")){
            balanceList = balanceService.getNotPayBalanceList();
        }else if(balanceType.equals("payed")){
            balanceList = balanceService.getPayedBalanceList();
        }
        List<Show> showList = new ArrayList<Show>();
        List<String> showTypeList = new ArrayList<String>();
        List<List<String>> dateTimesList =new ArrayList<List<String>>();
        List<String> theaterNameList = new ArrayList<String>();
        List<String> theaterIdList = new ArrayList<String>();
        for(Balance balance:balanceList){
            Show show = showService.getShow(balance.getShowid());
            showList.add(show);

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
            showTypeList.add(showTypeStr);

            List<ShowTime> showTimeList = showService.getShowTimeList(balance.getShowid());
            List<String> dateTimeList=new ArrayList<String>();
            for(ShowTime showTime:showTimeList){
                SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
                String dateTimeStr=sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime());
                dateTimeList.add(dateTimeStr);
            }
            dateTimesList.add(dateTimeList);

            Theater theater =theaterService.getTheater(show.getTheaterid());
            theaterNameList.add(theater.getName());
            theaterIdList.add(theater.getTheaterid());
        }
        modelMap.addAttribute("balanceList",balanceList);
        modelMap.addAttribute("showList",showList);
        modelMap.addAttribute("showTypeList",showTypeList);
        modelMap.addAttribute("dateTimesList",dateTimesList);
        modelMap.addAttribute("theaterNameList",theaterNameList);
        modelMap.addAttribute("theaterIdList",theaterIdList);
        return "manager/balanceList";
    }

}
