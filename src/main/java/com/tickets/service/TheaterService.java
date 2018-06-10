package com.tickets.service;

import com.tickets.model.OrderSeat;
import com.tickets.model.Theater;
import com.tickets.model.TheaterModify;
import com.tickets.util.LoginMessage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TheaterService {

    /*
    场馆注册，往邮箱发验证邮件，没有theaterid，在该方法中生成并返回，在数据库添加Theater
     */
    public String signup(Theater theater);

    /*
    场馆登录，判断用户是否存在, 判断密码是否匹配，判断是否验证邮箱(isvalid)，最后判断是否通过审核
     */
    public LoginMessage login(String theaterid, String inputPwd);

    /*
    邮箱验证
     */
    public boolean emailVerification(String theaterid);

    /*
    经理审核通过注册
     */
    public boolean passSignUp(String theaterid);

    /*
    经理审核拒绝注册，直接删除场馆
     */
    public boolean rejectSignUp(String theaterid);

    /*
    获取场馆信息
     */
    public Theater getTheater(String theaterid);

    public List<Theater> getTotalTheaterList();

    public List getSignUpTheaterList();

    public List<Theater> searchTheaterList(String key);

    /*
    按热度排序，所有演出加起来上座数最高
     */
    public Map<String, Integer> orderByHeatTheaterList();

    /*
    按演出数量排序，没有演出结束的所有演出的数量
     */
    public Map<String, Integer> orderByShowNumTheaterList();

    /*
    按最低价格排序，按没有演出结束的所有演出中的最低价格
     */
    public Map<String, Double> orderByMinPriceTheaterList();

    public boolean modifyTheaterWithoutApply(Theater theater);

    /*
    申请修改场馆信息，新建一条theaterModify
     */
    public boolean applyModifyTheater(TheaterModify theaterModify);

    /*
    通过修改场馆信息，修改theater，删除对应theaterModify
     */
    public boolean passModifyTheater(String theaterid);

    /*
    审核拒绝修改场馆信息，直接删除对应theaterModify
     */
    public boolean rejectModifyTheater(String theaterid);

    /*
    得到修改场馆信息申请列表
     */
    public List getTheaterModifyList();

    /*
    获取修改场馆信息详情
     */
    public TheaterModify getTheaterModify(String theaterid);

    //同层调用

    /*
    计算座位的类型
     */
    public List<OrderSeat> getSeatType(String theaterid, List<OrderSeat> seatList);

    public double getTheaterTotalIncome(String theaterid);

}
