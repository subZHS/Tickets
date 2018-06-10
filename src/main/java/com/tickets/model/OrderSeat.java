package com.tickets.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name="`orderseat`")
public class OrderSeat implements Serializable{

	@Id
	private int orderseatid;
	private String orderid;
	private int seatRow;
	private int seatColumn;
	private int seattype;
	private double price;

	public int getOrderseatid() {
		return orderseatid;
	}

	public void setOrderseatid(int orderseatid) {
		this.orderseatid = orderseatid;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public int getSeatRow() {
		return seatRow;
	}

	public void setSeatRow(int seatRow) {
		this.seatRow = seatRow;
	}

	public int getSeatColumn() {
		return seatColumn;
	}

	public void setSeatColumn(int seatColumn) {
		this.seatColumn = seatColumn;
	}

	public int getSeattype() {
		return seattype;
	}

	public void setSeattype(int seattype) {
		this.seattype = seattype;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

}
