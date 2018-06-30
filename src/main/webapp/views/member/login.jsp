<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <meta charset="utf-8" />
    <!-- Animate.css -->
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link  href="/resources/css/loginstyle.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="/resources/js/jquery.min.js"></script>
    <!--表单处理-->
    <script type="text/javascript" src="/resources/js/jquery.form.js"></script>
    <!-- Bootstrap -->
    <script src="/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript">

            // $('#login_form').submit(function() {
            //     // 提交表单
            //     $(this).ajaxSubmit(function(data) {
            //         alert('Thanks for your comment!');
            //     });
            //     // 为了防止普通浏览器进行表单提交和产生页面导航（防止页面刷新？）返回false
            //     return false;
            // });
            // $('#login_form').ajaxForm(function(data) {
            //     if(data.success=="false") {
            //         $("#wrong_alert").html(data.message).show();
            //     }else{
            //         window.location.href=data.nextPage;
            //     }
            // });
    </script>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<div id="gtco-header" class="gtco-cover" role="banner"
     style="background-image: url(/resources/images/background.jpg);margin: 0 auto">
    <div class="overlay"></div>
    <div class="gtco-container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0 text-left">
                <div class="row row-mt-15em">
                    <div class="col-md-7 mt-text animate-box" data-animate-effect="fadeInUp">
                        <h1 style="font-family: georgia;">Welcome to <span style="color: cornflowerblue">Tickets</span></h1>
                        <p></p>
                        <span class="intro-text-small">This website allows buying tickets to see shows.</span>
                    </div>
                    <div class="col-md-4 col-md-push-1 animate-box" data-animate-effect="fadeInRight">
                        <div class="form-wrap">
                            <div class="tab">
                                <ul class="tab-menu">
                                    <li class="gtco-first active"><a href="#" data-tab="login">登录</a></li>
                                    <li class="gtco-second"><a href="#" data-tab="signup">注册</a></li>
                                </ul>
                                <div class="tab-content">

                                    <div class="tab-content-inner active" data-content="login">
                                        <form id="login_form" method="post">
                                            <div style="display: none" class="alert alert-danger" id="wrong_alert">错误！请进行一些更改。</div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <label>账号</label>
                                                    <input type="text" class="form-control" name="memberid" oninput="onInput()" placeholder="请输入邮箱">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <label>密码</label>
                                                    <input type="password" class="form-control" name="password" oninput="onInput()" placeholder="请输入密码">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <p style="padding-bottom: 0;margin-bottom: 0px"><label>用户类型</label></p>
                                                    <select onchange="onInput()" name="usertype" style="width: 100%;height: 40px;line-height: 50px;border-radius: 6%">
                                                        <option value ="member">会员</option>
                                                        <option value ="theater">场馆</option>
                                                        <option value ="manager">Tickets经理</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <input type="submit" class="btn btn-primary" value="Login">
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="tab-content-inner" data-content="signup">
                                        <form id="signup_form" method="post" style="margin-bottom: 0;padding-bottom: 0">
                                            <div style="display: none" class="alert alert-danger" id="signup_alert">错误！请进行一些更改。</div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <label>邮箱</label>
                                                    <input name="memberid" type="email" t="email" class="form-control" oninput="onInput()" placeholder="请输入邮箱">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <label>昵称</label>
                                                    <input name="name" type="text" class="form-control" oninput="onInput()" placeholder="请输入昵称">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <label>密码</label>
                                                    <input name="password" type="password" class="form-control" oninput="onInput()" placeholder="请输入密码">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <label>重输密码</label>
                                                    <input name="againPwd" type="password" class="form-control" oninput="onInput()" placeholder="再次输入密码">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-12">
                                                    <input type="submit" class="btn btn-primary" value="注册会员"><span>(去邮箱验证后再登录)</span>
                                                    <a href="/theater/signup" style="outline: none;padding-left: 0;margin-left: 0;padding-bottom: 0;margin-bottom: 0" class="btn btn-link">>>注册场馆通道>></a>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var formTab = function() {

        $('.tab-menu a').on('click', function(event){
            var $this = $(this),
                data = $this.data('tab');

            $('.tab-menu li').removeClass('active');
            $this.closest('li').addClass('active');

            $('.tab .tab-content-inner').removeClass('active');
            $this.closest('.tab').find('.tab-content-inner[data-content="'+data+'"]').addClass('active');

            event.preventDefault();
        });
    };
    $(function(){
        formTab();
    });
</script>
<script type="text/javascript" src="/resources/js/member/login.js"></script>

</body>
</html>
