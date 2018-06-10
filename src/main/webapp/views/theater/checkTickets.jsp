<%@ page import="com.tickets.model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tickets.model.OrderSeat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tickets.util.OrderState" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
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
    <jsp:include page="/views/theater/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>

    <div class="col-md-9" style="margin-left: 5%">
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>检票</span></div>

        <form action="#" id="findOrder_form" style="font-size: 15px;margin-top: 15px">
            <div class="row form-group">
                <div class="col-md-12">
                    <label>订单号</label>
                    <input name="orderid" type="text" class="form-control" oninput="">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <input type="submit" class="btn btn-primary" value="检票">
                </div>
            </div>
        </form>
<br/><br/>
<%if(request.getAttribute("order")!=null){
    Order order=(Order)request.getAttribute("order");
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    List<OrderSeat> orderSeatList=(List<OrderSeat>)request.getAttribute("orderSeatList");%>
        <div id="haveChecked_div">
            <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>已检票订单</span></div>

            <div class="table_list" style="border-top:none">
                <div class="agile_featured_movies">
                    <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                        <div id="myTabContent" class="tab-content">
                            <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                                <div class="agile-news-table">
                                    <div class="w3ls-news-result">
                                        <h4>下单时间：<%=sdf.format(order.getTime())%>&nbsp;&nbsp; 订单号：<span style="color: #C9302C">${order.orderid}</span></h4>
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
                                            <td><a href="/public/theater/j${sessionScope.theater.theaterid}/show/j${show.showid}"><img src="${show.image}" style="width:90px;float:left;margin-right: 10px" alt="" />
                                                <h5 style="margin-top: 20px">${show.title}</h5></a>
                                                <span>${dateTimeStr}</span>
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

        </div>
<%}%>
    </div>
</div>

<script>

    $(document).ready(function () {
        //如果是检票后的页面，要显示检票结果
        if('<%=request.getParameter("orderid")%>'!='null'){
            if('<%=request.getAttribute("order")%>'=='null'){
                if('<%=request.getAttribute("message")%>'!='null'){
                    var tmpMessage="";
                    switch ('<%=request.getAttribute("message")%>'){
                         case 'PassPayTime':
                             tmpMessage="已取消";
                             break;
                        case 'WaitPay':
                             tmpMessage="待支付";
                             break;
                        case 'WaitCheck':
                            tmpMessage="待检票";
                             break;
                        case 'Refunded':
                            tmpMessage="已退款";
                             break;
                        case 'HaveChecked':
                            tmpMessage="已观看";
                             break;
                    }


                    alert("该订单类型是" + '<%=request.getAttribute("message")%>' + "，该订单不允许检票");
                }else{
                    alert("不存在该订单");
                }
                window.location.href="/theater/j${sessionScope.theater.theaterid}/checkTickets";
            }else{
                if('<%=request.getAttribute("message")%>'=='HaveChecked'){
                    alert("该订单已经检票过，不要重复检票");
                }else {
                    alert("检票成功");
                }
                $("#haveChecked_div").show();
            }
        }
    });

    $('#findOrder_form').submit(function () {
        if($("input[name='orderid']").val()==""){
            alert("请填写订单号");
            return false;
        }
        var orderid=$("input[name='orderid']").val();
        window.location.href="/theater/j${sessionScope.theater.theaterid}/checkTickets?orderid="+orderid;
        return false;
    });

</script>
</body>
</html>
