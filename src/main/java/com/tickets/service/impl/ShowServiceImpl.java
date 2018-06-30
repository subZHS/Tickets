package com.tickets.service.impl;

import com.tickets.dao.ShowDao;
import com.tickets.model.*;
import com.tickets.service.BalanceService;
import com.tickets.service.OrderService;
import com.tickets.service.ShowService;
import com.tickets.service.TheaterService;
import com.tickets.util.DateCompare;
import com.tickets.util.ShowType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ShowServiceImpl implements ShowService {

    @Autowired
    private ShowDao showDao;

    @Autowired
    private TheaterService theaterService;

    @Autowired
    private OrderService orderService;
    @Autowired
    private BalanceService balanceService;

    public int newShow(Show show) {
        if(!showDao.save(show)){
            return -1;
        }
        return getShow(show.getTheaterid(),show.getTitle(),show.getType()).getShowid();
    }

    public List<Show> getfilterShowList(boolean isOpen, ShowType showType, boolean orderByHeatOrPrice) {
        try {
            refleshShowState();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Show> showList = showDao.getNotPassShowList();
        List<Show> filterList = new ArrayList<Show>();
        int showTypeInt = showType.ordinal();
        for(Show show:showList){
            if(showTypeInt==6) {
                if (show.isIsopen() == isOpen) {
                    filterList.add(show);
                }
            }else{
                if(show.isIsopen()==isOpen&&show.getType()==showTypeInt){
                    filterList.add(show);
                }
            }
        }
        //排序
        if(orderByHeatOrPrice){//按热度倒序排序
            if(!isOpen){
                return filterList;
            }
            Collections.sort(filterList, new Comparator<Show>() {
                public int compare(Show o1, Show o2) {
                    int orderNum1 = orderService.getValidSeatNumInOneShow(o1.getShowid());
                    int orderNum2 = orderService.getValidSeatNumInOneShow(o2.getShowid());
                    return orderNum2-orderNum1;
                }
            });
        }else{//按价格排序
            Collections.sort(filterList, new Comparator<Show>() {
                public int compare(Show o1, Show o2) {
                    double minPrice1 = findMinPrice(o1.getPrice1(),o1.getPrice2(),o1.getPrice3());
                    double minPrice2 = findMinPrice(o2.getPrice1(),o2.getPrice2(),o2.getPrice3());
                    return (int)(minPrice1-minPrice2);
                }
            });
        }
        return filterList;
    }

    //刷新演出开票状态
    public void refleshShowState(String theaterid) throws ParseException {
        List<Show> showList = getNotOnSaleList(theaterid);
        java.util.Date curDate = new java.util.Date();
        for(Show show : showList){
            ArrayList<ShowTime> showTimeArrayList = (ArrayList<ShowTime>)showDao.findShowTimeList(show.getShowid());
            java.util.Date earlyDate = DateCompare.findEarlyDate(showTimeArrayList);
            //开票时间是两周前
            java.util.Date openTime=new java.util.Date(earlyDate.getTime()- (long)14 * 24 * 60 * 60 * 1000);
            if(openTime.before(curDate)){//两周前
                show.setIsopen(true);
            }
            showDao.updateById(show);
        }

    }

    public void refleshShowState() throws ParseException{
        List<Show> showList = getNotOnSaleList();
        java.util.Date curDate = new java.util.Date();
        for(Show show : showList){
            ArrayList<ShowTime> showTimeArrayList = (ArrayList<ShowTime>)showDao.findShowTimeList(show.getShowid());
            java.util.Date earlyDate = DateCompare.findEarlyDate(showTimeArrayList);
            //开票时间是两周前
            java.util.Date openTime=new java.util.Date(earlyDate.getTime()- (long)14 * 24 * 60 * 60 * 1000);
            if(openTime.before(curDate)){//两周前
                show.setIsopen(true);
            }
            showDao.updateById(show);
        }
    }

    public int getShowNumInOneType(ShowType showType) {
        List<Show> showList= showDao.find("type",showType.ordinal());
        if(showList==null){
            return 0;
        }
        return showList.size();
    }

    /*
    top10演出收入：演出名：收入
     */
    public List<Map.Entry<String, Double>> getTop10ShowIncome() {
        List<Show> showList=showDao.find();
        Map<String,Double> showIncomeMap=new HashMap<String, Double>();
        for(Show show:showList){
            double showIncome=orderService.getShowIncome(show.getShowid());
            showIncomeMap.put(show.getTitle(),showIncome);
        }
        //排序
        List<Map.Entry<String, Double>> showIncomeMapList = new ArrayList<Map.Entry<String, Double>>(showIncomeMap.entrySet());
        Collections.sort(showIncomeMapList, new Comparator<Map.Entry<String, Double>>() {
            public int compare(Map.Entry<String, Double> o1, Map.Entry<String, Double> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });
        if(showIncomeMapList.size()>10) {
            showIncomeMapList = showIncomeMapList.subList(0, 10);
        }
        return showIncomeMapList;
    }


    public List<Show> getShowList(String theaterid) {
        try {//每次打开演出列表都刷新一次演出开票状态
            refleshShowState(theaterid);
            balanceService.refleshBalance();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Show> showList = showDao.find("theaterid",theaterid);
        if(showList==null){
            showList=new ArrayList<Show>();
        }
        return showList;
    }

    public List<Show> getNotOnSaleList(String theaterid) {
        List<Show> showList = showDao.find("theaterid",theaterid);
        List<Show> notOnSaleShowList=new ArrayList<Show>();
        for(Show show:showList){//获得未开票的列表
            if(!show.isIsopen()){
                notOnSaleShowList.add(show);
            }
        }
        return notOnSaleShowList;
    }

    public List<Show> getNotOnSaleList() {
        List<Show> showList = showDao.find("isopen",false);
        if(showList==null){
            return new ArrayList<Show>();
        }
        return showList;
    }

    public List<Show> getOnSaleList(String theaterid) {
        List<Show> showList = showDao.getNotPassShowList(theaterid);
        List<Show> onSaleShowList=new ArrayList<Show>();
        for(Show show:showList){//获得未开票的列表
            if(show.isIsopen()){
                onSaleShowList.add(show);
            }
        }
        return onSaleShowList;
    }

    public List<Show> getNotPassList(String theaterid) {
        try {
            refleshShowState(theaterid);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Show> showList = showDao.getNotPassShowList(theaterid);
        if(showList==null){
            return new ArrayList<Show>();
        }else{
            return showList;
        }
    }

    public List<Show> searchShowList(String key) {
        List<Show> showList = showDao.searchShowList(key);
        if(showList==null){
            return new ArrayList<Show>();
        }
        return showList;
    }

    public Show getShow(String theaterid, String title, int showType){
        List<Show> showList = showDao.find("theaterid",theaterid);
        for(Show show : showList){
            if(show.getTitle().equals(title)&&show.getType()==showType){
                return show;
            }
        }
        return null;
    }

    public Show getShow(int showid) {
        return showDao.find(showid);
    }

    public List<ShowTime> getShowTimeList(int showid){
        List<ShowTime> showTimes= showDao.findShowTimeList(showid);
        if(showTimes==null){
            showTimes=new ArrayList<ShowTime>();
        }
        return showTimes;
    }

    public List<ShowTime> getHaveOrderShowTimeList(int showid) {
        List<ShowTime> showTimes= showDao.findHaveOrderShowTimeList(showid);
        if(showTimes==null){
            showTimes=new ArrayList<ShowTime>();
        }
        return showTimes;
    }

    public List<ShowTime> getNoOrderShowTimeList(int showid) {
        List<ShowTime> showTimes= showDao.findNoOrderShowTimeList(showid);
        if(showTimes==null){
            showTimes=new ArrayList<ShowTime>();
        }
        return showTimes;
    }


    public List<Date> getDateList(int showid) {
        List<Date> dates = showDao.findDateList(showid);
        if(dates==null){
            dates=new ArrayList<Date>();
        }
        return dates;
    }

    public List<ShowTime> getShowTimeList(int showid, Date date) {
        List<ShowTime> showTimes = showDao.findShowTimeList(showid,date);
        if(showTimes==null){
            showTimes=new ArrayList<ShowTime>();
        }
        return showTimes;
    }

    public ShowTime getShowTime(String showtimeid) {
        return showDao.findShowTime(showtimeid);
    }

    public boolean modifyShow(Show show) {
        return showDao.updateById(show);
    }

    public boolean deleteShowTime(String showtimeid) {
        return showDao.deleteShowTime(showtimeid);
    }

    public boolean addShowTimeList(List showtimeList) {
        for(ShowTime showtime:(ArrayList<ShowTime>)showtimeList) {
            //完善showtimeid=showid+date+time
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat sdf2 = new SimpleDateFormat("HHmm");
            String showtimeid = String.valueOf(showtime.getShowid()) + sdf1.format(showtime.getDate()) + sdf2.format(showtime.getTime());
            showtime.setShowtimeid(showtimeid);

            // 完善seatCondition，remianNum
            Theater theater = theaterService.getTheater(showDao.find(showtime.getShowid()).getTheaterid());
            String seatCondition = theater.getSeat();
            int remainNum = charAppearTimes(seatCondition, '1');
            showtime.setSeatCondition(seatCondition);
            showtime.setRemainNum(remainNum);
        }
        return showDao.saveShowTimeList(showtimeList);
    }

    /*选座购票*/
    public boolean occupySeat(String showtimeid, List<OrderSeat> orderSeatList) {
        ShowTime showTime=showDao.findShowTime(showtimeid);
        if(showTime.getRemainNum()<orderSeatList.size()){
            return false;
        }
        showTime.setRemainNum(showTime.getRemainNum()-orderSeatList.size());
        char[] seatCondition=showTime.getSeatCondition().toCharArray();
        //去对应位置把可选1修改成已选2
        for(OrderSeat orderSeat:orderSeatList){
            //所选行的第一列的index-1
            int baseIndex=getCharTimesIndex(showTime.getSeatCondition(),"\n",orderSeat.getSeatRow()-1);
            int index=baseIndex+orderSeat.getSeatColumn();
            seatCondition[index]='2';
        }
        showTime.setSeatCondition(String.valueOf(seatCondition));
        return showDao.updateShowTime(showTime);
    }

    /*不选座购票*/
    public boolean noSeatOccupy(String showtimeid, int number) {
        ShowTime showTime=showDao.findShowTime(showtimeid);
        if(showTime.getRemainNum()<number){
            return false;
        }
        showTime.setRemainNum(showTime.getRemainNum()-number);
        return showDao.updateShowTime(showTime);
    }

    /*在退款或超出支付时间后，释放所占座位，分为选座和不选座两种,如果是不选座，orderSeatList为null或空*/
    public boolean releaseOccupy(String showtimeid, List<OrderSeat> orderSeatList, int number) {
        ShowTime showTime=showDao.findShowTime(showtimeid);
        //判断是不是选座购买
        if(orderSeatList!=null&&orderSeatList.size()!=0){
            char[] seatCondition=showTime.getSeatCondition().toCharArray();
            //去对应位置把已选2修改成可选1
            for(OrderSeat orderSeat:orderSeatList){
                //所选行的第一列的index-1
                int baseIndex=getCharTimesIndex(showTime.getSeatCondition(),"\n",orderSeat.getSeatRow()-1);
                int index=baseIndex+orderSeat.getSeatColumn();
                seatCondition[index]='1';
            }
            showTime.setSeatCondition(String.valueOf(seatCondition));
        }
        showTime.setRemainNum(showTime.getRemainNum()+number);
        return showDao.updateShowTime(showTime);
    }

    /*检票时，给不选座买票的人分配座位,并在数据库保存OrderSeat即分配到的座位，并在数据库的showtime表中已更新座位情况*/
    public List<OrderSeat> distributeSeat(String orderid, int number) {
        List<OrderSeat> orderSeatList=new ArrayList<OrderSeat>();

        String showtimeid=orderService.getOrder(orderid).getShowtimeid();
        ShowTime showTime=showDao.findShowTime(showtimeid);
        char[] seatCondition=showTime.getSeatCondition().toCharArray();
        //寻找分配的座位
        for(int i=0;i<number;i++){
            //找到第一个空余座位，然后设置为已选座位
            String seatStr=String.valueOf(seatCondition);
            int firstAvailableSeat=seatStr.indexOf('1');
            seatCondition[firstAvailableSeat]='2';
            //计算row和column
            int row=charAppearTimes(seatStr.substring(0,firstAvailableSeat+1),'\n')+1;
            int baseIndex=seatStr.substring(0, firstAvailableSeat+1).lastIndexOf('\n');
            int column = firstAvailableSeat-baseIndex;

            OrderSeat orderSeat = new OrderSeat();
            orderSeat.setSeatRow(row);
            orderSeat.setSeatColumn(column);
            orderSeatList.add(orderSeat);
        }
        //及时更改场次的座位情况
        showTime.setSeatCondition(String.valueOf(seatCondition));
        showDao.updateShowTime(showTime);

        Show show=showDao.find(showTime.getShowid());
        orderSeatList=theaterService.getSeatType(show.getTheaterid(),orderSeatList);
        //给座位分配价格，立即购买的单价为最低价，并添加座位类型0（不选座购买），和订单号
        double minPrice=findMinPrice(show.getPrice1(),show.getPrice2(),show.getPrice3());
        for(OrderSeat orderSeat:orderSeatList){
            orderSeat.setPrice(minPrice);
            orderSeat.setSeattype(0);
            orderSeat.setOrderid(orderid);
        }
        //保存分配的座位
        orderService.saveOrderSeatList(orderSeatList);

        return orderSeatList;
    }

    public List<OrderSeat> calculateSeatPrice(String showtimeid, List<OrderSeat> orderSeatList) {
        ShowTime showTime=showDao.findShowTime(showtimeid);
        Show show=showDao.find(showTime.getShowid());
        //获取座位类型
        orderSeatList=theaterService.getSeatType(show.getTheaterid(),orderSeatList);
        //根据座位类型确定价格
        for(OrderSeat orderSeat:orderSeatList){
            if(orderSeat.getSeattype()==1){
                orderSeat.setPrice(show.getPrice1());
            }else if(orderSeat.getSeattype()==2){
                orderSeat.setPrice(show.getPrice2());
            }else if(orderSeat.getSeattype()==3){
                orderSeat.setPrice(show.getPrice3());
            }
        }
        return orderSeatList;
    }

    public double calculateNoSeatPrice(String showtimeid, int number) {
        ShowTime showTime=showDao.findShowTime(showtimeid);
        Show show=showDao.find(showTime.getShowid());
        return findMinPrice(show.getPrice1(),show.getPrice2(),show.getPrice3())*number;
    }

    /*orderSeatList中只包括row和column*/
    public boolean offlineOrder(String showtimeid, List<OrderSeat> orderSeatList) {
        return occupySeat(showtimeid,orderSeatList);
    }

    public List<Show> getTop10ShowList() {
        try {
            refleshShowState();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Show> showList = showDao.getNotPassShowList();
        //按热度倒序排序
        Collections.sort(showList, new Comparator<Show>() {
            public int compare(Show o1, Show o2) {
                int orderNum1 = orderService.getValidSeatNumInOneShow(o1.getShowid());
                int orderNum2 = orderService.getValidSeatNumInOneShow(o2.getShowid());
                return orderNum2-orderNum1;
            }
        });
        if(showList.size()>=10) {
            showList = showList.subList(0, 10);
        }
        return showList;
    }

    public List<Show> getPassedShowList() {
        List<Show> showList= showDao.getpassedShowList();
        if(showList==null){
            showList=new ArrayList<Show>();
        }
        return showList;
    }

    public List<Show> getNotInBalanceShowList() {
        List<Show> showList= showDao.getNotInBalanceShowList();
        if(showList==null){
            showList=new ArrayList<Show>();
        }
        return showList;
    }

    public Double minPriceInTheater(String theaterid) {
        List<Show> showList = getOnSaleList(theaterid);
        if(showList.size()==0){
            return -1.0;
        }
        double minPrice=findMinPrice(showList.get(0).getPrice1(),showList.get(0).getPrice2(),showList.get(0).getPrice3());
        for(Show show:showList){
            double price=findMinPrice(show.getPrice1(),show.getPrice2(),show.getPrice3());
            if(price<minPrice){
                minPrice=price;
            }
        }
        return minPrice;
    }

    /*得到某个字符在字符串中出现的次数*/
    private int charAppearTimes(String str, char c){
        int times=0;
        for(char i:str.toCharArray()){
            if(i==c){
                times++;
            }
        }
        return times;
    }

    /*得到某个字符在字符串中出现第N次时的下标*/
    private int getCharTimesIndex(String str, String modelStr, int times){
        if(times==0){
            return -1;
        }
        //对子字符串进行匹配
        Matcher slashMatcher = Pattern.compile(modelStr).matcher(str);
        int index = 0;
        //matcher.find();尝试查找与该模式匹配的输入序列的下一个子序列
        while(slashMatcher.find()) {
            index++;
            //当modelStr字符第count次出现的位置
            if(index == times){
                break;
            }
        }
        //matcher.start();返回以前匹配的初始索引。
        return slashMatcher.start();
    }

    /*得到三个价格中最低价*/
    public double findMinPrice(double price1, double price2, double price3){
        return Math.min(price1,Math.min(price2,price3));
    }
}
