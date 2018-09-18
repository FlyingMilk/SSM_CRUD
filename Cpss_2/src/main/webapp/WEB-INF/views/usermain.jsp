<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
    
    <%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>化工产品销售系统</title>

<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入JS项目插件 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/css/maincss.css"
	type="text/css">
	
<frameset rows="100,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="${APP_PATH}/top" name="title" scrolling="no" noresize="noresize" >
  <frameset cols="230,*" frameborder="no" border="0" framespacing="0">
    <frame src="${APP_PATH}/userleft" name="tree" scrolling="no" marginheight="0" marginwidth="0">
 	 <frame src="${APP_PATH}/product/selectMyProduct" name="main_right" scrolling="yes" frameborder="0" marginwidth="0" marginheight="0" noresize="noresize"> 
  </frameset>
</frameset> 
</head>
<body >
<script type="text/javascript">

	/* function show(){
	alert(123 );
}*/
</script>
</body>
</html>