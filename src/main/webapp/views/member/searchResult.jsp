<%@ page import="com.tickets.model.Show" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tickets.model.Theater" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/table.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/theaterList.css"rel="stylesheet" type="text/css" />
<script src="/resources/js/navanimition.js"></script>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<br/>

<div class="bottom_text" style="margin-top: 100px"><span>搜索到的电影</span></div>

<br/>

<div class="banner" style="border: 0;">
    <ul>
        <%
            List<Show> showList = (List<Show>)request.getAttribute("showList");
            if(showList.size()==0){%>
        <h3 style="text-align: center">Sorry, cannot search relative shows -_-</h3>
        <%}else{
            List<String> showTypeList=(List<String>)request.getAttribute("showTypeList");
//            List<Integer> orderNumList=(List<Integer>)request.getAttribute("orderNumList");
            List<String> theaterNameList=(List<String>)request.getAttribute("theaterNameList");
            List<String> theaterIdList=(List<String>)request.getAttribute("theaterIdList");
            for(int i=0;i<showList.size();i++){
                Show show = showList.get(i);
                double minPrice=Math.min(show.getPrice1(),Math.min(show.getPrice2(),show.getPrice3()));
        %>
        <li <%if(i%5==4){%> style="margin-right: 0"<%}%> onclick="window.location.href='/publish/theater/j<%=theaterIdList.get(i)%>/show/j<%=show.getShowid()%>#show_part'" >
            <img src="<%=show.getImage()%>">
            <div class="main_text">
                <%--<a href="#" ><span>作者太懒、什么都没有写</span></a>--%>
                <a>
                    <p style="overflow: hidden;height: 44px;line-height: 22px">参演人员：<%=show.getActor()%></p>
                    <p style="max-height: 66px;line-height: 22px;overflow: hidden;text-overflow: ellipsis">简介：<%=show.getDescription()%></p>
                    <label>...</label></a>
            </div>
            <%--<div class="main_head"><img src="/resources/images/user-head/01.png"></div>--%>
            <div class="tips"><span><%=showTypeList.get(i)%></span>
                <label style="float: right;margin:5px 5px;font-weight: 400"><label style="font-size: 16px;font-family: georgia;color: #C9302C;">¥<%=minPrice%></label>起</label></div>
            <div style="position:relative;top:-8px">
                <div class="name"><%=show.getTitle()%></div>
                <div class="main_bottom">
                    <%--<span><%=orderNumList.get(i)%></span>--%>
                    <a href="/publish/theater/j<%=theaterIdList.get(i)%>"><%=theaterNameList.get(i)%></a></div>
            </div>
        </li>
        <%}}%>
    </ul>
</div>

<br/>
<div class="bottom_text"><span>搜索到的影院</span></div>

<!-- latest blog start -->
<div class="latest-blog-area">
    <div class="w3_content_agilleinfo_inner" style="border: none">
        <div class="row">
            <div class="latest-blog-slider">
                <%List<Theater> theaterList = (List<Theater>)request.getAttribute("theaterList");
                    if(theaterList.size()==0){%>
                <h3 style="text-align: center">Sorry, cannot search relative theaters -_-</h3>
                <%}else{
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

                            </div>
                            <div class="blog-content">
                                <p>邮箱：<%=theater.getEmail()%></p>
                                <p>地址：<%=theater.getLocation()%></p>
                                <p>电话：<%=theater.getPhonenum()%></p>
                            </div>
                            <div class="continue-reading">
                                <div class="blog-icon">
                                    <a href="/publish/theater/j<%=theater.getTheaterid()%>" style="display: none" class="btn btn-primary">详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%}}%>
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
