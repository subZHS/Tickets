package com.tickets.dao;


import com.tickets.model.Show;
import com.tickets.model.ShowTime;

import java.sql.Date;
import java.util.List;

public interface ShowDao {

    public Show find(int showid);

    public List find(String column, Object value);

    public List find();

    public boolean save(Show show);

    public boolean updateById(Show show);

    public boolean delete(int showid);

    public List<Show> getNotPassShowList(String theaterid);

    public List<Show> getNotPassShowList();

    public List<Show> getpassedShowList();

    public List<Show> getNotInBalanceShowList();

    public List<Show> searchShowList(String key);

    public boolean saveShowTimeList(List showTimeList);

    public boolean updateShowTime(ShowTime showTime);

    public boolean deleteShowTime(String showtimeid);

    public List findShowTimeList(int showid);

    public List findHaveOrderShowTimeList(int showid);

    public List findNoOrderShowTimeList(int showid);

    public List findShowTimeList(int showid, Date date);

    public List<Date> findDateList(int showid);

    public ShowTime findShowTime(String showtimeid);

}
