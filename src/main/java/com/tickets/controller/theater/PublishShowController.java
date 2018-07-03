package com.tickets.controller.theater;

import com.tickets.dao.BaseDao;
import com.tickets.model.Member;
import com.tickets.model.Show;
import com.tickets.model.ShowTime;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.DateCompare;
import com.tickets.util.ShowType;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@Controller //@Controller用于标注控制层组件(如struts中的action)
@Scope("prototype")
@RequestMapping("/theater")
public class PublishShowController {

    @Autowired
    TheaterService theaterService;
    @Autowired
    ShowService showService;
    @Autowired
    BaseDao baseDao;

    @RequestMapping(value = "/j{theaterid}/newShow", method = RequestMethod.GET)
    public String newShowPage(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {

        return "theater/newShow";
    }

    @RequestMapping(value = "/j{theaterid}/newShow", method = RequestMethod.POST)
    @ResponseBody
    public boolean publishShow(@PathVariable String theaterid, HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException, ParseException {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        Show show=new Show();
        show.setTheaterid(theaterid);
        show.setTitle(request.getParameter("title"));
        show.setType(ShowType.valueOf(request.getParameter("type")).ordinal());
        show.setActor(request.getParameter("actor"));
        show.setDescription(request.getParameter("description"));
        show.setPrice1(Integer.valueOf(request.getParameter("price1")));
        show.setPrice2(Integer.valueOf(request.getParameter("price2")));
        show.setPrice3(Integer.valueOf(request.getParameter("price3")));

        MultipartFile image = multipartRequest.getFile("image");
        //保存图片
//        String imageName="/resources/images/upload/theater/"+theaterid+"/"+ShowType.valueOf(request.getParameter("type"))
//                + "/" +request.getParameter("title")+".jpg";
        String imageName=saveImage(request,image,theaterid,ShowType.valueOf(request.getParameter("type")),request.getParameter("title"));
        if(imageName==null){
            return false;
        }
        show.setImage(imageName);

        //设置开票状态
        java.util.Date curDate = new java.util.Date();
        String[] showTimeList = request.getParameterValues("showtime");
        java.util.Date earlyDate = DateCompare.findEarlyDate(showTimeList);
        if(earlyDate.before(curDate)){
            return false;
        }
        //开票时间是两周前
        java.util.Date openTime=new Date(earlyDate.getTime()- (long)14 * 24 * 60 * 60 * 1000);
        if(openTime.before(curDate)){//两周前
            show.setIsopen(true);
        }else{
            show.setIsopen(false);
        }

        int showid = showService.newShow(show);
        if(showid==-1){
            return false;
        }
        ArrayList<ShowTime> showTimeArrayList = new ArrayList<ShowTime>();
        try {
            for(String showTimeStr:showTimeList){
                ShowTime showTime = new ShowTime();
                showTime.setShowid(showid);

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
                Date datetime=sdf.parse(showTimeStr);
                java.sql.Date date = new java.sql.Date(datetime.getTime());
                java.sql.Time time = new java.sql.Time(datetime.getTime());
                showTime.setDate(date);
                showTime.setTime(time);
                showTimeArrayList.add(showTime);
            }
            return showService.addShowTimeList(showTimeArrayList);
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    //返回数据库存储的路径
    private String saveImage(HttpServletRequest request,MultipartFile image, String theaterid, ShowType showType, String title){
        try {
            //把名字改成memberid
            String[] splitStrs= image.getOriginalFilename().split("\\.");
            String externName = splitStrs[splitStrs.length-1];
            String fileName =  title+ "." + externName;

            String relativePath = "/resources/images/upload/theater/"+theaterid+"/"+showType.name();

            //存储图片
            String savePath = request.getSession().getServletContext().getRealPath(relativePath);
            FileOutputStream fos = null;//打开FileOutStrean流
            fos = FileUtils.openOutputStream(new File(savePath + "/" + fileName));

            IOUtils.copy(image.getInputStream(), fos);//将MultipartFile file转成二进制流并输入到FileOutStrean

            fos.close();//

            //修改图片路径
            String filePath = relativePath + "/" + fileName;
            return filePath;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
