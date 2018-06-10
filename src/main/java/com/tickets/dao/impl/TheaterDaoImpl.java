package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import com.tickets.dao.TheaterDao;
import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.model.TheaterModify;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.List;

@Repository
public class TheaterDaoImpl implements TheaterDao
{
    @Autowired
    private BaseDao baseDao;

    public Theater find(String theaterid) {
        return (Theater) baseDao.load(Theater.class,theaterid);
    }

    public List find(String column, Object value) {
        return baseDao.find(Theater.class,column,value);
    }

    public List find() {
        return baseDao.getAllList(Theater.class);
    }

    public List searchTheaterList(String key) {
        List theaters=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            java.util.Date datetime=new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=dateFormat.format(datetime);
            //取出已过当前时间的show
            String hql = "SELECT * FROM `theater` t WHERE t.name LIKE :keyword OR t.location LIKE :keyword";
            Query query=session.createNativeQuery(hql).addEntity("t",Theater.class);
            query.setParameter("keyword","%"+key+"%");
            theaters=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return theaters;
        }finally {
            session.clear();
            session.close();
        }
        return theaters;
    }

    public boolean save(Theater theater) {
        return baseDao.save(theater);
    }

    public boolean delete(String theaterid) {
        return baseDao.delete(Theater.class, theaterid);
    }

    public boolean updateById(Theater theater) {
        return baseDao.update(theater);
    }

    public boolean saveTheaterModify(TheaterModify theaterModify) {
        return baseDao.save(theaterModify);
    }

    public boolean saveOrUpdateTheaterModify(TheaterModify theaterModify) {
        return baseDao.saveOrUpdate(theaterModify);
    }

    public boolean deleteTheaterModify(String theaterid) {
        return baseDao.delete(TheaterModify.class, theaterid);
    }

    public List findTheaterModifyList() {
        return baseDao.getAllList(TheaterModify.class);
    }

    public TheaterModify findTheaterModify(String theaterid) {
        return (TheaterModify) baseDao.load(TheaterModify.class, theaterid);
    }


}
