<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="./include/stylescript.jsp"/>
<link rel="stylesheet" href="${context}/css/ntc_common.css?p={date}"/> 
<title>Insert title here</title>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="./include/header.jsp"/>
		<div>
			<jsp:include page="./include/sidemenu.jsp"/>
			<jsp:include page="./include/content.jsp"/>
				인덱스 페이지입니다! <br>
			<jsp:include page="./include/footer.jsp"/>
		</div>
	</div>
</body>
</html>