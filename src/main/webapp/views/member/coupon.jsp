<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8"/>
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="/resources/css/font-awesome.min.css">
<link href="/resources/css/table.css" media="screen" rel="stylesheet" type="text/css"/>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>

<link href="/resources/css/public.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/coupon.css" rel="stylesheet" type="text/css"/>

<head>
    <title>Login</title>
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

        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>积分优惠劵</span></div>

        <div class="table_list" style="border-top:none;margin-top: 20px">
            <div class="agile_featured_movies">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                            <div class="agile-news-table">
                                <div class="w3ls-news-result" style="margin-top: 35px">
                                    <h4>剩余积分:
                                        <span style="color: #C9302C;font-size: 22px"> ${sessionScope.member.points} </span>
                                        <%--消费金额*10的颜色，使其更明显--%>
                                        <span style="color: grey">（每消费一次，您的积分会增加<span
                                                style="color: #C9302C;">消费金额*10</span>)</span></h4>
                                </div>



                            <%--
                                <table id="table-breakpoint">
                                    <thead>
                                    <tr>
                                        <th>类型</th>
                                        <th>使用条件</th>
                                        <th>优惠</th>
                                        <th>所需积分</th>
                                        <th>拥有数量</th>
                                        <th>兑换数量</th>
                                        <th>兑换</th>
                                    </tr>
                                    </thead>
                                    <tbody style="line-height: 50px">
                                    <tr>
                                        <td>优惠券1</td>
                                        <td>满 10 元</td>
                                        <td>减 1 元</td>
                                        <td>150 积分</td>
                                        <td> ${sessionScope.member.coupon1} </td>
                                        <td><input type="number" value="1" min="1" class="form-control"
                                                   style="max-width: 100px"></td>
                                        <td class="w3-list-info">
                                            <button class="btn btn-primary">
                                                <i class="icon-plus icon-large"></i> 兑换
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>优惠券2</td>
                                        <td>满 30 元</td>
                                        <td>减 5 元</td>
                                        <td>550 积分</td>
                                        <td> ${sessionScope.member.coupon2} </td>
                                        <td><input type="number" value="1" min="1" class="form-control"
                                                   style="max-width: 100px"></td>
                                        <td class="w3-list-info">
                                            <button class="btn btn-primary">
                                                <i class="icon-plus icon-large"></i> 兑换
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>优惠券3</td>
                                        <td>满 50 元</td>
                                        <td>减 10 元</td>
                                        <td>1050 积分</td>
                                        <td> ${sessionScope.member.coupon3} </td>
                                        <td><input type="number" value="1" min="1" class="form-control"
                                                   style="max-width: 100px"></td>
                                        <td class="w3-list-info">
                                            <button class="btn btn-primary">
                                                <i class="icon-plus icon-large"></i> 兑换
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                --%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="div-couponCard">

            <%--coupon卡片样式--%>
            <!--可用-->
            <div class="coupon">
                <div class="coupon-left">
                    <div class="coupon-inner">
                        <div class="coupon-money">
                            <span>¥</span>
                            <span class="sum">1.00</span>
                            <span class="ownNum">${sessionScope.member.coupon1}</span>
                            <span class="ownLabel">已拥有：</span>
                        </div>
                        <div class="coupon-condition">
                            <p>满10.00可用</p>
                        </div>
                    </div>
                </div>
                <div class="coupon-right">
                    <div class="coupon-inner">
                        <div class="coupon-time">
                            150积分<br>
                        </div>
                        <div class="w3-list-info">
                            <button class="btn btn-default get-coupon">兑换</button>

                        </div>
                        <i class="coupon-circle up"></i>
                        <i class="coupon-circle bottom"></i>
                    </div>
                </div>
                <%--<div class="coupon-light"></div>--%>
            </div>

            <div class="coupon">
                <div class="coupon-left">
                    <div class="coupon-inner">
                        <div class="coupon-money">
                            <span>¥</span>
                            <span class="sum">5.00</span>
                            <span class="ownNum">${sessionScope.member.coupon2}</span>
                            <span class="ownLabel">已拥有：</span>
                        </div>
                        <div class="coupon-condition">
                            <p>满30.00可用</p>
                        </div>
                    </div>
                </div>
                <div class="coupon-right">
                    <div class="coupon-inner">
                        <div class="coupon-time">
                            550积分<br>
                        </div>
                        <div class="w3-list-info">
                            <button class="btn btn-default get-coupon">兑换</button>

                        </div>
                        <i class="coupon-circle up"></i>
                        <i class="coupon-circle bottom"></i>
                    </div>
                </div>
                <%--<div class="coupon-light"></div>--%>
            </div>


            <div class="coupon">
                <div class="coupon-left">
                    <div class="coupon-inner">
                        <div class="coupon-money">
                            <span>¥</span>
                            <span class="sum">10.00</span>
                            <span class="ownNum">${sessionScope.member.coupon3}</span>
                            <span class="ownLabel">已拥有：</span>
                        </div>
                        <div class="coupon-condition">
                            <p>满50.00可用</p>
                        </div>
                    </div>
                </div>
                <div class="coupon-right">
                    <div class="coupon-inner">
                        <div class="coupon-time">
                            1050积分<br>
                        </div>
                        <div class="w3-list-info">
                            <button class="btn btn-default get-coupon">兑换</button>
                        </div>
                        <i class="coupon-circle up"></i>
                        <i class="coupon-circle bottom"></i>
                    </div>
                </div>
                <%--<div class="coupon-light"></div>--%>
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
                <h4 class="modal-title" id="myModalLabel">确认兑换?</h4>
            </div>
            <%--<div class="modal-body">你确定兑换该优惠券？</div>--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="coupon_sure">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<script>
    var index;
    var number;
    $(".w3-list-info button").click(function () {
        index = $(this).index(".w3-list-info button");
        // number = $("table input[type='number']").eq(index).val();
        number = 1;
        $("#myModal").modal('show');
    });

    $("#coupon_sure").click(function () {
        $.ajax({
            type: 'get', url: '/member/j${sessionScope.member.memberid}/coupon/exchange',
            data: {"couponType": index + 1, "number": number},
            cache: false, dataType: 'json',
            success: function (success) {
                if (success) {
                    //添加兑换成功的提示
                    alert("兑换成功！");
                    window.location.href = "/member/j${sessionScope.member.memberid}/coupon";
                } else {
                    alert("您的积分不足，兑换失败");
                }
            }
        });
        $("#myModal").modal('hide');
    });

</script>

</body>
</html>
