<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/chooseSeat.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/font-awesome.css" rel="stylesheet" type="text/css"/>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.seat-charts.min.js"></script>
<style>
    .front{width: 300px;margin: 0px 32px 30px 50px;background-color: #f0f0f0;	color: #666;text-align: center;border-radius: 5px;}
    div.seatCharts-cell {color: #182C4E;height: 25px;width: 25px;line-height: 25px;margin: 5px;float: left;text-align: center;outline: none;font-size: 12px;}
    div.seatCharts-row {height: 37px;}
    div.seatCharts-container {border-right: 1px dotted #adadad;width: 410px;padding: 10px;float: left;}
    #seat_area2 div.seatCharts-container{float: right}
</style>
<head>
    <title>Login</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<div style="display: block;height: 50px"></div>
<div class="container row" style="width: 1200px;margin: 50px auto;">
    <jsp:include page="/views/manager/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>

    <div class="col-md-offset-3  col-md-9">
        <ol class="breadcrumb">
            <li><a href="/ticketsManager/j${managerid}/checkList?checkType=modifyTheater" style="outline: none;padding: 0;font-size: 15px" class="btn btn-link">修改审核</a></li>
            <li class="active">场馆号</li>
        </ol>

        <div style="width: 100%;border-top: none;margin:20px 0 20px 0">
            <div class="row">
                <form action="#">
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2" style="color: lightslategrey"></label>
                            <label class="col-md-5" style="color: #459bdc;font-size: 20px">修改前</label>
                            <label class="col-md-5" style="color: #459bdc;font-size: 20px">修改后</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2" style="color: lightslategrey">名称</label>
                            <label class="col-md-5">${theater.name}</label>
                            <label class="col-md-5">${theaterModify.name}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2" style="color: lightslategrey">
                                <%--<i style="font-size: 25px" class="fa fa-envelope" aria-hidden="true"></i> --%>
                                邮箱</label>
                            <label class="col-md-5">${theater.email}</label>
                            <label class="col-md-5">${theaterModify.email}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2" style="color: lightslategrey">
                                <%--<i style="font-size: 25px" class="fa fa-map-marker" aria-hidden="true"></i>&nbsp; --%>
                                地址</label>
                            <label class="col-md-5">${theater.location}</label>
                            <label class="col-md-5">${theaterModify.location}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2" style="color: lightslategrey">
                                <%--<i style="font-size: 25px" class="fa fa-phone" aria-hidden="true"></i> --%>
                                电话</label>
                            <label class="col-md-5">${theater.phonenum}</label>
                            <label class="col-md-5">${theaterModify.phonenum}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <label class="col-md-2" style="color: lightslategrey">收款账号</label>
                            <label class="col-md-5">${theater.alipayid}</label>
                            <label class="col-md-5">${theaterModify.alipayid}</label>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-2" style="color: lightslategrey">&nbsp;&nbsp; 座位类型分布</label>
                        <div class="col-md-5">
                            <ul>
                                <li><label>前排：1 ~ ${theater.rowdivide1}</label></li>
                                <li><label>中间：${theater.rowdivide1} ~ ${theater.rowdivide2}</label></li>
                                <li><label>靠后：${theater.rowdivide2} ~ -</label></li>
                            </ul>
                        </div>
                        <div class="col-md-5">
                            <ul>
                                <li><label>前排：1 ~ ${theaterModify.rowdivide1}</label></li>
                                <li><label>中间：${theaterModify.rowdivide1} ~ ${theaterModify.rowdivide2}</label></li>
                                <li><label>靠后：${theaterModify.rowdivide2} ~ -</label></li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <br/>
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>座位详情</span></div>
        <div class="row form-group">
            <div class="col-md-12">
                <label class="col-md-2" style="color: lightslategrey"></label>
                <label class="col-md-5" style="position:relative;left:5%;color: #459bdc;font-size: 20px">修改前</label>
                <label class="col-md-5" style="position:relative;left:13%;color: #459bdc;font-size: 20px">修改后</label>
            </div>
        </div>
        <div style="height: 700px">
            <div class="col-md-6">
                <div id="seat_form1" class="demo clearfix" style="margin-top: 10px;margin-left: 0px;padding-left: 0px">
                    <!---左边座位列表----->
                    <div id="seat_area1" contenteditable="false" style="height:500px;overflow: auto">
                        <div class="front">屏幕</div>
                    </div>
                    <%--<div id="legend"></div>--%>
                </div>
            </div>
            <div class="col-md-6">
                <div id="seat_form2" class="demo clearfix" style="margin-top: 10px;margin-left: 0px;padding-left: 0px">
                    <!---左边座位列表----->
                    <div id="seat_area2" contenteditable="false" style="height:500px;overflow: auto">
                        <div class="front">屏幕</div>
                    </div>
                    <%--<div id="legend"></div>--%>
                </div>
            </div>
        </div>

        <div class="col-md-offset-7 col-md-3" style="position: relative;top: -100px">
            <p><a id="rejectModify" class="btn btn-danger" style="float: left">拒绝</a>
                <a id="passModify" class="btn btn-primary" style="float: right">通过</a>
            </p>
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
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a type="button" class="btn btn-primary" onclick="passOrReject_submit()">确定</a>
            </div>
            <input id="passOrReject" type="hidden" value=""/>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<script type="text/javascript">
    var price = 100; //电影票价
    $(document).ready(function() {
        var $cart = $('#seats_chose'); //座位区
        var sc1 = $('#seat_area1').seatCharts({
            map:${theaterSeat},
            // map: [//座位结构图 a 代表座位; 下划线 "_" 代表过道
            //     'cccccccccc',
            //     'cccccccccc',
            //     '__________',
            //     'cccccccc__',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cc__cc__cc'
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
        var sc2 = $('#seat_area2').seatCharts({
            map:${theaterModifySeat},
            // map: [//座位结构图 a 代表座位; 下划线 "_" 代表过道
            //     'cccccccccc',
            //     'cccccccccc',
            //     '__________',
            //     'cccccccc__',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cccccccccc',
            //     'cc__cc__cc'
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
//        sc.get(['1_3', '1_4', '4_4', '4_5', '4_6', '4_7', '4_8']).status('unavailable');

        $("div.seatCharts-cell").unbind();
    });

    $("#passModify").click(function () {
        $("#myModalLabel").text("您确定要审核通过吗？");
        $("#passOrReject").val("pass");
        $("#myModal").modal("show");
    });

    $("#rejectModify").click(function () {
        $("#myModalLabel").text("您确定要审核拒绝吗？");
        $("#passOrReject").val("reject");
        $("#myModal").modal("show");
    });

    function passOrReject_submit() {
        if($("#passOrReject").val()=="pass"){
            $.ajax({
                type: 'post', url: '/ticketsManager/j${managerid}/passModify',
                data: {"theaterid":'${theater.theaterid}'},
                cache: false, dataType: 'json',
                success: function (success) {
                    if(success){
                        alert("审核通过修改场馆信息成功");
                        window.location.href="/ticketsManager/j${managerid}/checkList?checkType=modifyTheater";
                    }else{
                        alert("审核通过修改场馆信息失败");
                    }
                    $("#myModal").modal("hide");
                }
            });
        }else if($("#passOrReject").val()=="reject"){
            $.ajax({
                type: 'post', url: '/ticketsManager/j${managerid}/rejectModify',
                data: {"theaterid":'${theater.theaterid}'},
                cache: false, dataType: 'json',
                success: function (success) {
                    if(success){
                        alert("审核拒绝修改场馆信息成功");
                        window.location.href="/ticketsManager/j${managerid}/checkList?checkType=modifyTheater";
                    }else{
                        alert("审核拒绝修改场馆信息失败");
                    }
                    $("#myModal").modal("hide");
                },
                error:function(){
                    alert('error');
                }
            });
        }
    }
</script>
</body>
</html>
