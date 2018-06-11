<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<script src="/resources/js/navanimition.js"></script>
<header class="top" style="background-color: white">
    <nav>
<%--<<<<<<< HEAD--%>
        <%--<div class="logo"><img src="/resources/images/logo.png" width="auto" height="100%" /></div>--%>
        <%--<div class="nav">--%>
            <%--<ul>--%>
                <%--<li class="index"><a href="/views/home.jsp">首页</a></li>--%>
                <%--<li><a href="/publish/showList?isOpen=true&showType=All&orderType=heat">演出</a></li>--%>
                <%--<li><a href="/publish/theaterList?orderType=heat">场馆</a></li>--%>
<%--=======--%>
        <div class="logo" onclick="window.location.href='/views/home.jsp'"><img src="/resources/images/logo1.png" width="auto" height="100%" /></div>
        <div class="nav">
            <ul>
                <%--<li class="index"><a href="/views/home.jsp">首页</a></li>--%>
                <li><a style="font-size: 15px" href="/publish/showList?isOpen=true&showType=All&orderType=heat">演出</a></li>
                <li><a style="font-size: 15px" href="/publish/theaterList?orderType=heat">场馆</a></li>

                <!--<li><a href="#" class="text-bj nav-120">学习</a>
                    <dl class="nav-120">
                        <dd><a href="#">专题</a><i></i></dd>
                        <dd><a href="#">教程</a><i></i></dd>
                        <dd><a href="#">书籍</a><i></i></dd>
                    </dl>
                </li>
                <li><a href="#" class="text-bj nav-80">活动</a>
                    <dl class="nav-80">
                        <dd><a href="#">UTalk</a><i></i></dd>
                        <dd><a href="#">设计大赛</a><i></i></dd>
                    </dl></li>
                <li><a href="#">招聘</a></li>
                <li><a href="#">培训</a></li>
                <li><a href="#" class="text-bj nav-160">更多</a>
                    <dl class="nav-160">
                        <dd><a href="#">灵感</a><i></i></dd>
                        <dd><a href="#">工具</a><i></i></dd>
                        <dd><a href="#">话题</a><i></i></dd>
                        <dd><a href="#">主题学院</a><i></i></dd>
                    </dl>
                </li>-->
            </ul>

        </div>
        <section>

            <div class="head" id="user"><a href="#">

                <%if(request.getSession().getAttribute("userType")!=null){
                    if(request.getSession().getAttribute("userType").equals("member")){%>
                <img src="${sessionScope.member.image}" style="width: 49px;height: 49px;border-radius: 100%"/> &nbsp;${sessionScope.member.name}
                    <%}else if(request.getSession().getAttribute("userType").equals("theater")){%>
                <img src="${sessionScope.theater.image}" style="width: 49px;height: 49px;border-radius: 100%"/> &nbsp;${sessionScope.theater.name}
                    <%}else if(request.getSession().getAttribute("userType").equals("manager")){%>
                <img src="/resources/images/not-head.png" style="width: 49px;height: 49px;border-radius: 100%"/> &nbsp;${sessionScope.manager.managerid}
                <%}
                }else{%>
                <img src="/resources/images/not-head.png"/>
                <%}%>
            </a>
                <% if(request.getSession().getAttribute("userType")!=null){
                    if(request.getSession().getAttribute("userType").equals("member")){ %>
                <ul>
                    <li><a href="/member/j${sessionScope.member.memberid}/orderList?orderState=All">个人订单</a></li>
                    <li><a href="/member/j${sessionScope.member.memberid}/coupon">我的积分</a></li>
                    <li><a href="/member/j${sessionScope.member.memberid}/profile">基本信息</a></li>
                    <li><a href="/logout">退出登录</a></li>
                </ul>
                <% }else if(request.getSession().getAttribute("userType").equals("theater")){%>
                <ul>
                    <li><a href="/theater/j${sessionScope.theater.theaterid}/showList?showState=All">演出列表</a></li>
                    <li><a href="/theater/j${sessionScope.theater.theaterid}/checkTickets">检票</a></li>
                    <li><a href="/theater/j${sessionScope.theater.theaterid}/newShow">发布演出</a></li>
                    <li><a href="/theater/j${sessionScope.theater.theaterid}/profile">场馆信息</a></li>
                    <li><a href="/logout">退出登录</a></li>
                </ul>
                <%}else if(request.getSession().getAttribute("userType").equals("manager")){%>
                <ul>
                    <li><a href="/ticketsManager/j${managerid}/checkList?checkType=signUpTheater">场馆审核</a></li>
                    <li><a href="/ticketsManager/j${managerid}/balanceList?balanceType=notPay">演出结算</a></li>
                    <li><a href="/ticketsManager/j${managerid}/statistics">统计</a></li>
                    <li><a href="/logout">退出登录</a></li>
                </ul>
                <%}}else{%>
                <ul style="max-height: 40px">
                    <li><a href="/login">登录</a></li>
                </ul>
                <%} %>
            </div>

            <div class="search" onclick="search()"></div>
<%--<<<<<<< HEAD--%>
            <%--<div class="search_input"><input id="search_input" type="text" placeholder="请输入你要搜索的内容" /></div>--%>
<%--=======--%>
            <div class="search_input"><input id="search_input" type="text" placeholder="请输入你要搜索的内容" onfocus="listenEnterPress($(this))"/></div>
<%-->>>>>>> b42ba70cdad2ab6984cfaf0872c498eab05eafe2--%>
            <%--<div class="IT"><a href="#" class="text-zp">搜索方向</a>--%>
            <%--<dl>--%>
            <%--<dd><a href="#">演出</a></dd>--%>
            <%--<dd><a href="#">场馆</a></dd>--%>
            <%--</dl>--%>
            <%--</div>--%>
        </section>

    </nav>
</header>

<script>
    if(window.location.pathname=="/publish/searchResult"){
        $("#search_input").val("<%=request.getParameter("key")%>");
    }

    function search() {
        var keyword=$("#search_input").val();
        if(keyword==""){
            alert("请先输入要搜索的关键词");
            return;
        }
        window.location.href="/publish/searchResult?key="+keyword;
    }

    var url;
    $(document).ready(function () {
        for(var i=0;i<$(".nav li").length;i++){
            $(".nav li").eq(i).removeClass("index");
        }

        url=window.location.pathname;
//<<<<<<< HEAD
//        if(url=="/login"){
//            $(".nav li").eq(0).addClass("index");
//        }else if(url=="/publish/showList"){
//            $(".nav li").eq(1).addClass("index");
//        }else if(url=="/publish/theaterList"){
//            $(".nav li").eq(2).addClass("index");
//=======
        // if(url=="/login"){
        //     $(".nav li").eq(0).addClass("index");
        // }else if(url=="/publish/showList"){
        //     $(".nav li").eq(1).addClass("index");
        // }else if(url=="/publish/theaterList"){
        //     $(".nav li").eq(2).addClass("index");
        // }
        if(url=="/publish/showList"){
            $(".nav li").eq(0).addClass("index");
        }else if(url=="/publish/theaterList"){
            $(".nav li").eq(1).addClass("index");
//>>>>>>> b42ba70cdad2ab6984cfaf0872c498eab05eafe2
        }
    });
</script>

<%--<<<<<<< HEAD--%>
<%--=======--%>
<%--监听键盘回车搜索事件--%>
<script>
function listenEnterPress(searchInput) {
    searchInput.keydown(function(e) {
        var eCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
        if (eCode == 13){
            $(".search").click();
        }
    });
}
</script>

<script>
    document.getElementById("user").onmouseover=function (ev) {
        $("#user ul").height($("#user ul li").length*40);
    }

    document.getElementById("user").onmouseleave=function (ev) {
        $("#user ul").height(0);
    }
</script>
<%-->>>>>>> b42ba70cdad2ab6984cfaf0872c498eab05eafe2--%>
