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
<link rel="stylesheet" href="${APP_PATH}/static/css/topcss.css"
	type="text/css">
</head>
<body onload="showdate()">
	<div class="container" id="top">
	
		<div class="row">
			 <div class="col-md-6" id="top_h1">
			 <img src="${APP_PATH}/static/image/timg.jpg" align="left" >
				<p>化工产品销售系统</p>
			</div> 
			
			<div class="col-md-4 col-md-offset-8" style="text-align:right">
			<div  style="text-align:right"><span class="glyphicon glyphicon-time" id="myclock"></span></div>
			<div>&nbsp;</div>
			   <span class="glyphicon glyphicon-user"></span> 当前用户：<span id="sessionspan" >${sessionScope.seuser.loginname}</span>&nbsp;&nbsp;&nbsp;
				<a  id="zhuxiao" style="text-decoration:none;cursor:pointer;"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>注销</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</div>
	</div>
	<div border="1px">
		
	</div>
	
	
		<script type="text/javascript">
			$("#zhuxiao").click(function(){
			//	window.top.close();
			var text1 = $("#zhuxiao").text();
			
				if(text1 == "登录"){
					window.top.location.href  ="${APP_PATH}/login";
				}
				if(text1 == "注销"){
					//session.removeAttribute("seuser");
					
					window.top.location.href  ="${APP_PATH}/logout";
					$("#zhuxiao").text("登录");
				}
				
			// window.location = "${APP_PATH}/login";
			});
			$(function(){
				/* var preurl = document.referrer;
				alert(preurl);
				if(preurl !="http://localhost:8080/Cpss_2/usermain" && preurl !="http://localhost:8080/Cpss_2"){
					alert("请先登录，点击确认跳转到登录界面");
					setTimeout("${APP_PATH}/login",1000); 
				}
				 */
				
				var sesloginname = $("#sessionspan").text();
				if(sesloginname == ""){
					$("#sessionspan").text("未登录！");
					$("#zhuxiao").text("登录");
				}
				
			
			});
			//显示时间
			function showdate(){
				var datetime = new Date();
				var year = datetime.getFullYear();
				var mo = datetime.getMonth()+1;
				var da = datetime.getDate();
				var hh = datetime.getHours();
				var weekday = datetime.getDay();
				switch(weekday){
				case 1:weekday = "一";break;
				case 2:weekday = "二";break;
				case 3:weekday = "三";break;
				case 4:weekday = "四";break;
				case 5:weekday = "五";break;
				case 6:weekday = "六";break;
				case 7:weekday = "日";break;
				default:weekday="";break;
				}
				
				var mm = datetime.getMinutes();
				var ss = datetime.getSeconds();
				document.getElementById("myclock").innerHTML
				=year+"年"+mo+"月"+da+"日"+"星期"+weekday+hh+":"+mm+":"+ss;
			}
			
			 setInterval("showdate()", 1000);
			</script>
</body>
</html>