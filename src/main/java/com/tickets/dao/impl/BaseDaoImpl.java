package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import org.aspectj.weaver.ast.Or;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Repository
public class BaseDaoImpl implements BaseDao {
	/** * Autowired ???? ???get() set() */
	@Autowired
	protected SessionFactory sessionFactory;

	/** * gerCurrentSession ?????session????????session?? * * @return */
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	/** * openSession ??????session ?????????session * * @return */
	public Session getNewSession() {
		return sessionFactory.openSession();
	}

	public void flush() {
		getSession().flush();
	}

	public void clear() {
		getSession().clear();
	}

	/** * ?? id ???? * * @param id * @return */
	@SuppressWarnings("rawtypes")
	public Object load(Class c, Serializable id) {
		Session session = getSession();
		Object o=null;
		try {
			o = session.get(c, id);
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
		return o;
	}

	/** * ?????? * * @param c * * @return */

	public List getAllList(Class c) {
		String hql = "from " + c.getName();
		Session session = getSession();
		try {
			return session.createQuery(hql).list();
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
	}

	public List find(Class c,String column,Object value) {
		List orders=null;
		Session session = getNewSession();
		Transaction tx = null;
		try {
			tx=session.beginTransaction();
			String hql = "from "+c.getName()+" o where "+column+" =:value";
			Query query = session.createQuery(hql);
			query.setParameter("value", value);
			orders = query.list();
			tx.commit();
		} catch (Exception e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
			return null;
		}finally {
			session.clear();
			session.close();
		}
		return orders;
	}

	/** * ????? * * @param c * @return */

	public Long getTotalCount(Class c) {
		Long count=null;
		Session session = getNewSession();
		Transaction tx = null;
		try {
			tx=session.beginTransaction();
			String hql = "select count(*) from " + c.getName();
			count = (Long) session.createQuery(hql).uniqueResult();
			tx.commit();
		} catch (Exception e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
		}finally {
			session.clear();
			session.close();
		}
		return count != null ? count.longValue() : 0;
	}

	/** * ?? * * @param bean * */
	public boolean save(Object bean) {
		Session session = getNewSession();
		Transaction tx = null;
		try {
			tx=session.beginTransaction();
			session.save(bean);
			tx.commit();
		} catch (Exception e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
			return false;
		}finally {
			session.clear();
			session.close();
		}
		return true;
	}

	public boolean saveList(List beanList){
		for(Object bean:beanList){
			if(!save(bean)){
				return false;
			}
		}
		return true;
	}

	/** * ?? * * @param bean * */
	public boolean update(Object bean) {
		Session session = getNewSession();
		Transaction tx = null;
		try {
			tx=session.beginTransaction();
			session.update(bean);
			tx.commit();
		} catch (Exception e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
			return false;
		}finally {
			session.clear();
			session.close();
		}
		return true;
	}

	public boolean saveOrUpdate(Object bean) {
		Session session = getNewSession();
		Transaction tx = null;
		try {
			tx=session.beginTransaction();
			session.saveOrUpdate(bean);
			tx.commit();
		} catch (Exception e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
			return false;
		}finally {
			session.clear();
			session.close();
		}
		return true;
	}

	/** * ?? * * @param bean * */
	public boolean delete(Object bean) {
		Session session = getNewSession();
		Transaction tx = null;
		try {
			tx=session.beginTransaction();
			session.delete(bean);
			tx.commit();
		} catch (Exception e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
			return false;
		}finally {
			session.clear();
			session.close();
		}
		return true;
	}

	/** * ??ID?? * * @param c ? * * @param id ID * */
	@SuppressWarnings({ "rawtypes" })
	public boolean delete(Class c, Serializable id) {
		Session session = getNewSession();
		Transaction tx = null;
		try {
			tx=session.beginTransaction();
			Object o = session.get(c,id);
			session.delete(o);
			tx.commit();
		} catch (Exception e) {
			if (tx!=null) tx.rollback();
			e.printStackTrace();
			return false;
		}finally {
			session.clear();
			session.close();
		}
		return true;
	}

	/** * ???? * * @param c ? * * @param ids ID ?? * */
	@SuppressWarnings({ "rawtypes" })
	public boolean delete(Class c, Serializable[] ids) {
		try {
			for (Serializable id : ids) {
				Object obj = getSession().get(c, id);
				if (obj != null) {
					getSession().delete(obj);
				}
			}
			return true;
		}catch (Exception e){
			e.printStackTrace();
			return false;
		}
	}
}
