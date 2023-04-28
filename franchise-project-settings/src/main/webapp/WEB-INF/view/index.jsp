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
<jsp:include page="./include/stylescript.jsp" />
</head>
<body class="bg-dark bg-opacity-10 ">
<jsp:include page="./include/logo.jsp" />
<main class="d-flex flex-nowrap ">	
		<jsp:include page="./include/sidemenu.jsp" />
		<div style="margin:0px 0px 0px 250px; width: 100%;">
			<jsp:include page="./include/header.jsp" />
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">기본페이지</span>
		    </div>
		    
		    <!-- contents -->
		    <div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">
		    	<h3>기본 페이지 </h3>
		    </div>
      		<!-- /contents -->
		</div>
	</main>

</body>
</html>
