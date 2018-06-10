//添加演出时间
$("#showtime_add").click(function () {
    var showtime_html=$('.showtime_div').prop('outerHTML');
    $('#showtime_container').append(showtime_html);
    var obj=$('.form_datetime').eq($('.showtime_div').length-1);
    obj.datetimepicker({
        format: "yyyy-MM-dd hh:mm"
    });
});
//删除某演出时间
$("#showtime_container").on("click",".showtime_remove",function () {
    if($('.showtime_div').length>1){this.parentElement.parentElement.remove();}
});

function checkFullInput(form, alert) {
    if($(form+ " input[name=title]").val()==""){
        $(alert).html("请填写演出名称").slideDown();
        return false;
    }
    if($("#image").val()==""){
        $(alert).html("请上传演出海报").slideDown();
        return false;
    }
    if($(form+ " input[name=actor]").val()==""){
        $(alert).html("请填写演员/导演").slideDown();
        return false;
    }
    if($(form+ " textarea[name=description]").val()==""){
        $(alert).html("请填写简介").slideDown();
        return false;
    }
    if ($(form + " input[name|=price1]").val() == ""||$(form + " input[name|=price2]").val() == ""||$(form + " input[name|=price3]").val() == "") {
        $(alert).html("请填写三种座位类型的价格").slideDown();
        return false;
    }
    for(var i=0;i<$(form+" input[name=showtime]").length;i++) {
        if ($(form + " input[name=showtime]").eq(i).val() == "") {
            $(alert).html("请填写演出时间").slideDown();
            return false;
        }
    }
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

$(document).ready(function () {
    $('#publishShow_form').submit(function () {
        if(!checkFullInput('#publishShow_form', '#wrong_alert')){
            return false;
        }else {
            $("#myModal").modal('show');
            return false;
        }
    });
});

$("#coupon_sure").click(function () {
    var formData = new FormData(document.getElementById("publishShow_form"));
    $.ajax({
        type: 'post', url: '/theater/j' + theaterid + '/newShow',
        data: formData,
        cache: false, dataType: 'json',
        contentType: false,//必须false才会自动加上正确的Content-Type
        processData: false,//必须false才会避开jQuery对 formdata 的默认处理.XMLHttpRequest会对 formdata 进行正确的处理.
        success: function (success) {
            if (success) {
                alert("发布演出成功");
                window.location.href = '/theater/j' + theaterid + '/showList?showState=All';
            } else {
                alert("发布演出失败");
            }
        }
    });
    $("#myModal").modal('hide');
});


