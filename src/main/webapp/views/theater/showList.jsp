<%@ page import="com.tickets.model.Show" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tickets.util.ShowType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/table.css" rel="stylesheet" type="text/css" />
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<head>
    <title>Login</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<div style="display: block;height: 50px"></div>
<div class="container row" style="width: 1200px;margin: 50px auto;">
    <jsp:include page="/views/theater/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>

    <div class="col-md-offset-3  col-md-9">
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>所有演出</span></div>

        <%--<div style="border-left:1px solid #ccc;border-right:1px solid #ccc">--%>
            <div class="w3_content_agilleinfo_inner" style="border:none;width: 100%">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <ul id="myTab" class="nav-tabs" role="tablist">
                        <li><b>筛选： &nbsp;&nbsp;&nbsp;</b></li>
                        <li role="presentation" class="active">
                            <a href="/theater/j${sessionScope.theater.theaterid}/showList?showState=All" role="tab">全部</a></li>
                        <li role="presentation"><a href="/theater/j${sessionScope.theater.theaterid}/showList?showState=NotOnSale" role="tab">未售票</a></li>
                        <li role="presentation"><a href="/theater/j${sessionScope.theater.theaterid}/showList?showState=OnSale" role="tab">正在售票</a></li>
                        <li role="presentation"><a href="/theater/j${sessionScope.theater.theaterid}/showList?showState=NotPay" role="tab">演出结束</a></li>
                        <li role="presentation"><a href="/theater/j${sessionScope.theater.theaterid}/showList?showState=Payed" role="tab">已结算</a></li>
                    </ul>
                </div>
            </div>
<!--
            <div class="w3_content_agilleinfo_inner" style="width:100%;margin-bottom:0px;border-bottom: 1px solid #ccc">
                <label>排序： &nbsp;&nbsp;&nbsp;</label>
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-primary">
                        <input type="radio" name="options" id="option1"> 按时间倒序
                    </label>
                    <label class="btn btn-primary">
                        <input type="radio" name="options" id="option2"> 按上座率排序
                    </label>
                </div>
            </div>-->
        <%--</div>--%>
        <br/>
        <div class="table_list" style="border-top:none">
            <div class="agile_featured_movies">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                            <div class="agile-news-table">
                                <%
                                    ArrayList<Show> showList=(ArrayList<Show>)request.getAttribute("showList");
                                    if(showList.size()==0){
                                %>
                                <h3 style="text-align: center">this kind of movie List is empty -_-</h3>
                                <%}else{%>
                                <table id="table-breakpoint">
                                    <thead>
                                    <tr style="text-align: center">
                                        <th>演出</th>
                                        <th>类型</th>
                                        <th>参演人员</th>
                                        <th>简介</th>
                                        <th>价格</th>
                                        <th>详情</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for(Show show:showList){
                                    %>
                                    <tr>
                                        <td><img style="width: 120px;position: relative;left: 15px" src="<%=show.getImage()%>" alt="image"/> <h5 style="text-align: center"><%=show.getTitle()%></h5></td>
                                        <td><%=ShowType.values()[show.getType()].name()%></td>
                                        <td><%=show.getActor()%></td>
                                        <td style="max-width: 180px;word-break: break-all"><%=show.getDescription()%></td>
                                        <td class="w3-list-info">
                                            <ul>
                                                <li>前排：¥<%=show.getPrice1()%></li>
                                                <li>中间：¥<%=show.getPrice2()%></li>
                                                <li>靠后：¥<%=show.getPrice3()%></li>
                                            </ul>
                                        </td>
                                        <td>
                                            <a href="/theater/j${sessionScope.theater.theaterid}/show/j<%=show.getShowid()%>?dateIndex=0" class="btn btn-link">详情-></a><br/>
                                            <%if(request.getParameter("showState").equals("OnSale")){%>
                                            <a href="/theater/j${sessionScope.theater.theaterid}/show/j<%=show.getShowid()%>/offlineOrder?dateIndex=0" class="btn btn-link">线下购票-></a>
                                            <%}%>
                                        </td>
                                    </tr>
                                    <%}%>
                                    </tbody>
                                </table>
                                <%}%>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(".btn-group .btn-primary").click(function () {
        var index=$(this).index(".btn-group .btn-primary");
        $(".btn-group .btn-primary").removeClass("active");
        $(this).addClass("active");
    });
    $("#myTab li").removeClass("active");
    var showState='<%=request.getParameter("showState")%>';
    if(showState=='All'){
        $("#myTab li").eq(1).addClass("active");
    }else if(showState=='NotOnSale'){
        $("#myTab li").eq(2).addClass("active");
    }else if(showState=='OnSale'){
        $("#myTab li").eq(3).addClass("active");
    }else if(showState=='NotPay'){
        $("#myTab li").eq(4).addClass("active");
    }else if(showState=='Payed'){
        $("#myTab li").eq(5).addClass("active");
    }
</script>
</body>
</html>
