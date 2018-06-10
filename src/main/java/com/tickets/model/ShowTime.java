package com.tickets.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name="`showtime`")
public class ShowTime implements Serializable{

    @Id
    private String showtimeid;
    private int showid;
    private Date date;
    private Time time;
    private String seatCondition;
    private int remainNum;

    public String getShowtimeid() {
        return showtimeid;
    }

    public void setShowtimeid(String showtimeid) {
        this.showtimeid = showtimeid;
    }

    public int getShowid() {
        return showid;
    }

    public void setShowid(int showid) {
        this.showid = showid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public String getSeatCondition() {
        return seatCondition;
    }

    public void setSeatCondition(String seatCondition) {
        this.seatCondition = seatCondition;
    }

    public int getRemainNum() {
        return remainNum;
    }

    public void setRemainNum(int remainNum) {
        this.remainNum = remainNum;
    }
}
