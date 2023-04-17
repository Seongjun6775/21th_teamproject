<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 수정</title>
</head>
<body>
	<form action="<c:url value='/ntc/update'/>"
		method="post">
		<label for="title">공지 제목</label> 
		<input type="text" name="ntcTtl"
			id="ntcTtl" value="${NtcVO.ntcTtl}" required> 
			<label for="content">공지내용</label>
		<textarea name="ntcCntnt" id="ntcCntnt" required>${NtcVO.ntcCntnt}</textarea>
		<input type="submit" value="수정완료">
	</form>
</body>
</html>