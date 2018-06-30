package com.tickets.controller;

import com.tickets.model.Manager;
import com.tickets.model.Member;
import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.service.*;
import com.tickets.util.LoginMessage;
import com.tickets.util.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/")
public class LoginController {

    private static final long serialVersionUID = 1L;
    @Autowired
    MemberService memberService;
    @Autowired
    TheaterService theaterService;
    @Autowired
    ManagerService managerService;
    @Autowired
    ShowService showService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String homePage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
        List<Show> top10ShowList=showService.getTop10ShowList();
        modelMap.addAttribute("top10ShowList",top10ShowList);
        List<String> showTypeList=new ArrayList<String>();
        List<Integer> seatNumList=new ArrayList<Integer>();
        List<String> theaterNameList=new ArrayList<String>();
        List<String> theaterIdList=new ArrayList<String>();
        for(Show show:top10ShowList){
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
        return "home";
    }

    @RequestMapping(value = "/checkMemberLogined", method = RequestMethod.GET)
    @ResponseBody
    public boolean checkMemberLogined(HttpServletRequest request, HttpServletResponse response){
        if(request.getSession().getAttribute("member")==null){
            return false;
        }else{
            return true;
        }
    }

    @RequestMapping(value = "/Login", method = RequestMethod.GET)
    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String login="";
//		HttpSession session = request.getSession(false);
        HttpSession session = request.getSession(true);
        Cookie cookie = null;
        Cookie[] cookies = request.getCookies();

        if (null != cookies) {
            // Look through all the cookies and see if the
            // cookie with the login info is there.
            for (int i = 0; i < cookies.length; i++) {
                cookie = cookies[i];
                if (cookie.getName().equals("LoginCookie")) {
                    login=cookie.getValue();
                    break;
                }
            }
        }

        // Logout action removes session, but the cookie remains
        if (null != request.getParameter("Logout")) {
            if (null != session.getAttribute("login")) {
//            	session.invalidate();
//                session = null;
                session.removeAttribute("login");
            }
        }

        //修改在线人数
        if(null!=session.getAttribute("login")){
            if(null!=session.getAttribute("visitor")) {
                session.removeAttribute("visitor");
            }
        }else{
            if(null==session.getAttribute("visitor")) {
                session.setAttribute("visitor", true);
            }
        }

//        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println(
                "<form method='POST' action='"
                        + response.encodeURL(request.getContextPath()+"/ShowMyOrderServlet")
                        + "'>");
        out.println(
                "login: <input type='text' name='login' value='" + login + "'>");
        out.println(
                "password: <input type='password' name='password' value=''>");
        out.println("<input type='submit' name='Submit' value='Submit'>");

//        String onlinePeople="<p>当前在线总人数为 "+ OnlinePeopleSessionListener.totalNum+", 已登录人数为 "+ OnlinePeopleSessionListener.loginNum
//                +", 游客人数 "+ OnlinePeopleSessionListener.visitorNum+"</p>";
//        onlinePeople=new String(onlinePeople.getBytes(),"utf-8");
//
//        out.println(onlinePeople);

        out.println("<p>Servlet is version @version@</p>");
//    out.println("</p>You are visitor number " + webCounter);

        out.println("</form></body></html>");
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginMemberPage(HttpServletRequest request, HttpServletResponse response) throws IOException{
        return "member/login";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public Object loginMemberForm(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response)throws IOException{
        String memberid=request.getParameter("memberid");
        String password=request.getParameter("password");
        String usertype=request.getParameter("usertype");
        LoginMessage loginMessage=null;
        if(usertype.equals("member")){
            loginMessage=memberService.login(memberid, password);
        }else if(usertype.equals("theater")){
            loginMessage=theaterService.login(memberid,password);
        }else if(usertype.equals("manager")){
            loginMessage=managerService.login(memberid,password);
        }
        Map<String,String> loginResult = new HashMap<String, String>();
        if(loginMessage!=LoginMessage.Success){
            loginResult.put("success","false");
            loginResult.put("message",loginMessage.name());
        }else {
            loginResult.put("success", "true");
            //设置session
            request.getSession().setAttribute("userType",usertype);
            //返回用户主页路径
            if (usertype.equals("member")) {
                Member member=memberService.getMember(memberid);
                request.getSession().setAttribute("member",member);
                loginResult.put("nextPage", "/member/j" + memberid+"/orderList?orderState=All");
            } else if (usertype.equals("theater")) {
                Theater theater=theaterService.getTheater(memberid);
                request.getSession().setAttribute("theater",theater);
                loginResult.put("nextPage", "/theater/j" + memberid+"/showList?showState=All");
            } else {
                Manager manager= managerService.getManager();
                request.getSession().setAttribute("manager",manager);
                loginResult.put("nextPage", "/ticketsManager/j" + memberid+"/checkList?checkType=signUpTheater");
            }
        }
        return loginResult;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException{
        //销毁session
        request.getSession().invalidate();
        return "redirect:/login";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public Object signupMember(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException{
        String memberid=request.getParameter("memberid");
        String name=request.getParameter("name");
        String password=request.getParameter("password");
        boolean result=memberService.signup(memberid,name,password);
        if(result==true){//发邮件
            sendEmail(memberid, "member",memberid);
        }
        Map<String,Boolean> signupResult=new HashMap<String, Boolean>();
        signupResult.put("success",result);
        return signupResult;
    }

    private void sendEmail(String email, String userType, String id){
        String link="http://localhost:8080/verifyEmail?usertype="+userType+"&id="+email;
        new Thread(new MailUtil(email, link, id)).start();
    }

    //确认邮箱 /verifyEmail?usertype=member/theater&id=?
    @RequestMapping(value = "/verifyEmail", method = RequestMethod.GET)
    public String verifyEmail(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException{
        String userType=request.getParameter("usertype");
        String id=request.getParameter("id");
        if(userType.equals("member")){
            if(!memberService.emailVerification(id)){
                modelMap.addAttribute("message","激活失败");
                return "error";
            }
        }else{
            if(!theaterService.emailVerification(id)){
                modelMap.addAttribute("message","激活失败");
                return "error";
            }
        }
        return "member/verifyEmail";
    }

    private String getShowTypeStr(int showType){

        char[] showTypeArray=new char[2];
        if(showType==0){
            showTypeArray=new char[2];
            showTypeArray[0]='\u7535';
            showTypeArray[1]='\u5f71';//电影
        }else if(showType==1) {
            showTypeArray=new char[3];
            showTypeArray[0]='\u97f3';
            showTypeArray[1]='\u4e50';
            showTypeArray[2]='\u5267';//音乐剧
        }else if(showType==2) {
            showTypeArray=new char[2];
            showTypeArray[0]='\u8bdd';
            showTypeArray[1]='\u5267';//话剧
        }else if(showType==3){
            showTypeArray=new char[2];
            showTypeArray[0]='\u821e';
            showTypeArray[1]='\u8e48';//舞蹈
        }else if(showType==4){
            showTypeArray=new char[4];
            showTypeArray[0]='\u4f53';
            showTypeArray[1]='\u80b2';
            showTypeArray[2]='\u6bd4';
            showTypeArray[3]='\u8d5b';//体育比赛
        }else if(showType==5){
            showTypeArray=new char[3];
            showTypeArray[0]='\u6f14';
            showTypeArray[1]='\u5531';
            showTypeArray[2]='\u4f1a';//演唱会
        }
//        System.out.println(showTypeArray);
        return new String(showTypeArray);

    }

}
