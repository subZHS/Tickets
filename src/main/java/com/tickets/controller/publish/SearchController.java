package com.tickets.controller.publish;

import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.ShowType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/publish")
public class SearchController {

    @Autowired
    TheaterService theaterService;
    @Autowired
    ShowService showService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/searchResult", method = RequestMethod.GET)
    public String publishShowListPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String searchKey = request.getParameter("key");
        //电影列表
        List<Show> showList=showService.searchShowList(searchKey);
        modelMap.addAttribute("showList",showList);

        List<String> showTypeList=new ArrayList<String>();
        List<String> theaterNameList=new ArrayList<String>();
        List<String> theaterIdList=new ArrayList<String>();
        for(Show show:showList){
            showTypeList.add(getShowTypeStr(show.getType()));
            Theater theater=theaterService.getTheater(show.getTheaterid());
            theaterNameList.add(theater.getName());
            theaterIdList.add(theater.getTheaterid());
        }
        modelMap.addAttribute("showTypeList",showTypeList);
        modelMap.addAttribute("theaterNameList",theaterNameList);
        modelMap.addAttribute("theaterIdList",theaterIdList);

        //影院列表
        List<Theater> theaterList = theaterService.searchTheaterList(searchKey);

        modelMap.addAttribute("theaterList",theaterList);
        return "member/searchResult";
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
