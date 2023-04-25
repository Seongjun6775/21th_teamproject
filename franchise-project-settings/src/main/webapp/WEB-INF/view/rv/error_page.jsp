<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/rv_common.css?p=${date}" />
<script type="text/javascript">
	$().ready(function() {
		alert("권한이 없습니다.");
		location.href = "${context}/index";
	});
</script>
</head>
<body>
	Error Page
</body>
</html>