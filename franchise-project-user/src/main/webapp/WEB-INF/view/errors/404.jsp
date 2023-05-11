<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="3; url=${context}/">
<title>404에러입니다!</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<link rel="stylesheet" href="${context}/css/str_common.css?p=${date}" />
	<script type="text/javascript">
$().ready(function() {
	$("#index_btn").click(function(){
		location.href= "${context}/index";
	});
});
	</script>
<style>
	body{
		width:100%;
		height: auto;
	    background: url(${context}/img/404.png) no-repeat center;
	    background-size: cover;
	}
</style>
</head>
<body>
</body>
</html>