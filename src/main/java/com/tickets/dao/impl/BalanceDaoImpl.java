package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import com.tickets.dao.BalanceDao;
import com.tickets.model.Balance;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BalanceDaoImpl implements BalanceDao
{
    @Autowired
    private BaseDao baseDao;

    public Balance find(int showid) {
        return (Balance) baseDao.load(Balance.class,showid);
    }

    public List find(String column, Object value) {
        return baseDao.find(Balance.class,column,value);
    }

    public List find() {
        return baseDao.getAllList(Balance.class);
    }

    public boolean save(Balance balance) {
        return baseDao.save(balance);
    }

    public boolean updateById(Balance balance) {
        return baseDao.update(balance);
    }

    public List getNotPayBalaneInOneTheater(String theaterid){
        List balances=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT * from `balance` b WHERE b.showid IN (SELECT s.showid FROM `show` s where s.theaterid=:theaterid) AND b.state=0";
            Query query=session.createNativeQuery(hql).addEntity("b",Balance.class);
            query.setParameter("theaterid",theaterid);
            balances=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return balances;
        }finally {
            session.clear();
            session.close();
        }
        return balances;
    }

    public List getPayedBalaneInOneTheater(String theaterid){
        List balances=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT * from `balance` b WHERE b.showid IN (SELECT s.showid FROM `show` s where s.theaterid=:theaterid) AND b.state=1";
            Query query=session.createNativeQuery(hql).addEntity("b",Balance.class);
            query.setParameter("theaterid",theaterid);
            balances=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return balances;
        }finally {
            session.clear();
            session.close();
        }
        return balances;
    }

}
