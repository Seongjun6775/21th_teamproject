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
<title>관리자 페이지입니다</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<link rel="stylesheet" href="${context}/css/str_common.css?p=${date}" />
	<script type="text/javascript">
$().ready(function() {
	$("#index_btn").click(function(){
		location.href= "${context}/index";
	});
});
	</script>
</head>
<jsp:include page="../include/openBody.jsp" />
			
			
			<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
				<button id="index_btn" class="btn-index">처음 페이지로 돌아가기</button>
			</div>
			<h1 style="margin:20px;">해당 페이지는 관리자 페이지입니다.</h1>
<jsp:include page="../include/closeBody.jsp" />
</html>