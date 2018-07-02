<%@ page import="com.tickets.model.Member" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8"/>
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/jquery.step.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/chooseSeat.css" rel="stylesheet" type="text/css"/>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.step.min.js"></script>
<script src="/resources/js/jquery.seat-charts.min.js"></script>
<head>
    <title>buy tickets</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<div style="display: block;margin:100px auto"></div>

<div id="div-notBottom" style="min-height: 1080px">
    <div id="step" style="	width: 1000px;	margin: 20px auto;margin-bottom: 30px;"></div>

    <div style="width: 1000px;margin: 0 auto 40px;">
        <label>购票方式：&nbsp;&nbsp;</label>
        <div class="btn-group" data-toggle="buttons">
            <label class="btn btn-primary active">
                选座购买
            </label>
            <label class="btn btn-primary">
                不选座购买
            </label>
        </div>
    </div>

    <div id="choose_seat" class="demo clearfix" style="height: 750px">
        <!---左边座位列表----->
        <div id="seat_area" style="max-height: 650px;overflow:auto">
            <div class="front">屏幕</div>
            <div id="legend"></div>
        </div>
        <!---右边选座信息----->
        <div class="booking_area" >
            <%--更改买票界面右边提示样式--%>
            <div id="div-showTips">
                <div id="show-left">
                    <img src="${show.image}" width="150px" style="margin-bottom: 10px"/>
                </div>
                <div id="show-right">
                    <br>
                    <p>电影：<span>${show.title}</span></p>
                    <p>时间：<span>${dateTime}</span></p>
                    <p>票价：
                    <div style="font-size: 15px"><span>1 - ${divide1-1}排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price1}</span></span><br/><span>${divide1} - ${divide2-1}排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price2}</span></span>
                        <br/><span>${divide2} - *排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price3}</span></span></div>
                    </p>
                </div>
            </div>

            <p>座&emsp;&emsp;&emsp;&emsp;位：</p>
            <ul id="seats_chose"></ul>
            <p>票&emsp;&emsp;&emsp;&emsp;数：(限6张) &nbsp;<span id="tickects_num">0</span></p>
            <p>会员等级优惠: <span style="font-size: 25px;color: #C9302C;">${discount*10}</span> 折</p>
            <p style="margin-bottom: 0;padding-bottom:0"><label>优&emsp;&nbsp;惠&nbsp;&nbsp;&emsp;券:</label></p>
            <div>
                <select id="coupon_select" onchange="calculateSeatOrderPrice(getSeats())"
                        style="width: 100%;height: 40px;line-height: 50px;border-radius: 6%">
                    <%Member member = (Member) request.getSession().getAttribute("member");%>
                    <option value="0">未使用</option>
                    <option value="1" <%if((member.getCoupon1()==0)){%>disabled<%}%> >优惠券1:满10减1</option>
                    <option value="2" <%if((member.getCoupon2()==0)){%>disabled<%}%> >优惠券2:满30减5</option>
                    <option value="3" <%if((member.getCoupon3()==0)){%>disabled<%}%> >优惠券3:满50减10</option>
                </select>
            </div>
            <p><a target="_blank" href="/member/j${sessionScope.member.memberid}/coupon" class="btn btn-link"
                  style="outline: none;margin-top: 10px;padding-top:0">>>获取优惠券>></a></p>
                <p>总&emsp;&emsp;&emsp;&emsp;价：<b><span class="span-moneyTag" style="font-size: 25px;color: orange;">¥</span><span style="font-size: 25px;color: #C9302C;" id="total_price">0</span></b>
                </p>
            <input type="button" class="btn btn-primary" onclick="submitSeatOrder(getSeats())" value="确定购买"
                   style="margin-top: 10px;margin-left: 250px"/>
        </div>
    </div>

    <div id="not_choose" style="display: none;width: 1200px;margin: 0 auto;">
        <form action="#" class="col-md-offset-2 col-md-8">

            <div id="div-showTipsNot">
                <div id="show-leftNot">
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2"></label>
                            <div class="col-md-10">
                                <img src="${show.image}" width="150px"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="show-rightNot" style="font-size: 16px;">
                    <br>
                    <p>电影&emsp;<span style="font-size: 20px;color: #459bdc;">${show.title}</span></p>
                    <p>时间&emsp;<span>${dateTime}</span></p>
                    <p>票价&emsp;<span>1 - ${divide1-1}排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price1}</span></span><br/>
                        &emsp;&emsp;&emsp;<span>${divide1} - ${divide2-1}排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price2}</span></span><br/>
                        &emsp;&emsp;&emsp;<span>${divide2} - *排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price3}</span></span>
                    </p>
                    <%--
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2">电影</label>
                            <label class="col-md-10"><span style="font-size: 20px;color: #459bdc;">${show.title}</span></label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2">时间</label>
                            <label class="col-md-10">${dateTime}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2">票价</label>
                            <label class="col-md-10">
                                <div style="font-size: 15px">
                                    <span>1 - ${divide1-1}排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price1}</span></span><br/><span>${divide1} - ${divide2-1}排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price2}</span></span>
                                    <br/><span>${divide2} - -排：<span class="span-moneyTag">¥</span><span class="span-money">${show.price3}</span></span></div>
                            </label>
                        </div>
                    </div>
                    --%>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label class="col-md-2"  style="margin-top: 1rem">票&emsp;&emsp;&emsp;&emsp;数</label>
                    <div class="col-md-6">
                        <input id="noSeat_ticketNum" oninput="if($(this).val()==''){return;};calculateNoSeatOrderPrice()"
                               type="number" class="form-control" value="1" min="1" max="20">
                    </div>
                    <label class="col-md-4" style="margin-top: 1rem">（限20张）</label>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label class="col-md-2" style="margin-top: 1rem">会员等级优惠</label>
                    <div class="col-md-2">
                        <span style="font-size: 25px;color: #C9302C;">${discount*10}</span>
                    </div>
                    <label class="col-md-2" style="margin-top: 1rem">折</label>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label class="col-md-2" style="margin-top: 1rem">优&emsp;&nbsp;惠&emsp;&nbsp;&nbsp;券</label>
                    <div class="col-md-6">
                        <select id="noSeat_coupon" onchange="calculateNoSeatOrderPrice()"
                                style="width: 100%;height: 40px;line-height: 50px;border-radius: 6%">
                            <option value="0">未使用</option>
                            <option value="1" <%if((member.getCoupon1()==0)){%>disabled<%}%> >优惠券1:满10减1</option>
                            <option value="2" <%if((member.getCoupon2()==0)){%>disabled<%}%> >优惠券2:满30减5</option>
                            <option value="3" <%if((member.getCoupon3()==0)){%>disabled<%}%> >优惠券3:满50减10</option>
                        </select>
                    </div>
                    <button target="_blank" href="/member/j${sessionScope.member.memberid}/coupon"
                            class="col-md-2 btn btn-link" style="outline: none">>>获取优惠券>>
                    </button>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label class="col-md-2" style="margin-top: 1rem">总&emsp;&emsp;&emsp;&emsp;价</label>
                    <label class="col-md-10"><span style="font-size: 25px;color: #C9302C;"><span class="span-moneyTag">¥</span><span
                            id="noSeat_price">0</span></span><span style="color: grey">（每张票是所有价位的最低价）</span></label>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <a href="javascript:;" onclick="submitNoSeatOrder()" class="btn btn-primary" style="margin-left: 400px">确定购买</a>
                </div>
            </div>
        </form>
    </div>
    <div class="col-md-12" style="z-index: -1">
        <div id="info" style="width: 900px;margin: 0 190px 100px auto;">
            <p>特别提示：</p>
            <p>1、下单前请仔细核对演出、场馆、场次等信息。</p>
            <p>2、下单后请于15分钟内完成支付，超时系统将不保留座位。</p>
            <p>3、选座购买每笔订单最多可以选择6个座位，立即购买每单最多选20个座位。</p>
            <p>4、选座购买有前排、中间、靠后这三种不同价位的座位，立即购买的每张票按选座购买的最低价收费。</p>
        </div>

    </div>
</div>

<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<script type="text/javascript">
    $(".btn-group .btn-primary").click(function () {
        var index = $(this).index(".btn-group .btn-primary");
        $(".btn-group .btn-primary").removeClass("active");
        $(this).addClass("active");
        if (index == 0) {
            $('#choose_seat').show();
            $('#not_choose').hide();
        } else if (index == 1) {
            $('#choose_seat').hide();
            $('#not_choose').show();
        }
    });
</script>
<script type="text/javascript">
    var $step = $("#step");
    var $index = $("#index");

    $step.step({
        index: 1,
        time: 500,
        title: ["选择演出场次", "选择座位", "15分钟内付款", "场馆取票观看"]
    });
</script>
<script type="text/javascript">
    var sc;
    var $cart = $('#seats_chose'), //座位区
        $tickects_num = $('#tickects_num'), //票数
        $total_price = $('#total_price'); //票价总额

    $(document).ready(function () {

        sc = $('#seat_area').seatCharts({
            map:${seat},
            // map: [//座位结构图 a 代表座位; 下划线 "_" 代表过道
            //     'cccccccccc',
            //     'cccccccccc',
            //     '__________',
            //     'cccccccc__',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cc__cc__cc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            // ],
            seats: {
                a: {
                    price: 100,
                    classes: 'available', //your custom CSS class
                    category: '可选座'
                },
                b: {
                    price: 40,
                    classes: 'unavailable', //your custom CSS class
                    category: '已售出'
                }
            },
            naming: {//设置行列等信息
                top: false, //不显示顶部横坐标（行）
                getLabel: function (character, row, column) { //返回座位信息
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
            click: function () {
                if (this.status() == 'available') { //若为可选座状态，添加座位
                    //限制最多选6张
                    if ($("div.seatCharts-seat.selected").length == 7) {
                        return this.style();
                    }

                    $('<li>' + (this.settings.row + 1) + '排' + this.settings.label + '座</li>')
                        .attr('id', 'cart-item-' + this.settings.id)
                        .data('seatId', this.settings.id)
                        .appendTo($cart);

                    $tickects_num.text(sc.find('selected').length + 1); //统计选票数量

                    calculateSeatOrderPrice(getSeats());//计算票价总金额

                    return 'selected';
                } else if (this.status() == 'selected') { //若为选中状态

                    $('#cart-item-' + this.settings.id).remove();//删除已预订座位
                    $tickects_num.text(sc.find('selected').length - 1);//更新票数量
                    calculateSeatOrderPrice(getSeats());//更新票价总金额

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

    function getSeats() {
        //获取座位
        var seats = new Array();
        for (var i = 0; i < $("#seats_chose li").length; i++) {
            seats.push($("#seats_chose li").eq(i).data("seatId"));
        }
        return seats;
    }

    function calculateSeatOrderPrice(seats) {
        var couponType = $("#coupon_select").val();
        $.ajax({
            type: 'get', url: '/member/j${sessionScope.member.memberid}/buyTickets/j${showtimeid}/calculateSeatPrice',
            data: {"seats": JSON.stringify(seats), "couponType": couponType},
            cache: false, dataType: 'json',
            success: function (price) {
                $total_price.text(price);
            }
        });
    }

    calculateNoSeatOrderPrice();

    function calculateNoSeatOrderPrice() {
        var couponType = $("#coupon_select").val();
        $.ajax({
            type: 'get', url: '/member/j${sessionScope.member.memberid}/buyTickets/j${showtimeid}/calculateNoSeatPrice',
            data: {"number": $("#noSeat_ticketNum").val(), "couponType": couponType},
            cache: false, dataType: 'json',
            success: function (price) {
                $("#noSeat_price").text(price);
            }
        });
    }

    function submitSeatOrder(seats) {
        if ($("#seats_chose li").length == 0) {
            alert("请先选择座位");
            return false;
        }
        $.ajax({
            type: 'post', url: '/member/j${sessionScope.member.memberid}/buyTickets/j${showtimeid}/submitSeatOrder',
            data: {"seats": JSON.stringify(seats), "couponType": $("#coupon_select").val()},
            cache: false, dataType: 'json',
            success: function (orderid) {
                if (orderid == 'null') {
                    alert("剩余票数不足，购票失败");
                } else {
                    window.location.href = '/member/j${sessionScope.member.memberid}/order/j' + orderid + '/waitPay';
                }
            }
        });
    }

    function submitNoSeatOrder() {
        if ($("#noSeat_ticketNum").val() == "") {
            alert("请先选择票数");
            return false;
        }
        if (parseInt($("#noSeat_ticketNum").val()) > 20) {
            alert("不选座购买最多选20张");
            return false;
        }
        $.ajax({
            type: 'post', url: '/member/j${sessionScope.member.memberid}/buyTickets/j${showtimeid}/submitNoSeatOrder',
            data: {"number": $("#noSeat_ticketNum").val(), "couponType": $("#coupon_select").val()},
            cache: false, dataType: 'json',
            success: function (orderid) {
                if (orderid == 'null') {
                    alert("剩余票数不足，购票失败");
                } else {
                    window.location.href = '/member/j${sessionScope.member.memberid}/order/j' + orderid + '/waitPay';
                }
            }
        });
    }

</script>
</body>
</html>
