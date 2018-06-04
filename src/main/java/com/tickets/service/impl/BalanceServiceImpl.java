package com.tickets.service.impl;

import com.tickets.dao.BalanceDao;
import com.tickets.model.Balance;
import com.tickets.model.Show;
import com.tickets.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class BalanceServiceImpl implements BalanceService {

    @Autowired
    BalanceDao balanceDao;

    @Autowired
    AlipayService alipayService;

    @Autowired
    ShowService showService;

    @Autowired
    TheaterService theaterService;

    @Autowired
    ManagerService managerService;

    @Autowired
    OrderService orderService;

    /*
    获得没有结算某影院的演出列表
     */
    public List<Show> getNotPayShowList(String theaterid) {
        refleshBalance();
        List<Balance> balances= balanceDao.getNotPayBalaneInOneTheater(theaterid);
        List<Show> showList = new ArrayList<Show>();
        if(balances==null){
            return showList;
        }
        for(Balance balance : balances){
            if(!balance.isState()){//未结算
                Show show = showService.getShow(balance.getShowid());
                showList.add(show);
            }
        }
        return showList;
    }

    /*
    获得已结算某影院的演出列表
     */
    public List<Show> getPayedShowList(String theaterid) {
        List<Balance> balances= balanceDao.getPayedBalaneInOneTheater(theaterid);
        List<Show> showList = new ArrayList<Show>();
        if(balances==null){
            return showList;
        }
        for(Balance balance : balances){
            if(balance.isState()){//已结算
                Show show = showService.getShow(balance.getShowid());
                showList.add(show);
            }
        }
        return showList;
    }

    /*
    结算：转钱，修改balance状态,更新结算时间
     */
    public boolean payBalance(int showid, String password) {
        String managerAlipayid=managerService.getManager().getAlipayid();
        //验证密码
        if(!alipayService.isRightPwd(managerAlipayid,password)){
            return false;
        }
        Balance balance=getBalance(showid);
        balance.setState(true);//设置为已结算
        balance.setTime(new Date());
        balanceDao.updateById(balance);
        String toAlipayid=theaterService.getTheater(showService.getShow(showid).getTheaterid()).getAlipayid();
//        Double totalIncome=orderService.getShowIncome(showid);
        //按2：8分账
        Double payMoney=balance.getTotalincome()*0.8;
        return alipayService.transferMoney(managerAlipayid, toAlipayid, payMoney);
    }

    //刷新演出是否结束状态，如果结束，就在balance表添加
    public void refleshBalance(){
        //添加没在balance中的表
        List<Show> notInBalanceShowList=showService.getNotInBalanceShowList();
        for(int i=0;i<notInBalanceShowList.size();i++){
            Show show = notInBalanceShowList.get(i);
            Balance balance=new Balance();
            balance.setShowid(show.getShowid());
            balance.setTime(new Date());
            balance.setState(false);
            balance.setTotalincome(orderService.getShowIncome(show.getShowid()));
            balanceDao.save(balance);
        }
    }

    /*
    获得未结算，指已过了演出时间且未结算的演出列表，如果发现有已过了表演时间但不在balance表中则添加
     */
    public List<Balance> getNotPayBalanceList() {
        refleshBalance();
        List<Balance> balances= balanceDao.find("state",false);
        if(balances==null){
            return new ArrayList<Balance>();
        }else{
            return balances;
        }
    }

    public List<Balance> getPayedBalanceList() {
        List<Balance> balances= balanceDao.find("state",true);
        if(balances==null){
            return new ArrayList<Balance>();
        }else{
            return balances;
        }
    }

    public List<Balance> getAllBalanceList() {
        refleshBalance();
        List<Balance> balances= balanceDao.find();
        if(balances==null){
            return new ArrayList<Balance>();
        }else{
            return balances;
        }
    }

    public Balance getBalance(int showid) {
        return balanceDao.find(showid);
    }

}
