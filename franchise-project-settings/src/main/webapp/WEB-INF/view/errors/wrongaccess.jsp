<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$().ready(function() {
		
		alert("잘못된 접근입니다.");
		location.href="${context}/index";
		
	});

</script>
<jsp:include page="../include/stylescript.jsp" />
</head>
<jsp:include page="../include/openBody.jsp" />
			<!-- contents -->
      		<!-- /contents -->
<jsp:include page="../include/closeBody.jsp" />
</html>
