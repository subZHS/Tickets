<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/chooseSeat.css" rel="stylesheet" type="text/css"/>
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.seat-charts.min.js"></script>
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
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>线下购票</span></div>

        <div class="w3_content_agilleinfo_inner" style="border:none;width: 100%;padding-left: 0px">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="showTime_ul" class="nav-tabs" role="tablist">
                    <li><b>演出时间： &nbsp;&nbsp;&nbsp;</b></li>
                    <%for(String dateTimeStr :(List<String>)request.getAttribute("dateTimeList")){%>
                    <li role="presentation"><a href="javascript:;" onclick="window.location.href='/theater/j${theaterid}/show/j${show.showid}/offlineOrder?dateIndex='+$(this).index('#showTime_ul li a');" role="tab"><%=dateTimeStr%></a></li>
                    <%}%>
                </ul>
            </div>
        </div>

        <div class="demo clearfix" style="height: 750px">
            <!---左边座位列表----->
            <div id="seat_area" style="max-height: 650px;overflow:auto">
                <div class="front">屏幕</div>
                <div id="legend" style="bottom:220px"></div>
            </div>
            <!---右边选座信息----->
            <div class="booking_area" style="height: 750px">
                <img src="${show.image}" width="150px" style="margin-bottom: 10px" />
                <p>电影：<span>${show.title}</span></p>
                <p>时间：<span id="book_time"></span></p>
                <p>票价：<div style="font-size: 15px"><span>1 - ${divide1-1}排：¥${show.price1}</span><br/><span>${divide1} - ${divide2-1}排：¥${show.price2}</span>
                    <br/><span>${divide2} - -排：¥${show.price3}</span></div></p>
                <p>座位：</p>
                <ul id="seats_chose"></ul>
                <p>票数：<span id="tickects_num">0</span></p>
                <p>会员：<input oninput="checkDiscount()" id="memberid" type="email" class="form-control" placeholder="请输入会员账号"/><span id="show_discount" style="display: none">（享受 <span id="discount" style="color: red">9</span> 折优惠）</span></p>
                <p>总价：<b>￥<span id="total_price">0</span></b></p>
                <input type="button" class="btn btn-primary" onclick="submitOfflineOrder()" value="确定购买" style="margin-top: 10px"/>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var sc;
    var $cart = $('#seats_chose'), //座位区
        $tickects_num = $('#tickects_num'), //票数
        $total_price = $('#total_price'); //票价总额
    var discount=1;//会员优惠

    $(document).ready(function() {

        sc = $('#seat_area').seatCharts({
            map:${seat},
            // map: [//座位结构图 a 代表座位; 下划线 "_" 代表过道
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
            // ],
            seats: {
                a: {
                    price   : 100,
                    classes : 'available', //your custom CSS class
                    category: '可选座'
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
                }
            },
            legend: {//定义图例
                node: $('#legend'),
                items: [
                    ['a', 'available', '可选座'],
                    ['b', 'unavailable', '已售出'],
                    ['a', 'selected', '已选']
                ]
            },
            click: function() {
                if (this.status() == 'available') { //若为可选座状态，添加座位
                    $('<li>' + (this.settings.row + 1) + '排' + this.settings.label + '座</li>')
                        .attr('id', 'cart-item-' + this.settings.id)
                        .data('seatId', this.settings.id)
                        .appendTo($cart);

                    $tickects_num.text(sc.find('selected').length + 1); //统计选票数量
                    $total_price.text(getTotalPrice() + getSelectedSeatPrice(this.settings.row+1)*discount);//计算票价总金额

                    return 'selected';
                } else if (this.status() == 'selected') { //若为选中状态

                    $tickects_num.text(sc.find('selected').length - 1);//更新票数量
                    $total_price.text(getTotalPrice() - getSelectedSeatPrice(this.settings.row+1)*discount);//更新票价总金额
                    $('#cart-item-' + this.settings.id).remove();//删除已预订座位

                    return 'available';
                } else if (this.status() == 'unavailable') { //若为已售出状态
                    return 'unavailable';
                } else {
                    return this.style();
                }
            }
        });
        //设置已售出的座位
        // sc.get(['1_3', '1_4', '4_4', '4_5', '4_6', '4_7', '4_8']).status('unavailable');
    });

    function getSelectedSeatPrice(row) { //计算票价总额
        var price1=${show.price1};
        var price2=${show.price2};
        var price3=${show.price3};
        var divide1=${divide1};
        var divide2=${divide2};
        if(row<divide1){
            return price1;
        }else if(row<divide2){
            return price2;
        }else{
            return price3;
        }
    }

    function getTotalPrice() {
        var total = 0;
        sc.find('selected').each(function() {
            total += getSelectedSeatPrice(this.settings.row+1)*discount;
        });
        return total;
    }

    $(document).ready(function () {
        $("#showTime_ul li").eq(<%=request.getParameter("dateIndex")%>+1).addClass("active");

        updateBook_time();
    });

    function updateBook_time() {
        $("#book_time").text($("#showTime_ul li.active a").text());
    }

    //提交线下订票订单
    function submitOfflineOrder() {
        if($("#seats_chose li").length==0){
            alert("请先选择座位");
            return false;
        }
        //获取价格
        var price=parseInt($total_price.text());
        //获取座位
        var seats=new Array();
        for(var i=0;i<$("#seats_chose li").length;i++){
            seats.push($("#seats_chose li").eq(i).data("seatId"));
        }
        $.ajax({
            type: 'post', url: '/theater/j${theaterid}/show/j${show.showid}/offlineOrder',
            data: {"seats":JSON.stringify(seats),"price":price,"showtimeid":${showtimeid}},
            cache: false, dataType: 'json',
            success: function (success) {
                if(success){
                    alert("线下购票成功");
                    window.location.href='/theater/j${theaterid}/show/j${show.showid}/offlineOrder?dateIndex=0';
                }else {
                    alert("线下购票失败");
                }
            }
        });
    }

    function checkDiscount() {
        var memberid=$("#memberid").val();
        $.ajax({
            type: 'get', url: '/theater/getMemberDiscount',
            data: {"memberid":memberid},
            cache: false, dataType: 'json',
            success: function (success) {
                if (success==1) {
                    discount=1;
                    $total_price.text(getTotalPrice());
                    $("#show_discount").hide();
                    return false;
                }
                discount=parseFloat(success);
                $total_price.text(getTotalPrice());
                $("#discount").text(parseFloat(success)*10);
                $("#show_discount").show();
            }
        });
    }

</script>

</body>
</html>