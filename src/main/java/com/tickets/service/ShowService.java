package com.tickets.service;

import com.tickets.model.OrderSeat;
import com.tickets.model.Show;
import com.tickets.model.ShowTime;
import com.tickets.util.ShowType;

import java.sql.Date;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface ShowService {

    /*
    发布演出,返回showid，用于创建showtime
     */
    public int newShow(Show show);

    public List<Show> getfilterShowList(boolean isOpen, ShowType showType, boolean orderByHeatOrPrice);

    /*
    得到演出列表
     */
    public List<Show> getShowList(String theaterid);

    /*
    得到未开票演出列表
     */
    public List<Show> getNotOnSaleList(String theaterid);

    public List<Show> getNotOnSaleList();

    /*
    得到正在售票演出列表
     */
    public List<Show> getOnSaleList(String theaterid);

    public List<Show> getNotPassList(String theaterid);

    public List<Show> searchShowList(String key);

    /*
    得到演出详情
     */
    public Show getShow(int showid);

    public Show getShow(String theaterid, String title, int showType);

    /*
    得到某演出的所有演出时间列表
     */
    public List<ShowTime> getShowTimeList(int showid);

    /*
    得到某演出的已经有订单的所有演出时间列表
     */
    public List<ShowTime> getHaveOrderShowTimeList(int showid);

    /*
    得到没有售票过的所有场次列表
     */
    public List<ShowTime> getNoOrderShowTimeList(int showid);

    /*
    得到某演出的日期列表
     */
    public List<Date> getDateList(int showid);

    /*
    得到某演出某日期的时间列表
     */
    public List<ShowTime> getShowTimeList(int showid, Date date);

    public ShowTime getShowTime(String showtimeid);

    /*
    修改演出详情
     */
    public boolean modifyShow(Show show);

    /*
    删除某场次，如果已售票，不可以删除该场次
     */
    public boolean deleteShowTime(String showtimeid);

    /*
    添加某场次
     */
    public boolean addShowTimeList(List showTimeList);

    //买票相关

    /*
    选座购票
     */
    public boolean occupySeat(String showtimeid, List<OrderSeat> orderSeatList);

    /*
    不选座买票
     */
    public boolean noSeatOccupy(String showtimeid, int number);

    /*
    在退款或超出支付时间后，释放所占座位，分为选座和不选座两种
     */
    public boolean releaseOccupy(String showtimeid, List<OrderSeat> orderSeatList, int number);

    /*
    检票时，给不选座买票的人分配座位
     */
    public List<OrderSeat> distributeSeat(String orderid, int number);

    /*
    计算座位价格,调用TheaterService的getSeatType
     */
    public List<OrderSeat> calculateSeatPrice(String showtimeid, List<OrderSeat> orderSeatList);

    /*
    计算不选座购买的价格
     */
    public double calculateNoSeatPrice(String showtimeid, int number);

    /*
    线下购票
     */
    public boolean offlineOrder(String showtimeid, List<OrderSeat> orderSeatList);

    //同层调用

    /*
    取出已经演出完了show列表
     */
    public List<Show> getPassedShowList();

    /*
    取出已演完但还没有添加到balance的show列表
     */
    public List<Show> getNotInBalanceShowList();

    public Double minPriceInTheater(String theaterid);

    public double findMinPrice(double price1, double price2, double price3);

    public void refleshShowState(String theaterid) throws ParseException;

    public void refleshShowState() throws ParseException;

    public int getShowNumInOneType(ShowType showType);

    public List<Map.Entry<String, Double>> getTop10ShowIncome();

}
