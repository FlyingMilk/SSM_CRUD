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
	<div class="row">
			<div class="col-md-10" name="main_right">
				<div class="panel panel-default">
					<div class="panel-heading">
						当前位置 &nbsp; &nbsp;> &nbsp; 购物车信息&nbsp;&nbsp;&nbsp;
						<span style="align:center">当前用户：</span>&nbsp;
					<span style="align:center"id="sessionspan" >${sessionScope.seuser.loginname}</span>
						<button class="btn btn-danger btn-sm" id="shopcar_delectall_modal_btn" style="float: right">删除选中</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-info btn-sm" id="shopcar_addall_modal_btn" style="float: right">结算选中</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
					</div>
					<table class="table table-hover" id="orders_table">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="check_all"/>
								</th>
								<th>ID</th>
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
		//	alert(sesloginname);
		});
		
	 	var sesloginname = $("#sessionspan").text();
		if(sesloginname == ""){
			$("#sessionspan").text("未登录！");
		} 
		
		function to_page(pn){
			 $.ajax({
					url:"${APP_PATH}/shopcar",
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
				var ordersIDTd = $("<td style='text-align:center;'></td>").append(item.carId);
				var loginameTd = $("<td style='text-align:center;'></td>").append(item.loginname);
				var productNameTd = $("<td style='text-align:center;'></td>").append(item.productName);
				var productPriceTd = $("<td style='text-align:center;'></td>").append(item.productPrice);
				var ordersNumTd = $("<td style='text-align:center;'></td>").append(item.orderNum);
				var orderTotalTd = $("<td style='text-align:center;'></td>").append(item.orderTotal);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("结算");
				//为编辑按钮添加自定义的属性，来表示当前产品的ID
				editBtn.attr("edit-id",item.carId);
				editBtn.attr("edit-num",item.orderNum);
				var delectBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
				//为删除按钮添加自定义的属性，来表示当前产品的ID
				delectBtn.attr("del-id",item.carId);
				
				var btnTd= $("<td style='text-align:center;'></td>").append(editBtn).append(" ").append(delectBtn);
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
				var productId = $(this).parents("tr").find("td:eq(1)").text();
				if(confirm("确定删除【"+productId+"】吗?")){
					//确定后发送ajax请求
				$.ajax({
					url:"${APP_PATH}/shopcar/"+$(this).attr("del-id"),
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
				}
			});
		
		
			 //点击删除选中 按钮批量删除
			 $("#shopcar_delectall_modal_btn").click(function(){
				 //$(".check_item:checked")
				 if($(".check_item:checked").length ==0 )
					 {
					 alert("没有选中！")
					 return false;
					 }
				 var carCheckedName = "";
				 var del_idstr = "";
				 $.each($(".check_item:checked"),function(){
					// alert($(this).parents("tr").find("td:eq(2)").text());
					 carCheckedName += $(this).parents("tr").find("td:eq(1)").text()+" ,";
					//组装id字符串
					 del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				 });
				 //去掉proCheckedName后多余的逗号
				 carCheckedName = carCheckedName.substring(0,carCheckedName.length-1);
				 del_idstr = del_idstr.substring(0,del_idstr.length-1);
				 if(confirm("确定删除【"+carCheckedName+"】吗?")){
					 
					 
					 
					 $.ajax({
					 url:"${APP_PATH}/shopcar/"+ del_idstr,
					 type:"DELETE",
					 success:function(result){
						 alert(result.msg);
						 //回到当前页面
						 to_page(currentPage);
					 }
				 	});
				 }
			 });
			 
			 
			 
		  	//点击结算按钮提交订单数据
			$(document).on("click",".edit_btn",function(){

				var carId = $(this).parents("tr").find("td:eq(1)").text();
				var loginname = $(this).parents("tr").find("td:eq(2)").text();
				var productName = $(this).parents("tr").find("td:eq(3)").text();
				var productPrice = $(this).parents("tr").find("td:eq(4)").text();
				var orderNum = $(this).parents("tr").find("td:eq(5)").text();
				var orderTotal = $(this).parents("tr").find("td:eq(6)").text();

				
					//2.发送ajax请求保存修改信息
					$.ajax({
						url:"${APP_PATH}/savemyorder",
						type:"POST",
						dataType:'json',
						data:{loginname:loginname,productName:productName,productPrice:productPrice
							,orderNum:orderNum,orderTotal:orderTotal},
						success:function(result){
							if(result.code == 100 ){
								//alert(result.msg);
								//产品添加成功后关闭模态框并挑转到最后一页显示数据
								$.ajax({
									
									url:"${APP_PATH}/shopcar/"+carId,
									type:"DELETE",
									success:function(result){
										alert(result.msg);
										to_page(currentPage);
									}
								});
							}else{
								//显示失败信息
								}	
							}
						
					});
					//发送ajax请求修改产品表库存信息
					   $.ajax({
						url:"${APP_PATH}/proNum",
						dataType:'json',
						type:"POST",
						data:{proNum:orderNum,proName:productName},		
						success:function(result){
							
						}
					 });  
				
				}); 
			 
		  	
			//点击结算选中 按钮批量结算
			  $("#shopcar_addall_modal_btn").click(function(){
				 
				  if($(".check_item:checked").length ==0 )
					 {
					 alert("没有选中！")
					 return false;
					 }
				 var carCheckedName = "";
				 var del_idstr = "";
				 var alltotal = 0;
				// alert(alltotal);
				 $.each($(".check_item:checked"),function(){
					 var orderTotal = $(this).parents("tr").find("td:eq(6)").text();
				//	 alert(orderTotal);	
					 del_idstr += $(this).parents("tr").find("td:eq(1)").text()+",";
				//	 alert(del_idstr);
				//	 alltotal = alltotal + ovderTotal;
				//	 alert(alltotal);
					 
				 });
				  del_idstr = del_idstr.substring(0,del_idstr.length-1);
				 /*$.ajax({
					 	url:"${APP_PATH}/shopcarnum",
						type:"GET",
						dataType:'json',
						data: {carIds:del_idstr},
						success:function(result){
							//alert(result.mag);
						    var alltotal = result.alltotal;	
						}
						
				 }); */
				// alert(alltotal);
				
				 if(confirm("确定全部结算吗【"+del_idstr+"】吗?")){
				 $.each($(".check_item:checked"),function(){
					var carId = $(this).parents("tr").find("td:eq(1)").text();
					var loginname = $(this).parents("tr").find("td:eq(2)").text();
					var productName = $(this).parents("tr").find("td:eq(3)").text();
					var productPrice = $(this).parents("tr").find("td:eq(4)").text();
					var orderNum = $(this).parents("tr").find("td:eq(5)").text();
					var orderTotal = $(this).parents("tr").find("td:eq(6)").text();

					
						//2.发送ajax请求保存修改信息
						$.ajax({
							url:"${APP_PATH}/savemyorder",
							type:"POST",
							dataType:'json',
							data:{loginname:loginname,productName:productName,productPrice:productPrice
								,orderNum:orderNum,orderTotal:orderTotal},
							success:function(result){
								if(result.code == 100 ){
									//alert(result.msg);
									//产品添加成功后关闭模态框并挑转到最后一页显示数据
									$.ajax({
										
										url:"${APP_PATH}/shopcar/"+carId,
										type:"DELETE",
										success:function(result){
											alert(result.msg);
											to_page(currentPage);
										}
									});
								}else{
									//显示失败信息
									}	
								}
							
						});
						//发送ajax请求修改产品表库存信息
						   $.ajax({
							url:"${APP_PATH}/proNum",
							dataType:'json',
							type:"POST",
							data:{proNum:orderNum,proName:productName},		
							success:function(result){
								
							}
						 });   
				 });
				 }
				 if(result.code == 100 ){
				 alert("添加成功");}else{
					 return false;
				 }
			});
						
		 //防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
		</script>
</body>
</html>