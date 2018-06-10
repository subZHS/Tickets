package com.tickets.controller.publish;

import com.tickets.model.Show;
import com.tickets.model.ShowTime;
import com.tickets.model.Theater;
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
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/publish")
public class TheaterController {

    @Autowired
    TheaterService theaterService;
    @Autowired
    ShowService showService;

    @RequestMapping(value = "/theaterList", method = RequestMethod.GET)
    public String publishTheaterListPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String orderType = request.getParameter("orderType");
        Map<String,Integer> heatTheaterMap = theaterService.orderByHeatTheaterList();
        Map<String,Integer> showNumTheaterMap = theaterService.orderByShowNumTheaterList();
        Map<String,Double> minPriceTheaterMap = theaterService.orderByMinPriceTheaterList();
        List<Theater> theaterList = new ArrayList<Theater>();
        if(orderType.equals("heat")){
            List<Map.Entry<String, Integer>> heatTheaterMapList = new ArrayList<Map.Entry<String, Integer>>(heatTheaterMap.entrySet());
            Collections.sort(heatTheaterMapList, new Comparator<Map.Entry<String, Integer>>() {
                public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                    return o2.getValue().compareTo(o1.getValue());
                }
            });
            for(Map.Entry<String,Integer> heatTheater:heatTheaterMapList){
                String theaterid=heatTheater.getKey();
                Theater theater = theaterService.getTheater(theaterid);
                theaterList.add(theater);
            }
        }else if(orderType.equals("showNum")){
            List<Map.Entry<String, Integer>> showNumTheaterMapList = new ArrayList<Map.Entry<String, Integer>>(showNumTheaterMap.entrySet());
            Collections.sort(showNumTheaterMapList, new Comparator<Map.Entry<String, Integer>>() {
                public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                    return o2.getValue().compareTo(o1.getValue());
                }
            });
            for(Map.Entry<String,Integer> showNumTheater:showNumTheaterMapList){
                String theaterid=showNumTheater.getKey();
                Theater theater = theaterService.getTheater(theaterid);
                theaterList.add(theater);
            }
        }else if(orderType.equals("minPrice")){
            List<Map.Entry<String, Double>> minPriceTheaterMapList = new ArrayList<Map.Entry<String, Double>>(minPriceTheaterMap.entrySet());
            Collections.sort(minPriceTheaterMapList, new Comparator<Map.Entry<String, Double>>() {
                public int compare(Map.Entry<String, Double> o1, Map.Entry<String, Double> o2) {
                    if(o1.getValue()<0){
                        return 1;// 返回值为int类型，大于0表示正序，小于0表示逆序
                    }
                    if(o2.getValue()<0){
                        return -1;
                    }
                    return o1.getValue().compareTo(o2.getValue());
                }
            });
            for(Map.Entry<String,Double> minPriceTheater:minPriceTheaterMapList){
                String theaterid=minPriceTheater.getKey();
                Theater theater = theaterService.getTheater(theaterid);
                theaterList.add(theater);
            }
        }
        modelMap.addAttribute("theaterList",theaterList);
        modelMap.addAttribute("heatTheaterMap",heatTheaterMap);
        modelMap.addAttribute("showNumTheaterMap",showNumTheaterMap);
        modelMap.addAttribute("minPriceTheaterMap",minPriceTheaterMap);
        return "member/theaterList";
    }

    @RequestMapping(value = "/theater/j{theaterid}", method = RequestMethod.GET)
    public String publishTheaterDetailPage(@PathVariable String theaterid,HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        List<Show> showList = showService.getNotPassList(theaterid);
        modelMap.addAttribute("showList",showList);
        int showid=-1;
        if(showList.size()!=0) {
             showid= showList.get(0).getShowid();
        }
        return "redirect:/publish/theater/j"+theaterid+"/show/j"+showid;
    }

}
