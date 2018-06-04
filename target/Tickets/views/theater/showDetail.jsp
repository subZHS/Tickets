<%@ page import="java.util.List" %>
<%@ page import="com.tickets.util.ShowType" %>
<%@ page import="com.tickets.model.Show" %>
<%@ page import="com.tickets.model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tickets.model.OrderSeat" %>
<%@ page import="com.tickets.util.OrderState" %>
<%@ page import="com.tickets.model.Balance" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/resources/css/font-awesome.min.css">
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/chooseSeat.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/table.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/ImgCropping.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/fileUpload.css" rel="stylesheet" type="text/css"/>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.seat-charts.min.js"></script>
<script src="/resources/js/fileUpload.js"></script>
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
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>演出详情</span></div>
        <br/><br/>

        <div class="row">
            <div class="col-md-2">
                <img style="height: 200px;width:145px" src="${show.image}">
            </div>
            <div class="col-md-10">
                <div style="position: relative;left: 7%">
                    <h5>
                        <b style="color: #459bdc;font-size: 20px;">${show.title}</b><label style="padding-left:20px;color:gray;font-size:13px">( ${showTypeStr} )</label></h5>
                    <div class="row">
                        <ul class="col-md-2" style="line-height: 30px">
                            <li>演出状态：</li>
                            <li>参演人员：</li>
                            <li>价格：<br/><br/><br/></li>
                            <li>简介：</li>
                        </ul>
                        <ul class="col-md-10" style="line-height: 30px;position: relative;left: -6%;word-break: break-all">
                            <li style="color: #fe423f">
                                <%String showState = (String) request.getAttribute("showState");
                                if(showState.equals("NotOnSale")){%>
                                尚未售票
                                <%}else if(showState.equals("OnSale")){%>
                                开始售票
                                <%}else if(showState.equals("Notpay")){%>
                                演出结束，未结算
                                <%}else if(showState.equals("Payed")){%>
                                已结算
                                <%}%>
                            </li>
                            <li>${show.actor}</li>
                            <li><span>前排：¥${show.price1}</span><br/><span>中间：¥${show.price2}</span><br/><span>靠后：¥${show.price3}</span></li>
                            <li>${show.description}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="bottom_text" style="width: 100%;margin-top: 50px"><span>上座情况</span></div>

        <div class="w3_content_agilleinfo_inner" style="width: 100%;border-top: none;padding-left: 0px;padding-bottom: 0px;margin-bottom: 0">
            <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary active">
                    <input type="radio" name="options" id="option1">
                    <span>座位形式</span>
                </label>
                <label class="btn btn-primary">
                    <input type="radio" name="options" id="option2">
                    <span>列表形式</span>
                </label>
            </div>
        </div>

        <div class="w3_content_agilleinfo_inner" style="border:none;width: 100%;padding-left: 0px">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="showTime_ul" class="nav-tabs" role="tablist">
                    <li><b>演出时间： &nbsp;&nbsp;&nbsp;</b></li>
                    <%for(String dateTimeStr :(List<String>)request.getAttribute("dateTimeList")){%>
                    <li role="presentation"><a href="javascript:;" onclick="window.location.href='/theater/j${theaterid}/show/j${show.showid}?dateIndex='+$(this).index('#showTime_ul li a');" role="tab"><%=dateTimeStr%></a></li>
                    <%}%>
                </ul>
            </div>
        </div>

        <div id="seat_form">

            <div class="demo clearfix" style="margin-left: 0px;padding-left: 0px;height: 700px">
                <!---左边座位列表----->
                <div id="seat_area" contenteditable="false" style="max-height: 650px;overflow:auto">
                    <div class="front">屏幕</div>
                </div>
                <div id="legend" style="position: relative;top:0px">
                    <h4 style="width:800px;word-break: break-all">注意：如果是正在售票状态，只显示选座购买的座位。</h4>
                </div>
            </div>
        </div>
        <div id="orderList_form" class="table_list" style="display:none;border-top:none">
            <div class="agile_featured_movies">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                            <div class="agile-news-table">
                                <%List<Order> orderList=(List<Order>)request.getAttribute("orderList");
                                    if(orderList==null||orderList.size()==0){
                                %>
                                <h3 style="text-align: center">There are no order now -_-</h3>
                                <%}else{%>
                                <table id="table-breakpoint">
                                    <thead>
                                    <tr>
                                        <th>订单号</th>
                                        <th>订单类型</th>
                                        <th>座位</th>
                                        <th>票数</th>
                                        <th>价格</th>
                                        <th>状态</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        for(int i=0;i<orderList.size();i++){
                                            Order order=orderList.get(i);
                                            List<OrderSeat> orderSeatList=((List<List<OrderSeat>>)request.getAttribute("orderSeatsList")).get(i);%>
                                    <tr>
                                        <td><p>订单号：<label class="orderid"><%=order.getOrderid()%></label></p>
                                            <p>下单时间：<%=sdf.format(order.getTime())%></p></td>
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
<%if(request.getAttribute("balance")!=null){%>
        <div class="bottom_text" style="width: 100%;margin-top: 50px"><span>结算情况</span></div>

        <div class="table_list" style="border-top:none">
            <div class="agile_featured_movies">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                            <div class="agile-news-table">
                                <div class="w3ls-news-result">
                                    <h4>结算状态 : <span>
                                        <%Balance balance = (Balance) request.getAttribute("balance");
                                            if(balance.isState()){%>
                                        已结算
                                        <%}else{%>
                                        未结算
                                        <%}%>
                                    </span></h4><br/>
                                    <h4>当前总销售额 : <span>${showIncome}</span></h4>
                                </div>
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
<%}%>
    </div>
</div>

<!--图片裁剪框 start-->
<div style="display: none" class="tailoring-container">
    <div class="black-cloth" onClick="closeTailor(this)"></div>
    <div class="tailoring-content">
        <div id="fileUploadContent" class="fileUploadContent"></div>
        <div class="close-tailoring"  onclick="closeTailor(this)">×</div>
        <br/>
        <button class="l-btn sureCut" id="sureCut">确定</button>
    </div>
</div>
<!--图片裁剪框 end-->

<!--上传图片的script-->
<!--
<script type="text/javascript">

    //弹出框水平垂直居中
    (window.onresize = function () {
        var win_height = $(window).height();
        var win_width = $(window).width();
        $(".tailoring-content").css({
            "top": 50,
            "left": (win_width - $(".tailoring-content").outerWidth())/2
        });
//        if (win_width <= 768){
//            $(".tailoring-content").css({
//                "top": (win_height - $(".tailoring-content").outerHeight())/2,
//                "left": 0
//            });
//        }else{
//            $(".tailoring-content").css({
//                "top": (win_height - $(".tailoring-content").outerHeight())/2,
//                "left": (win_width - $(".tailoring-content").outerWidth())/2
//            });
//        }
    })();

    //弹出图片裁剪框
    $("#replaceImg").on("click",function () {
        $(".tailoring-container").toggle();
    });

    //裁剪后的处理
    $("#sureCut").on("click",function () {
//        if ($("#tailoringImg").attr("src") == null ){
//            return false;
//        }else{
//            var cas = $('#tailoringImg').cropper('getCroppedCanvas');//获取被裁剪后的canvas
//            var base64url = cas.toDataURL('image/png'); //转换为base64地址形式
//            $("#finalImg").prop("src",base64url);//显示为图片的形式
//
////            handleSave(base64url);
//
//            //关闭裁剪框
//            closeTailor();
//        }
        closeTailor();
    });
    //关闭裁剪框
    function closeTailor() {
        $(".tailoring-container").toggle();
    }

</script>
<script type="text/javascript">
    $("#fileUploadContent").initUpload({
        "uploadUrl":"#",//上传文件信息地址
        "progressUrl":"#",//获取进度信息地址，可选，注意需要返回的data格式如下（{bytesRead: 102516060, contentLength: 102516060, items: 1, percent: 100, startTime: 1489223136317, useTime: 2767}）
        //"showSummerProgress":false,//总进度条，默认限制
        //"size":350,//文件大小限制，单位kb,默认不限制
        //"maxFileNumber":3,//文件个数限制，为整数
        //"filelSavePath":"",//文件上传地址，后台设置的根目录
        //"beforeUpload":beforeUploadFun,//在上传前执行的函数
        //"onUpload":onUploadFun，//在上传后执行的函数
        autoCommit:true,//文件是否自动上传
        //"fileType":['png','jpg','docx','doc']，//文件类型限制，默认不限制，注意写的是文件后缀
    });
    function beforeUploadFun(opt){
        opt.otherData =[{"name":"你要上传的参数","value":"你要上传的值"}];
    }
    function onUploadFun(opt,data){
        alert(data);
        uploadTools.uploadError(opt);//显示上传错误
    }
</script>
-->
<!--座位的script-->
<script type="text/javascript">
    var price = 100; //电影票价
    $(document).ready(function() {
        var $cart = $('#seats_chose'); //座位区
        var sc = $('#seat_area').seatCharts({
            map:${seat},
            // map: [//座位结构图 a 代表可选，b代表已售出; 下划线 "_" 代表过道
            //     'aaaaaaaaaa',
            //     'bbbbbbbbbb',
            //     '__________',
            //     'aaaaaaaa__',
            //     'aaaaaaaaaa',
            //     'aaaaaaaaaa',
            //     'aaaaaaaaaa',
            //     'aaaaaaaaaa',
            //     'aaaaaaaaaa',
            //     'aaaaaaaaaa',
            //     'aaaaaaaaaa'
            // ],
            seats: {
                a: {
                    price   : 100,
                    classes : 'available', //your custom CSS class
                    category: '未售出'
                },
                b: {
                    price   : 40,
                    classes : 'unavailable', //your custom CSS class
                    category: '已售出'
                }
            },
            naming: {//设置行列等信息
                top: false, //不显示顶部横坐标（行）
                getLabel: function(character, row, column) { //返回座位信息
                    return column;
                },
                getData:function(dataList){
                    console.log(dataList);
                    return dataList;
                }
            },
            legend: {//定义图例
                node: $('#legend'),
                items: [
                    ['a', 'available', '未售出'],
                    ['b', 'unavailable', '已售出']
                ]
            }
        });
        //设置已售出的座位
        // sc.get(['1_3', '1_4', '4_4', '4_5', '4_6', '4_7', '4_8']).status('unavailable');

        $("div.seatCharts-cell").unbind();
    });

    function getTotalPrice(sc) { //计算票价总额
        var total = 0;
        sc.find('unavailable').each(function() {
            total += price;
        });
        return total;
    }
</script>
<script type="text/javascript">
    $(".btn-group .btn-primary").click(function () {
        var index=$(this).index(".btn-group .btn-primary");
        $(".btn-group .btn-primary").removeClass("active");
        $(this).addClass("active");
        if(index==0){
            $('#seat_form').show();
            $('#orderList_form').hide();
        }else if(index==1){
            $('#seat_form').hide();
            $('#orderList_form').show();
        }
    });

    $(document).ready(function () {
        $("#showTime_ul li").eq(<%=request.getParameter("dateIndex")%>+1).addClass("active");

    });

</script>
</body>
</html>
