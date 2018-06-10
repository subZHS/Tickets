<%@ page import="com.tickets.model.Show" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tickets.model.ShowTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/table.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/font-awesome.css" rel="stylesheet" type="text/css">
<script src="/resources/js/navanimition.js"></script>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<head>
    <title>theaterList</title>
</head>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<div class="bottom_text"><span style="margin-left: 38.4%;color: #1b6d85;font-size:28px ">${theater.name}</span></div>
<br/>
<div class="w3_content_agilleinfo_inner" style="border-top: none">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <img style="float: right;height: 200px" src="${theater.image}">
            </div>
            <div class="col-md-6" style="display: table;height: 200px">
                <div style="display: table-cell;vertical-align: middle">
                    <h4></h4>
                    <div class="row">
                    <ul class="col-md-1" style="line-height: 35px">
                        <li><i style="font-size: 25px" class="fa fa-map-marker" aria-hidden="true"></i></li>
                        <li><i style="font-size: 25px" class="fa fa-phone" aria-hidden="true"></i></li>
                        <li><i style="font-size: 25px" class="fa fa-envelope" aria-hidden="true"></i></li>
                    </ul>
                    <ul class="col-md-11" style="line-height: 35px">
                        <li>${theater.location}</li>
                        <li>${theater.phonenum}</li>
                        <li>${theater.email}</li>
                    </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="show_part" class="bottom_text"><span>演出</span></div>
<br/>
<%List<Show> showList = (List<Show>)request.getAttribute("showList");
if(showList.size()==0){%>
    <h3 style="text-align: center">暂无演出 -_-</h3>
<%}else{%>
<div style="border-left:1px solid #ccc;border-right:1px solid #ccc;width:1200px;margin:0 auto;">
    <div class="w3_content_agilleinfo_inner">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <ul class="nav-tabs" role="tablist">
                <li><b>演出列表： &nbsp;&nbsp;&nbsp;</b></li>
                <%Show show =(Show) request.getAttribute("show");
                    for(Show show1:showList){%>
                <li role="presentation" <%if(show1.getShowid()==show.getShowid()){%> class="active"<%}%>>
                    <a href="/publish/theater/j${theater.theaterid}/show/j<%=show1.getShowid()%>" role="tab"><%=show1.getTitle()%></a></li>
                <%}%>
            </ul>
        </div>
    </div>

    <div class="w3_content_agilleinfo_inner" style="padding-bottom:35px;border-bottom: 1px solid #ccc">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <ul id="myTab" class="nav-tabs" role="tablist">
                <li><b>演出时间： &nbsp;&nbsp;&nbsp;</b></li>
                <%List<String> dateStrList = (List<String>)request.getAttribute("dateStrList");
                String date=(String)request.getAttribute("date");
                for(String dateStr:dateStrList){%>
                <li role="presentation" <%if(dateStr.equals(date)){%> class="active"<%}%>>
                    <a href="/publish/theater/j${theater.theaterid}/show/j${show.showid}?date=<%=dateStr%>" role="tab"><%=dateStr%></a></li>
                <%}%>
            </ul>
        </div>
    </div>
</div>

<div class="w3_content_agilleinfo_inner" style="border-top: none">
    <div class="container">
        <div class="row">
            <div class="col-md-2">
                <img style="height: 200px" src="${show.image}">
            </div>
            <div class="col-md-10">
                <div>
                    <h4 style="color: #459bdc;font-size: 20px;padding-bottom:10px;border-bottom: 1px solid #ccc;">
                        <b>${show.title}</b></h4>
                    <div class="row">
                        <ul class="col-md-2" style="line-height: 30px">
                            <li>类&emsp;&emsp;型 ：</li>
                            <li>参演人员 ：</li>
                            <li>价&emsp;&emsp;格 ：</li>
                            <li>简&emsp;&emsp;介 ：</li>
                        </ul>
                        <ul class="col-md-10" style="line-height: 30px;position: relative;left: -3%">
                            <li>${showTypeStr}</li>
                            <li>${show.actor}</li>
                            <li><span style="font-size: 25px;font-family: georgia;color: #C9302C;">¥${minPrice}</span> 起</li>
                            <li>${show.description}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="w3_content_agilleinfo_inner table_list" style="border-top:none">
    <div class="agile_featured_movies">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <div id="myTabContent" class="tab-content">
                <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                    <div class="agile-news-table">
                        <table id="table-breakpoint">
                            <thead>
                            <tr>
                                <th>放映时间</th>
                                <th>剩余座位数</th>
                                <th>购票</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%List<ShowTime> showTimeList = (List<ShowTime>)request.getAttribute("showTimeList");
                            SimpleDateFormat sdfTime=new SimpleDateFormat("HH:mm");
                            for(ShowTime showTime:showTimeList){
                            %>
                            <tr>
                                <td><%=sdfTime.format(showTime.getTime())%></td>
                                <td><%=showTime.getRemainNum()%></td>
                                <td>
                                    <%if(show.isIsopen()) {
                                        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
                                        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                        java.util.Date showDate=sdf.parse(sdfDate.format(showTime.getDate())+" "+sdfTime.format(showTime.getTime()));
                                        if(new java.util.Date().after(showDate)){%>
                                          购票结束
                                        <%}else{
                                    %>
                                    <a href="javascript:;" onclick="buyTicket($(this))" data-href="/member/j${sessionScope.member.memberid}/buyTickets/j<%=showTime.getShowtimeid()%>" class="btn btn-primary">购票</a>
                                    <%}}else{%>
                                    暂未开票
                                    <%}%>
                                </td>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%}%>
<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<script>
    function buyTicket(a) {
        $.ajax({
            type: 'get', url: '/checkMemberLogined',
            data: {},
            cache: false, dataType: 'json',
            success: function (logined) {
                if(!logined){
                    alert("请先以会员身份登录");
                    window.location.href="/login";
                }else{
                    window.location.href=a.data("href");
                }
            }
        });
    }
</script>
</body>
</html>
