<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的信息</title>

<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入JS项目插件 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/css/myinfo.css"
	type="text/css">
</head>
<body>
<div class="container-fluid" id="right" >
	<div class="row">
		<div class="col-md-10" name="main_right">
			<div class="panel panel-default">
				<div class="panel-heading">
					当前位置 &nbsp; &nbsp;> &nbsp; 个人信息 &nbsp;&nbsp;&nbsp;
					<span style="align:center">当前用户：</span>&nbsp;
					<span style="align:center"id="sessionspan" >${sessionScope.seuser.loginname}</span>
				</div>
			</div>
		</div>
		
		<div class="col-md-10">
		<form >
		<label for="password1">新密码： </label>
		<input type="password" id="password1">
		<label for="password2">确认密码：</label>
		<input type="password" id="password2">
		<input type="button"  class="btn btn-default" id="update_password"value="修改">
		<span id="span1"></span>
		</form>
		</div>
		
		<script type="text/javascript">
		
		$(function(){
			var sesloginname = $("#sessionspan").text();
			if(sesloginname == ""){
				if(confirm("请先登录！点击确认跳转至登录界面")){
				//	alert(123);
					window.top.location.href="http://localhost:8080/Cpss_2";
				}else{
				$("#sessionspan").text("未登录！");
				return flase;
				}
			} 
		});
		function validate_psd1(){
			var password1 = $("#password1").val();
			var reg = /^[a-zA-Z0-9_-]{3,16}$/;
			 if(!reg.test(password1)){
				 $("#span1").text(" 密码格式错误！格式为3-16位英文，数字");
					return false;
					}else{
						$("#span1").text("");
						return true;
					}
		}
		function validate_psd2(){
			var password1 = $("#password1").val();
			var password2 = $("#password2").val();
			if(password1 != password2){
				$("#span1").text(" 密码不一致！");
				return false;
			}
			else{
				$("#span1").text("");
				return true;
			}
		}
		
		$("#password1").change(function(){
			validate_psd1();
		});
		
		/* 点击修改按钮  重新设置密码 */
		$("#update_password").click(function(){
			var sesloginname = $("#sessionspan").text();
			if(sesloginname == "未登录！"){
				alert("请先登录！");
				return false;
			}
		
			if(validate_psd1()){
				if(validate_psd2()){
					var password = $("#password1").val();
					var psd = 0;
					//发送ajax请求查询原来的密码
					$.ajax({
						url:"${APP_PATH}/selectmypsd",
						data:"loginname="+sesloginname,
						type:"GET",
						success:function(result){
							psd = result;
							if(psd == password){
								alert("新密码不能和原来一样");
								return false;
							}
							//发送ajax请求 更新密码
							$.ajax({
								url:"${APP_PATH}/myinfo",
								dataType:'json',
								data:{password:password,loginname:sesloginname},
								type:"POST",
								success:function(result){
									alert(result.msg);
									$("#password1").val("");
									$("#password2").val("");
								}
							});
						}
					})
					
					
					
				}
			}
		});
		
		</script>
	
	</div>
</div>
			
						
</body>
</html>