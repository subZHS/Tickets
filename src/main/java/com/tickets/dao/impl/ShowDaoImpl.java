package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import com.tickets.dao.ShowDao;
import com.tickets.model.Show;
import com.tickets.model.ShowTime;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

@Repository
public class ShowDaoImpl implements ShowDao
{
    @Autowired
    private BaseDao baseDao;

    public Show find(int showid) {
        return (Show) baseDao.load(Show.class,showid);
    }

    public List find(String column, Object value) {
        return baseDao.find(Show.class,column,value);
    }

    public List find() {
        return baseDao.getAllList(Show.class);
    }

    public boolean save(Show show) {
        return baseDao.save(show);
    }

    public boolean updateById(Show show) {
         return baseDao.update(show);
    }

    public boolean delete(int showid) {
        return baseDao.delete(Show.class, showid);
    }

    public List<Show> getNotPassShowList(String theaterid) {
        List shows=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            java.util.Date datetime=new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=dateFormat.format(datetime);
            //取出已过当前时间的show
            String hql = "SELECT * FROM `show` s WHERE EXISTS ( SELECT * FROM showtime st WHERE s.showid=st.showid " +
                    "AND CONCAT(st.date,' ',st.time) >= :date) AND s.theaterid=:theaterid";
            Query query=session.createNativeQuery(hql).addEntity("s",Show.class);
            query.setParameter("date",date);
            query.setParameter("theaterid",theaterid);
            shows=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return shows;
        }finally {
            session.clear();
            session.close();
        }
        return shows;
    }

    public List<Show> getNotPassShowList() {
        List shows=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            java.util.Date datetime=new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=dateFormat.format(datetime);
            //取出已过当前时间的show
            String hql = "SELECT * FROM `show` s WHERE EXISTS ( SELECT * FROM showtime st WHERE s.showid=st.showid " +
                    "AND CONCAT(st.date,' ',st.time) >= :date)";
            Query query=session.createNativeQuery(hql).addEntity("s",Show.class);
            query.setParameter("date",date);
            shows=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return shows;
        }finally {
            session.clear();
            session.close();
        }
        return shows;
    }

    public List<Show> getpassedShowList() {
        List shows=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            java.util.Date datetime=new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=dateFormat.format(datetime);
            //取出已过当前时间的show
            String hql = "SELECT * FROM `show` s WHERE NOT EXISTS ( SELECT * FROM showtime st WHERE s.showid=st.showid " +
                    "AND CONCAT(st.date,' ',st.time) >= :date )";
            Query query=session.createNativeQuery(hql).addEntity("s",Show.class);
            query.setParameter("date",date);
            shows=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return shows;
        }finally {
            session.clear();
            session.close();
        }
        return shows;
    }

    public List<Show> getNotInBalanceShowList() {
        List shows=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            java.util.Date datetime=new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=dateFormat.format(datetime);
            //取出已过当前时间的show
            String hql = "SELECT * FROM `show` s WHERE NOT EXISTS ( SELECT * FROM showtime st WHERE s.showid=st.showid " +
                    "AND CONCAT(st.date,' ',st.time) >= :date ) AND s.showid NOT IN (SELECT showid FROM balance)";
            Query query=session.createNativeQuery(hql).addEntity("s",Show.class);
            query.setParameter("date",date);
            shows=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return shows;
        }finally {
            session.clear();
            session.close();
        }
        return shows;
    }

    public List<Show> searchShowList(String key) {
        List shows=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            java.util.Date datetime=new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=dateFormat.format(datetime);
            //取出已过当前时间的show
            String hql = "SELECT * FROM `show` s WHERE s.title LIKE :keyword OR s.actor LIKE :keyword OR s.description LIKE :keyword";
            Query query=session.createNativeQuery(hql).addEntity("s",Show.class);
            query.setParameter("keyword","%"+key+"%");
            shows=query.list();
            if(shows.size()>5){
                for(int i=5;i<shows.size();i++){
                    shows.remove(shows.get(i));
                }
            }
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return shows;
        }finally {
            session.clear();
            session.close();
        }
        return shows;
    }

    public boolean saveShowTimeList(List showTimeList) {
        return baseDao.saveList(showTimeList);
    }

    public boolean updateShowTime(ShowTime showTime) {
        return baseDao.update(showTime);
    }

    public boolean deleteShowTime(String showtimeid) {
        return baseDao.delete(ShowTime.class, showtimeid);
    }

    public List findShowTimeList(int showid) {
        return baseDao.find(ShowTime.class, "showid", showid);
    }

    public List findHaveOrderShowTimeList(int showid) {
        List showtimes=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT * from showtime st where showid =:showid and showtimeid in " +
                    "(SELECT showtimeid FROM `order` o)";
            Query query=session.createNativeQuery(hql).addEntity("st",ShowTime.class);
            query.setParameter("showid",showid);
            showtimes=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return showtimes;
        }finally {
            session.clear();
            session.close();
        }
        return showtimes;
    }

    public List findNoOrderShowTimeList(int showid) {
        List showtimes=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT * from showtime st where showid =:showid and NOT EXISTS " +
                    "(SELECT * FROM `order` o WHERE st.showtimeid=o.showtimeid)";
            Query query=session.createNativeQuery(hql).addEntity("st",ShowTime.class);
            query.setParameter("showid",showid);
            showtimes=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return showtimes;
        }finally {
            session.clear();
            session.close();
        }
        return showtimes;
    }

    public List findShowTimeList(int showid, Date date) {
        List showtimes=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "from ShowTime o where showid =:showid and date =:date";
            Query query=session.createQuery(hql);
            query.setParameter("showid",showid);
            query.setParameter("date",date);
            showtimes=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return showtimes;
        }finally {
            session.clear();
            session.close();
        }
        return showtimes;
    }

    public List<Date> findDateList(int showid) {
        List dates=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT distinct date from ShowTime o where showid =:showid";
            Query query=session.createQuery(hql);
            query.setParameter("showid",showid);
            dates=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return dates;
        }finally {
            session.clear();
            session.close();
        }
        return dates;
    }


    public ShowTime findShowTime(String showtimeid) {
        return (ShowTime) baseDao.load(ShowTime.class, showtimeid);
    }

}
