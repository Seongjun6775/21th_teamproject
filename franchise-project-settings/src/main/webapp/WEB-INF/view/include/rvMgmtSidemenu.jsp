<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<div class="side-menu inline bg-black">
	<ul class="menu-list">
		<li class="menu-item active-item">							
			<a href="${context}/rv/list">전체 리뷰</a>							
		</li>
		<li class="menu-item">
			<c:choose>
				<c:when test="${sessionScope.__MBR__.mbrLvl == '001-02' || sessionScope.__MBR__.mbrLvl == '001-03'}">
					<a href="${context}/rv/list/store">내 매장 리뷰</a>
				</c:when>
			</c:choose>
		</li>			
	</ul>
</div>