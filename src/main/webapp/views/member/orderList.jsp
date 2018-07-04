<%@ page import="com.tickets.util.OrderState" %>
<%@ page import="com.tickets.model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tickets.model.Show" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tickets.model.OrderSeat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/table.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/resources/css/tagstyle.css" media="screen" rel="stylesheet" type="text/css" />
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>

<link href="/resources/css/public.css"rel="stylesheet" type="text/css" />


<head>
    <title>Member order list</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>


<div class="container row">

    <jsp:include page="/views/member/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>


    <div class="col-md-offset-3 col-md-9">

        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>个人订单</span></div>

        <div class="w3_content_agilleinfo_inner" style="border-top: none;width: 100%">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab" class="nav-tabs" role="tablist" style="border: none">
                    <%OrderState orderState= OrderState.valueOf(request.getParameter("orderState"));%>
                    <li><b>订单状态： &nbsp;&nbsp;&nbsp;</b></li>
                    <li role="presentation" <%if(orderState==OrderState.All){%> class="active"<%}%>>
                        <a href="/member/j${sessionScope.member.memberid}/orderList?orderState=All" id="home-tab" role="tab">全部</a></li>
                    <li role="presentation" <%if(orderState==OrderState.WaitPay){%> class="active"<%}%>>
                        <a href="/member/j${sessionScope.member.memberid}/orderList?orderState=WaitPay" role="tab">待支付</a></li>
                    <li role="presentation" <%if(orderState==OrderState.WaitCheck){%> class="active"<%}%>>
                        <a href="/member/j${sessionScope.member.memberid}/orderList?orderState=WaitCheck" role="tab">待检票</a></li>
                    <li role="presentation" <%if(orderState==OrderState.HaveChecked){%> class="active"<%}%>>
                        <a href="/member/j${sessionScope.member.memberid}/orderList?orderState=HaveChecked" role="tab">已观看</a></li>
                    <li role="presentation" <%if(orderState==OrderState.PassPayTime){%> class="active"<%}%>>
                        <a href="/member/j${sessionScope.member.memberid}/orderList?orderState=PassPayTime" role="tab">已失效</a></li>
                    <li role="presentation" <%if(orderState==OrderState.Refunded){%> class="active"<%}%>>
                        <a href="/member/j${sessionScope.member.memberid}/orderList?orderState=Refunded" role="tab">已退款</a></li>
                </ul>
            </div>
        </div>
        <%--和下面空点距离--%>
        <br>

        <div class="table_list" style="border-top:none">
            <div class="agile_featured_movies">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                            <div class="agile-news-table">
                                <%List<Order> orderList=(List<Order>)request.getAttribute("orderList");
                                    if(orderList==null||orderList.size()==0){
                                %>
                                <h3 id="noOrderTip" style="text-align: center;font-weight: 500;font-size: 18px">您当前没有这种状态的订单 -_-</h3>
                                <%}else{%>
                                <table id="table-breakpoint-order">
                                    <thead>
                                    <tr>
                                        <%--将"下单时间"放到后面--%>
                                        <th>订单信息</th>
                                        <th>下单时间</th>
                                        <th>订单类型</th>
                                        <th>座位</th>
                                        <th>票数</th>
                                        <th>价格</th>
                                        <th>状态</th>
                                        <th>详情</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        for(int i=0;i<orderList.size();i++){
                                            Order order=orderList.get(i);
                                            Show show=((List<Show>)request.getAttribute("showList")).get(i);
                                            String theaterName=((List<String>)request.getAttribute("theaterNameList")).get(i);
                                            String theaterId=((List<String>)request.getAttribute("theaterIdList")).get(i);
                                            String dateTime=((List<String>)request.getAttribute("dateTimeList")).get(i);
                                            List<OrderSeat> orderSeatList=((List<List<OrderSeat>>)request.getAttribute("orderSeatsList")).get(i);
                                    %>
                                    <tr><td style="text-align: left"><p>订单号：<label class="orderid"><%=order.getOrderid()%></label></p>
                                            <a href="/publish/theater/j<%=theaterId%>/show/j<%=show.getShowid()%>#show_part"><img src="<%=show.getImage()%>" style="width:90px;float:left;margin-right: 10px" alt="" />
                                            <h5 style="margin-top: 20px"><%=show.getTitle()%></h5></a>
                                            <a href="/publish/theater/j<%=theaterId%>" class="btn btn-link" style="padding: 0"><%=theaterName%></a><br/>
                                            <span><%=dateTime%></span>
                                        </td>
                                        <td><%=sdf.format(order.getTime())%></td>
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
                                        <td><%=order.getNumber()%></td>
                                        <td>¥<%=order.getPrice()%></td>
                                        <td class="w3-list-info"><%
                                            OrderState orderState1=OrderState.values()[order.getState()];
                                            if(orderState1==OrderState.WaitPay){%>待支付
                                            <%}else if(orderState1==OrderState.WaitCheck){%>待检票
                                            <%}else if(orderState1==OrderState.HaveChecked){%>已观看
                                            <%}else if(orderState1==OrderState.PassPayTime){%>已取消
                                            <%}else if(orderState1==OrderState.Refunded){%>已退款
                                            <%}%>
                                        </td>
                                        <td><%if(orderState1==OrderState.WaitPay){%>
                                            <a href="/member/j${sessionScope.member.memberid}/order/j<%=order.getOrderid()%>/waitPay" class="btn btn-link">去支付-></a>
                                            <%}else{%>
                                            <a href="/member/j${sessionScope.member.memberid}/order/j<%=order.getOrderid()%>/orderDetail" class="btn btn-link">详情-></a>
                                            <%}%>
                                            <%if(orderState1==OrderState.WaitCheck){%>
                                            <br/><a href="javascript:;" onclick="refundOrderIndex=$(this).parent().parent().index('#table-breakpoint tbody tr');$('#myModal').modal('show');" class="btn btn-link">退款-></a>
                                            <%}%>
                                        </td>
                                    </tr>
                                    <%} }%>
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

<script>
    if($("#myTab li").eq(1).hasClass("active")){
        $("#noOrderTip").html("您还没有任何购票记录 -_- <a href='/publish/showList?isOpen=true&showType=All&orderType=heat' style='font-size: 18px' class='btn btn-link'>去买票</a>");
    }
</script>

<script>
    var refundOrderIndex;
    function refundOrder() {
        var orderid=$(".orderid").eq(refundOrderIndex).text();
        $.ajax({
            type: 'post', url: '/member/j${sessionScope.member.memberid}/order/j'+orderid+'/refundOrder',
            data: {},
            cache: false, dataType: 'json',
            success: function (data) {
                if (data=="Success") {
                    alert("退款成功");
                    window.location.href = "/member/j${sessionScope.member.memberid}/orderList?orderState=Refunded";
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
