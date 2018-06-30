<%@ page import="com.tickets.model.Show" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<link href="/resources/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />--%>
<link href="/resources/css/leftmenu.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/resources/css/rankListStyle.css" media="screen" rel="stylesheet" type="text/css" />
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

<dl class="col-md-offset-1 col-md-2 tab-rank" style="padding: 0">
    <dt class="hd">
        <h3 style="margin-top: 0;margin-bottom: 0"><a href="#">演出排行榜</a></h3>
        <%--<h3><a href="#">经验分享</a></h3>--%>
    </dt>

    <dd class="bd">
        <ul class="ulList">
            <%--<%--%>
                <%--List<Show> showList = (List<Show>)request.getAttribute("top10ShowList");--%>
                <%--if(showList.size()==0){%>--%>
            <%--<li class="t">--%>
                <%--<span class="num">1</span>--%>
                <%--<a class="btn btn-link" href="#">暂无</a>--%>
            <%--</li>--%>
            <%--<%}else{--%>
                <%--List<String> top10TheaterIdList=(List<String>)request.getAttribute("top10TheaterIdList");--%>
                <%--for(int i=0;i<showList.size();i++){--%>
                    <%--Show show = showList.get(i);--%>
            <%--%>--%>
            <%--<li <%if(i<3){%>class="t"<%}%>>--%>
                <%--<span class="num"><%=i+1%></span>--%>
                <%--<a class="btn btn-link" href="/publish/theater/j<%=top10TheaterIdList.get(i)%>/show/j<%=show.getShowid()%>#show_part"><%=show.getTitle()%></a>--%>
            <%--</li>--%>
            <%--<%}}%>--%>
        </ul>
    </dd>

</dl>

<script>
    $.ajax({
        type: 'get', url: '/member/getTop10shows',
        data: {},
        cache: false, dataType: 'json',
        contentType: false,//必须false才会自动加上正确的Content-Type
        processData: false,//必须false才会避开jQuery对 formdata 的默认处理.XMLHttpRequest会对 formdata 进行正确的处理.
        success: function (data) {
            if(data.top10ShowList.length==0){
                $(".tab-rank .bd .ulList").append("<li class=\"t\">" +
                    "<span class=\"num\">1</span>" +
                    "<a class=\"btn btn-link\" href=\"#\">暂无</a>" +
                    "</li>");
            }else {
                for(var i=0;i<data.top10ShowList.length;i++) {
                    var show=data.top10ShowList[i];
                    var theaterId=data.top10TheaterIdList[i];
                    if(i<3){
                        $(".tab-rank .bd .ulList").append("<li class=\"t\">"+
                            "<span class=\"num\">"+(i+1)+"</span>\n" +
                            "<a class=\"btn btn-link\" href=\"/publish/theater/j"+theaterId+"/show/j"+show.showid+"#show_part\">"+show.title+"</a>\n" +
                            "</li>");
                    }else{
                        $(".tab-rank .bd .ulList").append("<li>"+
                            "<span class=\"num\">"+(i+1)+"</span>\n" +
                            "<a class=\"btn btn-link\" href=\"/publish/theater/j"+theaterId+"/show/j"+show.showid+"#show_part\">"+show.title+"</a>\n" +
                            "</li>");
                    }
                }
            }
        }
    });
</script>

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
