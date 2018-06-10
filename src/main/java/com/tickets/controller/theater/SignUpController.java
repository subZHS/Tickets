package com.tickets.controller.theater;

import com.tickets.model.Theater;
import com.tickets.service.TheaterService;
import com.tickets.util.MailUtil;
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
import java.util.HashMap;
import java.util.Map;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/theater")
public class SignUpController {

    @Autowired
    TheaterService theaterService;

    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String signupPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        return "theater/signup";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String signupTheater(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException{
        try {
            Theater theater = new Theater();
            String email = request.getParameter("email");
            theater.setEmail(email);
            theater.setName(request.getParameter("name"));
            theater.setPassword(request.getParameter("password"));
            theater.setLocation(request.getParameter("location"));
            theater.setPhonenum(request.getParameter("phonenum"));
            theater.setAlipayid(request.getParameter("alipayid"));
            theater.setSeat(request.getParameter("seat"));
            theater.setImage("/resources/images/not-head.png");
            theater.setRowdivide1(Integer.valueOf(request.getParameter("divide1")));
            theater.setRowdivide2(Integer.valueOf(request.getParameter("divide2")));

            String theaterid = theaterService.signup(theater);
            if (theaterid != null) {//发邮件
                sendEmail(email, "theater", theaterid);
            }
            return theaterid;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    private void sendEmail(String email, String userType, String theaterid){
        String link="http://localhost:8080/verifyEmail?usertype="+userType+"&id="+theaterid;
        new Thread(new MailUtil(email, link, theaterid)).start();
    }
}
