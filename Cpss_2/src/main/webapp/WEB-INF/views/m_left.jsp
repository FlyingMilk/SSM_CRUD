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
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入JS项目插件 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/css/left/leftcss.css"
	type="text/css">
	
	<style type="text/css">
	#a_eare1:hover{background-color:#97FFFF;}
	#a_eare2:hover{background-color:#97FFFF;}
	#a_eare3:hover{background-color:#97FFFF;}
	#a_eare4:hover{background-color:#97FFFF;}
	</style>
</head>
<body ondragstart="return false">
<div class="container-fluid" id="left" >
	<div class="row" id="left_eare">
		<div class="col-md-2"> 
			<div class="row" id= "a_eare1" >
				<div id= "font_eara1" style="position: absolute;bottom: 220px;left:5px;">
				<a href="${APP_PATH}/product/selectProduct" target="main_right" class="glyphicon glyphicon-tasks" style="text-decoration:none;">产品管理</a>
				</div>
			</div>
			<div class="row" id= "a_eare2" >
				<div id= "font_eara2" style="position: absolute;bottom: 150px;left:5px;">
				<a href="${APP_PATH}/user/selectUser" target="main_right" class="glyphicon glyphicon-th-list" style="text-decoration:none;">用户管理</a>
				</div>
			</div>
			<div class="row" id= "a_eare3">
				<div id= "font_eara3" style="position: absolute;bottom: 80px;left:5px;">
				<a href="${APP_PATH}/order/selectOrder" target="main_right" class="glyphicon glyphicon-usd" style="text-decoration:none;">订单管理</a>
				</div>
			</div>
			<div class="row" id= "a_eare4">
				<div id= "font_eara4" style="position: absolute;bottom: 10px;left:5px;">
				<a href="${APP_PATH}/order/showpic" target="main_right" class="glyphicon glyphicon-retweet" style="text-decoration:none;">生成报表</a>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>