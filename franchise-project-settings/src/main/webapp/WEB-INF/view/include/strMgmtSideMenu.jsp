<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<div class="side-menu inline bg-black">
	<ul class="menu-list">
		<li class="menu-item active-item">
			<c:choose>
				<c:when test ="${sessionScope.__MBR__.mbrLvl eq '001-01'}">
					<a href="${context}/str/list">전국매장 조회</a>
				</c:when>
				<c:otherwise>
					<a href="${context}/str/list">매장 조회</a>
				</c:otherwise>
			</c:choose>
		</li>
		<li class="menu-item">
			<a href="${context}/str/odrlst">주문 관리</a>
		</li>
		<li class="menu-item">
			<a href="${context}/str/completeOdr">처리 주문 조회</a>
		</li>
		<li class="menu-item">
			<!-- <a href="#">채용관리</a> -->
		</li>
		<li class="menu-item">
			
		</li>
	</ul>
</div>