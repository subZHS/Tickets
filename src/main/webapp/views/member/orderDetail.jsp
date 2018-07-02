<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tickets.model.Order" %>
<%@ page import="com.tickets.model.OrderSeat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tickets.util.OrderState" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/navstyle.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/jquery.step.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/table.css" rel="stylesheet" type="text/css"/>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.step.min.js"></script>
<style>
    .warp{
        height: 60px;
        line-height: 60px;
        text-align: center;
        font-size: 30px;
        font-family: "微软雅黑";
    }
    .warp strong{
        width: 60px;
        display: inline-block;
        text-align: center;
        font-family: georgia;
        color: #C9302C;
    }
</style>
<head>
    <title>wait for pay</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<div style="display: block;height: 50px"></div>
<%Order order=(Order)request.getAttribute("order");
if(OrderState.values()[order.getState()]==OrderState.WaitCheck){%>
<div id="step"style="	width: 1000px;	margin: 50px auto;margin-bottom: 60px;"></div>

<div class="w3_content_agilleinfo_inner row" style="border-top: none">
    <div class="alert alert-info">
        <span class="col-md-offset-1 col-md-9">○ &nbsp;您已购票成功，请凭订单号<span style="color: #C9302C">${order.orderid}</span>到场馆检票观看演出。</span>
        <br/>
    </div>
</div>
<%}%>
<div id="div-space">
    <br><br>
</div>
<div class="bottom_text" style="margin-top: 10px"><span>订单详情</span></div>

<div class="w3_content_agilleinfo_inner table_list" style="border-top:none">
    <div class="agile_featured_movies">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <div id="myTabContent" class="tab-content">
                <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                    <div class="agile-news-table">
                        <%SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            List<OrderSeat> orderSeatList=(List<OrderSeat>)request.getAttribute("orderSeatList");%>
                        <div class="w3ls-news-result">
                            <h4>下单时间：<%=sdf.format(order.getTime())%>&nbsp;&nbsp; 订单号：<span style="color: #C9302C">${order.orderid}</span></h4>
                        </div>
                        <table id="table-breakpoint">
                            <thead>
                            <tr>
                                <th>订单信息</th>
                                <th>订单类型</th>
                                <th>订单状态</th>
                                <th>座位</th>
                                <th>票数</th>
                                <th>会员优惠</th>
                                <th>优惠券</th>
                                <th>价格</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><a href="/publish/theater/j${theaterId}/show/j${show.showid}#show_part"><img src="${show.image}" style="width:90px;float:left;margin-right: 10px" alt="" />
                                    <h5 style="margin-top: 20px">${show.title}</h5></a>
                                    <a href="/publish/theater/j${theaterId}" class="btn btn-link" style="padding: 0">${theaterName}</a><br/>
                                    <span>${showTimeStr}</span>
                                </td>
                                <td><%if(order.isOrdertype()){%>
                                    选座购买
                                    <%}else{%>
                                    不选座购买<%}%></td>
                                <td style="color: #C9302C" class="w3-list-info"><%
                                    OrderState orderState1=OrderState.values()[order.getState()];
                                    if(orderState1==OrderState.WaitPay){%>待支付
                                    <%}else if(orderState1==OrderState.WaitCheck){%>待检票
                                    <%}else if(orderState1==OrderState.HaveChecked){%>已观看
                                    <%}else if(orderState1==OrderState.PassPayTime){%>已取消
                                    <%}else if(orderState1==OrderState.Refunded){%>已退款
                                    <%}%>
                                </td>
                                <td><%if(orderSeatList.size()!=0){
                                    for(OrderSeat orderSeat:orderSeatList){%>
                                    <%=orderSeat.getSeatRow()%>排<%=orderSeat.getSeatColumn()%>座<br/>
                                    <%}}else{%>
                                    待定
                                    <%}%>
                                </td>
                                <td>${order.number}</td>
                                <td>${order.discount*10}折</td>
                                <td><%if(order.getCoupontype()==0){%>
                                    未使用
                                    <%}else if(order.getCoupontype()==1){%>
                                    满10减1
                                    <%}else if(order.getCoupontype()==2){%>
                                    满30减5
                                    <%}else if(order.getCoupontype()==3){%>
                                    满50减10
                                    <%}%>
                                </td>
                                <td>¥${order.price}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%if(orderState1==OrderState.WaitCheck){%>
<div class="w3_content_agilleinfo_inner" style="border-top: none">
    <%--对调"去退款"和"返回"按钮样式--%>
    <a href="javascript:;" onclick="$('#myModal').modal('show');" class="btn btn-default col-md-offset-10" style="width: 80px">去退款</a>
</div>
<%}%>
<div class="w3_content_agilleinfo_inner" style="border-top: none">
    <a href="/member/j${sessionScope.member.memberid}/orderList?orderState=All" class="btn btn-primary col-md-offset-10" style="width: 80px">返回</a>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">您确定要退款吗？</h4>
            </div>
            <div class="modal-body" style="white-space: pre">退款可能会收取部分手续费。距离开场时间不同设置不同比例的手续费，具体规则如下：
1、开场1天前：退票费0
2、开场1天内：退票费5%
3、开场2小时内：退票费10%
4、开场15分钟内：不得退票</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a type="button" class="btn btn-primary" onclick="refundOrder()">确定</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<script type="text/javascript">
    var $step = $("#step");
    var $index = $("#index");

    $("#div-space").show();
    <%if (orderState1 == OrderState.WaitCheck){%>
    $("#div-space").hide();
    <%}%>


    $step.step({
        index: 3,
        time: 500,
        title: ["选择演出场次", "选择座位", "15分钟内付款", "场馆取票观看"]
    });
</script>
<script>
    function refundOrder() {
        $.ajax({
            type: 'post', url: '/member/j${sessionScope.member.memberid}/order/j${order.orderid}/refundOrder',
            data: {},
            cache: false, dataType: 'json',
            success: function (data) {
                if (data=="Success") {
                    alert("退款成功");
                    window.location.href = "/member/j${sessionScope.member.memberid}/order/j${order.orderid}/orderDetail";
                } else if(data=="PassShowTime") {
                    alert("您已错过开场时间，无法退票");
                }else if(data=="InMinutes15") {
                    alert("开场15分钟内不得退票");
                }else{
                    alert("退票失败");
                }
            }
        });
        $("#myModal").modal('hide');
    }
</script>
</body>
</html>
