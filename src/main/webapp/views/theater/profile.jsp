<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/font-awesome.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/cropper.min.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/ImgCropping.css" rel="stylesheet" type="text/css" />
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/cropper.min.js" type="text/javascript"></script>
<head>
    <title>Login</title>
</head>
<body>
<input id="theaterid_hide" type="hidden" value="${sessionScope.theater.theaterid}"/>

<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>
<div style="display: block;height: 50px"></div>
<div class="container row" style="width: 1200px;margin: 50px auto;">
    <jsp:include page="/views/theater/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>

    <div class="col-md-offset-3  col-md-9">
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>场馆信息</span></div>

        <form action="#" class="col-md-8" id="modifyTheater" style="font-size: 15px;margin-top: 15px">
            <div class="row form-group">
                <div class="col-md-12">
                    <label style="margin-right: 8%">总&nbsp;收&nbsp;&nbsp;入</label>
                    <span style="color: #C9302C;font-size:22px;margin-right: 5%">l000</span>
                    <a href="/theater/j${sessionScope.theater.theaterid}/showList" style="outline: none" class="btn btn-link">>>查看收入详情>></a>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label style="margin-right: 8%">场&nbsp;馆&nbsp;&nbsp;号</label>
                    <span style="color: #C9302C;font-family: georgia;font-size:22px;margin-right: 5%">${sessionScope.theater.theaterid}</span>
                    <span>（用于登录）</span>
                </div>
            </div>
            <div style="display: none;position: fixed;top:0;z-index: 1000;width: 550px" class="alert alert-danger" id="wrong_alert">错误！请进行一些更改。</div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <%--<i style="font-size: 25px" class="fa fa-envelope" aria-hidden="true"></i>--%>
                        邮&emsp;&emsp;箱</label>
                    <input name="email" type="email" class="form-control" disabled value="${sessionScope.theater.email}">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>场馆名称</label>
                    <input name="name" type="text" class="form-control" oninput="onInput()" value="${sessionScope.theater.name}">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <%--<i style="font-size: 25px" class="fa fa-map-marker" aria-hidden="true"></i>--%>
                        地&emsp;&emsp;址</label>
                    <input name="location" type="text" class="form-control" oninput="onInput()" value="${sessionScope.theater.location}">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <%--<i style="font-size: 25px" class="fa fa-phone" aria-hidden="true"></i>--%>
                        电&emsp;&emsp;话
                    </label>
                    <input name="phonenum" type="number" class="form-control" oninput="onInput()" value="${sessionScope.theater.phonenum}">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <%--<i style="font-size: 25px" class="fa fa-user" aria-hidden="true"></i>--%>
                        收款账号
                    </label>
                    <input name="alipayid" type="text" class="form-control" oninput="onInput()" value="${sessionScope.theater.alipayid}">
                    <span>( 演出结束后，经理会把结算的金额转账到该账号 )</span>
                </div>
            </div>
            <div class="row form-group" style="font-family: Monospaced">
                <%--<label style="margin-left:3%;margin-right: 3%;font-weight: 600">--%>
                    <label>座位情况</label>
                <div class="col-md-12">
                    <textarea style="width:66%;float: left" name="seat" class="form-control" rows="10" cols="10" oninput="onInput()">${sessionScope.theater.seat}</textarea>
                    <div style="width: 27%;float: right;color: grey">
                        （提示：用数字<span style="color: #C9302C">1</span>表示座位，用数字<span style="color: #C9302C">0</span>表示过道或者无座位。例：
                        <span style="white-space: pre">
1111111111
1111111111
0000000000
1111111100
1111111111
1111111111
1100110011</span>）
                    </div>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>座位类型分布</label>
                    <div style="vertical-align: middle">
                        <span class="col-md-2">前排：</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="number" class="form-control" value="1" disabled="true">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                        <span class="col-md-2">——</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="number" class="divide1 form-control" value="${sessionScope.theater.rowdivide1}" oninput="onInput();$('.divide1').eq(1).val($(this).val())">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                    </div>
                    <div style="vertical-align: middle">
                        <span class="col-md-2">中间：</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input name="divide1" type="number" class="divide1 form-control" value="${sessionScope.theater.rowdivide1}" oninput="onInput();$('.divide1').eq(0).val($(this).val())">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                        <span class="col-md-2">——</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="number" class=" divide2 form-control" value="${sessionScope.theater.rowdivide2}" oninput="onInput();$('.divide2').eq(1).val($(this).val())">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                    </div>
                    <div style="vertical-align: middle">
                        <span class="col-md-2">靠后：</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input name="divide2" type="number" class="divide2 form-control" value="${sessionScope.theater.rowdivide2}" oninput="onInput();$('.divide2').eq(0).val($(this).val())">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                        <span class="col-md-2">——</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" class="form-control" value="最后一" disabled style="text-align: center">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <input id="submit_modify" type="submit" class="btn btn-primary" value="申请修改">
                    <span style="color: grey"> （必须经Tickets经理审核通过方能生效）</span>
                </div>
            </div>
        </form>

        <form class="col-md-4">
            <div class="row form-group">
                <div class="col-md-12">
                    <label for="finalImg" style="margin-left: 35px">图片</label><br/>
                    <img id="finalImg" src="${sessionScope.theater.image}" class="col-md-offset-1 col-md-10" style="border-radius: 0%"/>
                </div>
            </div>
            <br/>
            <div class="row form-group">
                <div>
                    <a id="replaceImg" class="l-btn btn btn-primary" href="javascript:;" style="position:relative;left:20%;width: 60%">更换图片</a>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">确认修改?</h4>
            </div>
            <%--<div class="modal-body">你确定兑换该优惠券？</div>--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="modify_sure">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<!--图片上传框 start-->
<div style="display: none" class="tailoring-container">
    <div class="black-cloth" onClick="closeTailor(this)"></div>
    <div class="tailoring-content">
        <div class="tailoring-content-one">
            <label title="上传图片" for="chooseImg" class="l-btn choose-btn">
                <input type="file" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg" class="hidden" onChange="selectImg(this)">
                选择图片
            </label>
            <div class="close-tailoring"  onclick="closeTailor(this)">×</div>
        </div>
        <div class="tailoring-content-two">
            <div class="tailoring-box-parcel">
                <img id="tailoringImg">
            </div>
            <div class="preview-box-parcel">
                <p>图片预览：</p>
                <div class="square previewImg"></div>
                <div class="circular previewImg"></div>
            </div>
        </div>
        <div class="tailoring-content-three">
            <button class="l-btn cropper-reset-btn">复位</button>
            <button class="l-btn cropper-rotate-btn">旋转</button>
            <button class="l-btn cropper-scaleX-btn">换向</button>
            <button class="l-btn sureCut" id="sureCut">确定</button>
        </div>
    </div>
    <div></div>
</div>
<!--图片上传框 end-->
<script src="/resources/js/theater/profile.js"></script>
</body>
</html>
