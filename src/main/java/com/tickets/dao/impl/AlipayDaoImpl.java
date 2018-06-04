package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import com.tickets.dao.AlipayDao;
import com.tickets.model.Alipay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AlipayDaoImpl implements AlipayDao
{
    @Autowired
    private BaseDao baseDao;

    public Alipay find(String alipayid) {
        return (Alipay) baseDao.load(Alipay.class,alipayid);
    }

    public List find(String column, Object value) {
        return baseDao.find(Alipay.class,column,value);
    }

    public List find() {
        return baseDao.getAllList(Alipay.class);
    }

    public boolean save(Alipay alipay) {
        return baseDao.save(alipay);
    }

    public boolean updateById(Alipay alipay) {
        return baseDao.update(alipay);
    }

}
