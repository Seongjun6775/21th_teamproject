<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<div class="side-menu inline bg-black">
	<ul class="menu-list">
		<li class="menu-item active-item"><a href="${context}/evnt/create">등록</a></li>
		<li class="menu-item"><a href="${context}/evnt/list">조회</a></li>
	</ul>
</div>
