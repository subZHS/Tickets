package com.tickets.dao.impl;

import com.tickets.dao.BaseDao;
import com.tickets.dao.ManagerDao;
import com.tickets.model.Manager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ManagerDaoImpl implements ManagerDao
{
    @Autowired
    private BaseDao baseDao;

    public Manager find(String managerid) {
        return (Manager) baseDao.load(Manager.class,managerid);
    }

    public List find(String column, Object value) {
        return baseDao.find(Manager.class,column,value);
    }

    public List find() {
        return baseDao.getAllList(Manager.class);
    }

    public boolean save(Manager manager) {
        return baseDao.save(manager);
    }

    public boolean updateById(Manager manager) {
        return baseDao.update(manager);
    }

}
