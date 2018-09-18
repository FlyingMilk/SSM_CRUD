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
<link rel="stylesheet" href="${APP_PATH}/static/css/rightcss.css"
	type="text/css">
</head>
<body ondragstart="return false">

<!-- 用户修改的模态框 -->
	<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">用户修改界面</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal">
						<div class="form-group">
							<label for="loginName_update_input" class="col-sm-2 control-label">账号</label>
							<div class="col-sm-8">
								<p class="form-control-static" id="loginname_update_static"></p>
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
						<label for="password_update_input" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-8">
								<input type="text" name="password" class="form-control" id="password_update_input"
									placeholder="密码">
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						
						
						<div class="form-group">
						<label for="createdate_update_input" class="col-sm-2 control-label">日期</label>
							<div class="col-sm-8">
								<input type="text" name="createdate" class="form-control" id="createdate_update_input"
									placeholder="日期" readonly>
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						
						
						<div class="form-group">
							<label for="username1_update_input" class="col-sm-2 control-label">身份</label>
							<div class="col-sm-8">
								<label class="radio-inline">
									 <input type="radio" name="username" id="username1_update_input" value="普通用户" checked="checked">普通用户
								</label> 
								<label class="radio-inline"> 
									<input type="radio" name="username" id="username2_update_input" value="管理员">管理员
								</label>
							</div>
						</div>
					
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="user_update_btn">修改</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 用户添加的模态框 -->
	<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">用户添加界面</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal">
						<div class="form-group">
							<label for="loginName_add_input" class="col-sm-2 control-label">账号</label>
							<div class="col-sm-8">
								<input type="text" name="loginname" class="form-control" id="loginName_add_input"
									placeholder="账号">
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
						<label for="password_add_input" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-8">
								<input type="text" name="password" class="form-control" id="password_add_input"
									placeholder="密码">
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						
						
						<div class="form-group">
						<label for="createdate_add_input" class="col-sm-2 control-label">日期</label>
							<div class="col-sm-8">
								<input type="text" name="createdate" class="form-control" id="createdate_add_input"
									placeholder="日期" readonly>
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						
						
						<div class="form-group">
							<label for="username1_add_input" class="col-sm-2 control-label">身份</label>
							<div class="col-sm-8">
								<label class="radio-inline">
									 <input type="radio" name="username" id="username1_add_input" value="普通用户" checked="checked">普通用户
								</label> 
								<label class="radio-inline"> 
									<input type="radio" name="username" id="username2_add_input" value="管理员">管理员
								</label>
							</div>
						</div>
					
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="user_add_btn">添加</button>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid" id="right">
		<div class="row">
			<div class="col-md-10" name="main_right">
				<div class="panel panel-default">
					<div class="panel-heading">
						当前位置 &nbsp; &nbsp;> &nbsp; 用户信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="align:center">当前用户：</span>&nbsp;
						<span style="align:center"id="sessionspan" >${sessionScope.seuser.loginname}</span>
						<button class="btn btn-danger btn-sm" id="user_delectall_modal_btn" style="float: right">删除选中</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-info btn-sm" style="float: right" id="user_add_modal_btn">添加用户信息</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-warning btn-sm" id="user_excel_out" style="float: right">导出用户表</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<table class="table table-hover" id="users_table">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="check_all"/>
								</th>
								<th>id</th>
								<th>账号名</th>
								<th>密码</th>
								<th>创建日期</th>
								<th>身份</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>

						</tbody>

					</table>
				</div>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row" id="page_area">
			<!-- 分页文字信息 -->
			<div class="col-md-5 " id="page_info_area">
				
			</div>	
			<!-- 分页条  -->
			<div class="col-md-4 col-md-offset-3" id="page_nav_area">
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//1.页面加载完成后直接发送一个ajax请求，要到分页数据
		$(function(){
			//获取session信息
	 		var sesloginname = $("#sessionspan").text();
			if(sesloginname == ""){
				$("#sessionspan").text("未登录！");
			} 
			//取出第一页
			to_page(1);
		});
		
		function to_page(pn){
			 $.ajax({
					url:"${APP_PATH}/allusers",
					data:"pn="+pn, 
					type:"GET",
					success:function(result){
						
						//console.log(result);
						//1.解析并显示产品信息
						build_users_table(result);
						//2.解析并显示分页信息
						build_page_info(result);
						//3.解析并显示分页信息
						build_page_nav(result);
					} 
				});
			
		}
		function build_users_table(result){
			//清空table
			$("#users_table tbody").empty();
			var users = result.extend.pageInfo.list;
			$.each(users,function(index,item){
				//将时间戳转换格式显示
				da = new Date(item.createdate);
			    var month = da.getMonth()+1+'-';
				var datetime=da.getFullYear()+'-'+month+da.getDate()+' '
				+da.getHours()+':'+da.getMinutes()+':'+da.getSeconds();
				var checkBoxTd = $("<td style='text-align:center;'><input type='checkbox' class='check_item'/></td>");
				var IDTd = $("<td style='text-align:center;'></td>").append(item.id);
				var loginNameTd = $("<td style='text-align:center;'></td>").append(item.loginname);
				var passWordTd = $("<td style='text-align:center;'></td>").append(item.password);
				var createDateTd = $("<td style='text-align:center;'></td>").append(datetime);
				var usersNameTd = $("<td style='text-align:center;'></td>").append(item.username);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加自定义的属性，来表示当前产品的ID
				editBtn.attr("edit-id",item.id);
				var delectBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
				//为删除按钮添加自定义的属性，来表示当前产品的ID
				delectBtn.attr("del-id",item.id);
				var btnTd= $("<td style='text-align:center;'></td>").append(editBtn).append(" ").append(delectBtn);
				 $("<tr></tr>").append(checkBoxTd)
				 .append(IDTd)
				.append(loginNameTd)
				.append(passWordTd)
				.append(createDateTd)
				.append(usersNameTd)
				.append(btnTd)
				.appendTo("#users_table tbody");
			});
		}
		//
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页, 总共"+result.extend.pageInfo.pages+"页, 共条"+result.extend.pageInfo.total+"记录");
			//记录当前页数
			currentPage = result.extend.pageInfo.pageNum;
		}
		
		function build_page_nav(result){
			
			//重置全选
			$("#check_all").prop("checked",false);
			$("#page_nav_area").empty();
			
			var ul = $("<ul></ul>").addClass("pagination");
			
			//构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var perPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				perPageLi.addClass("disabled");
			}
			else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					to_page(1);
				})
				perPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				})
			}
			
			
			//构建元素
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			else{
				//为元素添加点击翻页的事件
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				})
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				})
			}
			
			
			//添加首页和前一页
			ul.append(firstPageLi).append(perPageLi);
			
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});	
				ul.append(numLi);
			});
			//添加后一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle = $("<nav></nav>").append(ul);
			$("#page_nav_area").append(navEle);
		}
	
		//清除表单数据和表单样式
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		/* 点击添加用户按钮弹出模块框 */
		$("#user_add_modal_btn").click(function(){
			//获取session信息
			var sesloginname = $("#sessionspan").text();
			 if("未登录！" == sesloginname){
				 alert("当前未登录，请先登录！")
				 return false;
			 }
			//清除表单数据和表单样式
			reset_form("#userAddModal form");
			$("#userAddModal").modal({
				backdrop:"static"
			});
		});
		
		/* 创建日期 */
		$("#createdate_add_input").click(function(){
			//发送ajax请求校验用户名是否重复alert("12d");
			
			var myDate = new Date();
			/* da1 = new Date(userData.createdate);
		    var month = da1.getMonth()+1+'-';
			var datetime=da1.getFullYear()+'-'+month+da1.getDate()+' '
			+da1.getHours()+':'+da1.getMinutes()+':'+da1.getSeconds(); */
		/* 	alert("1 "+myDate.toDateString());
			alert("2 "+myDate.toLocaleDateString());
			alert("3 "+myDate.toTimeString());
			alert("4 "+myDate.toUTCString());
			alert("5 "+myDate.toLocaleString());
			alert("6 "+myDate.toLocaleTimeString()); */
			$("#createdate_add_input").val(myDate);
			$("#createdate_add_input").parent().removeClass("has-success has-error");
			$("#createdate_add_input").next("span").text("");
		});
		
		//校验方法
		function validate_adduser_form(){
			//获得要校验的数据			
			var loginName = $("#loginName_add_input").val();
			var password = $("#password_add_input").val();
			var createdate = $("#createdate_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,10})/;
			if(!regName.test(loginName)){
				showsave_validate_msg("#loginName_add_input","error","账号格式为5-16位英文，数字或2-10位中文！");
				return false;
				}else{
					showsave_validate_msg("#loginName_add_input","success","");
				}
			 var reg = /^[a-zA-Z0-9_-]{3,16}$/;
			if(!reg.test(password)){
				showsave_validate_msg("#password_add_input","error","密码格式为3-16位英文，数字");
				return false;
				}else{
					showsave_validate_msg("#password_add_input","success","");
				}
			if(createdate == ""){
				showsave_validate_msg("#createdate_add_input","error","创建日期不能为空！");
				return false;
			}else{
				showsave_validate_msg("#createdate_add_input","success","");
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
		/* 添加用户按钮 */
		$("#user_add_btn").click(function(){
			
			//检验账号是否可用
			if($(this).attr("ajax-va") == "error"){
				showsave_validate_msg("#loginName_add_input","error","账号已存在！");
				return false;				
			}
			//对要提交给服务器的数据进行校验
		 	if(!validate_adduser_form()){
				return false;
			}; 
			
			
		
			//alert($("#userAddModal form").serialize());
			//发送ajax请求保存产品信息
			   $.ajax({
				url:"${APP_PATH}/users",
				type:"POST",
				data:$("#userAddModal form").serialize(),
				success:function(result){
					 
					if(result.code == 100 ){
						//alert(result.msg);
						//产品添加成功后关闭模态框并挑转到最后一页显示数据
						$("#userAddModal").modal('hide');
						to_page(999999);
					}
					else{
						//显示失败信息
						if(undefined != result.extend.errorFields.loginname){
							showsave_validate_msg("#loginname_add_input","error",result.extend.errorFields.loginname);
						}
						if(undefined != result.extend.errorFields.password){
							showsave_validate_msg("#password_add_input","error",result.extend.errorFields.password);
						}
					}
					}		
				});  
		});
		/* 动态检验密码 */
		$("#password_add_input").change(function(){
			validate_adduser_form();
			//检验账号是否可用
			if($("#user_add_btn").attr("ajax-va") == "error"){
				showsave_validate_msg("#loginName_add_input","error","账号已存在");
				return false;				
			}
		})
		//*检查用户名是否重复  */
		$("#loginName_add_input").change(function(){
			//发送ajax请求校验用户名是否重复
			var loginName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuseradd",
				data:"loginname="+loginName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						showsave_validate_msg("#loginName_add_input","success","账号可用！"); 
						$("#user_add_btn").attr("ajax-va","success");
					}else{
						showsave_validate_msg("#loginName_add_input","error",result.extend.va_msg);
						$("#user_add_btn").attr("ajax-va","error");
					}					
				}			
			});
			
		});
		
		//为编辑按钮添加事件
		$(document).on("click",".edit_btn",function(){
			//获取session信息
			var sesloginname = $("#sessionspan").text();
			 if("未登录！" == sesloginname){
				 alert("当前未登录，请先登录！")
				 return false;
			 }
			//1.查询产品类型，显示在下拉列表中
		//	getProGenres("#userUpdateModal select");
			//2. 查出产品信息，显示
			getUser($(this).attr("edit-id"));
			
			//3.把产品的id信息传递给模态框的修改按钮
			$("#user_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#userUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		/* 根据id查询用户信息 */
		function getUser(id){
			$.ajax({
				url:"${APP_PATH}/user/"+id,
				type:"GET",
				success:function(result){
					console.log(result);
					var userData = result.extend.user;
					$("#loginname_update_static").text(userData.loginname);
					$("#password_update_input").val(userData.password);
					
					//将时间戳转换格式显示								
					da1 = new Date(userData.createdate);				
					
				    /*   var month = da1.getMonth()+1+'-';
					var datetime=da1.getFullYear()+'-'+month+da1.getDate()+' '
					+da1.getHours()+':'+da1.getMinutes()+':'+da1.getSeconds(); */
					
					$("#createdate_update_input").val(da1);
					$("#userUpdateModal input[type=radio]").val([userData.username]); 
				}				
			}); 
		}
		
		$("#user_update_btn").click(function(){
			//验证密码是否合法
			 var password = $("#password_update_input").val();
			 var reg = /^[a-zA-Z0-9_-]{3,16}$/;
				if(!reg.test(password)){
					showsave_validate_msg("#password_update_input","error","密码格式为3-16位英文，数字");
					return false;
					}else{
						showsave_validate_msg("#password_update_input","success","");
					}
				
				//2.发送ajax请求保存修改信息
				$.ajax({
					url:"${APP_PATH}/user/"+$(this).attr("edit-id"),
					type:"POST",
					data:$("#userUpdateModal form").serialize()+"&_method=PUT",
					success:function(result){

						//alert(result.msg);
						//1.关闭模态框，
						$("#userUpdateModal").modal("hide");
						//2.回到本页面
						to_page(currentPage);
					}
					
				}); 
		});
		
		//为单个删除按钮添加删除事件
		$(document).on("click",".delete_btn",function(){
			//获取session信息
			var sesloginname = $("#sessionspan").text();
			 if("未登录！" == sesloginname){
				 alert("当前未登录，请先登录！")
				 return false;
			 }
			 
				
			//1.弹出是否删除确认框
			var loginname = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确定删除【"+loginname+"】吗?")){
				//确定后发送ajax请求
				
				/* 删除用户时根据用户名 查询订单表获取相关订单的商品名称和商品数量并根据名称返还商品数量 */
				$.ajax({
					url:"${APP_PATH}/updateNumbyName",
					data:"loginname="+loginname,
					type:"GET",
					success:function(result){
						
					}
				})
				
			$.ajax({
				url:"${APP_PATH}/user/"+$(this).attr("del-id"),
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					to_page(currentPage);
				}
				
			});
				
		
			  
			}
		});
		
		//全选或全不选 功能实现
		 $("#check_all").click(function(){
			 	//attr获取checked是undefined，对于dom原生属性建议用prop获取，用attr获取自定义属性
			 	//alert($(this).prop("checked"));
			 	$(".check_item").prop("checked",$(this).prop("checked"));
			});
		 
		 $(document).on("click",".check_item",function(){
			 //判断当前选中的元素是否全选
			 var checkflag = $(".check_item:checked").length == $(".check_item").length;
			 $("#check_all").prop("checked",checkflag);
		 });
		 
		 
		 //点击删除选中 按钮批量删除
		 $("#user_delectall_modal_btn").click(function(){
			//获取session信息
				var sesloginname = $("#sessionspan").text();
				 if("未登录！" == sesloginname){
					 alert("当前未登录，请先登录！")
					 return false;
				 }
			 //$(".check_item:checked")
			 if($(".check_item:checked").length ==0 )
				 {
				 alert("没有选中！")
				 return false;
				 }
			 var userCheckedName = "";
			 var del_idstr = "";
			 $.each($(".check_item:checked"),function(){
				// alert($(this).parents("tr").find("td:eq(2)").text());
				 userCheckedName += $(this).parents("tr").find("td:eq(2)").text()+" ,";
				//组装id字符串
				 del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			 });
			 //去掉proCheckedName后多余的逗号
			 userCheckedName = userCheckedName.substring(0,userCheckedName.length-1);
			 del_idstr = del_idstr.substring(0,del_idstr.length-1);
			 if(confirm("确定删除【"+userCheckedName+"】吗?")){
				 
				 $.each($(".check_item:checked"),function(){
					 var loginname = $(this).parents("tr").find("td:eq(2)").text();
						/* 删除用户时根据用户名 查询订单表获取相关订单的商品名称和商品数量并根据名称返还商品数量 */
						$.ajax({
							url:"${APP_PATH}/updateNumbyName",
							data:"loginname="+loginname,
							type:"GET",
							success:function(result){
								
							}
						});
				 });
				 
				 
				 $.ajax({
				 url:"${APP_PATH}/user/"+ del_idstr,
				 type:"DELETE",
				 success:function(result){
					 alert(result.msg);
					 //回到当前页面
					 to_page(currentPage);
				 }
			 });
			 }
		 });
		 
		 /* 导出EXCEL数据 */
		 $("#user_excel_out").click(function(){
			 
			//获取session信息
				var sesloginname = $("#sessionspan").text();
				 if("未登录！" == sesloginname){
					 alert("当前未登录，请先登录！")
					 return false;
				 }
			/*   $.ajax({
				 url:"${APP_PATH}/export",
				 type:"GET",
				 success:function(result){
				 }
			 });  */
			 window.location.href = "${APP_PATH}/userdownLoadExcel";
			 // window.open("D:/poi_test.xls");
		 });
		 //防止页面后退
		    history.pushState(null, null, document.URL);
		    window.addEventListener('popstate', function () {
		        history.pushState(null, null, document.URL);
		    });
	</script>
</body>
</html>