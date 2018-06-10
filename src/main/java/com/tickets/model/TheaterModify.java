package com.tickets.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name="`theatermodify`")//theatermodify和theater的唯一区别是没有passCheck和verified，如果审核通过，该记录会被删除
public class TheaterModify implements Serializable{

    @Id
    private String theaterid;
    private String name;
    private String password;
    private String location;
    private String phonenum;
    private String image;
    private String alipayid;
    private String email;
    private String seat;
    private int rowdivide1;
    private int rowdivide2;
    
    public TheaterModify(){}
    
    public TheaterModify(Theater theater){
        this.theaterid=theater.getTheaterid();
        this.name=theater.getName();
        this.password=theater.getPassword();
        this.location=theater.getLocation();
        this.phonenum=theater.getPhonenum();
        this.image=theater.getImage();
        this.alipayid=theater.getAlipayid();
        this.email=theater.getEmail();
        this.seat=theater.getSeat();
        this.rowdivide1=theater.getRowdivide1();
        this.rowdivide2=theater.getRowdivide2();
    }

    public String getTheaterid() {
        return theaterid;
    }

    public void setTheaterid(String theaterid) {
        this.theaterid = theaterid;
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPhonenum() {
        return phonenum;
    }

    public void setPhonenum(String phonenum) {
        this.phonenum = phonenum;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getAlipayid() {
        return alipayid;
    }

    public void setAlipayid(String alipayid) {
        this.alipayid = alipayid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public int getRowdivide1() {
        return rowdivide1;
    }

    public void setRowdivide1(int rowdivide1) {
        this.rowdivide1 = rowdivide1;
    }

    public int getRowdivide2() {
        return rowdivide2;
    }

    public void setRowdivide2(int rowdivide2) {
        this.rowdivide2 = rowdivide2;
    }

}
