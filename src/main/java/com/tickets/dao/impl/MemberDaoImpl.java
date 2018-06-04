package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import com.tickets.dao.MemberDao;
import com.tickets.model.Member;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberDaoImpl implements MemberDao
{
    @Autowired
    private BaseDao baseDao;

    public Member find(String memberid) {
        Member member= (Member) baseDao.load(Member.class, memberid);
        return member;
    }

    public List find(String column, Object value) {
        return baseDao.find(Member.class,column,value);
    }

    public List find() {
        return baseDao.getAllList(Member.class);
    }

    public boolean save(Member member) {
        return baseDao.save(member);
    }

    public boolean updateById(Member member) {
        return baseDao.update(member);
    }

    public List<Member> getTop10ConsumeMemberList() {
        List members=null;
        Session session = baseDao.getNewSession();
        Transaction tx = null;
        try {
            tx=session.beginTransaction();
            String hql = "SELECT * from `member` m ORDER BY m.consumption DESC limit 10";
            Query query=session.createNativeQuery(hql).addEntity("m",Member.class);
            members=query.list();
            tx.commit();
        } catch (Exception e) {
            if (tx!=null) tx.rollback();
            e.printStackTrace();
            return members;
        }finally {
            session.clear();
            session.close();
        }
        return members;
    }

}
