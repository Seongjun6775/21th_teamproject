<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 삭제</title>
</head>
<body>
	<form action="<c:url value='/ntc/delete/${NtcVO.ntcId}' />"
		method="post">
		<p>정말 삭제하시겠습니까?</p>
		<input type="submit" value="삭제완료">
	</form>
</body>
</html>