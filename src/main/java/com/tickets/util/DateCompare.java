package com.tickets.util;

import com.tickets.model.ShowTime;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class DateCompare {

    static public java.util.Date findEarlyDate(ArrayList<ShowTime> showTimeList) throws ParseException {
        SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfTime = new SimpleDateFormat("hh:mm");
        String earlyDateTimeStr = sdfDate.format(showTimeList.get(0).getDate())+" "+sdfTime.format(showTimeList.get(0).getTime());
        java.util.Date earlyDateTime = sdfDate.parse(earlyDateTimeStr);
        for(ShowTime showTime:showTimeList) {
            String dateTimeStr = sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime());
            java.util.Date dateTime = sdfDate.parse(dateTimeStr);
            if(dateTime.before(earlyDateTime)){
                earlyDateTime = dateTime;
            }
        }
        return earlyDateTime;
    }

    static public java.util.Date findEarlyDate(String[] showTimeList) throws ParseException {
        SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        java.util.Date earlyDateTime = sdfDateTime.parse(showTimeList[0]);
        for(String showTimeStr:showTimeList) {
            java.util.Date dateTime = sdfDateTime.parse(showTimeStr);
            if(dateTime.before(earlyDateTime)){
                earlyDateTime = dateTime;
            }
        }
        return earlyDateTime;
    }
}
