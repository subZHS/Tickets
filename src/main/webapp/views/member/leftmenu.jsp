<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/resources/css/leftmenu.css" media="screen" rel="stylesheet" type="text/css" />
<ul class="col-md-offset-1 col-md-2" id="member_leftmenu">
    <li class="dropdown">
        <a onclick="window.location.href='/member/j${sessionScope.member.memberid}/orderList?orderState=All'" data-toggle="dropdown" class="selected">个人订单</a>
    </li>
    <li class="dropdown">
        <a onclick="window.location.href='/member/j${sessionScope.member.memberid}/coupon'" data-toggle="dropdown">积分优惠券</a>
    </li>
    <li class="dropdown">
        <a onclick="window.location.href='/member/j${sessionScope.member.memberid}/profile'" data-toggle="dropdown">基本信息</a>
    </li>
    <%--<li class="dropdown">--%>
        <%--<a onclick="window.location.href='/logout'" data-toggle="dropdown">退出登录</a>--%>
    <%--</li>--%>
</ul>

<script>
    var url;
    $(document).ready(function () {
        for(var i=0;i<$("#member_leftmenu a").length;i++){
            $("#member_leftmenu a").eq(i).removeClass("selected");
        }

        url=window.location.pathname;
        if(url=="/member/j${sessionScope.member.memberid}/orderList"){
            $("#member_leftmenu a").eq(0).addClass("selected");
        }else if(url=="/member/j${sessionScope.member.memberid}/coupon"){
            $("#member_leftmenu a").eq(1).addClass("selected");
        }else if(url=="/member/j${sessionScope.member.memberid}/profile"){
            $("#member_leftmenu a").eq(2).addClass("selected");
        }
    });
</script>
