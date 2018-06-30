<%@ page import="com.tickets.model.Show" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tickets-首页</title>
    <meta charset="utf-8" />
    <!-- Animate.css -->
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link  href="/resources/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link  href="/resources/css/loginstyle.css" rel="stylesheet" type="text/css" />
    <link  href="/resources/css/homePage.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="/resources/js/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="/resources/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>


<div role="banner" style="background-image: url(/resources/images/background.jpg);background-size:100%;margin: 0px auto;height: 500px">
    <div class="overlay"></div>
    <div>
        <div class="row">
                <div class="row row-mt-15em">
                    <div class="mt-text animate-box slider-text">
                        <%--<span class="intro-text-small">Welcome to Tickets</span>--%>
                        <%--<h1>This website allows buying tickets to see shows.</h1>--%>
                        <h1>Welcome to Tickets.</h1>
                        <p style="font-size: 20px">This website allows buying tickets to see shows.</p>
                        <ul>
                            <li><a href="/login">去登录</a></li>
                        </ul>
                    </div>
            </div>
        </div>
    </div>
    <br/><br/><br/><br/>
</div>

<div class="our-service-sec pt-50 pb-20" style="padding-bottom: 0px;padding-top:20px">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="sec-title">
                    <h1><span>Top 10</span> Shows</h1>
                    <div class="border-shape"></div>
                    <%--<p>The most popular 10 shows.</p>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="banner" style="border: 0;padding-top: 0px">
    <ul>
        <%
            List<Show> showList = (List<Show>)request.getAttribute("top10ShowList");
            if(showList.size()==0){%>
        <h3 style="text-align: center">Sorry, there is not this kind of show list now -_-</h3>
        <%}else{
            List<String> showTypeList=(List<String>)request.getAttribute("showTypeList");
            List<Integer> seatNumList=(List<Integer>)request.getAttribute("seatNumList");
            List<String> theaterNameList=(List<String>)request.getAttribute("theaterNameList");
            List<String> theaterIdList=(List<String>)request.getAttribute("theaterIdList");
            for(int i=0;i<showList.size();i++){
                Show show = showList.get(i);
                double minPrice=Math.min(show.getPrice1(),Math.min(show.getPrice2(),show.getPrice3()));
        %>
        <li style="<%if(i%5==4){%>;margin-right: 0<%}%>" onclick="window.location.href='/publish/theater/j<%=theaterIdList.get(i)%>/show/j<%=show.getShowid()%>#show_part'" >
            <img src="<%=show.getImage()%>">
            <div class="main_text">
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
                    <span title="已售出座位数"><%=seatNumList.get(i)%></span><a href="/publish/theater/j<%=theaterIdList.get(i)%>"><%=theaterNameList.get(i)%></a></div>
            </div>
        </li>
        <%}}%>
    </ul>
</div>

<!-- Service Section Start -->
<div class="our-service-sec pt-50 pb-20" style="padding-top:0px">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="sec-title">
                    <h1><span>Website</span> Users</h1>
                    <div class="border-shape"></div>
                    <%--<p>This website contains 3 kinds of users.</p>--%>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-sm-4 service-inner">
                <div class="single-service">
                    <h2><a href="">Member</a></h2>
                    <a href=""><i><img style="height: 45px" src="/resources/images/user.png"/></i></a>
                    <p>Members can buy some shows' tickets by our website. There is a discount for the purchase of members.</p>
                    <a href="/login" class="btn rdmorebtn">注册</a>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 service-inner">
                <div class="single-service">
                    <h2><a href="">Theater</a></h2>
                    <a href=""><i><img style="height: 45px" src="/resources/images/user.png"/></i></a>
                    <p>Theater managers can use our website to publish shows for members to buy. We also provide a series of services about tickets.</p>
                    <a href="/theater/signup" class="btn rdmorebtn">注册</a>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 service-inner">
                <div class="single-service">
                    <h2><a href="">Manager</a></h2>
                    <a href=""><i><img style="height: 45px" src="/resources/images/user.png"/></i></a>
                    <p>Website manager will validate the application, settle accounts, look through Website achievement and so on.</p>
                    <a href="/login" class="btn rdmorebtn">登录</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Service Section End -->
</body>
</html>
