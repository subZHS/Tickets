package com.tickets.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name="`order`")
public class Order implements Serializable{

	@Id
	private String orderid;
	private String memberid;
	private String showtimeid;
	private String alipayid;
	private boolean ordertype;//true为选座购买，false为立即购买
	private int number;
	private double price;
	private int state;//待支付0，已支付（待检票1，已观看2），已失效（已取消3，已退订4）
	private Date time;
	private double discount;
	private int coupontype;//0为未使用，1-3表示优惠劵类型

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public String getShowtimeid() {
		return showtimeid;
	}

	public void setShowtimeid(String showtimeid) {
		this.showtimeid = showtimeid;
	}

	public String getAlipayid() {
		return alipayid;
	}

	public void setAlipayid(String alipayid) {
		this.alipayid = alipayid;
	}

	public boolean isOrdertype() {
		return ordertype;
	}

	public void setOrdertype(boolean ordertype) {
		this.ordertype = ordertype;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public int getCoupontype() {
		return coupontype;
	}

	public void setCoupontype(int coupontype) {
		this.coupontype = coupontype;
	}
}
