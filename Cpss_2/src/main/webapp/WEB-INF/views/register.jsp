<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入JS项目插件 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/css/register.css" type="text/css">
</head>
<body>
<div id="login" class="center-block" >
	<h1>用户注册</h1	>
	<div class="center-block container-fluid">
		<div class="row">	
		<form class="form-horizontal"  method="post" id="register_from">
  			<div class="form-group" >
  			  <label for="reg_loginname" class="col-sm-offset-1 col-sm-2 control-label">账号</label>
   				 <div class="col-sm-8">
     				 <input type="text" class="form-control" name="loginname" id="reg_loginname" placeholder="请输入账号">
    				 <span class="help-block"></span>
    			</div>
  			</div>
  			<div class="form-group">
   				 <label for="reg_password" class="col-sm-offset-1 col-sm-2 control-label">密码</label>
   				 <div class="col-sm-8">
     				 <input type="password" class="form-control" name="password" id="reg_password" placeholder="请输入密码">
      				 <span class="help-block"></span>
    			 </div>
        	</div>
  			<div class="form-group">
					<div class="col-sm-7">
						<input type="text" name="createdate" class="form-control" id="reg_createdate_update_input"
							placeholder="日期" style="display: none">
						<span id="helpBlock2" class="help-block"></span>
					</div>
			</div>
			<div class="form-group">
   				<div class="col-sm-8">
     				 <input type="text" class="form-control" name="username" id="reg_username" value="普通用户" style="display: none">
      				 <span class="help-block"></span>
    			 </div>
        	</div>
  			<div>
  	    		<div class="col-sm-offset-2 col-sm-5">
   			   		 <button type="button" class="btn btn-default" id="reg_register"> 注册</button>
 		    	</div>
  			</div>
  
		</form>
		</div>
	</div>
</div>
<script type="text/javascript">

$("#reg_loginname").change(function(){
	//设置时间
	var myDate = new Date();
	$("#reg_createdate_update_input").val(myDate);
	$("#reg_createdate_update_input").parent().removeClass("has-success has-error");
	$("#reg_createdate_update_input").next("span").text("");

	//发送ajax请求校验用户名是否重复
	var loginName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuseradd",
				data:"loginname="+loginName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						showsave_validate_msg("#reg_loginname","success","账号可用！"); 
						$("#reg_register").attr("ajax-va","success");
					}else{
						showsave_validate_msg("#reg_loginname","error",result.extend.va_msg);
						$("#reg_register").attr("ajax-va","error");
					}					
				}			
			});
	
});
//校验方法
function validate_adduser_form(){
	//获得要校验的数据			
	var loginName = $("#reg_loginname").val();
	var password = $("#reg_password").val();
	var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,10})/;
	if(!regName.test(loginName)){
		showsave_validate_msg("#reg_loginname","error","账号格式为5-16位英文，数字或2-10位中文！");
		return false;
		}else{
			showsave_validate_msg("#reg_loginname","success","");
		}
	 var reg = /^[a-zA-Z0-9_-]{3,16}$/;
	if(!reg.test(password)){
		showsave_validate_msg("#reg_password","error","密码格式为3-16位英文，数字");
		return false;
		}else{
			showsave_validate_msg("#reg_password","success","");
		}
	return true;
}

//显示校验信息
function showsave_validate_msg(ele,status,msg){
	//每次之前清空之前的样式
	$(ele).parent().removeClass("has-success has-error");
	$(ele).next("span").text("");
	if("success" == status){
		$(ele).parent().addClass("has-success");
		$(ele).next("span").text(msg);
	}else if("error" == status){
		$(ele).parent().addClass("has-error");
		$(ele).next("span").text(msg);
	}
}	

$("#reg_register").click(function(){
	//ajax检验账号是否可用
	if($(this).attr("ajax-va") == "error"){
		showsave_validate_msg("#reg_loginname","error","账号已存在！");
		return false;				
	}
	//前端检验账号规格
	 if(!validate_adduser_form()){
		return fasle;
	} 
	
	$.ajax({
		url:"${APP_PATH}/registeruser",
		type:"POST",
		data:$("#register_from").serialize(),
		success:function(result){
			alert(result.msg);
			//注册成功后跳转到登录界面
			if(result.code == 100 )
			window.location.href="${APP_PATH}/index.jsp"; 
		}
	})
});
</script>
</body>
</html>