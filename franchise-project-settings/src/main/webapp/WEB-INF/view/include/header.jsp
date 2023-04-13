<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<div class="header bg-black">
	<ul class="nav">
		<li class="nav-item active">
			<a href="#">회원관리</a>
		</li>
		<li class="nav-item">
			<a href="#">메뉴관리</a>
		</li>
		<li class="nav-item">
			<a href="#">매장관리</a>
		</li>
		<li class="nav-item">
			<a href="#">이벤트관리</a>
		</li>
		<li class="nav-item">
			<a href="#">채용 관리</a>
		</li>
		<li class="nav-item">
			<a href="#">리뷰관리</a>
		</li>
		<li class="nav-item">
			<a href="#">댓글관리</a>
		</li>
		<li class="nav-item">
			<a href="#">관리자게시판</a>
		</li>
		<li class="nav-item">
			<a href="#">고객센터</a>	
		</li>
	</ul>
	<!--TODO 로그아웃 주소 추가 -->
	<div class="inline profile">이름 <a href="${context}/logout">(Logout)</a></div>
</div>