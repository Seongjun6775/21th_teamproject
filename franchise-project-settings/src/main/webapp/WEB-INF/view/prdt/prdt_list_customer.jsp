<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	
})
</script>
</head>
<body>

	<div>
		<div>${prdtList}</div>
		<div>${prdtList}</div>
		<div>${prdtVO}</div>
		<div>${prdtVO}</div>
		<div>${srtList}</div>
	</div>
	
	<div>
		<c:choose>
			<c:when test="${not empty prdtList}">
				<c:forEach items="${prdtList}"
							var="prdt">
					<div class="prdt1">
						<div class="prdt2">${prdt.prdtFileId}</div>
						<div class="prdt3">
							<div class="flex">${prdt.prdtNm}</div>
							<div class="flex">${prdt.prdtPrc}</div>
						</div>
					</div>
				</c:forEach>
			</c:when>
		</c:choose>
	</div>
	
	


</body>
</html>