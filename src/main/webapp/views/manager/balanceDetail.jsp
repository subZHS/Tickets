<%@ page import="java.util.List" %>
<%@ page import="com.tickets.model.Balance" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/font-awesome.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/navstyle.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/table.css" rel="stylesheet" type="text/css"/>
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
        <ol class="breadcrumb">
            <li><a href="/ticketsManager/j${managerid}/balanceList?balanceType=notPay" style="outline: none;padding: 0;font-size: 15px" class="btn btn-link">结算</a></li>
            <li class="active">${show.title}</li>
        </ol>

        <div style="width: 100%;border-top: none;margin:20px 0 20px 0">
            <div class="row">
                <form action="#">
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-4">名称</label>
                            <label class="col-md-8">${show.title}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-4">&nbsp;&nbsp; 总销售额</label>
                        <label class="col-md-8" style="font-size: 25px;font-family: georgia;color: #C9302C;">¥${balance.totalincome}</label>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-4">&nbsp;&nbsp; 结算状态</label>
                        <label class="col-md-8" style="color: red">
                            <%Balance balance = (Balance)request.getAttribute("balance");
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            if(balance.isState()){%>
                            已结算 （结算时间：<%=sdf.format(balance.getTime())%>）
                            <%}else{%>
                            未结算
                            <%}%>
                        </label>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-4">类型</label>
                            <label class="col-md-8">${showTypeStr}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-4">场馆</label>
                            <label class="col-md-8"><a style="padding:0;margin: 0" href="/public/theater/j${theater.theaterid}" class="btn btn-link">${theater.name}</a>
                                (收款账号：${theater.alipayid})
                            </label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-4">参演人员</label>
                            <label class="col-md-8">${show.actor}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-4">简介</label>
                            <label class="col-md-8">${show.description}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-4">&nbsp;&nbsp; 座位分布</label>
                        <div class="col-md-8">
                            <ul>
                                <li><label>前排：1 - ${theater.rowdivide1}排</label></li>
                                <li><label>中间：${theater.rowdivide1} - ${theater.rowdivide2}排</label></li>
                                <li><label>靠后：${theater.rowdivide2} - -排</label></li>
                            </ul>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-4">&nbsp;&nbsp; 价格分布</label>
                        <div class="col-md-8">
                            <ul>
                                <li><label>前排：¥${show.price1}</label></li>
                                <li><label>中间：¥${show.price2}</label></li>
                                <li><label>靠后：¥${show.price3}</label></li>
                            </ul>
                        </div>
                    </div>
                </form>
                <div class="bottom_text" style="width: 100%;margin-top: 50px"><span>销售情况</span></div>

                <div class="table_list" style="border-top:none">
                    <div class="agile_featured_movies">
                        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                                    <div class="agile-news-table">
                                        <table>
                                            <thead>
                                            <tr>
                                                <th>场次</th>
                                                <th>上座数</th>
                                                <th>销售额</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%List<String> dateTimeList=(List<String>)request.getAttribute("dateTimeList");
                                                List<Double> showtimeIncomeList=(List<Double>)request.getAttribute("showtimeIncomeList");
                                                List<Integer> showtimeSeatNumList=(List<Integer>)request.getAttribute("showtimeSeatNumList");
                                                for(int i=0;i<dateTimeList.size();i++){%>
                                            <tr>
                                                <td><%=dateTimeList.get(i)%></td>
                                                <td><%=showtimeSeatNumList.get(i)%></td>
                                                <td><%=showtimeIncomeList.get(i)%></td>
                                            </tr>
                                            <%}%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
        <%if(!balance.isState()){%>
        <a href="javascript:;" onclick="$('#myModal').modal('show');" class="btn btn-primary" style="float: right;margin-right: 15%">结算</a>
        <%}%>
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

<script>
    function payBalance() {
        if($("#pay_password").val()==""){
            alert("请先输入您的支付密码");
            return;
        }
        $.ajax({
            type: 'post', url: '/ticketsManager/j${managerid}/balance/j${show.showid}/pay',
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
