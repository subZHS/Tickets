package com.tickets.controller.theater;

import com.tickets.model.Theater;
import com.tickets.model.TheaterModify;
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

@Controller("TheaterProfileController") //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/theater")
public class ProfileController {

    @Autowired
    TheaterService theaterService;

    @RequestMapping(value = "/j{theaterid}/profile", method = RequestMethod.GET)
    public String profilePage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        Theater theater=theaterService.getTheater(((Theater)request.getSession().getAttribute("theater")).getTheaterid());
        request.getSession().setAttribute("theater",theater);
        return "theater/profile";
    }

    @RequestMapping(value = "/j{theaterid}/profile/modify", method = RequestMethod.GET)
    @ResponseBody
    public Boolean modifyProfile(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
        Theater theater = theaterService.getTheater(((Theater)request.getSession().getAttribute("theater")).getTheaterid());
        theater.setName(request.getParameter("name"));
        theater.setLocation(request.getParameter("location"));
        theater.setPhonenum(request.getParameter("phonenum"));
        theater.setAlipayid(request.getParameter("alipayid"));
        theater.setSeat(request.getParameter("seat"));
        theater.setRowdivide1(Integer.valueOf(request.getParameter("divide1")));
        theater.setRowdivide2(Integer.valueOf(request.getParameter("divide2")));
        TheaterModify theaterModify = new TheaterModify(theater);
        return theaterService.applyModifyTheater(theaterModify);
    }

    @RequestMapping(value="/j{theaterid}/profile/uploadImage", method=RequestMethod.POST)
    @ResponseBody
    public Boolean uploadFile(@PathVariable String theaterid, HttpServletRequest request, @RequestParam MultipartFile file){
        if (file == null) {
            System.out.println("no file");
            return false;
        }
        try {
            //把名字改成memberid
            String externName = file.getOriginalFilename().split("\\.")[1];
            String fileName = theaterid + "." + externName;

            String relativePath = "/resources/images/upload/theaterImage";

            //存储图片
            String savePath = request.getSession().getServletContext().getRealPath(relativePath);
            FileOutputStream fos = null;//打开FileOutStrean流
            fos = FileUtils.openOutputStream(new File(savePath + "/" + fileName));

            IOUtils.copy(file.getInputStream(), fos);//将MultipartFile file转成二进制流并输入到FileOutStrean

            fos.close();//

            //修改图片路径
            String filePath = relativePath + "/" + fileName;
            Theater theater = theaterService.getTheater(theaterid);
            theater.setImage(filePath);
            return theaterService.modifyTheaterWithoutApply(theater);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

}
