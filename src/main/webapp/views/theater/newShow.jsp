<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/resources/css/font-awesome.min.css">
<link  href="/resources/css/navstyle.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/ImgCropping.css" rel="stylesheet" type="text/css"/>
<link href="/resources/css/fileUpload.css" rel="stylesheet" type="text/css"/>
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/bootstrap-datetimepicker.min.js"></script>
<script src="/resources/js/fileUpload.js"></script>
<head>
    <title>New Show</title>
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
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>发布演出</span></div>

        <div class="row">
            <form id="publishShow_form" action="#" enctype="multipart/form-data" style="font-size: 15px;margin-top: 15px;width: 750px;">

                <div style="display:none;position: fixed;top:70px;z-index: 3;width:61%" class="alert alert-danger" id="wrong_alert">错误！请进行一些更改。</div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label>名&emsp;&emsp;称</label>
                        <input name="title" type="text" class="form-control" oninput="onInput()">
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label>类&emsp;&emsp;型</label>

                        <div style="width: 100%">
                        <select name="type" id="type" class="col-md-12" style="height: 40px;line-height: 50px;border-radius: 6%" onchange="onInput()">
                            <option value ="Movie">电影</option>
                            <option value ="MusicDrama">音乐剧</option>
                            <option value ="Drama">话剧</option>
                            <option value ="Dance">舞蹈</option>
                            <option value ="Sports">体育比赛</option>
                            <option value ="Concert">演唱会</option>
                        </select>

                        </div>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label>海&emsp;&emsp;报</label>

                        <input name="image" type="file" id="image" style="display:none"/>
                        <div class="input-append">
                            <input id="photoCover" class="input-large form-control" style="display:inline-block;width: 86%" type="text" disabled>
                            <a class="btn btn-default" onclick="$('input[id=image]').click();">上传文件</a>
                        </div>
                        <script type="text/javascript">
                            $('input[id=image]').change(function() {
                                $('#photoCover').val($(this).val());
                                $(".alert-danger").slideUp();
                            });
                        </script>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label>演员/导演</label>
                        <input name="actor" type="text" class="form-control" oninput="onInput()">
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label>简&emsp;&emsp;介</label>
                        <textarea name="description" class="form-control" oninput="onInput()"></textarea>
                    </div>
                </div>
                <div class="row form-group">
                    <label style="margin-left: 2%">价&emsp;&emsp;格</label>
                    <div class="col-md-12">

                        <div class="input-group col-md-12">
                            <span class="input-group-addon">前排</span>
                            <input name="price1" type="number" class="form-control" min="0" oninput="onInput()">
                            <span class="input-group-addon">元</span>
                        </div>

                        <div class="input-group col-md-12">
                            <span class="input-group-addon">中间</span>
                            <input name="price2" type="number" class="form-control" min="0" oninput="onInput()">
                            <span class="input-group-addon">元</span>
                        </div>

                        <div class="input-group col-md-12">
                            <span class="input-group-addon">靠后</span>
                            <input name="price3" type="number" class="form-control" min="0" oninput="onInput()">
                            <span class="input-group-addon">元</span>
                        </div>
                    </div>
                </div>
                <div class="row form-group">
                    <div id="showtime_container" class="col-md-12">
                        <label>演出时间</label><span>（演出2周前开放购票）</span>
                        <a id="showtime_add" href="javascript:;" class="btn btn-link">
                            <i class="icon-plus icon-large"></i> 增加</a>

                        <div class="showtime_div row">

                            <div class="col-md-8" style="padding-right: 0px">
                                <div class="input-append date form_datetime">
                                    <input name="showtime" size="16" type="text" value="" readonly style="display: inline-block;text-align:center;height: 40px;width: 100%">
                                    <span style="float: right;position: relative;top:-30px;padding-right: 10px" class="add-on"><i class="icon-th"></i></span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <a class="showtime_remove btn btn-link" href="javascript:;">
                                    <i class="icon-remove icon-large"></i> 删除
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <input type="submit" class="btn btn-primary" value="确认发布" style="margin-left: 250px;width:250px">
                        <%--<span style="color: grey"> （必须经Tickets经理审核通过方能生效）</span>--%>
                    </div>
                </div>
            </form>


        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">您确定要发布该演出吗？</h4>
            </div>
            <div class="modal-body" style="color:red">注意：发布之后将不可删除和修改。</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="coupon_sure">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<!--时间选择器-->
<script type="text/javascript">
    var theaterid=$("#theaterid_hide").val();

    $(".form_datetime").datetimepicker({
        format: "yyyy-MM-dd hh:mm"
    });


    $(".form_datetime").click(function () {
        $(this).children('span').click();
    });
</script>

<!--图片裁剪框 start-->
<%--<div style="display: none;" class="tailoring-container">--%>
    <%--<div class="black-cloth" onClick="closeTailor(this)"></div>--%>
    <%--<div class="tailoring-content" style="height: 400px">--%>
        <%--<div class="close-tailoring"  onclick="closeTailor(this)">×</div>--%>
        <%--<div id="fileUploadContent" class="fileUploadContent"></div>--%>
        <%--<br/>--%>
        <%--<button class="l-btn sureCut" id="sureCut">确定</button>--%>
    <%--</div>--%>
<%--</div>--%>
<!--图片裁剪框 end-->

<!--上传图片的script-->
<!--
<script type="text/javascript">

    //弹出框水平垂直居中
    (window.onresize = function () {
        var win_height = $(window).height();
        var win_width = $(window).width();
        $(".tailoring-content").css({
            "top": "150px",
            "left": (win_width - $(".tailoring-content").outerWidth())/2
        });
//        if (win_width <= 768){
//            $(".tailoring-content").css({
//                "top": (win_height - $(".tailoring-content").outerHeight())/2,
//                "left": 0
//            });
//        }else{
//            $(".tailoring-content").css({
//                "top": (win_height - $(".tailoring-content").outerHeight())/2,
//                "left": (win_width - $(".tailoring-content").outerWidth())/2
//            });
//        }
    })();

    //弹出图片裁剪框
    $("#replaceImg").on("click",function () {
        $(".tailoring-container").toggle();
    });

    //裁剪后的处理
    $("#sureCut").on("click",function () {
//        if ($("#tailoringImg").attr("src") == null ){
//            return false;
//        }else{
//            var cas = $('#tailoringImg').cropper('getCroppedCanvas');//获取被裁剪后的canvas
//            var base64url = cas.toDataURL('image/png'); //转换为base64地址形式
//            $("#finalImg").prop("src",base64url);//显示为图片的形式
//
////            handleSave(base64url);
//
//            //关闭裁剪框
//            closeTailor();
//        }
        closeTailor();
    });
    //关闭裁剪框
    function closeTailor() {
        $(".tailoring-container").toggle();
    }

</script>
<script type="text/javascript">
    $("#fileUploadContent").initUpload({
        "uploadUrl":"#",//上传文件信息地址
        "progressUrl":"#",//获取进度信息地址，可选，注意需要返回的data格式如下（{bytesRead: 102516060, contentLength: 102516060, items: 1, percent: 100, startTime: 1489223136317, useTime: 2767}）
        //"showSummerProgress":false,//总进度条，默认限制
        //"size":350,//文件大小限制，单位kb,默认不限制
        //"maxFileNumber":3,//文件个数限制，为整数
        //"filelSavePath":"",//文件上传地址，后台设置的根目录
        //"beforeUpload":beforeUploadFun,//在上传前执行的函数
        //"onUpload":onUploadFun，//在上传后执行的函数
        autoCommit:true,//文件是否自动上传
        //"fileType":['png','jpg','docx','doc']，//文件类型限制，默认不限制，注意写的是文件后缀
    });
    function beforeUploadFun(opt){
        opt.otherData =[{"name":"你要上传的参数","value":"你要上传的值"}];
    }
    function onUploadFun(opt,data){
        alert(data);
        uploadTools.uploadError(opt);//显示上传错误
    }
</script>-->
<script src="/resources/js/theater/newShow.js"></script>
</body>
</html>
