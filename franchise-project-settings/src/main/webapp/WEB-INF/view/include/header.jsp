<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<style type="text/css">


</style>
<div class="header bg-black">
	<ul class="nav">
		<li class="nav-item active"><a href="${context}/미구현페이지">회원</a></li>
		<li class="nav-item"><a href="${context}/미구현페이지">매장</a></li>
		<li class="nav-item"><a href="${context}/prdt/list">메뉴</a></li>
	</ul>
	<div id="login_info" class="inline profile">
		<div>
			<span id="userName">${sessionScope.__ADMIN__.mbrNm}(${sessionScope.__ADMIN__.mbrId})</span>님 반갑습니다! 
		</div>
		<div id="logout">
			( <a href="${context}/mbr/logout">logout</a> )
		</div>
	</div>
</div>