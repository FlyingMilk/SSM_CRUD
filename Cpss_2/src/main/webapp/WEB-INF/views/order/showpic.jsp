<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 引入jquery -->
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 引入JS项目插件 -->
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
	<script
	src="${APP_PATH}/static/js/echarts.js"></script>
	
<link rel="stylesheet" href="${APP_PATH}/static/css/rightcss.css"
	type="text/css">
	
</head>
<body ondragstart="return false">

<div id="main1" style="width: 600px;height:400px;"></div>
	
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main1'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '产品销量'
            },
            tooltip: {},
            legend: {
                data:['销量']
            },
            xAxis: {
            	name:"产品名称",//坐标轴名称。
                nameLocation:'end',//坐标轴名称显示位置。
                axisLabel : {//坐标轴刻度标签的相关设置。
                    interval:0,
                    rotate:"45"
                },
            	data: (function(){
                    var names=[];
                    $.ajax({
                    	url:"${APP_PATH}/selectnumbyname",
                    	async :false,
                		type:"GET",
                		data : {},
                        dataType : "json", //返回数据形式为json
                		success:function(result){
                                for(var i=0;i<result.extend.names.length;i++){
                                console.log(result.extend.names[i]);
                               names.push(result.extend.names[i]);
                             
                             }    
                        },
                            error : function(errorMsg) {
                                alert("图表请求数据失败!");
                                 myChart.hideLoading();
                               }
                       })
                         return names;
                      })() 
            },
            yAxis: {
             	name: '销量/个',
            },
            series: [{
                name: '销量',
                type: 'bar',
                data: (function(){
                    var sum = [];
                    $.ajax({
                    	url:"${APP_PATH}/selectnumbyname",
                    	async :false,
                		type:"GET",
                		data : {},
                        dataType : "json", //返回数据形式为json
                		success:function(result){
                                for(var i=0;i<result.extend.sum.length;i++){
                                console.log(result.extend.sum[i]);
                                sum.push(result.extend.sum[i]);
                             
                             }    
                           
                                                
                        },
                            error : function(errorMsg) {
                                alert("图表请求数据失败!");
                                 myChart.hideLoading();
                               }
                       })
                         return sum;
                      })() 
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
   <div id="main2" style="width: 600px;height:400px;"></div>
	
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main2'));

        option = {
        	    title : {
        	        text: '产品销售图',
        	        x:'center'
        	    },
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
        	    },
        	    legend: {
        	        orient: 'vertical',
        	        left: 'left',
        	        data:  []
        	    },
        	    series : [
        	        {
        	            name: '访问来源',
        	            type: 'pie',
        	            radius : '55%',
        	            center: ['50%', '60%'],
        	            data:(function(){
                            var names=[];
                            $.ajax({
                            	url:"${APP_PATH}/selectnumbyname",
                            	async :false,
                        		type:"GET",
                        		data : {},
                                dataType : "json", //返回数据形式为json
                        		success:function(result){
                                        for(var i=0;i<result.extend.names.length;i++){
                                        	 //alert(result.extend.names[i]+" "+result.extend.sum[i])
                                        	 names.push({
                                        	name :result.extend.names[i],
                                        	value :result.extend.sum[i] 
                                        	 });
                                     
                                     }    
                                },
                                    error : function(errorMsg) {
                                        alert("图表请求数据失败!");
                                         myChart.hideLoading();
                                       }
                               })
                                 return names;
                              })() ,
        	            
        	            itemStyle: {
        	                emphasis: {
        	                    shadowBlur: 10,
        	                    shadowOffsetX: 0,
        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
        	                }
        	            }
        	        }
        	    ]
        	};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script> 
    <div id="main3" style="width: 600px;height:400px;"></div>
	
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main3'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '产品收入'
            },
            tooltip: {},
            legend: {
                data:['收入']
            },
            xAxis: {
            	name:"产品名称",//坐标轴名称。
                nameLocation:'end',//坐标轴名称显示位置。
                axisLabel : {//坐标轴刻度标签的相关设置。
                    interval:0,
                    rotate:"45"
                },
            	data: (function(){
                    var names=[];
                    $.ajax({
                    	url:"${APP_PATH}/selectnumbyname",
                    	async :false,
                		type:"GET",
                		data : {},
                        dataType : "json", //返回数据形式为json
                		success:function(result){
                                for(var i=0;i<result.extend.names.length;i++){
                                console.log(result.extend.names[i]);
                               names.push(result.extend.names[i]);
                             
                             }    
                        },
                            error : function(errorMsg) {
                                alert("图表请求数据失败!");
                                 myChart.hideLoading();
                               }
                       })
                         return names;
                      })() 
            },
            yAxis: {
            	name: '收入/元',
            },
            series: [{
                name: '收入',
                type: 'bar',
                data: (function(){
                    var sum = [];
                    $.ajax({
                    	url:"${APP_PATH}/selectnumbyname",
                    	async :false,
                		type:"GET",
                		data : {},
                        dataType : "json", //返回数据形式为json
                		success:function(result){
                                for(var i=0;i<result.extend.sum.length;i++){
                                console.log(result.extend.sum[i]*result.extend.prices[i]);
                                sum.push(result.extend.sum[i]*result.extend.prices[i]);
                             
                             }    
                           
                                                
                        },
                            error : function(errorMsg) {
                                alert("图表请求数据失败!");
                                 myChart.hideLoading();
                               }
                       })
                         return sum;
                      })() 
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
    
     <div id="main4" style="width: 600px;height:400px;"></div>
	
 	<script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main4'));

        option = {
        	    title : {
        	        text: '产品收入图',
        	        x:'center'
        	    },
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
        	    },
        	    legend: {
        	        orient: 'vertical',
        	        left: 'left',
        	        data:  []
        	    },
        	    series : [
        	        {
        	            name: '访问来源',
        	            type: 'pie',
        	            radius : '55%',
        	            center: ['50%', '60%'],
        	            data:(function(){
                            var names=[];
                            $.ajax({
                            	url:"${APP_PATH}/selectnumbyname",
                            	async :false,
                        		type:"GET",
                        		data : {},
                                dataType : "json", //返回数据形式为json
                        		success:function(result){
                                        for(var i=0;i<result.extend.names.length;i++){
                                        	 //alert(result.extend.names[i]+" "+result.extend.sum[i])
                                        	 names.push({
                                        	name :result.extend.names[i],
                                        	value :result.extend.sum[i]*result.extend.prices[i]
                                        	 });
                                     
                                     }    
                                },
                                    error : function(errorMsg) {
                                        alert("图表请求数据失败!");
                                         myChart.hideLoading();
                                       }
                               })
                                 return names;
                              })() ,
        	            
        	            itemStyle: {
        	                emphasis: {
        	                    shadowBlur: 10,
        	                    shadowOffsetX: 0,
        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
        	                }
        	            }
        	        }
        	    ]
        	};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script> 
</body>
</html>