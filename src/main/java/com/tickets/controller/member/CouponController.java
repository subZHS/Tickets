package com.tickets.controller.member;

import com.tickets.model.Member;
import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.service.MemberService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
@RequestMapping("/member")
public class CouponController {

    @Autowired
    MemberService memberService;
    @Autowired
    ShowService showService;
    @Autowired
    TheaterService theaterService;

    @RequestMapping(value = "/j{memberid}/coupon", method = RequestMethod.GET)
    public String couponPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        Member member=memberService.getMember(((Member)request.getSession().getAttribute("member")).getMemberid());
        request.getSession().setAttribute("member",member);

        return "member/coupon";
    }

    @RequestMapping(value = "/j{memberid}/coupon/exchange", method = RequestMethod.GET)
    @ResponseBody
    public Boolean exchangeCoupon(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        int couponType=Integer.valueOf(request.getParameter("couponType"));
        int number = Integer.valueOf(request.getParameter("number"));
        String memberid=((Member)request.getSession().getAttribute("member")).getMemberid();
        System.out.println(couponType+" "+number);
        boolean success=memberService.exchangeCoupon(memberid,number,couponType);
        return success;
    }

}
