function checkFullInput(form, alert) {
    for(var i=0;i<$(form+" input").length;i++) {
        if ($(form+" input").eq(i).val() == ""||$(form+" textarea").val()=="") {
            $(alert).html("请先完善表单信息").slideDown();
            return false;
        }
    }
    return true;
}

function onInput() {
    $(".alert-danger").slideUp();
}


function checkSignup(form) {
    var isfull=checkFullInput(form, '#wrong_alert');
    if(!isfull) {
        return false;
    }else if($("#signupTheater input[name='password']").val()!=$("#signupTheater input[name='againPwd']").val()){
        $("#wrong_alert").html("密码不一致").slideDown();
        return false;
    }else {
        var divide1=$("#signupTheater input[name='divide1']").val();
        var divide2=$("#signupTheater input[name='divide2']").val();
        var finalRow = $("#signupTheater textarea").val().split('\n').length;
        if(divide1>divide2||divide2>finalRow){
            $("#wrong_alert").html("座位类型分布不符合规则").slideDown();
            return false;
        }else {
            return true;
        }
    }
}

$(document).ready(function () {
    $('#signupTheater').submit(function () {
        if(!checkSignup('#signupTheater')){
            return false;
        }else {
            $.ajax({
                type: 'post', url: '/theater/signup',
                data: $("#signupTheater").serialize(),
                cache: false, dataType: 'json',
                success: function (data) {
                    if (data != null) {
                        alert("您登录的账号是：" + data + "，务必记住以用于登录,请先去邮箱验证，待Tickets经理审核后会有邮件通知，届时即可登录");
                        window.location.href = "/login";
                    } else {
                        alert("注册失败，该邮箱已经注册过");
                    }
                }
            });
            return false;
        }
    });
});