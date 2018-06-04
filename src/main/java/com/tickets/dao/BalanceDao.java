package com.tickets.dao;

import com.tickets.model.Balance;

import java.util.List;

public interface BalanceDao {

    public Balance find(int showid);

    public List find(String column, Object value);

    public List find();

    public boolean save(Balance balance);

    public boolean updateById(Balance balance);

    public List getNotPayBalaneInOneTheater(String theaterid);

    public List getPayedBalaneInOneTheater(String theaterid);

}
