<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <meta charset="utf-8" />
    <!-- Animate.css -->
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link  href="/resources/css/loginstyle.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="/resources/js/jquery.min.js"></script>
    <!--表单处理-->
    <script type="text/javascript" src="/resources/js/jquery.form.js"></script>
    <!-- Bootstrap -->
    <script src="/resources/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<div id="gtco-header" class="gtco-cover" role="banner"
     style="background-image: url(/resources/images/background.jpg);margin: 0 auto">
    <div class="overlay"></div>
    <div class="gtco-container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0 text-left">
                <div class="row row-mt-15em">
                    <div class="col-md-9 mt-text animate-box" data-animate-effect="fadeInUp">
                        <span class="intro-text-small">Welcome to Tickets</span>
                        <h1>This website allows buying tickets to see shows.</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
