package com.tickets.controller.member;

import com.tickets.model.Member;
import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.service.MemberService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/member")
public class ProfileController {

    @Autowired
    MemberService memberService;
    @Autowired
    ShowService showService;
    @Autowired
    TheaterService theaterService;

    @RequestMapping(value = "/j{memberid}/profile", method = RequestMethod.GET)
    public String profilePage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        Member member=memberService.getMember(((Member)request.getSession().getAttribute("member")).getMemberid());
        request.getSession().setAttribute("member",member);
        int level=memberService.getLevel(member.getMemberid());
        double discount= memberService.getDiscount(member.getMemberid());
        modelMap.addAttribute("level",level);
        modelMap.addAttribute("discount",discount*10);

        //排行榜
        List<Show> top10ShowList=showService.getTop10ShowList();
        modelMap.addAttribute("top10ShowList",top10ShowList);
        List<String> top10TheaterIdList=new ArrayList<String>();
        for(Show show:top10ShowList){
            Theater theater=theaterService.getTheater(show.getTheaterid());
            top10TheaterIdList.add(theater.getTheaterid());
        }
        modelMap.addAttribute("top10TheaterIdList",top10TheaterIdList);

        return "member/profile";
    }

    @RequestMapping(value = "/j{memberid}/profile/modify", method = RequestMethod.GET)
    @ResponseBody
    public Boolean modifyProfile(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        String name=request.getParameter("name");
        int sex=Integer.valueOf(request.getParameter("sex"));
        int age=Integer.valueOf(request.getParameter("age"));
        Member member=memberService.getMember(((Member)request.getSession().getAttribute("member")).getMemberid());
        member.setName(name);
        member.setSex(sex);
        member.setAge(age);
        boolean success=memberService.modifyMember(member);
        return success;
    }

    @RequestMapping(value="/j{memberid}/profile/uploadImage", method=RequestMethod.POST)
    @ResponseBody
    public Boolean uploadFile(@PathVariable String memberid, HttpServletRequest request, @RequestParam MultipartFile file){
        if (file == null) {
            System.out.println("no file");
            return false;
        }
        try {
            //把名字改成memberid
            String externName = file.getOriginalFilename().split("\\.")[1];
            String fileName = memberid + "." + externName;

            String relativePath = "/resources/images/upload/portrait";

            //存储图片
            String savePath = request.getSession().getServletContext().getRealPath(relativePath);
            FileOutputStream fos = null;//打开FileOutStrean流
            fos = FileUtils.openOutputStream(new File(savePath + "/" + fileName));

            IOUtils.copy(file.getInputStream(), fos);//将MultipartFile file转成二进制流并输入到FileOutStrean

            fos.close();//

            //修改图片路径
            String filePath = relativePath + "/" + fileName;
            Member member = memberService.getMember(memberid);
            member.setImage(filePath);
            return memberService.modifyMember(member);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

}
