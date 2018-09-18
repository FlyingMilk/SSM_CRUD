<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>化工产品销售系统管理员界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- web路径
	不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
	以/开始的相对路径，。找资源，以服务器的路径为基准(http:localhost:8080)需要加上项目名
	http:localhost:8080/cpss_2

 -->
<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入JS项目插件 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/css/maincss.css"
	type="text/css">
<frameset rows="100,*" cols="*" name="main" frameborder="no" border="0" framespacing="0">
  <frame src="${APP_PATH}/top" name="title" scrolling="no" noresize="noresize" >
 <frameset cols="230,*" frameborder="no" border="0" framespacing="0">
    <frame src="${APP_PATH}/left" name="tree" scrolling="no" marginheight="0" marginwidth="0">
    <frame src="${APP_PATH}/product/selectProduct" name="main_right" scrolling="yes" frameborder="0" marginwidth="0" marginheight="0" noresize="noresize">
  </frameset>
</frameset> 
</head>
<body>     
 
        //防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    </script>
</body>
</html>