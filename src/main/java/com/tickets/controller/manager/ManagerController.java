package com.tickets.controller.manager;

import com.tickets.model.Theater;
import com.tickets.model.TheaterModify;
import com.tickets.service.TheaterService;
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
import java.util.ArrayList;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/ticketsManager")
public class ManagerController {

    @Autowired
    TheaterService theaterService;

    @RequestMapping(value = "/j{managerid}/checkList", method = RequestMethod.GET)
    public String loginManagerPage(@PathVariable String managerid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        modelMap.addAttribute("managerid",managerid);
        String checkType = request.getParameter("checkType");
        if(checkType.equals("signUpTheater")){
            List<Theater> signUpTheaterList=theaterService.getSignUpTheaterList();
            modelMap.addAttribute("signUpTheaterList",signUpTheaterList);
        }else if(checkType.equals("modifyTheater")){
            List<TheaterModify> theaterModifyList=theaterService.getTheaterModifyList();
            List<Theater> modifyOriginalTheaterList = new ArrayList<Theater>();
            for(TheaterModify theaterModify:theaterModifyList){
                modifyOriginalTheaterList.add(theaterService.getTheater(theaterModify.getTheaterid()));
            }
            modelMap.addAttribute("theaterModifyList",theaterModifyList);
            modelMap.addAttribute("modifyOriginalTheaterList",modifyOriginalTheaterList);
        }
        return "manager/checkList";
    }

    @RequestMapping(value = "/j{managerid}/passSignUp", method = RequestMethod.POST)
    @ResponseBody
    public Boolean passSignUp(@PathVariable String managerid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String theaterid = request.getParameter("theaterid");
        return theaterService.passSignUp(theaterid);
    }

    @RequestMapping(value = "/j{managerid}/rejectSignUp", method = RequestMethod.POST)
    @ResponseBody
    public Boolean rejectSignUp(@PathVariable String managerid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String theaterid = request.getParameter("theaterid");
        return theaterService.rejectSignUp(theaterid);
    }

}
