<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="bottom_line" style="width: 800px;margin: 30px auto 20px;height: 1px;background:#ccc;">
    <span style="color:grey;margin-left:40%;width:20%;text-align:center;position:relative; top:-11px;background:#fff;font-size: 15px">这是底线. >_<</span>
</div>
<script>
    $(document).ready(function () {
        if(document.getElementById("bottom_line").offsetTop<screen.height){
            $("#bottom_line").hide();
        }
    });
</script>