package com.tickets.service;

import com.tickets.model.Alipay;
import com.tickets.util.PayMessage;

public interface AlipayService {

    /*
    订单支付，如果支付成功，在订单中添加alipayid, 要去修改订单状态
     */
    public PayMessage payOrder(String orderid, String alipayid, String password);

    public Alipay getAlipay(String alipayid);

    public boolean isRightPwd(String alipayid, String password);

    /*
    转钱，从某账户赚到另一账户
     */
    public boolean transferMoney(String fromAlipayid, String toAlipayid, double money);

}
