package com.tickets.dao;

import com.tickets.model.Order;
import com.tickets.model.OrderRefund;
import com.tickets.model.OrderSeat;

import java.util.List;

public interface OrderDao {

    public Order find(String orderid);

    public List find(String column, Object value);

    public List find(String column1, Object value1, String column2, Object value2);

    public List find(String column1, Object value1, String column2, Object value2, String column3, Object value3);

    public List find();

    public List findValidOrderListInOneShow(int showid);

    public int findSeatNumInOneTheater(String theaterid);

    public boolean save(Order order);

    public boolean updateById(Order order);

    //order seat相关
    public boolean saveSeat(List orderSeat);

    public List findSeat(String orderid);

    //order refund 相关
    public boolean saveRefund(OrderRefund orderRefund);

    public List findRefundList(List orderidList);

    /*
        如果没有该orderid，返回null
     */
    public OrderRefund findRefund(String orderid);

}