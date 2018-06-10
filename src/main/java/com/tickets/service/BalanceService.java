package com.tickets.service;

import com.tickets.model.Balance;
import com.tickets.model.Show;

import java.util.List;

public interface BalanceService {

    /*
    结算：转钱，修改balance状态
     */
    public boolean payBalance(int showid, String password);

    /*
    获得未结算，指已过了演出时间且未结算的演出列表，如果发现有已过了表演时间但不在balance表中则添加
     */
    public List<Balance> getNotPayBalanceList();

    /*
    获得已结算的列表
     */
    public List<Balance> getPayedBalanceList();

    /*
   得到某场馆演出结束，未结算演出列表
    */
    public List<Show> getNotPayShowList(String theaterid);

    /*
    得到某场馆正在售票演出列表
     */
    public List<Show> getPayedShowList(String theaterid);

    /*
    获取所有的balance列表
     */
    public List<Balance> getAllBalanceList();

    /*
    获取某个结算清单
     */
    public Balance getBalance(int showid);

    /*
    将演出结束的演出添加到balance中，在场馆加载所有演出列表时调用
     */
    public void refleshBalance();

}
