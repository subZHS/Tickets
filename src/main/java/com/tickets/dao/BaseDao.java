package com.tickets.dao;

import org.hibernate.Session;

import java.io.Serializable;
import java.util.List;


public interface BaseDao {

	public Session getSession();

	public Session getNewSession();
	
	public void flush();

	public void clear() ;

	public Object load(Class c, Serializable id) ;

	public List getAllList(Class c) ;

	public List find(Class c,String column,Object value);

	public Long getTotalCount(Class c) ;

	public boolean save(Object bean) ;

	public boolean saveList(List beanList);

	public boolean update(Object bean) ;

	public boolean saveOrUpdate(Object bean) ;

	public boolean delete(Object bean) ;
	
	public boolean delete(Class c, Serializable id) ;

	public boolean delete(Class c, Serializable[] ids) ;
}
