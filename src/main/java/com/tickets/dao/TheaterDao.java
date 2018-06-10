package com.tickets.dao;

import com.tickets.model.Show;
import com.tickets.model.Theater;
import com.tickets.model.TheaterModify;

import java.util.List;

public interface TheaterDao {

    public Theater find(String theaterid);

    public List find(String column, Object value);

    public List find();

    public List searchTheaterList(String key);

    public boolean save(Theater theater);

    public boolean delete(String theaterid);

    public boolean updateById(Theater theater);

    public boolean saveTheaterModify(TheaterModify theaterModify);

    public boolean saveOrUpdateTheaterModify(TheaterModify theaterModify);

    public boolean deleteTheaterModify(String theaterid);

    public List findTheaterModifyList();

    public TheaterModify findTheaterModify(String theaterid);

}
