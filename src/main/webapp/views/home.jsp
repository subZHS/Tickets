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

<div role="banner" style="background-image: url(/resources/images/background.jpg);background-size:100%;margin: 0px auto;height: 600px">
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
<!-- Service Section Start -->
<div class="our-service-sec pt-50 pb-20">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="sec-title">
                    <h1><span>Website</span> Users</h1>
                    <div class="border-shape"></div>
                    <p>This website contains 3 kinds of users.</p>
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
