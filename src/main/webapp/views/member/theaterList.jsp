<%@ page import="java.util.List" %>
<%@ page import="com.tickets.model.Theater" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/table.css" rel="stylesheet" type="text/css" />
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
<br/>
<div class="bottom_text"><span>场馆列表</span><!--<i>南宁</i>--></div>
</br>
    <div class="w3_content_agilleinfo_inner" style="border:none">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <ul id="myTab" class="nav-tabs" role="tablist">
                <li><b>排序： &nbsp;&nbsp;&nbsp;</b></li>
                <li role="presentation" <%if(request.getParameter("orderType").equals("heat")){%> class="active"<%}%>>
                    <a onclick="window.location.href='/publish/theaterList?orderType=heat'" href="javascript:;" id="home-tab" role="tab">按热度</a></li>
                <li role="presentation" <%if(request.getParameter("orderType").equals("showNum")){%> class="active"<%}%>>
                    <a onclick="window.location.href='/publish/theaterList?orderType=showNum'" href="javascript:;" role="tab" >按演出数量</a></li>
                <li role="presentation" <%if(request.getParameter("orderType").equals("minPrice")){%> class="active"<%}%>>
                    <a onclick="window.location.href='/publish/theaterList?orderType=minPrice'" href="javascript:;" role="tab">按最低价格</a></li>
            </ul>
        </div>
    </div>
<br/>
<div class="w3_content_agilleinfo_inner table_list" style="border-top:none">
    <div class="agile_featured_movies">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <div id="myTabContent" class="tab-content">
                <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                    <div class="agile-news-table">
                        <table id="table-breakpoint">
                            <thead>
                            <tr>
                                <th>影院信息</th>
                                <th></th>
                                <th>热度(售出座位数)</th>
                                <th>待售演出数</th>
                                <th>价格起步</th>
                                <th>进入</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%List<Theater> theaterList = (List<Theater>)request.getAttribute("theaterList");
                                Map<String,Integer> heatTheaterMap = (Map<String,Integer>)request.getAttribute("heatTheaterMap");
                                Map<String,Integer> showNumTheaterMap = (Map<String,Integer>)request.getAttribute("showNumTheaterMap");
                                Map<String,Double> minPriceTheaterMap = (Map<String,Double>)request.getAttribute("minPriceTheaterMap");
                            for(int i=0;i<theaterList.size();i++){
                                Theater theater = theaterList.get(i);
                            %>
                            <tr>
                                <td><p>场馆号：<label class="theaterid"><%=theater.getTheaterid()%></label></p>
                                    <div style="min-height: 140px;float: left;margin-right: 10px">
                                        <img src="<%=theater.getImage()%>" style="width:90px" alt="" /></div>
                                </td>
                                <td><h5 style="margin-top: 20px"><%=theater.getName()%></h5>
                                    <span>邮箱：<%=theater.getEmail()%></span><br/>
                                    <span>地址：<%=theater.getLocation()%></span><br/>
                                    <span>电话：<%=theater.getPhonenum()%></span></td>
                                <td><%=heatTheaterMap.get(theater.getTheaterid())%></td>
                                <td><%=showNumTheaterMap.get(theater.getTheaterid())%></td>
                                    <%if(minPriceTheaterMap.get(theater.getTheaterid())>0){%>
                                <td style="font-size: 25px;font-family: georgia;color: #C9302C;">¥<%=minPriceTheaterMap.get(theater.getTheaterid())%></td>
                                    <%}else{%>
                                <td>暂无</td>
                                    <%}%>
                                <td>
                                    <a href="/publish/theater/j<%=theater.getTheaterid()%>" class="btn btn-primary">选座</a>
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
<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
</body>
</html>
