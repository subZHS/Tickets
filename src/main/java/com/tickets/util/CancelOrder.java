package com.tickets.util;

import com.tickets.model.Order;
import com.tickets.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

public class CancelOrder implements Runnable {

    private String orderid;
    OrderService orderService;
    final long timeInterval = 1000;

    public CancelOrder(String orderid, OrderService orderService){
        this.orderid=orderid;
        this.orderService=orderService;
    }

    public void run(){
        while (true) {
            Order order=orderService.getOrder(orderid);
            if(order.getState()!=0){
                return;
            }
            Date curDate=new Date();
            if(curDate.getTime()-order.getTime().getTime()>1000*60*5){
                orderService.cancelOrder(order.getOrderid());
                return;
            }
            try {
                Thread.sleep(timeInterval);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
