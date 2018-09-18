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
<div class="container-fluid" id="right" >


	<!-- 修改界面模态框 -->
		<div class="modal fade" id="proUpdateModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改产品信息 </h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<div class="form-group">
								<label for="proName_update_input" class="col-sm-2 control-label">产品名称</label>
								<div class="col-sm-8">
									<p class="form-control-static" id="proName_update_static"></p>
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="proPrice_update_input" class="col-sm-2 control-label">价格</label>
								<div class="col-sm-8">
									<input type="text" name="productPrice" class="form-control" id="proPrice_update_input"
										placeholder="价格">
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="proDesc_update_input" class="col-sm-2 control-label">分类</label>
								<div class="col-sm-4">
									<select class="form-control" name="productGenre" id="proGenre_update_select">
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="proNum_update_input" class="col-sm-2 control-label">数量</label>
								<div class="col-sm-8">
									<input type="text" name="productNum" class="form-control" id="proNum_update_input"
										placeholder="数量">
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="proDesc_update_input" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-8">
									<input type="text" name="productDescribe" class="form-control" id="proDesc_update_input"
										placeholder="描述">
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" id ="pro_update_btn">修改</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- 添加界面模态框 -->
		<div class="modal fade" id="proAddModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">商品添加界面</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<div class="form-group">
								<label for="proName_add_input" class="col-sm-2 control-label">产品名称</label>
								<div class="col-sm-8">
									<input type="text" name="productName" class="form-control" id="proName_add_input"
										placeholder="名称不能为空">
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="proPrice_add_input" class="col-sm-2 control-label">价格</label>
								<div class="col-sm-8">
									<input type="text" name="productPrice" class="form-control" id="proPrice_add_input"
										placeholder="价格">
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="proDesc_add_input" class="col-sm-2 control-label">分类</label>
								<div class="col-sm-4">
									<select class="form-control" name="productGenre" id="proGenre_add_select">
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="proNum_add_input" class="col-sm-2 control-label">数量</label>
								<div class="col-sm-8">
									<input type="text" name="productNum" class="form-control" id="proNum_add_input"
										placeholder="数量">
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="proDesc_add_input" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-8">
									<input type="text" name="productDescribe" class="form-control" id="proDesc_add_input"
										placeholder="描述">
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" id ="pro_save_btn">添加</button>
					</div>
				</div>
			</div>
		</div>


		<div class="row">
			<div class="col-md-10" name="main_right">
				<div class="panel panel-default">
					<div class="panel-heading">
					
						当前位置 &nbsp; &nbsp;> &nbsp; 产品信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="align:center">当前用户：</span>&nbsp;
						<span style="align:center"id="sessionspan" >${sessionScope.seuser.loginname}</span>
						
						
						<button class="btn btn-danger btn-sm" id="pro_delectall_modal_btn" style="float: right">删除选中</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-info btn-sm" id="pro_add_modal_btn" style="float: right">添加产品信息</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-warning btn-sm" id="pro_excel_out" style="float: right">导出产品表</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
					
						
					</div>
					<table class="table table-hover" id="products_table">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="check_all"/>
								</th>
								<th width="90px">id</th>
								<th width="120px">产品名称</th>
								<th width="90px">价格</th>
								<th width="120px">种类</th>
								<th width="90px">数量</th>
								<th width="340px">描述</th>
								<th width="140px">操作</th>
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
	
		var currentPage; // 当前页数
		//1.页面加载完成后直接发送一个ajax请求，要到分页数据
		$(function(){
			//取出第一页
			//获取session信息
	 		var sesloginname = $("#sessionspan").text();
			if(sesloginname == ""){
				$("#sessionspan").text("未登录！");
			} 
			to_page(1);
		});
		
		function to_page(pn){
			var order_by = "no";
			var select_type = "no";
			var select_text = "no";
			var coll_flag = "no";
			var loginname = "no";
			 $.ajax({
					url:"${APP_PATH}/products",
					dataType:'json',
					data:{pn:pn,order_by:order_by,select_type:select_type,select_text:select_text,coll_flag:coll_flag,loginname:loginname}, 
					type:"GET",
					success:function(result){
						
						//console.log(result);
						//1.解析并显示产品信息
						build_products_table(result);
						//2.解析并显示分页信息
						build_page_info(result);
						//3.解析并显示分页信息
						build_page_nav(result);
					} 
				});
			
		}
		function build_products_table(result){
			//重置全选
			$("#check_all").prop("checked",false);
			//清空table
			$("#products_table tbody").empty();
			var products = result.extend.pageInfo.list;
			$.each(products,function(index,item){
				var checkBoxTd = $("<td style='text-align:center;'><input type='checkbox' class='check_item'/></td>");
				var prosIDTd = $("<td style='text-align:center;'></td>").append(item.productId);
				var prosNameTd = $("<td style='text-align:center;'></td>").append(item.productName);
				var prosPriceTd = $("<td style='text-align:center;'></td>").append(item.productPrice);
				var prosGenreTd = $("<td style='text-align:center;'></td>").append(item.productGenre);
				var prosNumTd = $("<td style='text-align:center;'></td>").append(item.productNum);
				var prosDescribeTd = $("<td></td>").append(item.productDescribe);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加自定义的属性，来表示当前产品的ID
				editBtn.attr("edit-id",item.productId);
				var delectBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
				//为删除按钮添加自定义的属性，来表示当前产品的ID
				delectBtn.attr("del-id",item.productId);
				
				var btnTd= $("<td style='text-align:center;'></td>").append(editBtn).append(" ").append(delectBtn);
				 $("<tr></tr>").append(checkBoxTd)
				.append(prosIDTd)
				.append(prosNameTd)
				.append(prosPriceTd)
				.append(prosGenreTd)
				.append(prosNumTd)
				.append(prosDescribeTd)
				.append(btnTd)
				.appendTo("#products_table tbody");
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
			$("#page_nav_area").empty();
			
			
			var order_by = "no";
			var select_type = "no";
			var select_text = "no";
			
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
					to_page(1,order_by,select_type,select_text,"no","no");
				})
				perPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1,order_by,select_type,select_text,"no","no");
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
					to_page(result.extend.pageInfo.pageNum+1,order_by,select_type,select_text,"no","no");
				})
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages,order_by,select_type,select_text,"no","no");
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
					to_page(item,order_by,select_type,select_text,"no","no");
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
		//点击新增按钮弹出模态框
		$("#pro_add_modal_btn").click(function(){
			//获取session信息
			var sesloginname = $("#sessionspan").text();
			 if("未登录！" == sesloginname){
				 alert("当前未登录，请先登录！")
				 return false;
			 }
			//清除表单数据和表单样式
			reset_form("#proAddModal form");		
			//发送Ajax请求，获取产品分类数据,显示在下拉列表中
			getProGenres("#proGenre_add_select");
			//弹出模态框
			$("#proAddModal").modal({
				backdrop:"static"
			});
		});
		
		//获取产品分类信息显示在下拉列表中
		function getProGenres(ele){
			//清空下拉列表中的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/ProsGenre",
				type:"GET",
				success:function(result){
					//console.log(result);
					//显示产品分类信息在下拉列表中
					//$("#proGenre_add_select").append("")
					$.each(result.extend.Pros,function(){
						var optionEle = $("<option></option>").append(this.productGenre).attr("value",this.productId);
						optionEle.appendTo(ele);
					});
					
				}
			});
		}

		
		//校验方法
		function validate_addpro_form(){
			//获得要校验的数据
			var proName = $("#proName_add_input").val();
			var proPrice = $("#proPrice_add_input").val();
			var proNum = $("#proNum_add_input").val();
			 var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{1,10})/;
			if(!regName.test(proName)){
				showsave_validate_msg("#proName_add_input","error","名称格式为3-16位英文，数字或1-10位中文！");
				return false;
				}else{
					//showsave_validate_msg("#proName_add_input","success","");
				}
			 var reg = /^[0-9]+.?[0-9]*$/;
			if(proPrice == "" || !reg.test(proPrice)){
				showsave_validate_msg("#proPrice_add_input","error","价格不能为空且必须是数字！");
				return false;
				}else{
					showsave_validate_msg("#proPrice_add_input","success","");
				}
			if(proNum == ""|| !reg.test(proNum)){
				showsave_validate_msg("#proNum_add_input","error","数量不能为空且必须是数字！");
				return false;
			}else{
				showsave_validate_msg("#proNum_add_input","success","");
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
		
		/* 动态检验价钱和数量 */
		$("#proPrice_add_input").change(function(){
			validate_addpro_form();
		});
		$("#proNum_add_input").change(function(){
			validate_addpro_form();
		});


		//校验用户名是否重复
		$("#proName_add_input").change(function(){
			//发送ajax请求校验用户名是否重复
			var proName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkproname",
				data:"proName="+proName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						showsave_validate_msg("#proName_add_input","success","产品名称可用！"); 
						$("#pro_save_btn").attr("ajax-va","success");
					}else{
						showsave_validate_msg("#proName_add_input","error",result.extend.va_msg);
						$("#pro_save_btn").attr("ajax-va","error");
					}					
				}			
			});
			
		});
		
		//点击添加按钮保存数据
		$("#pro_save_btn").click(function(){
			//点击保存，将模态框中的数据提交给服务器
			//对要提交给服务器的数据进行校验
			if(!validate_addpro_form()){
				return false;
			}; 
			//检验产品名称是否可用
			if($(this).attr("ajax-va") == "error"){
				return false;				
			}
			//发送ajax请求保存产品信息
			 $.ajax({
				url:"${APP_PATH}/pro",
				type:"POST",
				data:$("#proAddModal form").serialize(),
				success:function(result){
					
					if(result.code == 100 ){
						//alert(result.msg);
						//产品添加成功后关闭模态框并挑转到最后一页显示数据
						$("#proAddModal").modal('hide');
						to_page(999999,"no","no","no","no","no");
					}
					else{
						//显示失败信息
						if(undefined != result.extend.errorFields.proName){
							showsave_validate_msg("#proName_add_input","error",result.extend.errorFields.proName);
						}
						
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
			getProGenres("#proUpdateModal select");
			//2. 查出产品信息，显示
			getPro($(this).attr("edit-id"));
			
			//3.把产品的id信息传递给模态框的修改按钮
			$("#pro_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#proUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getPro(id){
			$.ajax({
				url:"${APP_PATH}/pro/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var proData = result.extend.pro;
					$("#proName_update_static").text(proData.productName);
					$("#proPrice_update_input").val(proData.productPrice);
					$("#proUpdateModal select").val([proData.productGenre]);
					$("#proNum_update_input").val([proData.productNum]);
					$("#proDesc_update_input").val([proData.productDescribe]);
				}				
			}); 
		}
		
		//点击修改按钮保存数据
		$("#pro_update_btn").click(function(){
		
			//验证信息是否合法
			var proPrice = $("#proPrice_update_input").val();
			var proNum = $("#proNum_update_input").val();
			 var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{1,10})/;
			 var reg = /^[0-9]+.?[0-9]*$/;
			if(proPrice == "" || !reg.test(proPrice)){
				showsave_validate_msg("#proPrice_update_input","error","价格不能为空且必须是数字！");
				return false;
				}else{
					showsave_validate_msg("#proPrice_update_input","success","");
				}
			if(proNum == ""|| !reg.test(proNum)){
				showsave_validate_msg("#proNum_update_input","error","数量不能为空且必须是数字！");
				return false;
			}else{
				showsave_validate_msg("#proNum_update_input","success","");
			}
			//2.发送ajax请求保存修改信息
			$.ajax({
				url:"${APP_PATH}/pro/"+$(this).attr("edit-id"),
				type:"POST",
				data:$("#proUpdateModal form").serialize()+"&_method=PUT",
				success:function(result){

					//alert(result.msg);
					//1.关闭模态框，
					$("#proUpdateModal").modal("hide");
					//2.回到本页面
					to_page(currentPage,"no","no","no","no","no");
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
			var productName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确定删除【"+productName+"】吗?")){
				//确定后发送ajax请求
			$.ajax({
				url:"${APP_PATH}/pro/"+$(this).attr("del-id"),
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					to_page(currentPage,"no","no","no","no","no");
					
					//删除商品的时候同时根据名称发送请求删除相关订单
					 $.ajax({
						url:"${APP_PATH}/orderdeletebyname",
						type:"DELETE",
						data:"productName="+productName,
						success:function(result){
						}
					}); 
					 
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
		 $("#pro_delectall_modal_btn").click(function(){
			 //$(".check_item:checked")
			//获取session信息
				var sesloginname = $("#sessionspan").text();
				 if("未登录！" == sesloginname){
					 alert("当前未登录，请先登录！")
					 return false;
				 }
			 if($(".check_item:checked").length ==0 )
				 {
				 alert("没有选中！")
				 return false;
				 }
			 var proCheckedName = "";
			 var del_idstr = "";
			 $.each($(".check_item:checked"),function(){
				// alert($(this).parents("tr").find("td:eq(2)").text());
				 proCheckedName += $(this).parents("tr").find("td:eq(2)").text()+" ,";
				//组装id字符串
				 del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			 });
			 //去掉proCheckedName后多余的逗号
			 proCheckedName = proCheckedName.substring(0,proCheckedName.length-1);
			 del_idstr = del_idstr.substring(0,del_idstr.length-1);
			 if(confirm("确定删除【"+proCheckedName+"】吗?")){
				 $.ajax({
				 url:"${APP_PATH}/pro/"+ del_idstr,
				 type:"DELETE",
				 success:function(result){
					 alert(result.msg);
					 //回到当前页面
					 to_page(currentPage,"no","no","no","no","no");
				 }
			 });
			 }
		 });
		
		 /* 导出EXCEL数据 */
		 $("#pro_excel_out").click(function(){
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
			 window.location.href = "${APP_PATH}/downLoadExcel";
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