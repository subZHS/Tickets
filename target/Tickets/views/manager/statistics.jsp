<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tickets.model.Member" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" />
<!-- Animate.css -->
<link rel="stylesheet" href="/resources/css/animate.css">
<link  href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link  href="/resources/css/tagstyle.css" rel="stylesheet" type="text/css" />
<!-- jQuery -->
<script src="/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/echarts.min.js"></script>
<head>
    <title>statistics</title>
</head>
<body>
<jsp:include page="/views/header.jsp" flush="true">
    <jsp:param name="index" value="0"/>
</jsp:include>

<div class="container row" style="width: 1200px;margin: 50px auto;">
    <jsp:include page="/views/manager/leftmenu.jsp" flush="true">
        <jsp:param name="index" value="0"/>
    </jsp:include>

    <div class="col-md-9" style="margin-left: 5%">
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>场馆统计</span></div>
        <br/>
        <!--场馆收入-->
        <div id="theaterIncome" style="width: 600px;height:400px;"></div>\
        <br/>
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>演出统计</span></div>
        <br/>
        <!--演出类型-->
        <div id="showType" style="width: 600px;height:400px"></div>
        <!--演出收入-->
        <div id="showIncome" style="width: 600px;height:400px"></div>
        <br/>
        <div class="bottom_text" style="width: 100%;margin-top: 10px"><span>会员统计</span></div>
        <br/>
        <!--会员等级占比-->
        <div id="memberLevel" style="width: 600px;height:400px"></div>
        <!--会员前十消费金额-->
        <div id="memberConsume" style="width: 600px;height:400px"></div>

    </div>
</div>
<!--场馆收入-->
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('theaterIncome'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '各场馆收入统计(单位：元)'
        },
        tooltip: {},
        legend: {
            data:['销售额']
        },
        <%List<Map.Entry<String, Double>> theaterIncomeMapList=new ArrayList<Map.Entry<String, Double>>(((Map<String,Double>)request.getAttribute("theaterIncomeMap")).entrySet());%>

        xAxis: {
            data: [
                <%for(int i=0;i<theaterIncomeMapList.size();i++){
                    Map.Entry<String, Double> entry=theaterIncomeMapList.get(i);%>
                '<%=entry.getKey()%>'
                <%if(i!=theaterIncomeMapList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        },
        yAxis: {},
        series: [{
            name: '销售额',
            type: 'bar',
            data: [
                <%for(int i=0;i<theaterIncomeMapList.size();i++){
                    Map.Entry<String, Double> entry=theaterIncomeMapList.get(i);%>
                <%=entry.getValue()%>
                <%if(i!=theaterIncomeMapList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>

<!--演出类型-->
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('showType'));

    // 指定图表的配置项和数据
    var option = {
        title : {
            text: '各演出类型占比',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        <%List<Map.Entry<String, Integer>> showTypeNumMapList=new ArrayList<Map.Entry<String, Integer>>(((Map<String,Integer>)request.getAttribute("showTypeNumMap")).entrySet());%>
        legend: {
            orient: 'vertical',
            left: 'left',
            data: [
                <%for(int i=0;i<showTypeNumMapList.size();i++){
                    Map.Entry<String, Integer> entry=showTypeNumMapList.get(i);%>
                '<%=entry.getKey()%>'
                <%if(i!=showTypeNumMapList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        },
        series: [{
            name: '演出类型',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data: [
                <%for(int i=0;i<showTypeNumMapList.size();i++){
                    Map.Entry<String, Integer> entry=showTypeNumMapList.get(i);%>
                {value:<%=entry.getValue()%>,name:'<%=entry.getKey()%>'}
                <%if(i!=showTypeNumMapList.size()-1){%>
                ,<%}%>
                <%}%>
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>

<!--演出收入-->
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('showIncome'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '各演出总销售额前十(单位：元)'
        },
        tooltip: {},
        legend: {
            data:['销售额']
        },
        <%List<Map.Entry<String, Double>> showIncomeMapList=(List<Map.Entry<String, Double>>)request.getAttribute("showIncomeMapList");%>

        xAxis: {
            data: [
                <%for(int i=0;i<showIncomeMapList.size();i++){
                    Map.Entry<String, Double> entry=showIncomeMapList.get(i);%>
                '<%=entry.getKey()%>'
                <%if(i!=showIncomeMapList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        },
        yAxis: {},
        series: [{
            name: '销售额',
            type: 'bar',
            data: [
                <%for(int i=0;i<showIncomeMapList.size();i++){
                    Map.Entry<String, Double> entry=showIncomeMapList.get(i);%>
                <%=entry.getValue()%>
                <%if(i!=showIncomeMapList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>

<!--会员占比-->
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('memberLevel'));

    // 指定图表的配置项和数据
    var option = {
        title : {
            text: '各会员等级占比',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        <%List<Integer> memberLevelNumList=(List<Integer>)request.getAttribute("memberLevelNumList");%>
        legend: {
            orient: 'vertical',
            left: 'left',
            data: [
                <%for(int i=0;i<memberLevelNumList.size();i++){%>
                'Lv<%=i%>'
                <%if(i!=memberLevelNumList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        },
        series: [{
            name: '会员等级',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data: [
                <%for(int i=0;i<memberLevelNumList.size();i++){%>
                {value:<%=memberLevelNumList.get(i)%>,name:'Lv<%=i%>'}
                <%if(i!=memberLevelNumList.size()-1){%>
                ,<%}%>
                <%}%>
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>

<!--会员前十消费金额-->
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('memberConsume'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '会员消费金额前十(单位：元)'
        },
        tooltip: {},
        legend: {
            data:['消费金额']
        },
        <%List<Member> top10MemberList=(List<Member>)request.getAttribute("top10MemberList");%>

        xAxis: {
            data: [
                <%for(int i=0;i<top10MemberList.size();i++){
                    Member member=top10MemberList.get(i);%>
                '<%=member.getName()%>'
                <%if(i!=top10MemberList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        },
        yAxis: {},
        series: [{
            name: '消费金额',
            type: 'bar',
            data: [
                <%for(int i=0;i<top10MemberList.size();i++){
                    Member member=top10MemberList.get(i);%>
                <%=member.getConsumption()%>
                <%if(i!=top10MemberList.size()-1){%>
                ,<%}%>
                <%}%>
            ]
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>
</html>
