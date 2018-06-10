<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/resources/css/leftmenu.css" media="screen" rel="stylesheet" type="text/css" />
<ul class="col-md-offset-1 col-md-2" id="theater_leftmenu">
    <li class="dropdown">
        <a onclick="window.location.href='/theater/j${sessionScope.theater.theaterid}/showList?showState=All'" href="javascript:;" data-toggle="dropdown" class="selected">演出列表</a>
    </li>
    <li class="dropdown">
        <a onclick="window.location.href='/theater/j${sessionScope.theater.theaterid}/checkTickets'" href="javascript:;" data-toggle="dropdown">检票</a>
    </li>
    <li class="dropdown">
        <a onclick="window.location.href='/theater/j${sessionScope.theater.theaterid}/newShow'" href="javascript:;" data-toggle="dropdown">发布演出</a>
    </li>
    <li class="dropdown">
        <a onclick="window.location.href='/theater/j${sessionScope.theater.theaterid}/profile'" href="javascript:;" data-toggle="dropdown">场馆信息</a>
    </li>
    <%--<li class="dropdown">--%>
        <%--<a onclick="window.location.href='/logout'" href="javascript:;" data-toggle="dropdown">退出登录</a>--%>
    <%--</li>--%>
</ul>
<script>
    var url;
    $(document).ready(function () {
        for(var i=0;i<$("#theater_leftmenu a").length;i++){
            $("#theater_leftmenu a").eq(i).removeClass("selected");
        }

        url=window.location.pathname;
        if(url=="/theater/j${sessionScope.theater.theaterid}/showList"){
            $("#theater_leftmenu a").eq(0).addClass("selected");
        }else if(url=="/theater/j${sessionScope.theater.theaterid}/checkTickets"){
            $("#theater_leftmenu a").eq(1).addClass("selected");
        }else if(url=="/theater/j${sessionScope.theater.theaterid}/newShow"){
            $("#theater_leftmenu a").eq(2).addClass("selected");
        }else if(url="/theater/j${sessionScope.theater.theaterid}/profile"){
            $("#theater_leftmenu a").eq(3).addClass("selected");
        }
    });
</script>