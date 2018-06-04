package com.tickets.controller.manager;

import com.tickets.model.Member;
import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.service.*;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/ticketsManager")
public class StatisticsController {

    @Autowired
    TheaterService theaterService;
    @Autowired
    MemberService memberService;
    @Autowired
    ShowService showService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/j{managerid}/statistics", method = RequestMethod.GET)
    public String balanceDetailPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        //场馆收入
        List<Theater> theaterList = theaterService.getTotalTheaterList();
        Map<String,Double> theaterIncomeMap=new HashMap<String, Double>();
        for(Theater theater:theaterList){
            double income=theaterService.getTheaterTotalIncome(theater.getTheaterid());
            theaterIncomeMap.put(theater.getName(),income);
        }
        modelMap.addAttribute("theaterIncomeMap",theaterIncomeMap);

        //演出类型
        Map<String,Integer> showTypeNumMap=new HashMap<String, Integer>();
        for(ShowType showType:ShowType.values()){
            if(showType==ShowType.All){
                break;
            }
            int showNum=showService.getShowNumInOneType(showType);
            showTypeNumMap.put(showType.name(),showNum);
        }
        modelMap.addAttribute("showTypeNumMap",showTypeNumMap);

        //演出收入
        List<Map.Entry<String, Double>> showIncomeMapList=showService.getTop10ShowIncome();
        modelMap.addAttribute("showIncomeMapList",showIncomeMapList);

        //会员等级占比
        List<Integer> memberLevelNumList=memberService.getLevelMemberNumList();
        modelMap.addAttribute("memberLevelNumList",memberLevelNumList);

        //会员前十消费金额
        List<Member> top10MemberList=memberService.getTop10ConsumeMemberList();
        modelMap.addAttribute("top10MemberList",top10MemberList);

        return "manager/statistics";
    }

}
