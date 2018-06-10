<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tickets.model.Order" %>
<%@ page import="com.tickets.model.OrderSeat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tickets.util.OrderState" %>
<%@ page import="java.util.Date" %>
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

<div id="step"style="	width: 1000px;	margin: 50px auto;margin-bottom: 60px;"></div>

<div class="w3_content_agilleinfo_inner row" style="border-top: none">
    <div class="alert alert-danger">
        <span class="col-md-offset-1 col-md-5">○ &nbsp;请在15分钟内完成支付，超时订单会自动取消，现在还剩下</span>
        <div class="warp">
            <img src="/resources/images/time.png" style="height: 60px"/>
            <strong class="a">111</strong>分 <strong class="b"></strong>秒
        </div>
    </div>
</div>

<div class="bottom_text" style="margin-top: 10px"><span>确认订单详情</span></div>

<div class="w3_content_agilleinfo_inner table_list" style="border-top:none">
    <div class="agile_featured_movies">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <div id="myTabContent" class="tab-content">
                <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                    <div class="agile-news-table">
                        <%SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Order order=(Order)request.getAttribute("order");
                        List<OrderSeat> orderSeatList=(List<OrderSeat>)request.getAttribute("orderSeatList");%>
                        <div class="w3ls-news-result">
                            <h4>下单时间：<%=sdf.format(order.getTime())%>&nbsp;&nbsp; 订单号：<label style="color: #C9302C">${order.orderid}</label></h4>
                        </div>
                        <table id="table-breakpoint">
                            <thead>
                            <tr>
                                <th>订单信息</th>
                                <th>订单类型</th>
                                <th>座位</th>
                                <th>票数</th>
                                <th>会员优惠</th>
                                <th>优惠券</th>
                                <th>价格</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><a href="/public/theater/j${theaterId}/show/j${show.showid}"><img src="${show.image}" style="width:90px;float:left;margin-right: 10px" alt="" />
                                        <h5 style="margin-top: 20px">${show.title}</h5></a>
                                    <a href="/public/theater/j${theaterId}" class="btn btn-link" style="padding: 0">${theaterName}</a><br/>
                                    <span>${showTimeStr}</span>
                                </td>
                                <td><%if(order.isOrdertype()){%>
                                    选座购买
                                    <%}else{%>
                                    不选座购买<%}%></td>
                                <td><%if(orderSeatList.size()!=0){
                                    for(OrderSeat orderSeat:orderSeatList){%>
                                    <%=orderSeat.getSeatRow()%>排<%=orderSeat.getSeatColumn()%>座<br/>
                                    <%}}else{%>
                                    待定
                                    <%}%>
                                </td>
                                <td>${order.number}</td>
                                <td>${order.discount}</td>
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
<br/>
<div class="bottom_text" style="margin-top: 10px"><span>去支付</span></div>
<br/>
<div class="w3_content_agilleinfo_inner" style="border-top: none">
    <%--<a href="#" class="btn btn-primary col-md-offset-10">确认支付</a>--%>
        <form id="pay_form" action="#" style="margin-left: 25%;width: 50%;margin-bottom: 0;padding-bottom: 0">
            <div style="display: none" class="alert alert-danger" id="wrong_alert">错误！请进行一些更改。</div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>支付账号</label>
                    <input name="alipayid" type="text" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>支付密码</label>
                    <input name="password" type="password" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>支付金额</label>
                    <label style="margin-left: 5%"><span style="font-size: 25px;font-family: georgia;color: #C9302C;">￥${order.price}</span></label>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <input type="submit" class="btn btn-primary" value="确认支付">
                </div>
            </div>
        </form>
</div>

<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<script type="text/javascript">
    var $step = $("#step");
    var $index = $("#index");

    $step.step({
        index: 2,
        time: 500,
        title: ["选择演出场次", "选择座位", "15分钟内付款", "场馆取票观看"]
    });
</script>
<script type="text/javascript">
    $(document).ready(function() {
        <%Date deadTime=order.getTime();
        Date curDate=new Date();
        long times=(deadTime.getTime()+5*60*1000-curDate.getTime())/1000;//单位是秒
        %>
        var times = <%=times%>; // 15*60秒
        countTime = setInterval(function() {
            times = --times < 0 ? 0 : times;
            var minute = Math.floor(times/60).toString();

            if(minute.length <= 1) {
                minute = "0" + minute;
            }
            var ms = Math.floor(times % 60).toString();
            if(ms.length <= 1) {
                ms = "0" + ms;
            }
            if(times <= 0) {
                clearInterval(countTime);
                $.ajax({
                    type: 'post', url: '/member/j${sessionScope.member.memberid}/order/j${order.orderid}/cancelOrder',
                    data: {},
                    cache: false, dataType: 'json',
                    success: function (success) {
                        if (success) {
                            alert("支付超时，订单已取消");
                        } else {
                            alert("支付超时，订单取消失败");
                        }
                        window.location.href = "/member/j${sessionScope.member.memberid}/orderList?orderState=All";
                    }
                });
            }
            // 获取分钟、毫秒数
            $(".a").html(minute);
            $(".b").html(ms);
        }, 1000);
    });
</script>
<script>
    function checkFullInput(form, alert) {
        for(var i=0;i<$(form+" input").length;i++) {
            if ($(form+" input").eq(i).val() == "") {
                $(alert).html("请完善表单信息").show();
                return false;
            }
        }
        return true;
    }

    function onInput() {
        $("#wrong_alert").hide();
    }

    $('#pay_form').submit(function () {
        if(!checkFullInput('#pay_form','#wrong_alert')){
            return false;
        }
        $.ajax({
            type: 'post', url: '/member/j${sessionScope.member.memberid}/order/j${order.orderid}/payOrder',
            data: $("#pay_form").serialize(),
            cache: false, dataType: 'json',
            success: function (data) {
                if (data.success == "false") {
                    var showStr;
                    if (data.message == "AliPayNotExist") {
                        showStr = "该支付账号不存在";
                    } else if (data.message == "WrongPassword") {
                        showStr = "密码错误";
                    } else if (data.message == "NotEnoughMoney") {
                        showStr = "账户余额不足";
                    }
                    $("#wrong_alert").html(showStr).show();
                } else {
                    window.location.href = "/member/j${sessionScope.member.memberid}/order/j${order.orderid}/orderDetail";
                }
            }
        });
        return false;
    });
</script>
</body>
</html>
