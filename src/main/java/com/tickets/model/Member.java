package com.tickets.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name="`member`")
public class Member implements Serializable{

    @Id
    private String memberid;
    private String name;
    private String password;
    private int sex;//其中0代表男，1代表女
    private int age;
    private String image;
    private double consumption;//消费金额
    private int points;//积分
    private int coupon1;//第一种代金劵个数
    private int coupon2;//第二种代金劵个数
    private int coupon3;//第三种代金劵个数
    private boolean isvalid;//这个会员账号是否有效

    public Member(){}

    public Member(String memberid, String name, String password){
        this.memberid=memberid;
        this.name=name;
        this.password=password;
        this.image="/resources/images/not-head.png";
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getConsumption() {
        return consumption;
    }

    public void setConsumption(double consumption) {
        this.consumption = consumption;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getCoupon1() {
        return coupon1;
    }

    public void setCoupon1(int coupon1) {
        this.coupon1 = coupon1;
    }

    public int getCoupon2() {
        return coupon2;
    }

    public void setCoupon2(int coupon2) {
        this.coupon2 = coupon2;
    }

    public int getCoupon3() {
        return coupon3;
    }

    public void setCoupon3(int coupon3) {
        this.coupon3 = coupon3;
    }

    public boolean isIsvalid() {
        return isvalid;
    }

    public void setIsvalid(boolean isvalid) {
        this.isvalid = isvalid;
    }
}
