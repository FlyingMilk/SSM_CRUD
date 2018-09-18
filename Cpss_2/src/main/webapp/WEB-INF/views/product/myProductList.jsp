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
<link rel="stylesheet" href="${APP_PATH}/static/css/rightcss.css"
	type="text/css">
</head>
<body ondragstart="return false">

	<div class="container-fluid" id="right">

		<!-- 添加界面模态框 -->
		<div class="modal fade" id="shopcarAddModal" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">购物车添加界面</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<div class="form-group">
								<label for="loginame_add_input" class="col-sm-2 control-label">账号</label>
								<div class="col-sm-8">
									<input type="text" name="loginname" class="form-control"
										id="loginame_add_input" placeholder="账号" onfocus=this.blur()>
									<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="productName_add_input"
									class="col-sm-2 control-label">产品名称</label>
								<div class="col-sm-8">
									<input type="text" name="productName" class="form-control"
										id="productName_add_input" placeholder="产品名称"
										onfocus=this.blur()> <span id="helpBlock2"
										class="help-block"></span>
								</div>
							</div>

							<div class="form-group">
								<label for="productPrice_add_input"
									class="col-sm-2 control-label">价格</label>
								<div class="col-sm-8">
									<input type="text" name="productPrice" class="form-control"
										id="productPrice_add_input" placeholder="价格"
										onfocus=this.blur()> <span id="helpBlock2"
										class="help-block"></span>
								</div>
							</div>

							<div class="form-group">
								<label for="orderAdd_proNum" class="col-sm-2 control-label">库存</label>
								<div class="col-sm-8">
									<input class="form-control" id="orderAdd_proNum" type="text"
										onfocus=this.blur()>

								</div>
							</div>

							<div class="form-group">
								<label for="orderNum_add_input" class="col-sm-2 control-label">数量</label>
								<div class="col-sm-8">
									<input type="text" name="orderNum" class="form-control"
										id="orderNum_add_input" placeholder="数量"> <span
										id="helpBlock2" class="help-block"></span>
								</div>
							</div>

							<div class="form-group">
								<label for="orderTotal_add_input" class="col-sm-2 control-label">总价</label>
								<div class="col-sm-8">
									<input type="text" name="orderTotal" class="form-control"
										id="orderTotal_add_input" placeholder="总价" onfocus=this.blur()>
									<span id="helpBlock2" class="help-block"></span>
								</div>
							</div>

						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" id="order_save_btn">添加</button>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-10" name="main_right">
				<div class="panel panel-default">
					<div class="panel-heading">
						当前位置 &nbsp; &nbsp;> &nbsp; 产品信息 &nbsp;&nbsp;&nbsp; <span
							style="align: center">当前用户：</span>&nbsp; <span
							style="align: center" id="sessionspan">${sessionScope.seuser.loginname}</span>
						&nbsp;&nbsp;&nbsp;类型： <select id="select_type" select_type="no">
							<option value="productId">产品编号</option>
							<option value="productName">产品名称</option>
							<option value="productGenre">种类</option>
						</select>&nbsp;&nbsp;&nbsp; 
						内容：<input type="text" select_text="no" id="select_text">
						&nbsp;&nbsp;&nbsp;
						<button id="select_some" class="btn btn-info btn-sm" >查找</button>
						&nbsp;&nbsp;&nbsp;
						
						
						<div class="btn-group">
  							<button type="button"  id= "orderby_btn" order_by = "no" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
  							  按价格排序 <span class="caret"></span>
 							</button>
 							<ul class="dropdown-menu">
  								<li><a href="javascript:void(0)" id = "order_a_asc"onclick = "mypro_orderby(this)">按价格升序↑</a></li>
  								<li><a href="javascript:void(0)" id = "order_a_desc" onclick = "mypro_orderby(this)">按价格降序↓</a></li>
  								<li><a href="javascript:void(0)" id = "quxiao" onclick = "mypro_orderby(this)">取消排序</a></li>
 						 </ul>
						</div>
						
						<!-- 我的收藏 -->
							<button type="button"  id= "coll_btn" coll_by = "no" class="btn btn-default " > 我的收藏</button>

						<!-- <button class="btn btn-danger btn-sm" id="pro_delectall_modal_btn" style="float: right">删除选中</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-info btn-sm" id="pro_add_modal_btn" style="float: right">我的购物车</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->

					</div>
					<table class="table table-hover" id="products_table">
						<thead>
							<tr>
								<!-- 	<th>
									<input type="checkbox" id="check_all"/>
								</th> -->
								<th width="90px">产品编号</th>
								<th width="110px">产品名称</th>
								<th width="70px">价格</th>
								<th width="110px">种类</th>
								<th width="70px">数量</th>
								<th width="280px">描述</th>
								<th width="70px">收藏</th>
								<th width="120px">操作</th>
							</tr>
						</thead>
						<tbody>

						</tbody>

					</table>
				</div>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row" id="page_area" >
			<!-- 分页文字信息 -->
			 <div class="col-md-6 " id="page_info_area"></div>
			<!-- 分页条  -->
			<div class="col-md-4 col-md-offset-1" id="page_nav_area"></div>
		</div>
		
	
	</div>


	<script type="text/javascript">
	
		var currentPage; // 当前页数
		var num2=0;
		//获取session信息
 		var sesloginname = $("#sessionspan").text();
		if(sesloginname == ""){
			$("#sessionspan").text("未登录！");
		} 
		//1.页面加载完成后直接发送一个ajax请求，要到分页数据
		$(function(){
			//取出第一页
			var order_by = $("#orderby_btn").attr("order_by");
			var select_type = $("#select_type").attr("select_type");
			var select_text = $("#select_text").attr("select_text");
			var coll_flag = $("#coll_btn").attr("coll_by");
			if(coll_flag == "no"){
				var loginname = "no";
			}else{
				var loginname = sesloginname;
			}
			to_page(1,order_by,select_type,select_text,coll_flag,loginname);
		});
		
		function to_page(pn,order_by,select_type,select_text,coll_flag,loginname){		
			 $.ajax({
					url:"${APP_PATH}/products",
					dataType:'json',
					data:{pn:pn,order_by:order_by,select_type:select_type
						,select_text:select_text,coll_flag:coll_flag,loginname:loginname}, 
					type:"GET",
					success:function(result){
						
						//console.log(result);
						//1.解析并显示产品信息
						build_products_table(result);
						//2.解析并显示分页信息
						build_page_info(result);
						//3.解析并显示分页信息
						build_page_nav(result);
						
						if(result.extend.pageInfo.pageNum == 0){
							alert("没有找到,请重新查找..");
						}
					} 
				});
			 
			 setTimeout(function () { $("button[name ='edit1']").each(function(){
				 var productid = $(this).parents("tr").find("td:eq(0)").text();
				 
				 var defer = $.Deferred();   //创建一个新的 Deferred（延迟）对象
				 $.ajax({
						url:"${APP_PATH}/getallcoll",
						type:"GET",
						dataType:'json',
						async:false,
						data:{loginname:sesloginname,productId:productid},
						success:function(result){
							if(result.extend.num1==1){
								
								num2=1;
								/* alert($(this).parents("tr").find("td:eq(0)").text());
								alert(ssss);
								//$(this).parents("tr").find("td:eq(6)").children().removeClass("glyphicon glyphicon-star-empty");
								$(this).parents("tr").find("td:eq(6)").children().addClass("glyphicon glyphicon-star"); */
							}
							else{
								num2=0;
							}
						}
						});
				// setTimeout(function () {"num2="+num2},2000);
				 //alert("num2="+num2);
				 //alert(1);
				// setTimeout("function()",1000);
				//console.log("num2="+num2);
				//console.info(num2);
				 if(num2==1){
					 $(this).parents("tr").find("td:eq(6)").children().addClass("glyphicon glyphicon-star");
				 }if(num2==0){
					 $(this).parents("tr").find("td:eq(6)").children().addClass("glyphicon glyphicon-star-empty");
				 }
				 
				 }); 
			 }, 300);
			
		}
		//信息显示表格
		function build_products_table(result){
			//重置全选
			$("#check_all").prop("checked",false);
			var sesloginname = $("#sessionspan").text();
			//清空table
			$("#products_table tbody").empty();
			var products = result.extend.pageInfo.list;
			$.each(products,function(index,item){
			//	var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var prosIDTd = $("<td style='text-align:center;'></td>").append(item.productId);
				var prosNameTd = $("<td style='text-align:center;'></td>").append(item.productName);
				var prosPriceTd = $("<td style='text-align:center;'></td>").append(item.productPrice);
				var prosGenreTd = $("<td style='text-align:center;'></td>").append(item.productGenre);
				var prosNumTd = $("<td style='text-align:center;'></td>").append(item.productNum);
				var prosDescribeTd = $("<td></td>").append(item.productDescribe);
				
				//.addClass("glyphicon glyphicon-star-empty")
				var collspan = $("<span></span>");
				var collTd = $("<td class='coll_td' style='text-align:center;'></td>").append(collspan);
				
				
				var editBtn = $("<button name = 'edit1'></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("加入购物车");
				//为加入购物车按钮添加自定义的属性，来表示当前产品的ID
				
				editBtn.attr("edit-id",item.productId);
				var btnTd= $("<td></td>").append(editBtn);
				
				
				 $("<tr></tr>")
				 //.append(checkBoxTd)
				.append(prosIDTd)
				.append(prosNameTd)
				.append(prosPriceTd)
				.append(prosGenreTd)
				.append(prosNumTd)
				.append(prosDescribeTd)
				.append(collTd)
				.append(btnTd)
				.appendTo("#products_table tbody");
				 
				/*  $.ajax({
						url:"${APP_PATH}/getallcoll",
						type:"GET",
						dataType:'json',
						data:{loginname:sesloginname,productId:item.productId},
						success:function(result){
							if(result.extend.num1==1){
								alert(item.productId);
								//if(item.productId == $("'."+item.productId+"'").class())
							//	$("#collspan").addClass("glyphicon glyphicon-star");
								
							//	alert($("'#"+item.productId +"'"));
								//设置收藏
								//alert($("'#"+item.productId +"'").parents("tr").find("td:eq(6)").children().text());
								if($(".edit-id").attr("edit-id")==item.productId){
									alert("123")
								$(".edit-id").parents("tr").find("td:eq(6)").children().addClass("glyphicon glyphicon-star");
								}
									//	collspan.removeClass("glyphicon glyphicon-star-empty");
							//	collspan.addClass("glyphicon glyphicon-star");
								alert(4)
							}
							else{
								alert(3)
								
							//	var collspan = $("<span id='collspan'></span>").addClass("glyphicon glyphicon-star-empty");
							//	var collTd = $("<td id='coll_td' style='text-align:center;'></td>").append(collspan);
							}
							
						}
				 });    */
				
				
				 
				 
			});
		}
		//分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页, 总共"+result.extend.pageInfo.pages+"页, 共条"+result.extend.pageInfo.total+"记录");
			//记录当前页数
			currentPage = result.extend.pageInfo.pageNum;
		}
		//分页条
		function build_page_nav(result){
			
			$("#page_nav_area").empty();
			//获取排序条件
			var order_by = $("#orderby_btn").attr("order_by");
			
			//获取查询条件
			var select_type = $("#select_type").attr("select_type");
			var select_text = $("#select_text").attr("select_text");
			//获取收藏条件
			var coll_flag = $("#coll_btn").attr("coll_by");
			
			if(coll_flag == "no"){
				var loginname = "no";
			}else{
				var loginname = sesloginname;
			}
			
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
					to_page(1,order_by,select_type,select_text,coll_flag,loginname);
				})
				perPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1,order_by,select_type,select_text,coll_flag,loginname);
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
					to_page(result.extend.pageInfo.pageNum+1,order_by,select_type,select_text,coll_flag,loginname);
				})
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages,order_by,select_type,select_text,coll_flag,loginname);
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
					to_page(item,order_by,select_type,select_text,coll_flag,loginname);
				});
				ul.append(numLi);
			});
			//添加后一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle = $("<nav></nav>").append(ul);
			$("#page_nav_area").append(navEle);
		}
		
	
		
		//获取产品名称信息显示在添加模块下拉列表中
		function getproname(ele){
			//清空下拉列表中的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/Prosname",
				type:"GET",
				success:function(result){
					//console.log(result);
					//显示用户名称信息在下拉列表中
					//$("#proGenre_add_select").append("")
					$.each(result.extend.Pronps,function(){
						$(ele).val(this.productName);
					});
					
				}
			});
			
		}
		
		//根据商品价格数量动态生成总价   添加界面
		$("#orderNum_add_input").change(function(){
			 if(!validate_addorder_form()){
				return false;
			};  
			var Proprice = $("#productPrice_add_input").val();
			var Pronum = $("#orderNum_add_input").val();
			var orderTotal = Pronum * Proprice;
			$("#orderTotal_add_input").val(orderTotal);
		
		});
		//校验方法  检验添加界面的数量
		function validate_addorder_form(){
			//获得要校验的数据
			var orderNum = $("#orderNum_add_input").val();
			var pronum = $("#orderAdd_proNum").val();
			 var reg = /^[0-9]+.?[0-9]*$/;
			if(orderNum == ""|| !reg.test(orderNum)  || eval(orderNum) > eval(pronum)){
				showsave_validate_msg("#orderNum_add_input","error","数量不能为空必须是数字且要小于等于库存！");
				$("#orderTotal_add_input").val(0);
				return false;
			}else{
				showsave_validate_msg("#orderNum_add_input","success","");
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
		$(document).on("click",".edit_btn",function(){
			
			//清除表单数据和表单样式
			reset_form("#shopcarAddModal form");
			//获取session信息
			var sesloginname = $("#sessionspan").text();
			 if("未登录！" == sesloginname){
				 alert("当前未登录，请先登录！")
				 return false;
			 }
			$("#loginame_add_input").val(sesloginname);
			
			var proname = $(this).parents("tr").find("td:eq(1)").text();
			$("#productName_add_input").val(proname);
			
			var proprice = $(this).parents("tr").find("td:eq(2)").text();
			$("#productPrice_add_input").val(proprice);
			
			var pronum = $(this).parents("tr").find("td:eq(4)").text();
			$("#orderAdd_proNum").val(pronum);
			
			
			$("#shopcarAddModal").modal({
				backdrop:"static"
			});
		});
		
		 

		
		 
		 
		//清除表单数据和表单样式
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
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
				url:"${APP_PATH}/shopcar",
				type:"POST",
				data:$("#shopcarAddModal form").serialize(),
				success:function(result){
					
					if(result.code == 100 ){
						//alert(result.msg);
						//产品添加成功后关闭模态框并挑转到最后一页显示数据
						$("#shopcarAddModal").modal('hide');
					//	to_page(currentPage);
						alert("添加成功");
					}else{
						//显示失败信息
						 if(undefined != result.extend.errorFields.proName){
							showsave_validate_msg("#proName_add_input","error",result.extend.errorFields.proName); 
						}	
					}
				}
			});
		});
		
		
		//点击查询按钮查询数据   添加界面
		$("#select_some").click(function(){
			
			
			var select_type = $("#select_type").val();
			var select_text = $("#select_text").val();
			//点击查找时 分别给下拉列表框和文本框添加属性   保存查询条件 ，以便分页条跳转时使用
			$("#select_type").attr("select_type",select_type);
			$("#select_text").attr("select_text",select_text);
			//获取排序条件
			var order_by = $("#orderby_btn").attr("order_by");
			
			var coll_flag = $("#coll_btn").attr("coll_by");
			
			if(select_text== ""){
				alert("请输入查询内容！")
				$("#select_text").attr("select_text","no");
				return false;
			}
			if(select_type == "productId"){
				 var reg = /^[0-9]+.?[0-9]*$/;
				 if(!reg.test(select_text)){
					 alert("请输入正确类型的产品编号");
					 return false;
				 }
			}
			
			
			to_page(1,order_by,select_type,select_text,coll_flag,coll_flag)
			
			
		});
		 
	
		 
		//点击排序↓按钮，
		function mypro_orderby(ob){
			var select_type = $("#select_type").attr("select_type");
			var select_text = $("#select_text").attr("select_text");
			var coll_flag = $("#coll_btn").attr("coll_by");
			var id=$(ob).attr("id");   //获取事件源ID
			if("order_a_asc" == id){
				$("#orderby_btn").attr("order_by","ASC");  //为排序按钮添加排序属性
				$("#orderby_btn").text("按价格升序↑");
				$("#odeer_a_asc").text("按价格升序↑√");
				$("#quxiao").text("取消排序");
				$("#odeer_a_desc").text("按价格降序↓");
				var order_by = $("#orderby_btn").attr("order_by");
				to_page(1,order_by,select_type,select_text,coll_flag);
			}else if("order_a_desc" == id){
				$("#orderby_btn").attr("order_by","DESC");
				$("#orderby_btn").text("按价格降序↓");
				$("#odeer_a_desc").text("按价格降序↓√");
				$("#quxiao").text("取消排序");
				$("#odeer_a_asc").text("按价格升序↑");
				var order_by = $("#orderby_btn").attr("order_by");
				to_page(1,order_by,select_type,select_text,coll_flag);
			} else{
				$("#orderby_btn").attr("order_by","no");
				$("#orderby_btn").text("按价格排序");
				$("#odeer_a_desc").text("按价格降序");
				$("#odeer_a_asc").text("按价格升序");
				$("#quxiao").text("取消排序√");
				var order_by = $("#orderby_btn").attr("order_by");
				to_page(1,order_by,select_type,select_text,coll_flag);
			} 
			
		}
		
		//点击收藏
		$(document).on("click",".coll_td",function(){
			var sesloginname = $("#sessionspan").text();
			 if("未登录！" == sesloginname){
				 alert("当前未登录，请先登录！")
				 return false;
			 }
			 var product_id = $(this).parent("tr").find("td:eq(0)").text();
			var product_Name = $(this).parent("tr").find("td:eq(1)").text();
		
			if($(this).children().hasClass("glyphicon glyphicon-star-empty")){
				
				$(this).children().removeClass("glyphicon glyphicon-star-empty");
				$(this).children().addClass("glyphicon glyphicon-star");
				//发送Ajax请求添加收藏
				 $.ajax({
						url:"${APP_PATH}/coll",
						type:"POST",
						dataType:'json',
						data:{loginname:sesloginname,productId:product_id
							,productName:product_Name,collFlag:"1"},
						success:function(result){
						},
						fail:function(result){
							result.msg();
						}
				 });
			}
			else{
				//发送Ajax请求删除收藏
	
				 $.ajax({
						url:"${APP_PATH}/deletecoll",
						type:"GET",
						dataType:'json',
						data:{loginname:sesloginname,productId:product_id},
						success:function(result){
							
						}
				 });
				
				
				$(this).children().removeClass("glyphicon glyphicon-star");
				$(this).children().addClass("glyphicon glyphicon-star-empty");
				
			}
		});
		
		$("#coll_btn").click(function(){
			var sesloginname = $("#sessionspan").text();
			 if("未登录！" == sesloginname){
				 alert("当前未登录，请先登录！")
				 return false;
			 }
			 
			var select_type = $("#select_type").attr("select_type");
			var select_text = $("#select_text").attr("select_text");
			var coll_flag = $("#coll_btn").attr("coll_by");
			var order_by = $("#orderby_btn").attr("order_by");
			if(coll_flag == "no"){
				var loginname = sesloginname;
				$(this).attr("coll_by","ok");
				to_page(1,order_by,select_type,select_text,"ok",loginname);
				
			}else{
				var loginname = "no";
				$(this).attr("coll_by","no");
				to_page(1,order_by,select_type,select_text,"no",loginname);
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