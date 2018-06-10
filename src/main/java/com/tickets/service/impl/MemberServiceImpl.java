package com.tickets.service.impl;

import com.tickets.dao.MemberDao;
import com.tickets.model.Member;
import com.tickets.service.MemberService;
import com.tickets.util.LoginMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDao memberDao;

    public LoginMessage login(String memberid, String inputPwd) {
        Member member = memberDao.find(memberid);
        if(member==null){
            return LoginMessage.MemberNotExist;
        }
        if(!member.getPassword().equals(inputPwd)){
            return LoginMessage.WrongPassword;
        }
        if(!member.isIsvalid()){
            return LoginMessage.EmailNotVerify;
        }
        return LoginMessage.Success;
    }

    public boolean signup(String memberid, String name, String password) {
        //往邮箱发验证邮件

        return memberDao.save(new Member(memberid,name,password));
    }

    public boolean emailVerification(String memberid) {
        Member member = memberDao.find(memberid);
        member.setIsvalid(true);
        return memberDao.updateById(member);
    }

    public Member getMember(String memberid) {
        return memberDao.find(memberid);
    }

    public boolean modifyMember(Member member) {
        return memberDao.updateById(member);
    }

    public boolean afterConsume(String memberid, Double consumption, int couponType) {
        Member member=memberDao.find(memberid);
        member.setConsumption(member.getConsumption()+consumption);
        member.setPoints(member.getPoints() + (int)(10*consumption));
        //减少优惠券
        if(couponType==1){
            if(member.getCoupon1()==0){
                return false;
            }
            member.setCoupon1(member.getCoupon1()-1);
        }else if(couponType==2){
            if(member.getCoupon2()==0){
                return false;
            }
            member.setCoupon1(member.getCoupon2()-1);
        }else if(couponType==3){
            if(member.getCoupon3()==0){
                return false;
            }
            member.setCoupon1(member.getCoupon3()-1);
        }
        return memberDao.updateById(member);
    }

    /*
        每消费1元兑换10积分
        优惠劵：
        150积分兑换满10减1元劵
        550积分兑换满30减5元劵
        1050积分兑换满50减10元劵
     */
    public boolean exchangeCoupon(String memberid, int number, int couponType) {
        int[] pointsArray={150, 550, 1050};
        int needPoints = number*pointsArray[couponType-1];
        Member member=getMember(memberid);
        if(member.getPoints()<needPoints){
            return false;
        }
        member.setPoints(member.getPoints()-needPoints);
        if(couponType==1){
            member.setCoupon1(member.getCoupon1()+number);
        }else if(couponType==2){
            member.setCoupon2(member.getCoupon2()+number);
        }else if(couponType==3){
            member.setCoupon3(member.getCoupon3()+number);
        }
        return memberDao.updateById(member);
    }

    public boolean recoverConsume(String memberid, Double consumption, int couponType) {
        Member member=memberDao.find(memberid);
        member.setConsumption(member.getConsumption()-consumption);
        member.setPoints(member.getPoints() - (int)(10*consumption));
        //恢复优惠券
        if(couponType==1){
            member.setCoupon1(member.getCoupon1()+1);
        }else if(couponType==2){
            member.setCoupon1(member.getCoupon2()+1);
        }else if(couponType==3){
            member.setCoupon1(member.getCoupon3()+1);
        }
        return memberDao.updateById(member);
    }

    public boolean cancelMember(String memberid) {
        Member member=getMember(memberid);
        member.setIsvalid(false);
        return memberDao.updateById(member);
    }

    /*
    会员级别：
    lv0  lv1(50) lv2(100) lv3(200) lv4(500) lv5(1000)
折扣 0.95   0.9     0.85       0.8     0.75      0.7
     */
    public double getDiscount(String memberid) {
        if(memberid==null||memberid.equals("")){
            return 1;
        }
        Member member=getMember(memberid);
        if(member==null){
            return 1;
        }
        Double consumption=member.getConsumption();
        int[] divideArray={0,50,100,200,500,1000};
        double[] discountArray={0.95, 0.9, 0.85, 0.8, 0.75, 0.7};
        for(int i=0;i<divideArray.length-1;i++) {
            if (consumption >= divideArray[i] && consumption < divideArray[i + 1]) {
                return discountArray[i];
            }
        }
        return discountArray[divideArray.length-1];
    }

    public int getLevel(String memberid) {
        if(memberid==null||memberid.equals("")){
            return 0;
        }
        Member member=getMember(memberid);
        if(member==null){
            return 0;
        }
        Double consumption=member.getConsumption();
        int[] divideArray={0,50,100,200,500,1000};
        for(int i=0;i<divideArray.length-1;i++) {
            if (consumption >= divideArray[i] && consumption < divideArray[i + 1]) {
                return i;
            }
        }
        return divideArray.length-1;
    }

    public List<Integer> getLevelMemberNumList() {
        List<Integer> memberLevelNumList=new ArrayList<Integer>();
        for(int i=0;i<6;i++){
            memberLevelNumList.add(0);
        }
        List<Member> memberList=memberDao.find();
        for(Member member:memberList){
            int level=getLevel(member.getMemberid());
            memberLevelNumList.set(level,memberLevelNumList.get(level)+1);
        }
        return memberLevelNumList;
    }

    public List<Member> getTop10ConsumeMemberList() {
        return memberDao.getTop10ConsumeMemberList();
    }
}
