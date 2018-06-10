var theaterid=$("#theaterid_hide").val();

$('#submit_modify').click(function () {
    if (!checkFullInput("#modifyTheater", ".alert-danger")) {
        $("#myModal").modal('hide');
        return false;
    }else {
        var divide1=$("#modifyTheater input[name='divide1']").val();
        var divide2=$("#modifyTheater input[name='divide2']").val();
        var finalRow = $("#modifyTheater textarea").val().split('\n').length;
        if(divide1>divide2||divide2>finalRow){
            $("#wrong_alert").html("座位类型分布不符合规则").slideDown();
            return false;
        }else {
            $('#myModal').modal('show');
            return false;
        }
    }
});

$("#modify_sure").click(function () {
    $.ajax({
        type: 'get', url: '/theater/j'+theaterid+"/profile/modify",
        data: $("#modifyTheater").serialize(),
        cache: false, dataType: 'json',
        success: function (success) {
            $("#myModal").modal('hide');
            if(success){
                alert("修改申请成功，等待Tickets经理审核");
                window.location.href='/theater/j'+theaterid+'/profile';
            }else {
                alert("修改申请失败");
            }
        }
    });
});

function checkFullInput(form, alert) {
    for(var i=0;i<$(form+" input").length;i++) {
        if ($(form+" input").eq(i).val() == "") {
            $(alert).html("请完善表单信息").slideDown();
            return false;
        }
    }
    return true;
}

function onInput() {
    $(".alert-danger").slideUp();
}


//上传图片相关

//弹出框水平垂直居中
(window.onresize = function () {
    var win_height = $(window).height();
    var win_width = $(window).width();
    if (win_width <= 768){
        $(".tailoring-content").css({
            "top": (win_height - $(".tailoring-content").outerHeight())/2,
            "left": 0
        });
    }else{
        $(".tailoring-content").css({
            "top": "150px",
            "left": (win_width - $(".tailoring-content").outerWidth())/2
        });
    }
})();

//弹出图片裁剪框
$("#replaceImg").on("click",function () {
    $(".tailoring-container").toggle();
});

//图像上传
function selectImg(file) {
    if (!file.files || !file.files[0]){
        return;
    }
    var reader = new FileReader();
    reader.onload = function (evt) {
        var replaceSrc = evt.target.result;
        //更换cropper的图片
        $('#tailoringImg').cropper('replace', replaceSrc,false);//默认false，适应高度，不失真
    }
    reader.readAsDataURL(file.files[0]);
}
//cropper图片裁剪
$('#tailoringImg').cropper({
    aspectRatio: 1/1,//默认比例
    preview: '.previewImg',//预览视图
    guides: false,  //裁剪框的虚线(九宫格)
    autoCropArea: 0.5,  //0-1之间的数值，定义自动剪裁区域的大小，默认0.8
    movable: false, //是否允许移动图片
    dragCrop: true,  //是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
    movable: true,  //是否允许移动剪裁框
    resizable: true,  //是否允许改变裁剪框的大小
    zoomable: true,  //是否允许缩放图片大小
    mouseWheelZoom: true,  //是否允许通过鼠标滚轮来缩放图片
    touchDragZoom: true,  //是否允许通过触摸移动来缩放图片
    rotatable: true,  //是否允许旋转图片
    crop: function(e) {
        // 输出结果数据裁剪图像。
    }
});
//旋转
$(".cropper-rotate-btn").on("click",function () {
    $('#tailoringImg').cropper("rotate", 45);
});
//复位
$(".cropper-reset-btn").on("click",function () {
    $('#tailoringImg').cropper("reset");
});
//换向
var flagX = true;
$(".cropper-scaleX-btn").on("click",function () {
    if(flagX){
        $('#tailoringImg').cropper("scaleX", -1);
        flagX = false;
    }else{
        $('#tailoringImg').cropper("scaleX", 1);
        flagX = true;
    }
    flagX != flagX;
});

//裁剪后的处理
$("#sureCut").on("click",function () {
    if ($("#tailoringImg").attr("src") == null ){
        return false;
    }else{
        var cas = $('#tailoringImg').cropper('getCroppedCanvas');//获取被裁剪后的canvas
        var base64url = cas.toDataURL('image/png'); //转换为base64地址形式
        $("#finalImg").prop("src",base64url);//显示为图片的形式

        //关闭裁剪框
        closeTailor();

         uploadCanvas(cas);

    }
});
//关闭裁剪框
function closeTailor() {
    $(".tailoring-container").toggle();
}


function uploadCanvas(canvas) {
    var dataurl = canvas.toDataURL('image/png')//base64图片数据;
    var arr = dataurl.split(','), mime=arr[0].match(/:(.*?);/)[1],
        bstr=atob(arr[1]), n=bstr.length, u8arr = new Uint8Array(n);
    while (n--){
        u8arr[n] = bstr.charCodeAt(n);
    }
    var obj = new Blob([u8arr], {type:mime});
    var fd = new FormData();
    fd.append("file", obj, "image.png");
    $.ajax({
        url: "/theater/j"+theaterid+"/profile/uploadImage",
        type: "POST",
        data: fd,
        contentType: false,//必须false才会自动加上正确的Content-Type
        processData: false,//必须false才会避开jQuery对 formdata 的默认处理.XMLHttpRequest会对 formdata 进行正确的处理.
        success: function (data) {
            if (data) {
                alert("更换图片成功！");
                window.location.href="/theater/j"+theaterid+"/profile";
            }
            else {
                alert("更换图片失败");
            }
        }
    });
}

