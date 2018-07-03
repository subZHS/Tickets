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

<link href="/resources/css/public.css"rel="stylesheet" type="text/css" />

<link href="/resources/css/theaterList.css"rel="stylesheet" type="text/css" />

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

<div class="bottom_text" style="margin-top:100px"><span>场馆列表</span><!--<i>南宁</i>--></div>

</br>
<div class="w3_content_agilleinfo_inner" style="border:none">
    <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
        <ul id="myTab" class="nav-tabs" role="tablist">
            <li><b>排序： &nbsp;&nbsp;&nbsp;</b></li>
            <li role="presentation" <%if(request.getParameter("orderType").equals("heat")){%> class="active"<%}%>>
                <a onclick="window.location.href='/publish/theaterList?orderType=heat'" href="javascript:;" id="home-tab" role="tab">按热度
                    <img src="/resources/images/seat.png" alt="" style="width: 16px;display: inline"/>
                </a></li>
            <li role="presentation" <%if(request.getParameter("orderType").equals("showNum")){%> class="active"<%}%>>
                <a onclick="window.location.href='/publish/theaterList?orderType=showNum'" href="javascript:;" role="tab" >按演出数量
                    <img src="/resources/images/movie_ico.png" alt="" style="width: 16px;display: inline"/>
                </a></li>
            <li role="presentation" <%if(request.getParameter("orderType").equals("minPrice")){%> class="active"<%}%>>
                <a onclick="window.location.href='/publish/theaterList?orderType=minPrice'" href="javascript:;" role="tab">按最低价格</a></li>
        </ul>
    </div>
</div>
<br/>

<!-- latest blog start -->
<div class="latest-blog-area">
    <div class="w3_content_agilleinfo_inner" style="border: none">
        <div class="row">
            <div class="latest-blog-slider">
                <%List<Theater> theaterList = (List<Theater>)request.getAttribute("theaterList");
                    Map<String,Integer> heatTheaterMap = (Map<String,Integer>)request.getAttribute("heatTheaterMap");
                    Map<String,Integer> showNumTheaterMap = (Map<String,Integer>)request.getAttribute("showNumTheaterMap");
                    Map<String,Double> minPriceTheaterMap = (Map<String,Double>)request.getAttribute("minPriceTheaterMap");
                    for(int i=0;i<theaterList.size();i++){
                        Theater theater = theaterList.get(i);
                %>
                <div class="col-md-6">
                    <div class="single-latest-blog row">
                        <div class="single-latest-blog-img">
                            <a>
                                <img src="<%=theater.getImage()%>" alt="">
                            </a>
                        </div>
                        <div class="single-latest-blog-text">
                            <div class="date-comment clearfix">
                                <h4><%=theater.getName()%></h4>
                                <%if(minPriceTheaterMap.get(theater.getTheaterid())>0){%>
                                <h5><label style="float: right;margin:5px 5px;font-weight: 400"><label style="font-size: 16px;font-family: georgia;color: #C9302C;">¥<%=minPriceTheaterMap.get(theater.getTheaterid())%></label>起</label></h5>
                                <%}else{%>
                                <h5><label style="float: right;margin:5px 5px;font-weight: 400"><label style="font-size: 16px;font-weight: 400">¥暂无</label></label></h5>
                                <%}%>
                            </div>
                            <div class="blog-content">
                                <p>邮箱：<%=theater.getEmail()%></p>
                                <p>地址：<%=theater.getLocation()%></p>
                                <p>电话：<%=theater.getPhonenum()%></p>
                            </div>
                            <div class="continue-reading">
                                    <div class="main_bottom">
                                        <span title="已售出座位数"><%=heatTheaterMap.get(theater.getTheaterid())%></span>
                                        <span title="待售演出数"><%=showNumTheaterMap.get(theater.getTheaterid())%></span></div>
                                <div class="blog-icon">
                                    <a href="/publish/theater/j<%=theater.getTheaterid()%>" style="display: none" class="btn btn-primary">详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>
<!-- blog end -->

<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<script>
    $(".single-latest-blog").mouseover(function () {
        $(this).find(".blog-icon a").show();
    });
    $(".single-latest-blog").mouseout(function () {
        $(this).find(".blog-icon a").hide();
    });
</script>
</body>
</html>
