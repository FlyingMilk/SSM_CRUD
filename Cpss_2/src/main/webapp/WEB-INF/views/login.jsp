<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆界面</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入JS项目插件 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/css/loginForm.css" type="text/css">
</head>
<body>
<div id="login" class="center-block" >
<h1 id="h1">化工产品销售系统</h1	>
<div class="center-block container-fluid" id="login1">
	<div class="row">	
	<form class="form-horizontal"  action="checkuser" method="post">
  		<div class="form-group" >
  		  <label for="loginname" class="col-sm-offset-1 col-sm-2 control-label">账号</label>
   			 <div class="col-sm-8">
     			 <input type="text" class="form-control" name="loginname" id="loginname" placeholder="请输入账号">
    			 <span class="help-block"></span>
    		</div>
  		</div>
  		<div class="form-group">
   			 <label for="password" class="col-sm-offset-1 col-sm-2 control-label">密码</label>
   			 <div class="col-sm-8">
     		 <input type="password" class="form-control" name="password" id="password" placeholder="请输入密码">
      		 <span class="help-block"></span>
    		 </div>
        </div>
  
  		<div class="form-group">
 			 <label for="username" class="col-sm-offset-1 col-sm-2 control-label">身份</label>&nbsp;
  				<div  class=" col-sm-7"> 
  					<select class="form-control" name ="username" id="username">
  						<option value="普通用户">普通用户</option>
  						<option value="管理员">管理员</option>
					</select>
					<span class="help-block"></span>
				</div>
  		</div>
  		<div>
  		 <div class="col-sm-offset-2 col-sm-4">
   			   <button type="button" class="btn btn-default" id="register"> 注册</button>
 		   </div>
  		</div>
  
  		<div class="form-group">
 		   <div class="	col-sm-4">
   			   <button type="button" class="btn btn-info" id="submit"> 登录</button>
 		   </div>
 		 </div>
	</form>
	</div>
</div>
</div>

<%
session.setAttribute("loginname","2424");
%>
<script type="text/javascript">


	//显示校验信息
	function show_validate_msg(ele,status,msg){
		//每次之前清空之前的样式
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		if("success" == status){
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text(msg);
			
		}else if("error" == status){
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg)
		}
		
	}

	//校验登录数据
	function validate_login(){
		//1.拿到药校验的数据，使用正则表达式进行校验
		var loginName = $("#loginname").val();
		var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,10})/;
		if(!regName.test(loginName)){
			show_validate_msg("#loginname","error","账号错误！")
			return false
		}
		else{
			show_validate_msg("#loginname","success","")
		}
		return true;
	}
	
	var num = 0;
	
	$("#submit").click(function(){
		
		if(!validate_login()){
			return false;
		}
		else{
			var loginname = $("#loginname").val();
			var password = $("#password").val();
			var username = $("#username").val();
			$.ajax({
				url:"${APP_PATH}/checkUser",
			//	data:"loginname="+loginname & "password="+password,
				data:{loginname:loginname , password:password ,username:username},
				type:"POST",
				success:function(result){
					
					if(result.code == 100 ){
						if(username == "管理员"){
						 	 window.location = "${APP_PATH}/main";
						 	
						}
						  else{ 
							  window.location = "${APP_PATH}/usermain";
						  }

					}else{
						num++;
						$("#username").next("span").text("账号,密码或身份验证错误！");
						//show_validate_msg("#username","error","账号,密码或身份验证错误！")
					}
				}			
			});
		}	
	});  
	/* 为注册按钮添加跳转事件 */
	$("#register").click(function(){
		window.location = "${APP_PATH}/register";
	});
	
	 //防止页面后退
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });
	
</script>
</body>
</html>