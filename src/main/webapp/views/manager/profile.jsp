<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/table.css" rel="stylesheet" type="text/css" />
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<head>
    <title>profile</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<div class="container row" style="width: 1200px;margin: 50px auto;">
    <jsp:include page="/views/manager/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>

    <div class="col-md-9" style="margin-left: 5%">
   n     <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>个人信息</span></div>

        <form action="#" class="col-md-8" style="font-size: 15px;margin-top: 15px">
            <div class="row form-group">
                <div class="col-md-12">
                    <label style="margin-right: 8%">ID</label>
                    <span style="color: #C9302C;font-family: georgia;font-size:22px;margin-right: 5%">l000</span>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label for="username">支付账号</label>
                    <input type="text" class="form-control" id="username">
                </div>
            </div>
        </form>

    </div>
</div>

</body>
</html>
