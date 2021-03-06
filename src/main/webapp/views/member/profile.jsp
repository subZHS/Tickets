<%@ page import="com.tickets.model.Member" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>profile</title>
    <meta charset="utf-8" />
    <!-- Animate.css -->
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link  href="/resources/css/cropper.min.css" rel="stylesheet" type="text/css" />
    <link  href="/resources/css/ImgCropping.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="/resources/js/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="/resources/js/bootstrap.min.js"></script>
    <script src="/resources/js/cropper.min.js" type="text/javascript"></script>

    <link href="/resources/css/public.css"rel="stylesheet" type="text/css" />

</head>
<body>
<input id="memberid_hide" type="hidden" value="${sessionScope.member.memberid}"/>

<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<div class="container row">

    <jsp:include page="/views/member/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>


    <div class="col-md-offset-3 col-md-9">

        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>基本信息</span></div>

        <div id="user-left" style="width: 460px;float: left;margin-left: -55px">
            <form class="col-md-4" style="margin-top: 22px;width: 460px;">
                <div class="row form-group">
                    <div class="col-md-12">
                        <label for="finalImg" style="margin-left: 50px">头像</label><br/><br/>
                        <img id="finalImg" src="${sessionScope.member.image}" style="border-radius: 0%" class="col-md-offset-1 col-md-10"/>
                    </div>
                </div>
                <br/>
                <div class="row form-group">
                    <div>
                        <a id="replaceImg" class="l-btn btn btn-primary" href="javascript:;" style="position:relative;left:20%;width: 60%">更换头像</a>
                    </div>
                </div>
            </form>
        </div>
        <div id="user-right" style="width: 425px;float: right">
            <form id="modify_form" action="#" class="col-md-8" style="font-size: 15px;margin-top: 15px;width: 425px;float: right;margin-right: 20px">
                <div class="alert alert-danger" style="display: none">错误！请进行一些更改。</div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label for="level" style="margin-right: 8%">会员等级</label>
                        <span id="level" style="font-size: 22px;color: #C9302C;margin-right: 5%">lv ${level}</span>
                        <span style="color: grey">&emsp;（可享受 <span style="color: #C9302C">${discount}</span> 折优惠）</span>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label style="margin-right: 8%">积&emsp;&emsp;分</label>
                        <span style="color: #C9302C;font-size:20px;margin-right: 5%">${sessionScope.member.points}</span>
                        <a style="outline: none" class="btn btn-link" onclick="window.location.href='/member/j${sessionScope.member.memberid}/coupon'">>>可兑换优惠劵>></a>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label>邮&emsp;&emsp;箱</label>
                        <input type="email" class="form-control" value="${sessionScope.member.memberid}" disabled="disabled">
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label>昵&emsp;&emsp;称</label>
                        <input name="name" type="text" class="form-control" value="${sessionScope.member.name}" oninput="onInput()">
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-12">
                        <label for="sex" style="margin-right: 3%">性&emsp;&emsp;别</label><br>
                        <%--拉长性别选择框长度--%>
                        <select id="sex" style="width: 100%;height: 40px;border-radius: 6%">
                            <%
                                Member member=(Member)session.getAttribute("member");
                            %>
                            <option value ="0">男</option>
                            <option value ="1" <%if(member.getSex()==1){%>selected<%}%>>女</option>
                        </select>
                    </div>
                </div>

                <div class="row form-group">
                    <div class="col-md-12">
                        <label>年&emsp;&emsp;龄</label>
                        <input name="age" type="number" class="form-control" value="${sessionScope.member.age}" oninput="onInput()">
                    </div>
                </div>

                <div class="row form-group">
                    <div class="col-md-12">
                        <%--添加css样式--%>
                        <input id="submit_modify" type="submit" class="btn btn-primary" value="修改" style="float: right;margin: 30px 0 auto  auto;min-width: 100px">
                    </div>
                </div>
            </form>

        </div>



    </div>
</div>

<%--<input type="file" id="file" />--%>
<%--<input type="button" value="上传" onclick="upload()">--%>

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

<!--图片裁剪框 start-->
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
</div>
<!--图片裁剪框 end-->

<%--底线--%>
<jsp:include page="/views/bottomLine.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<script>
function upload() {
    var formData = new FormData();
    formData.append("file", document.getElementById("file").files[0]);
    $.ajax({
        url: "/member/j${sessionScope.member.memberid}/profile/uploadImage",
        type: "POST",
        data: formData,
        contentType: false,//必须false才会自动加上正确的Content-Type
        processData: false,//必须false才会避开jQuery对 formdata 的默认处理.XMLHttpRequest会对 formdata 进行正确的处理.
        success: function (data) {
            if (data) {
                alert("上传成功！");
            }
            else {
                alert("失败");
            }
        }
    });
}
</script>

<script type="text/javascript" src="/resources/js/member/profile.js"></script>

</body>
</html>
