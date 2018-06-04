package com.tickets.service.impl;

import com.tickets.dao.AlipayDao;
import com.tickets.model.Alipay;
import com.tickets.model.Order;
import com.tickets.service.*;
import com.tickets.util.OrderState;
import com.tickets.util.PayMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlipayServiceImpl implements AlipayService {

    @Autowired
    AlipayDao alipayDao;

    @Autowired
    OrderService orderService;

    @Autowired
    ManagerService managerService;

    /*
   订单支付，如果支付成功，在订单中添加alipayid, 要去修改订单状态
    */
    public PayMessage payOrder(String orderid, String alipayid, String password) {
        Alipay alipay=getAlipay(alipayid);
        if(alipay==null){
            return PayMessage.AliPayNotExist;
        }
        if(!alipay.getPassword().equals(password)){
            return PayMessage.WrongPassword;
        }
        Order order=orderService.getOrder(orderid);
        if(!transferMoney(alipayid,managerService.getManager().getAlipayid(),order.getPrice())){
            return PayMessage.NotEnoughMoney;
        }
        orderService.setOrderAlipay(orderid, alipayid);
        orderService.changeOrderState(orderid, OrderState.WaitCheck.ordinal());
        return PayMessage.Success;
    }

    public Alipay getAlipay(String alipayid) {
        return alipayDao.find(alipayid);
    }

    public boolean isRightPwd(String alipayid, String password) {
        Alipay alipay=getAlipay(alipayid);
        if(alipay.getPassword().equals(password)){
            return true;
        }else{
            return false;
        }
    }


    public boolean transferMoney(String fromAlipayid, String toAlipayid, double money) {
        Alipay fromAlipay=getAlipay(fromAlipayid);
        Alipay toAlipay=getAlipay(toAlipayid);
        if(fromAlipay==null||toAlipay==null||fromAlipay.getMoney()<money){
            return false;
        }
        fromAlipay.setMoney(fromAlipay.getMoney()-money);
        toAlipay.setMoney(toAlipay.getMoney()+money);
        return alipayDao.updateById(fromAlipay)&&alipayDao.updateById(toAlipay);
    }

}
