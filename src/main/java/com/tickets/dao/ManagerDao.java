package com.tickets.dao;

import com.tickets.model.Manager;

import java.util.List;

public interface ManagerDao {

    public Manager find(String managerid);

    public List find(String column, Object value);

    public List find();

    public boolean save(Manager manager);

    public boolean updateById(Manager manager);

}
