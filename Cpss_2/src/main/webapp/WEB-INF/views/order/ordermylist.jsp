<%@page import="java.awt.Window"%>
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

<!-- 添加界面模态框 -->
		<div class="modal fade" id="orderAddOneModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">订单添加界面</h4>
					</div>
					
					<div class="modal-body">
						<form class="form-horizontal">
						
							<div class="form-group">
								<label for="loginame_addone_text" class="col-sm-2 control-label">账号</label>
								<div class="col-sm-8">
									<input type="text" name="loginname" class="form-control" id="loginame_addone_text"
										placeholder="账号" onfocus=this.blur();>
								</div>
							</div>
							<div class="form-group">
								<label for="productName_addone_text" class="col-sm-2 control-label">产品名称</label>
								<div class="col-sm-8">
									<input type="text" name="productName" class="form-control" id="productName_addone_text"
										placeholder="产品名称" onfocus=this.blur();>
								</div>
							</div>
							
							<div class="form-group">
								<label for="productPrice_addone_input" class="col-sm-2 control-label">价格</label>
								<div class="col-sm-8">
									<input type="text" name="productPrice" class="form-control" id="productPrice_addone_input"
										placeholder="价格" onfocus=this.blur();>
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							
							<div class="form-group">
								<label for="orderNum_addone_input" class="col-sm-2 control-label">库存</label>
								<div class="col-sm-8">
									<input class="form-control" id="orderAddOne_proNum" type="text" onfocus=this.blur();>
							
								</div>
							</div>
							
							<div class="form-group">
								<label for="orderNum_addone_input" class="col-sm-2 control-label">数量</label>
								<div class="col-sm-8">
									<input type="text" name="orderNum" class="form-control" id="orderNum_addone_input"
										placeholder="数量">
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							
							<div class="form-group">
								<label for="orderTotal_addone_input" class="col-sm-2 control-label">总价</label>
								<div class="col-sm-8">
									<input type="text" name="orderTotal" class="form-control" id="orderTotal_addone_input"
										placeholder="总价" onfocus=this.blur();>
										<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" id ="order_save_btn">添加</button>
					</div>
				</div>
			</div>
	</div>


	<div class="row">
		<div class="col-md-10" name="main_right">
			<div class="panel panel-default">
				<div class="panel-heading">
					当前位置 &nbsp; &nbsp;> &nbsp; 订单信息&nbsp;&nbsp;&nbsp;
					<span style="align:center">当前用户：</span>&nbsp;
					<span style="align:center"id="sessionspan" >${sessionScope.seuser.loginname}</span>
					<button class="btn btn-danger btn-sm" id="order_delectall_modal_btn" style="float: right">删除选中</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
				</div>
				<table class="table table-hover" id="orders_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>订单号</th>
							<th>账号</th>
							<th>产品名称</th>
							<th>价格</th>
							<th>数量</th>
							<th>总价</th>
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
			<div class="col-md-4 col-md-offset-1" id="page_nav_area">
			</div>
		</div>
</div>
	
	<script type="text/javascript">
	
		var currentPage; // 当前页数
		//1.页面加载完成后直接发送一个ajax请求，要到分页数据
		$(function(){
			//取出第一页
			to_page(1);
		});
		
		//获取session信息
		var sesloginname = $("#sessionspan").text();
		if(sesloginname == ""){
			$("#sessionspan").text("未登录！");
		}
		function to_page(pn){
			 $.ajax({
					url:"${APP_PATH}/myorder",
					data:"pn="+pn, 
					data:{pn:pn,loginname:sesloginname},
					type:"GET",
					success:function(result){
						
						//console.log(result);
						//1.解析并显示产品信息
						build_orders_table(result);
						//2.解析并显示分页信息
						build_page_info(result);
						//3.解析并显示分页信息
						build_page_nav(result);
					} 
				});
			
		}
		function build_orders_table(result){
			//重置全选
			$("#check_all").prop("checked",false);
			//清空table
			$("#orders_table tbody").empty();
			var orders = result.extend.pageInfo.list;
			$.each(orders,function(index,item){
				var checkBoxTd = $("<td style='text-align:center;'><input type='checkbox' class='check_item'/></td>");
				var ordersIDTd = $("<td style='text-align:center;'></td>").append(item.orderId);
				var loginameTd = $("<td style='text-align:center;'></td>").append(item.loginname);
				var productNameTd = $("<td style='text-align:center;'></td>").append(item.productName);
				var productPriceTd = $("<td style='text-align:center;'></td>").append(item.productPrice);
				var ordersNumTd = $("<td style='text-align:center;'></td>").append(item.orderNum);
				var orderTotalTd = $("<td style='text-align:center;'></td>").append(item.orderTotal);
			
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("再来一单");
				//为编辑按钮添加自定义的属性，来表示当前产品的ID
				editBtn.attr("edit-id",item.orderId);
				editBtn.attr("edit-num",item.orderNum);
				
				var delectBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
				//为删除按钮添加自定义的属性，来表示当前产品的ID
				delectBtn.attr("del-id",item.orderId);
				
				var btnTd= $("<td style='text-align:center;'></td>").append(delectBtn).append(" ").append(editBtn);
				 $("<tr></tr>").append(checkBoxTd)
				.append(ordersIDTd)
				.append(loginameTd)
				.append(productNameTd)
				.append(productPriceTd)
				.append(ordersNumTd)
				.append(orderTotalTd)
				.append(btnTd)
				.appendTo("#orders_table tbody");
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
				});
				perPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
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
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
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
		 
		 
			//为单个删除按钮添加删除事件
			$(document).on("click",".delete_btn",function(){
				//1.弹出是否删除确认框
				var orderId = $(this).parents("tr").find("td:eq(1)").text();
				
				var proname = $(this).parents("tr").find("td:eq(3)").text();
				var pronum = $(this).parents("tr").find("td:eq(5)").text();
				
				if(confirm("确定删除【"+orderId+"】吗?")){
					//确定后发送ajax请求
				$.ajax({
					url:"${APP_PATH}/order/"+$(this).attr("del-id"),
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
				//发送ajax请求修改产品表库存信息
				
				
				  $.ajax({
					url:"${APP_PATH}/proNum",
					dataType:'json',
					type:"POST",
					data:{proNum:-pronum,proName:proname},		
					success:function(result){				
					}
				 }); 
				}
			});
		 
			
			
			 //点击删除选中 按钮批量删除
			 $("#order_delectall_modal_btn").click(function(){
				 //$(".check_item:checked")
				 if($(".check_item:checked").length ==0 )
					 {
					 alert("没有选中！")
					 return false;
					 }
				 var orderCheckedId = "";
				 var del_idstr = "";
				 $.each($(".check_item:checked"),function(){
					 //alert($(this).parents("tr").find("td:eq(1)").text());
					 orderCheckedId += $(this).parents("tr").find("td:eq(1)").text()+" ,";
					//组装id字符串
					 del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				 });
				 //去掉proCheckedName后多余的逗号
				 orderCheckedId = orderCheckedId.substring(0,orderCheckedId.length-1);
				 del_idstr = del_idstr.substring(0,del_idstr.length-1);
				 if(confirm("确定删除【"+orderCheckedId+"】吗?")){
					 
					 $.each($(".check_item:checked"),function(){ 
						 var proname = $(this).parents("tr").find("td:eq(3)").text();
						 var pronum = $(this).parents("tr").find("td:eq(5)").text();
						  $.ajax({
								url:"${APP_PATH}/proNum",
								dataType:'json',
								type:"POST",
								data:{proNum:-pronum,proName:proname},		
								success:function(result){				
								}
							 }); 
					 });
					 $.ajax({
					 url:"${APP_PATH}/order/"+ del_idstr,
					 type:"DELETE",
					 success:function(result){
						 alert(result.msg);
						 //回到当前页面
						 to_page(currentPage);
					 }
				 	});
				 }		
			 });
			 
			 
			 
			 $(document).on("click",".edit_btn",function(){
				//获取session信息
					var sesloginname = $("#sessionspan").text();
					 if("未登录！" == sesloginname){
						 alert("当前未登录，请先登录！")
						 return false;
					 }
					//清除表单数据和表单样式
						reset_form("#orderAddOneModal form");		
					
						var loginname = $(this).parents("tr").find("td:eq(2)").text();
						var proname = $(this).parents("tr").find("td:eq(3)").text();
						var proprice = $(this).parents("tr").find("td:eq(4)").text();
						
						$("#loginame_addone_text").val(loginname);
						$("#productName_addone_text").val(proname);
						$("#productPrice_addone_input").val(proprice);
						//延迟两秒后再调用函数，为了先执行AJAX后获取数据
						setTimeout(function () { getpronum("#orderAddOne_proNum"); }, 500); 
					 $("#orderAddOneModal").modal({
							backdrop:"static"
						});
			 });
			 
			//清除表单数据和表单样式
				function reset_form(ele){
					$(ele)[0].reset();
					$(ele).find("*").removeClass("has-error has-success");
					$(ele).find(".help-block").text("");
				}
				
				//获取产品名称信息查询产品库存并显示    添加界面
				function getpronum(ele){
					var proName = $("#productName_addone_text").val();
					//清空下拉列表中的值
					 $(ele).empty();
					$.ajax({
						url:"${APP_PATH}/Proprice",
						data:"productName="+proName,
						type:"GET",
						success:function(result){
							$.each(result.extend.Proprices,function(){
								$(ele).val(this.productNum);
							});					
						} 
					});
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
				//校验方法  检验添加界面的数量
				function validate_addorder_form(){
					//获得要校验的数据
					var orderNum = $("#orderNum_addone_input").val();
					var pronum = $("#orderAddOne_proNum").val();
					 var reg = /^[0-9]+.?[0-9]*$/;
					if(orderNum == ""|| !reg.test(orderNum)  || eval(orderNum) > eval(pronum)){
						showsave_validate_msg("#orderNum_addone_input","error","数量不能为空必须是数字且要小于等于库存！");
						$("#orderTotal_addone_input").val(0);
						return false;
					}else{
						showsave_validate_msg("#orderNum_addone_input","success","");
					}
					return true;

				}
				
				//根据商品价格数量动态生成总价   添加界面
				$("#orderNum_addone_input").change(function(){
					
					if(!validate_addorder_form()){
						return false;
					}; 
					var Proprice = $("#productPrice_addone_input").val();
					var Pronum = $("#orderNum_addone_input").val();
					var orderTotal = Pronum * Proprice;
					$("#orderTotal_addone_input").val(orderTotal);
				
				});
				
				//点击添加按钮保存数据  添加界面
				$("#order_save_btn").click(function(){
					
					//点击保存，将模态框中的数据提交给服务器
					//对要提交给服务器的数据进行校验
				 	if(!validate_addorder_form()){
						return false;
					}; 
					/* //检验产品名称是否可用
					if($(this).attr("ajax-va") == "error"){
						return false;				
					}  */
					//发送ajax请求保存产品信息
					 $.ajax({
						url:"${APP_PATH}/order",
						type:"POST",
						data:$("#orderAddOneModal form").serialize(),
						success:function(result){
							
							if(result.code == 100 ){
								//alert(result.msg);
								//产品添加成功后关闭模态框并挑转到最后一页显示数据
								$("#orderAddOneModal").modal('hide');
								to_page(999999);
							}else{
								//显示失败信息
								 if(undefined != result.extend.errorFields.proName){
									showsave_validate_msg("#proName_addone_input","error",result.extend.errorFields.proName); 
								}	
							}
						}
					});
					
					//发送ajax请求修改产品表库存信息
					var proname = $("#productName_addone_text").val();
					var pronum = $("#orderNum_addone_input").val();
					
					  $.ajax({
						url:"${APP_PATH}/proNum",
						dataType:'json',
						type:"POST",
						data:{proNum:pronum,proName:proname},		
						success:function(result){
							
						}
					 }); 
				});
		 //防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
		
		</script>
</body>
</html>