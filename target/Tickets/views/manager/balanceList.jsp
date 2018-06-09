<%@ page import="java.util.List" %>
<%@ page import="com.tickets.model.Balance" %>
<%@ page import="com.tickets.model.Show" %>
<%@ page import="com.tickets.model.ShowTime" %>
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
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>待结算</span></div>

        <div class="w3_content_agilleinfo_inner" style="width: 100%;border:none">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab" class="nav-tabs" role="tablist">
                    <li><b>筛选： &nbsp;&nbsp;&nbsp;</b></li>
                    <li role="presentation" <%if(request.getParameter("balanceType").equals("notPay")){%> class="active"<%}%>>
                        <a href="/ticketsManager/j${managerid}/balanceList?balanceType=notPay" role="tab">待结算</a></li>
                    <li role="presentation" <%if(request.getParameter("balanceType").equals("payed")){%> class="active"<%}%>>
                        <a href="/ticketsManager/j${managerid}/balanceList?balanceType=payed" role="tab">已结算</a></li>

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
                                <%List<Balance> balanceList = (List<Balance>) request.getAttribute("balanceList");
                                    if(balanceList.size()==0){
                                %>
                                <h3 style="text-align: center">There are no this kind of balance list now -_-</h3>
                                <%}else{%>
                                <table id="table-breakpoint">
                                    <thead>
                                    <tr>
                                        <th>电影信息</th>
                                        <th>场次</th>
                                        <th>总销售额</th>
                                        <th>详情</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%for(int i=0;i<balanceList.size();i++){
                                        Balance balance = balanceList.get(i);
                                        Show show=((List<Show>)request.getAttribute("showList")).get(i);
                                        String theaterName = ((List<String>)request.getAttribute("theaterNameList")).get(i);
                                        String theaterId = ((List<String>)request.getAttribute("theaterIdList")).get(i);
                                        String showTypeStr=((List<String>)request.getAttribute("showTypeList")).get(i);
                                        List<String> dateTimesList=((List<List<String>>)request.getAttribute("dateTimesList")).get(i);
                                    %>
                                    <tr>
                                        <td><input class="showid_hide" type="hidden" value="<%=show.getShowid()%>">
                                            <a href="/publish/theater/j<%=theaterId%>/show/j<%=show.getShowid()%>"><img src="<%=show.getImage()%>" style="width:90px;float:left;margin-right: 10px" alt="" />
                                                <h5 style="margin-top: 20px"><%=show.getTitle()%></h5></a>
                                            <span>(<%=showTypeStr%>)</span>
                                            <a href="/public/theater/j<%=theaterId%>" class="btn btn-link" style="padding: 0"><%=theaterName%></a><br/>
                                        </td>
                                        <td><%for(String dateTimes:dateTimesList){%>
                                            <%=dateTimes%><br/>
                                            <%}%>
                                        </td>
                                        <td><%=balance.getTotalincome()%></td>
                                        <td>
                                            <a href="/ticketsManager/j${managerid}/balance/j<%=show.getShowid()%>" class="btn btn-link">查看详情-></a>
                                            <%if(!balance.isState()){%>
                                            <br/><a href="javascript:;" onclick="payIndex=<%=i%>;$('#myModal').modal('show');" class="btn btn-link">结算-></a>
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

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">您确定要结算吗？</h4>
            </div>
            <div class="modal-body"><p>结算将按总销售额的80%转给场馆的支付账号。</p>
                <input id="pay_password" type="password" class="form-control" placeholder="请输入管理员支付密码">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a type="button" class="btn btn-primary" onclick="payBalance()">结算</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<script type="text/javascript">
    var payIndex;
    function payBalance() {
        if($("#pay_password").val()==""){
            alert("请先输入您的支付密码");
            return;
        }
        var showid=$(".showid_hide").eq(payIndex).val();
        $.ajax({
            type: 'post', url: '/ticketsManager/j${managerid}/balance/j'+showid+'/pay',
            data: {"password":$("#pay_password").val()},
            cache: false, dataType: 'json',
            success: function (success) {
                if(success){
                    alert("结算成功");
                    window.location.href="/ticketsManager/j${managerid}/balanceList?balanceType=notPay";
                }else{
                    alert("支付密码错误，请重试");
                }
            }
        });
        $("#myModal").modal('hide');
    }
</script>
</body>
</html>
