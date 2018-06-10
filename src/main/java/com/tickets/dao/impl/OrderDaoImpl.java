package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import com.tickets.dao.OrderDao;
import com.tickets.model.Order;
import com.tickets.model.OrderRefund;
import com.tickets.model.OrderSeat;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class OrderDaoImpl implements OrderDao
{
    @Autowired
    private BaseDao baseDao;

    public Order find(String orderid) {
//        Session session= HibernateUtil.getSession();
//        Transaction tx=session.beginTransaction();
//        Order order = session.get(Order.class,id);
//        session.clear();
//        tx.commit();
//        return order;
        return (Order)baseDao.load(Order.class,orderid);
    }

    public List find(String column,Object value) {
        return baseDao.find(Order.class,column,value);
    }

    public List find(String column1,Object value1, String column2,Object value2) {
        List orders=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "from Order o where "+column1+" =:value1 and "+column2+" =:value2";
            Query query=session.createQuery(hql);
            query.setParameter("value1",value1);
            query.setParameter("value2",value2);
            orders=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return orders;
        }finally {
            session.clear();
            session.close();
        }
        return orders;
    }

    public List find(String column1,Object value1, String column2,Object value2, String column3,Object value3) {
        List orders=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "from Order o where "+column1+" =:value1 and "+column2+" =:value2 and "+column3+" =:value3";
            Query query=session.createQuery(hql);
            query.setParameter("value1",value1);
            query.setParameter("value2",value2);
            query.setParameter("value3",value3);
            orders=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return orders;
        }finally {
            session.clear();
            session.close();
        }
        return orders;
    }

    public List find() {
//        Session session = HibernateUtil.getSession() ;
//        Transaction tx=session.beginTransaction();
//        String hql = "from Order";
//        Query query=session.createQuery(hql);
//        List orders=query.list();
//        session.clear();
//        tx.commit();
//        return orders;
        return baseDao.getAllList(Order.class);
    }

    public List findValidOrderListInOneShow(int showid) {
        List orders=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT * from `order` o WHERE o.showtimeid IN (SELECT st.showtimeid FROM showtime st where st.showid=:showid)" +
                    " AND (o.state=1 OR o.state=2)";
            Query query=session.createNativeQuery(hql).addEntity("o",Order.class);
            query.setParameter("showid",showid);
            orders=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return orders;
        }finally {
            session.clear();
            session.close();
        }
        return orders;
    }

    public int findSeatNumInOneTheater(String theaterid) {
        int seatNum=0;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT ifnull(SUM(o.number),0) as seatNum from `order` o WHERE o.showtimeid IN (SELECT st.showtimeid FROM showtime st, `show` sh " +
                    "where st.showid=sh.showid AND sh.theaterid=:theaterid) AND (o.state=1 OR o.state=2)";
            Query query=session.createNativeQuery(hql).addScalar("seatNum", StandardBasicTypes.INTEGER);
            query.setParameter("theaterid",theaterid);
            seatNum=(Integer) query.list().get(0);
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return seatNum;
        }finally {
            session.clear();
            session.close();
        }
        return seatNum;
    }

    public boolean save(Order order) {
//        Session session = HibernateUtil.getSession() ;
//        Transaction tx=session.beginTransaction();
//        session.save(order);
//        tx.commit();
        return baseDao.save(order);
    }

    public boolean updateById(Order order) {
//        Session session = HibernateUtil.getSession() ;
//        Transaction tx=session.beginTransaction();
//        session.update(order);
//        tx.commit();
        return baseDao.update(order);
    }

    public boolean saveSeat(List orderSeat) {
        return baseDao.saveList(orderSeat);
    }

    public List findSeat(String orderid) {
        return baseDao.find(OrderSeat.class, "orderid",orderid);
    }

    public boolean saveRefund(OrderRefund orderRefund) {
        return baseDao.save(orderRefund);
    }

    public List findRefundList(List orderidList) {
        ArrayList<OrderRefund> refundList = new ArrayList<OrderRefund>();
        for(String orderid:(List<String>)orderidList){
            OrderRefund orderRefund = findRefund(orderid);
            if(orderRefund!=null){
                refundList.add(orderRefund);
            }
        }
        return refundList;
    }

    public OrderRefund findRefund(String orderid) {
        return (OrderRefund) baseDao.load(OrderRefund.class, orderid);
    }

}
