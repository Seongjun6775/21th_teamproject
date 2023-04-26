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
<jsp:include page="../include/stylescript.jsp" />
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<!-- 조회영역 -->
			<div class="grid">
				<div class="detail-header">
					<h1>직원 조회</h1>
				</div>
				<div class="detail-content">
					<div class="content-block">
						<div class="content-subject">
							<h1>아이디</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrId}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>이름</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrNm}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>이메일</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>소속</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>등급</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>이력서</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>최근 로그인</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>차단 여부</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>가입일?</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>