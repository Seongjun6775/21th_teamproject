<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>  
<div class="side-menu inline bg-black">
	<ul class="menu-list">
		<li class="menu-item active-item" >
			<a href ="${context}/ntc/list">공지 관리</a>
		</li>
		<li class="menu-item" >제목 관리</li>
		<li class="menu-item" >내용 관리</li>
	</ul>
</div>