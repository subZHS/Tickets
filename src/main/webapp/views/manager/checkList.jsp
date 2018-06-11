<%@ page import="com.tickets.model.Theater" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tickets.model.TheaterModify" %>
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
    <title>Login</title>
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
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>场馆审核</span></div>

        <div class="w3_content_agilleinfo_inner" style="width: 100%;border:none">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab" class="nav-tabs" role="tablist">
                    <li><b>筛选： &nbsp;&nbsp;&nbsp;</b></li>
                    <li role="presentation" <%if(request.getParameter("checkType").equals("signUpTheater")){%> class="active"<%}%>>
                        <a href="/ticketsManager/j${managerid}/checkList?checkType=signUpTheater" role="tab">注册审核</a></li>
                    <li role="presentation" <%if(request.getParameter("checkType").equals("modifyTheater")){%> class="active"<%}%>>
                        <a href="/ticketsManager/j${managerid}/checkList?checkType=modifyTheater" role="tab">修改审核</a></li>

                </ul>
            </div>
        </div>

        <br/>

        <div class="table_list" style="border-top:none">
            <div class="agile_featured_movies">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                            <div class="agile-news-table">
                                <% List<Theater> theaterList=null;
                                    List<TheaterModify> theaterModifyList=null;
                                    if(request.getParameter("checkType").equals("signUpTheater")) {
                                        theaterList = (List<Theater>) request.getAttribute("signUpTheaterList");
                                    }else if(request.getParameter("checkType").equals("modifyTheater")) {
                                        theaterModifyList = (List<TheaterModify>) request.getAttribute("theaterModifyList");
                                    }
                                    if(request.getParameter("checkType").equals("signUpTheater")&&theaterList.size()==0){
                                %>
                                <h3 style="text-align: center">There are no signup theater to check -_-</h3>
                                <%}else if(request.getParameter("checkType").equals("modifyTheater")&&theaterModifyList.size()==0){%>
                                <h3 style="text-align: center">There are no theater modify to check -_-</h3>
                                <%}else{%>
                                <table id="table-breakpoint">
                                    <thead>
                                    <tr>
                                        <th>影院信息</th>
                                        <th></th>
                                        <th>收款账号</th>
                                        <th>座位情况</th>
                                        <th>座位类型分布</th>
                                        <th>审核</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%if(request.getParameter("checkType").equals("signUpTheater")){
                                    for(Theater theater:theaterList){%>
                                    <tr>
                                        <td><p>场馆号：<label class="theaterid"><%=theater.getTheaterid()%></label></p>
                                            <div style="min-height: 140px;float: left;margin-right: 10px">
                                            <img src="<%=theater.getImage()%>" style="width:90px;margin-top: 20px" alt="" /></div>
                                        </td>
                                        <td><h5 style="margin-top: 20px"><%=theater.getName()%></h5>
                                            <span>邮箱：<%=theater.getEmail()%></span><br/>
                                            <span>地址：<%=theater.getLocation()%></span><br/>
                                            <span>电话：<%=theater.getPhonenum()%></span></td>
                                        <td><%=theater.getAlipayid()%></td>
                                        <td style="white-space: pre"><%=theater.getSeat()%></td>
                                        <td>前排：0 - <%=theater.getRowdivide1()%> 排<br/>
                                        中间：<%=theater.getRowdivide1()%> - <%=theater.getRowdivide2()%> 排<br/>
                                        靠后：<%=theater.getRowdivide2()%> - - 排</td>
                                        <td>
                                            <a href="javascript:;" class="pass btn btn-link">审核通过-></a><br/>
                                            <a href="javascript:;" class="reject btn btn-link">审核拒绝-></a>
                                        </td>
                                    </tr>
                                    <%}}else if(request.getParameter("checkType").equals("modifyTheater")){
                                    for(TheaterModify theaterModify:theaterModifyList){%>
                                    <tr>
                                        <td><p>场馆号：<label><%=theaterModify.getTheaterid()%></label></p>
                                            <div style="min-height: 140px;float: left;margin-right: 10px">
                                                <img src="<%=theaterModify.getImage()%>" style="width:90px;margin-top: 20px" alt="" /></div>
                                            </td>
                                        <td><h5 style="margin-top: 20px"><%=theaterModify.getName()%></h5><span>邮箱：<%=theaterModify.getEmail()%></span><br/>
                                            <span>地址：<%=theaterModify.getLocation()%></span><br/>
                                            <span>电话：<%=theaterModify.getPhonenum()%></span>
                                            <p>下单时间：</p>
                                        </td>
                                        <td><%=theaterModify.getAlipayid()%></td>
                                        <td style="white-space: pre"><%=theaterModify.getSeat()%></td>
                                        <td>前排：0 - <%=theaterModify.getRowdivide1()%> 排<br/>
                                            中间：<%=theaterModify.getRowdivide1()%> - <%=theaterModify.getRowdivide2()%> 排<br/>
                                            靠后：<%=theaterModify.getRowdivide2()%> - - 排</td>
                                        <td>
                                            <a href="/ticketsManager/j${managerid}/modifyTheater/j<%=theaterModify.getTheaterid()%>" class="btn btn-link">详情-></a>
                                        </td>
                                    </tr>
                                    <%}}%>
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

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">您确定要审核通过吗？</h4>
            </div>
            <div class="modal-body" style="white-space: pre"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a type="button" class="btn btn-primary" onclick="passOrReject_submit()">确定</a>
            </div>
            <input id="passOrReject" type="hidden" value=""/>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>


<script>
    var index;

    $(".pass").click(function () {
        $("#myModalLabel").text("您确定要审核通过吗？");
        $("#passOrReject").val("pass");
        index = $(this).index(".pass");
        $("#myModal").modal("show");
    });

    $(".reject").click(function () {
        $("#myModalLabel").text("您确定要审核拒绝吗？");
        $("#passOrReject").val("reject");
        index = $(this).index(".reject");
        $("#myModal").modal("show");
    });

    function passOrReject_submit() {
        var theaterid = $(".theaterid").eq(index).text();
        if($("#passOrReject").val()=="pass"){
            $.ajax({
                type: 'post', url: '/ticketsManager/j${managerid}/passSignUp',
                data: {"theaterid":theaterid},
                cache: false, dataType: 'json',
                success: function (success) {
                    if(success){
                        alert("审核通过注册场馆成功");
                        window.location.href="/ticketsManager/j${managerid}/checkList?checkType=signUpTheater";
                    }else{
                        alert("审核通过注册场馆失败");
                    }
                    $("#myModal").modal("hide");
                }
            });
        }else if($("#passOrReject").val()=="reject"){
            $.ajax({
                type: 'post', url: '/ticketsManager/j${managerid}/rejectSignUp',
                data: {"theaterid":theaterid},
                cache: false, dataType: 'json',
                success: function (success) {
                    if(success){
                        alert("审核拒绝注册场馆成功");
                        window.location.href="/ticketsManager/j${managerid}/checkList?checkType=signUpTheater";
                    }else{
                        alert("审核拒绝注册场馆失败");
                    }
                    $("#myModal").modal("hide");
                }
            });
        }
    }
</script>
</body>
</html>
