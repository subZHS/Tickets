package com.tickets.util;

import com.tickets.model.OrderSeat;
import com.tickets.model.ShowTime;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SeatFormat {

    static public List<String[]> formatSeat(List<ShowTime> showTimeList){
        List<String[]> seatList=new ArrayList<String[]>();
        for(ShowTime showTime:showTimeList){
            String original=showTime.getSeatCondition();
            original=original.replaceAll("2","b");
            original=original.replaceAll("1","a");
            original=original.replaceAll("0","_");
            String[] rows=original.split("\n");
            seatList.add(rows);
        }
        return seatList;
    }

    static public String[] formatSeatStr(String seatStr){
        seatStr=seatStr.replaceAll("2","b");
        seatStr=seatStr.replaceAll("1","a");
        seatStr=seatStr.replaceAll("0","_");
        String[] rows=seatStr.split("\n");
        return rows;
    }

}
