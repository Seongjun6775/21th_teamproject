<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<div class="side-menu inline bg-black">
	<ul class="menu-list">
		<li class="menu-item active-item">
			<a href="${context}/mbr/list">회원목록 조회</a>
		</li>
		<li class="menu-item">
			<a href="${context}/mbr/admin/list">권한/소속 변경</a>
		</li>
		<li class="menu-item">
			<a href="#">채용관리</a>
		</li>
		<li class="menu-item">abc</li>
	</ul>
</div>