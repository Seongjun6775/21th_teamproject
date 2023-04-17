<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<c:url value='/ntc/insert' />" method="post">
		<label for="title">제목</label> <input type="text" name="ntcTtl"
			id="ntcTtl" required> 
			<label for="content">내용</label>
		<textarea name="ntcCntnt" id="ntcCntnt" required></textarea>
		<label for="isNew">새글 표시</label> 
		<input type="checkbox" name="isNew"
			id="isNew" value="true"> 
			<input type="submit" value="등록">
	</form>
</body>
</html>