<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/resources/css/leftmenu.css" media="screen" rel="stylesheet" type="text/css" />
<ul class="col-md-offset-1 col-md-2" id="manager_leftmenu">
    <li class="dropdown the-man-f4">
        <a onclick="window.location.href='/ticketsManager/j${managerid}/checkList?checkType=signUpTheater'" data-toggle="dropdown" class="selected">场馆审核</a>
    </li>
    <li class="dropdown the-man-f4">
        <a onclick="window.location.href='/ticketsManager/j${managerid}/balanceList?balanceType=notPay'" data-toggle="dropdown">演出结算</a>
    </li>
    <li class="dropdown">
        <a onclick="window.location.href='/ticketsManager/j${managerid}/statistics'" data-toggle="dropdown"><span class=" the-man-f2">统计</span></a>
    </li>
    <%--<li class="dropdown">--%>
        <%--<a onclick="window.location.href='/logout'" data-toggle="dropdown">退出登录</a>--%>
    <%--</li>--%>
</ul>

<script>
    var url;
    $(document).ready(function () {
        for(var i=0;i<$("#manager_leftmenu a").length;i++){
            $("#manager_leftmenu a").eq(i).removeClass("selected");
        }
        url=window.location.pathname;
        if(url=="/ticketsManager/j${managerid}/checkList"){
            $("#manager_leftmenu a").eq(0).addClass("selected");
        }else if(url=="/ticketsManager/j${managerid}/balanceList"){
            $("#manager_leftmenu a").eq(1).addClass("selected");
        }else if(url=="/ticketsManager/j${managerid}/statistics"){
            $("#manager_leftmenu a").eq(2).addClass("selected");
        }
    });
</script>