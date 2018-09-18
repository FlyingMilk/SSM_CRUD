<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- web路径
	不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
	以/开始的相对路径，。找资源，以服务器的路径为基准(http:localhost:8080)需要加上项目名
	http:localhost:8080/cpss_2

 -->
<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入JS项目插件 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">


</script>
</head>
<body>
	<!-- 搭建显示页面  -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>化工产品</h1>	
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">添加</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">		
			<table class="table table-hover">
				<tr>
					<th>id</th>
					<th>name</th>
					<th>price</th>
					<th>genre</th>
					<th>num</th>
					<th>describe</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${pageInfo.list}" var="product">
					<tr>
					<td>${product.productId}</td>
					<td>${product.productName}</td>
					<td>${product.productPrice}</td>
					<td>${product.productGenre}</td>
					<td>${product.productNum}</td>
					<td>${product.productDescribe}</td>
					<td>
						<button class="btn btn-primary btn-sm">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
						<button class="btn btn-danger btn-sm">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除</button>
					</td>
				</tr>
				</c:forEach>
				
				
			</table>	
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum}页, 总共${pageInfo.pages}页, 共${pageInfo.total}条记录
			</div>	
			<!-- 分页条  -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH}/products?pn=1">首页</a></li>
					<c:if test="${pageInfo.hasPreviousPage}">
						<li><a href="${APP_PATH}/products?pn=${pageInfo.pageNum-1}" aria-label="Previous"> 
						<span aria-hidden="true">&laquo;</span>
					</a></li>
					</c:if>
					
					
					<c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
						<c:if test="${page_Num == pageInfo.pageNum}">
							<li class="active"><a href="#">${page_Num}</a></li>
						</c:if>
						<c:if test="${page_Num != pageInfo.pageNum}">
							<li><a href="${APP_PATH}/products?pn=${page_Num}">${page_Num}</a></li>
						</c:if>
						
					</c:forEach>
					<c:if test="${pageInfo.hasNextPage}">
						<li><a href="${APP_PATH}/products?pn=${pageInfo.pageNum+1}" aria-label="Next"> 
						<span aria-hidden="true">&raquo;</span>
					</a></li>
					</c:if>
					
					<li><a href="${APP_PATH}/products?pn=${pageInfo.pages}">末页</a></li>
					
				</ul>
				</nav>
			</div>

		</div>
	</div>
	
	
</body>
</html>