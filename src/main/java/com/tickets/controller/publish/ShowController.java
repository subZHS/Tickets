package com.tickets.controller.publish;

import com.tickets.model.Show;
import com.tickets.model.ShowTime;
import com.tickets.model.Theater;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.ShowType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller("PublishShowController") //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/publish")
public class ShowController {

    @Autowired
    TheaterService theaterService;
    @Autowired
    ShowService showService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String homePage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        return "home";
    }

    @RequestMapping(value = "/showList", method = RequestMethod.GET)
    public String publishShowListPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        modelMap.addAttribute("isOpen",request.getParameter("isOpen"));
        modelMap.addAttribute("showType",request.getParameter("showType"));
        modelMap.addAttribute("orderType",request.getParameter("orderType"));
        Boolean isOpen = Boolean.valueOf(request.getParameter("isOpen"));
        ShowType showType = ShowType.valueOf(request.getParameter("showType"));
        String orderType = request.getParameter("orderType");
        boolean orderByHeatOrPrice=true;
        if(orderType.equals("heat")){
            orderByHeatOrPrice=true;
        }else if(orderType.equals("price")){
            orderByHeatOrPrice=false;
        }
        List<Show> showList=showService.getfilterShowList(isOpen,showType,orderByHeatOrPrice);
        modelMap.addAttribute("showList",showList);

        List<String> showTypeList=new ArrayList<String>();
        List<Integer> seatNumList=new ArrayList<Integer>();
        List<String> theaterNameList=new ArrayList<String>();
        List<String> theaterIdList=new ArrayList<String>();
        for(Show show:showList){
            showTypeList.add(getShowTypeStr(show.getType()));
            seatNumList.add(orderService.getValidSeatNumInOneShow(show.getShowid()));
            Theater theater=theaterService.getTheater(show.getTheaterid());
            theaterNameList.add(theater.getName());
            theaterIdList.add(theater.getTheaterid());
        }
        modelMap.addAttribute("showTypeList",showTypeList);
        modelMap.addAttribute("seatNumList",seatNumList);
        modelMap.addAttribute("theaterNameList",theaterNameList);
        modelMap.addAttribute("theaterIdList",theaterIdList);
        return "member/showList";
    }

    @RequestMapping(value = "/theater/j{theaterid}/show/j{showid}", method = RequestMethod.GET)
    public String publishShowDetailPage(@PathVariable String theaterid, @PathVariable String showid,HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        Theater theater = theaterService.getTheater(theaterid);
        modelMap.addAttribute("theater",theater);

        List<Show> showList = showService.getNotPassList(theaterid);
        modelMap.addAttribute("showList",showList);

        if(showList.size()==0){
            return "member/theaterDetail";
        }

        Show show = showService.getShow(Integer.valueOf(showid));
        modelMap.addAttribute("show",show);
        int showType = show.getType();
        String showTypeStr=getShowTypeStr(showType);
        modelMap.addAttribute("showTypeStr",showTypeStr);
        double minPrice = showService.findMinPrice(show.getPrice1(),show.getPrice2(),show.getPrice3());
        modelMap.addAttribute("minPrice",minPrice);

        List<Date> dateList = showService.getDateList(show.getShowid());
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        List<String> dateStrList = new ArrayList<String>();
        for(Date date:dateList){
            dateStrList.add(sdf.format(date));
        }
        modelMap.addAttribute("dateStrList",dateStrList);

        String dateStr =request.getParameter("date");
        if(dateStr==null){
            dateStr = sdf.format(showService.getShowTimeList(show.getShowid()).get(0).getDate());
        }
        modelMap.addAttribute("date",dateStr);

        Date date= null;
        try {
            date = new Date(sdf.parse(dateStr).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<ShowTime> showTimeList = showService.getShowTimeList(show.getShowid(), date);
        modelMap.addAttribute("showTimeList",showTimeList);
        return "member/theaterDetail";
    }

    private String getShowTypeStr(int showType){
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
        return showTypeStr;
    }

}
