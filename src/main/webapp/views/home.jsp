<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tickets-首页</title>
    <meta charset="utf-8" />
    <!-- Animate.css -->
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
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

<div role="banner" style="background-image: url(/resources/images/background.jpg);background-size:100%;margin: 0px auto;height: 100%">
    <div class="overlay"></div>
    <div>
        <div class="row">
                <div class="row row-mt-15em">
                    <div class="mt-text animate-box slider-text">
                        <%--<span class="intro-text-small">Welcome to Tickets</span>--%>
                        <%--<h1>This website allows buying tickets to see shows.</h1>--%>
                        <h1>Welcome to Tickets.</h1>
                        <p>This website allows buying tickets to see shows.</p>
                        <ul>
                            <li><a href="">登录</a></li>
                            <li><a href="">注册</a></li>
                        </ul>
                    </div>
            </div>
        </div>
    </div>
    <br/><br/><br/><br/>
</div>

</body>
</html>
