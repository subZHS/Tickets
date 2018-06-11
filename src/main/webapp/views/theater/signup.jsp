<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/font-awesome.css" rel="stylesheet" type="text/css" />

<link  href="/resources/css/public.css" rel="stylesheet" type="text/css" />
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

<div class="container row" style="width: 1200px;">

    <div class="col-md-offset-2 col-md-8">
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>注册场馆</span></div>

        <form action="#" id="signupTheater" style="font-size: 15px;margin-top: 15px">
            <div style="display: none;position: fixed;top:0;z-index: 1000;width: 750px" class="alert alert-danger" id="wrong_alert">错误！请进行一些更改。</div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <i style="font-size: 25px" class="fa fa-envelope" aria-hidden="true"></i> 邮箱</label>
                    <input name="email" type="email" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>场馆名称</label>
                    <input name="name" type="text" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label >密码</label>
                    <input name="password" type="password" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>再输一次</label>
                    <input name="againPwd" type="password" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <i style="font-size: 25px" class="fa fa-map-marker" aria-hidden="true"></i> 地址</label>
                    <input name="location" type="text" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <i style="font-size: 25px" class="fa fa-phone" aria-hidden="true"></i> 电话
                    </label>
                    <input name="phonenum" type="number" class="form-control" oninput="onInput()">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <label>
                        <i style="font-size: 25px" class="fa fa-user" aria-hidden="true"></i> 收款账号
                    </label>
                    <input name="alipayid" type="text" class="form-control" oninput="onInput()">
                    <span>( 演出结束后，经理会把结算的金额转账到该账号 )</span>
                </div>
            </div>
            <div class="row form-group" style="font-family: Monospaced">
                <label style="margin-left:3%;margin-right: 3%;font-weight: 600">座位情况</label>
                <div class="col-md-12">
                    <textarea style="width:66%;float: left" name="seat" class="form-control" rows="10" cols="10" oninput="onInput()"></textarea>
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
                                <input type="number" class="divide1 form-control" oninput="onInput();$('.divide1').eq(1).val($(this).val())">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                    </div>
                    <div style="vertical-align: middle">
                        <span class="col-md-2">中间：</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input name="divide1" type="number" class="divide1 form-control" oninput="onInput();$('.divide1').eq(0).val($(this).val())">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                        <span class="col-md-2">——</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="number" class=" divide2 form-control" oninput="onInput();$('.divide2').eq(1).val($(this).val())">
                                <span class="input-group-addon">排</span>
                            </div>
                        </div>
                    </div>
                    <div style="vertical-align: middle">
                        <span class="col-md-2">靠后：</span>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input name="divide2" type="number" class="divide2 form-control" oninput="onInput();$('.divide2').eq(0).val($(this).val())">
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
                    <input type="submit" class="btn btn-primary" value="注册场馆">
                    <span style="color: grey"> （必须经邮箱验证和Tickets经理审核通过方能生效）</span>
                </div>
            </div>
        </form>

    </div>
</div>
<script src="/resources/js/theater/signup.js"></script>
</body>
</html>
