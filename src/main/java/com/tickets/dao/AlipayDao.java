package com.tickets.dao;

import com.tickets.model.Alipay;

import java.util.List;

public interface AlipayDao {

    public Alipay find(String alipayid);

    public List find(String column, Object value);

    public List find();

    public boolean save(Alipay alipay);

    public boolean updateById(Alipay alipay);

}
