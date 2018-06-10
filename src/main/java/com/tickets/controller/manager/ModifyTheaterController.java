package com.tickets.controller.manager;

import com.tickets.model.Theater;
import com.tickets.model.TheaterModify;
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
import java.util.ArrayList;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/ticketsManager")
public class ModifyTheaterController {

    @Autowired
    TheaterService theaterService;

    @RequestMapping(value = "/j{managerid}/modifyTheater/j{theaterid}", method = RequestMethod.GET)
    public String modifyTheaterDetailPage(@PathVariable String managerid,@PathVariable String theaterid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        modelMap.addAttribute("managerid",managerid);
        Theater theater = theaterService.getTheater(theaterid);
        String[] theaterSeat = SeatFormat.formatSeatStr(theater.getSeat());
        TheaterModify theaterModify = theaterService.getTheaterModify(theaterid);
        String[] theaterModifySeat = SeatFormat.formatSeatStr(theaterModify.getSeat());
        modelMap.addAttribute("theater",theater);
        modelMap.addAttribute("theaterModify",theaterModify);
        modelMap.addAttribute("theaterSeat",new JSONArray(theaterSeat));
        modelMap.addAttribute("theaterModifySeat",new JSONArray(theaterModifySeat));
        return "manager/modifyDetail";
    }

    @RequestMapping(value = "/j{managerid}/passModify", method = RequestMethod.POST)
    @ResponseBody
    public Boolean passSignUp(@PathVariable String managerid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String theaterid = request.getParameter("theaterid");
        return theaterService.passModifyTheater(theaterid);
    }

    @RequestMapping(value = "/j{managerid}/rejectModify", method = RequestMethod.POST)
    @ResponseBody
    public Boolean rejectSignUp(@PathVariable String managerid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        String theaterid = request.getParameter("theaterid");
        return theaterService.rejectModifyTheater(theaterid);
    }

}
