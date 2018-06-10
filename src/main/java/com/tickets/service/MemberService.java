package com.tickets.service;

import com.tickets.model.Member;
import com.tickets.util.LoginMessage;

import java.util.List;

/**
 * Created by lenovo on 2017/12/29.
 */
public interface MemberService {

    /*
    会员登录，判断用户是否存在, 判断密码是否匹配，判断是否验证邮箱(isvalid)
     */
    public LoginMessage login(String memberid, String inputPwd);

    /*
    会员注册，往邮箱发验证邮件, 然后在数据库添加member记录
     */
    public boolean signup(String memberid, String name, String password);

    /*
    邮箱验证
     */
    public boolean emailVerification(String memberid);

    /*
    获取会员信息
     */
    public Member getMember(String memberid);

    /*
    修改会员信息：昵称，性别，年龄
     */
    public boolean modifyMember(Member member);

    /*
    在每次消费之后修改会员信息：consumption，points，以及消耗优惠券
     */
    public boolean afterConsume(String memberid, Double consumption, int couponType);

    /*
    兑换优惠券，先减去积分
     */
    public boolean exchangeCoupon(String memberid, int number, int couponType);

    /*
    支付超时，恢复优惠券，总消费金额和积分
     */
    public boolean recoverConsume(String memberid, Double consumption, int couponType);

    /*
    取消会员资格
     */
    public boolean cancelMember(String memberid);

    //同层调用

    /*
	计算会员等级所得优惠
	 */
    public double getDiscount(String memberid);

    public int getLevel(String memberid);

    public List<Integer> getLevelMemberNumList();

    public List<Member> getTop10ConsumeMemberList();

}
