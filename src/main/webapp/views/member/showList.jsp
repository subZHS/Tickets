<%@ page import="com.tickets.model.Show" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />

<link href="/resources/css/public.css"rel="stylesheet" type="text/css" />

<script src="/resources/js/navanimition.js"></script>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<head>
    <title>showList</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<br/>
<div class="main_nav" style="position:relative;left:34%">
    <ul>
        <li>
            <a href="/publish/showList?isOpen=true&showType=${showType}&orderType=${orderType}" <%if(request.getParameter("isOpen").equals("true")){%> class="main_nav_index"<%}%>>正在热映</a></li>
        <li>
            <a href="/publish/showList?isOpen=false&showType=${showType}&orderType=${orderType}" <%if(request.getParameter("isOpen").equals("false")){%> class="main_nav_index"<%}%>>即将上映</a></li>
    </ul>
</div>

    <div class="w3_content_agilleinfo_inner">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <ul class="nav-tabs" role="tablist">
                <li><b>类型： &nbsp;&nbsp;&nbsp;</b></li>
                <li role="presentation" <%if(request.getParameter("showType").equals("All")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=All&orderType=${orderType}" role="tab">所有</a></li>
                <li role="presentation" <%if(request.getParameter("showType").equals("Movie")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=Movie&orderType=${orderType}" role="tab">电影</a></li>
                <li role="presentation" <%if(request.getParameter("showType").equals("MusicDrama")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=MusicDrama&orderType=${orderType}" role="tab">舞台剧</a></li>
                <li role="presentation" <%if(request.getParameter("showType").equals("Drama")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=Drama&orderType=${orderType}" role="tab">戏剧</a></li>
                <li role="presentation" <%if(request.getParameter("showType").equals("Dance")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=Dance&orderType=${orderType}" role="tab">舞蹈</a></li>
                <li role="presentation" <%if(request.getParameter("showType").equals("Sports")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=Sports&orderType=${orderType}" role="tab">体育比赛</a></li>
                <li role="presentation" <%if(request.getParameter("showType").equals("Concert")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=Concert&orderType=${orderType}" role="tab">演唱会</a></li>
            </ul>
        </div>
    </div>

    <div class="w3_content_agilleinfo_inner">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <ul class="nav-tabs" role="tablist">
                <li><b>排序： &nbsp;&nbsp;&nbsp;</b></li>
                <li role="presentation" <%if(request.getParameter("orderType").equals("heat")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=${showType}&orderType=heat" role="tab">按热度</a></li>
                <li role="presentation" <%if(request.getParameter("orderType").equals("price")){%> class="active"<%}%>>
                    <a href="/publish/showList?isOpen=${isOpen}&showType=${showType}&orderType=price" role="tab">按价格</a></li>
            </ul>
        </div>
    </div>

<div class="banner">
    <ul>
        <%
            List<Show> showList = (List<Show>)request.getAttribute("showList");
            if(showList.size()==0){%>
        <h3 style="text-align: center;font-weight: 400;font-size: 20px">暂无此类型的演出，请耐心等候 -_-</h3>
        <%}else{
            List<String> showTypeList=(List<String>)request.getAttribute("showTypeList");
            List<Integer> seatNumList=(List<Integer>)request.getAttribute("seatNumList");
            List<String> theaterNameList=(List<String>)request.getAttribute("theaterNameList");
            List<String> theaterIdList=(List<String>)request.getAttribute("theaterIdList");
            for(int i=0;i<showList.size();i++){
                Show show = showList.get(i);
                double minPrice=Math.min(show.getPrice1(),Math.min(show.getPrice2(),show.getPrice3()));
        %>
        <li <%if(i%5==4){%> style="margin-right: 0"<%}%> onclick="window.location.href='/publish/theater/j<%=theaterIdList.get(i)%>/show/j<%=show.getShowid()%>#show_part'" >
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
<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<script type="text/javascript">
    $(".btn-group .btn-primary").click(function () {
        var index=$(this).index(".btn-group .btn-primary");
        $(".btn-group .btn-primary").removeClass("active");
        $(this).addClass("active");
    });
</script>
</body>
</html>
