
function checkFullInput(form, alert) {
    for(var i=0;i<$(form+" input").length;i++) {
        if ($(form+" input").eq(i).val() == "") {
            $(alert).html("请完善表单信息").show();
            return false;
        }
    }
    return true;
}

function onInput() {
    $(".alert-danger").hide();
}

function checkLogin(form) {
    var isfull=checkFullInput(form, '#wrong_alert');
    if(!isfull) {
        return false;
    }else {
        return true;
    }
}

function checkSignup(form) {
    var isfull=checkFullInput(form, '#signup_alert');
    if(!isfull) {
        return false;
    }else if($("#signup_form input[name='password']").val()!=$("#signup_form input[name='againPwd']").val()){
        $("#signup_alert").html("密码不一致").show();
        return false;
    }else {
        return true;
    }
}

$(document).ready(function() {
    $('#login_form').submit(function () {
        if(!checkLogin('#login_form')){
            return false;
        }
        $.ajax({
            type: 'post', url: '/login',
            data: $("#login_form").serialize(),
            cache: false, dataType: 'json',
            success: function (data) {
                if (data.success == "false") {
                    var showStr;
                    if (data.message == "MemberNotExist") {
                        showStr = "该用户不存在";
                    } else if (data.message == "WrongPassword") {
                        showStr = "密码错误";
                    } else if (data.message == "EmailNotVerify") {
                        showStr = "请先去邮箱验证";
                    }else if( data.message == "NotPassCheck"){
                        showStr = "尚未通过审核，请耐心等待";
                    }
                    $("#wrong_alert").html(showStr).show();
                } else {
                    window.location.href = data.nextPage;
                }
            }
        });
        return false;
    });

    $('#signup_form').submit(function () {
        if(!checkSignup('#signup_form')){
            return false;
        }
        $.ajax({
            type: 'post', url: '/signup',
            data: $("#signup_form").serialize(),
            cache: false, dataType: 'json',
            success: function (data) {
                if(data.success){
                    alert("注册成功，请去邮箱验证再登录");
                    window.location.href="/login";
                }else{
                    alert("该邮箱已经注册过");
                }
            }
        });
        return false;
    });
});