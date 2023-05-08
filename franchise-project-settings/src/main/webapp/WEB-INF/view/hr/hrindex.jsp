<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">



</script>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">인재채용
			<div style="color: #ccc; padding-top: 10px;"></div>
		</div>
		<div class="overlay absolute"></div>
	</div>
	
	<div class="carousel-inner" style="height: 1200px;">
		<div style="background-color: #ccc; height: 250px; display: flex;align-items: center;">
			<p style="margin: 0 auto; color: #fff; font-weight: bold; font-size: 20px;">변화를 만나는 곳, 변화를 만드는 곳<br>프랜차이즈의 최신 채용정보를 확인하세요. </p>
		</div>
		<div style="margin: 80px; height: 100%; text-align:center;">
			<div style="float: left; width: 50%; height: 900px;">
				<img alt="즐거워하는 직원 사진" src="${context}/img/직원.jpg" style="border-radius: 15px; width: 600px; height: 600px;">
				<p style="margin: 0 auto; margin-top: 15px; color: #666; font-weight: bold;">
					프랜차이즈의 맛과 서비스의 팬이신 분,
					<br>
					프랜차이즈와 함께 성장해 나가실 분들을 찾습니다.
					<br>
					지금 프랜차이즈에서 여러분의 열정을 펼쳐보세요!
				</p>
				<div style="margin-top: 50px;">
					<a href="${context}/hr/list" style="background-color: #ffbe2e; border-radius: 35px;
														font-size: 20px; padding: 30px; font-weight: bold; color: #FFF;">
						매장 점원 지원
					</a>
				</div>
			</div>
			<div style="float: left; width: 50%; height: 900px;">
				<img alt="매장 사진" src="${context}/img/가게.jpeg" style="border-radius: 15px; width: 600px; height: 600px;">
				<p style="margin: 0 auto; margin-top: 15px; color: #666; font-weight: bold;">
					뜨거운 열정과 강한 의지로 새로운 성공 신화를 만들어갈
					<br>
					프랜차이즈의 새로운 사업 파트너를 모시고 있습니다.
					<br>
					프랜차이즈와 함께 당신의 소중한 꿈을 이뤄보세요!
				</p>
				<div style="margin-top: 50px;">
					<a href="${context}/hr/list" style="background-color: #ffbe2e; border-radius: 35px;
														font-size: 20px; padding: 30px; font-weight: bold; color: #FFF;">
						가맹점주 지원
					</a>
				</div>
			</div>
		</div>
		
	</div>

	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>