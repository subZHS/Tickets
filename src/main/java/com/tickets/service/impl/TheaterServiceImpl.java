package com.tickets.service.impl;

import com.tickets.dao.TheaterDao;
import com.tickets.model.OrderSeat;
import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.model.TheaterModify;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.LoginMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class TheaterServiceImpl implements TheaterService {

    @Autowired
    TheaterDao theaterDao;
    @Autowired
    OrderService orderService;
    @Autowired
    ShowService showService;

    public String signup(Theater theater) {
        //给theater分配7位识别码,去邮箱@前部分和电话号码拼接的前7位
        String baseStr = theater.getEmail().split("@")[0]+theater.getPhonenum();
        String theaterid = baseStr.substring(0, 7);
        theater.setTheaterid(theaterid);
        boolean signupSuccess=theaterDao.save(theater);
        if(signupSuccess){
            return theaterid;
        }else{
            return null;
        }
    }

    public LoginMessage login(String theaterid, String inputPwd) {
        Theater theater = theaterDao.find(theaterid);
        if(theater==null){
            return LoginMessage.MemberNotExist;
        }
        if(!theater.getPassword().equals(inputPwd)){
            return LoginMessage.WrongPassword;
        }
        if(!theater.isVerified()){
            return LoginMessage.EmailNotVerify;
        }
        if(!theater.isPassCheck()){
            return LoginMessage.NotPassCheck;
        }
        return LoginMessage.Success;
    }

    public boolean emailVerification(String theaterid) {
        Theater theater=getTheater(theaterid);
        theater.setVerified(true);
        return theaterDao.updateById(theater);
    }

    public boolean passSignUp(String theaterid) {
        Theater theater=getTheater(theaterid);
        theater.setPassCheck(true);
        return theaterDao.updateById(theater);
    }

    public boolean rejectSignUp(String theaterid) {
        return theaterDao.delete(theaterid);
    }


    public Theater getTheater(String theaterid) {
        return theaterDao.find(theaterid);
    }

    public List<Theater> getTotalTheaterList() {
        return theaterDao.find();
    }

    public List getSignUpTheaterList() {
        List<Theater> allTheaterList = theaterDao.find();
        List<Theater> signUpTheaterList = new ArrayList<Theater>();
        for(Theater theater:allTheaterList){
            if(theater.isVerified()&&!theater.isPassCheck()){
                signUpTheaterList.add(theater);
            }
        }
        return signUpTheaterList;
    }

    public List<Theater> searchTheaterList(String key) {
        List<Theater> theaterList = theaterDao.searchTheaterList(key);
        if(theaterList==null){
            return new ArrayList<Theater>();
        }
        return theaterList;
    }

    /*
    按热度排序，所有演出加起来上座数最高,Map<theaterid, seatNum>
    */
    public Map<String,Integer> orderByHeatTheaterList() {
        List<Theater> theaterList = theaterDao.find();
        Map<String, Integer> seatNumMap = new HashMap<String, Integer>();
        for(Theater theater:theaterList){
            int seatNum = orderService.getTheaterSaleSeatNum(theater.getTheaterid());
            seatNumMap.put(theater.getTheaterid(),seatNum);
        }
        //排序
//        List<Map.Entry<String, Integer>> seatNumMapList = new ArrayList<Map.Entry<String, Integer>>(seatNumMap.entrySet());
//        Collections.sort(seatNumMapList, new Comparator<Map.Entry<String, Integer>>() {
//            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
//                return o2.getValue().compareTo(o1.getValue());
//            }
//        });
        return seatNumMap;
    }

    /*
    按演出数量排序，没有演出结束的所有演出的数量
     */
    public Map<String,Integer> orderByShowNumTheaterList() {
        List<Theater> theaterList = theaterDao.find();
        Map<String, Integer> showNumMap = new HashMap<String, Integer>();
        for(Theater theater:theaterList){
            int showNum = showService.getNotPassList(theater.getTheaterid()).size();
            showNumMap.put(theater.getTheaterid(),showNum);
        }
        //排序
//        List<Map.Entry<String, Integer>> showNumMapList = new ArrayList<Map.Entry<String, Integer>>(showNumMap.entrySet());
//        Collections.sort(showNumMapList, new Comparator<Map.Entry<String, Integer>>() {
//            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
//                return o2.getValue().compareTo(o1.getValue());
//            }
//        });
        return showNumMap;
    }

    /*
    按最低价格排序，按没有演出结束的所有演出中的最低价格
     */
    public Map<String,Double> orderByMinPriceTheaterList() {
        List<Theater> theaterList = theaterDao.find();
        Map<String,Double> minPriceMap = new HashMap<String, Double>();
        for(Theater theater:theaterList){
            double minPrice = showService.minPriceInTheater(theater.getTheaterid());
            minPriceMap.put(theater.getTheaterid(),minPrice);
        }
        //排序
//        List<Map.Entry<String, Double>> minPriceMapList = new ArrayList<Map.Entry<String, Double>>(minPriceMap.entrySet());
//        Collections.sort(minPriceMapList, new Comparator<Map.Entry<String, Double>>() {
//            public int compare(Map.Entry<String, Double> o1, Map.Entry<String, Double> o2) {
//                return o1.getValue().compareTo(o2.getValue());
//            }
//        });
        return minPriceMap;
    }


    public boolean modifyTheaterWithoutApply(Theater theater) {
        return theaterDao.updateById(theater);
    }

    public boolean applyModifyTheater(TheaterModify theaterModify) {
        return theaterDao.saveOrUpdateTheaterModify(theaterModify);
    }

    public boolean passModifyTheater(String theaterid) {
        TheaterModify theaterModify=getTheaterModify(theaterid);
        Theater theater = getTheater(theaterid);
        theater.setEmail(theaterModify.getEmail());
        theater.setLocation(theaterModify.getLocation());
        theater.setPhonenum(theaterModify.getPhonenum());
        theater.setAlipayid(theaterModify.getAlipayid());
        theater.setSeat(theaterModify.getSeat());
        theater.setRowdivide1(theaterModify.getRowdivide1());
        theater.setRowdivide2(theaterModify.getRowdivide2());
        return theaterDao.deleteTheaterModify(theaterid)&&theaterDao.updateById(theater);
    }

    public boolean rejectModifyTheater(String theaterid) {
        return theaterDao.deleteTheaterModify(theaterid);
    }

    public List getTheaterModifyList() {
        List<TheaterModify> theaterModifies= theaterDao.findTheaterModifyList();
        if(theaterModifies==null){
            theaterModifies=new ArrayList<TheaterModify>();
        }
        return theaterModifies;
    }

    public TheaterModify getTheaterModify(String theaterid) {
        return theaterDao.findTheaterModify(theaterid);
    }

    /*
    座位类型
     */
    public List<OrderSeat> getSeatType(String theaterid, List<OrderSeat> seatList) {
        Theater theater=getTheater(theaterid);
        int divide1=theater.getRowdivide1();
        int divide2=theater.getRowdivide2();
        for(OrderSeat orderSeat:seatList){
            int row=orderSeat.getSeatRow();
            if(row<divide1){
                orderSeat.setSeattype(1);
            }else if(row>=divide1&&row<divide2){
                orderSeat.setSeattype(2);
            }else{
                orderSeat.setSeattype(3);
            }
        }
        return seatList;
    }

    public double getTheaterTotalIncome(String theaterid) {
        List<Show> showList=showService.getShowList(theaterid);
        double totalIncome=0;
        for(Show show:showList){
            double showIncome=orderService.getShowIncome(show.getShowid());
            totalIncome+=showIncome;
        }
        return totalIncome;
    }
}
