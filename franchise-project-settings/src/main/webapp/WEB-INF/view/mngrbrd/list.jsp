<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
	});
</script>
</head>
<body>
	<h1>게시판</h1>
	
	<!-- 한 칸에 한 정보만 -> table / 한 칸에 여러 정보 -> ul -->
	<div>총 ${mngrBrdList.size()}건</div>
	<div>
		<table>
			<thead>
				<tr>
					<th>글번호</th>
					<th>카테고리</th>					
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정자</th>
					<th>수정일</th>
					<th>사용여부</th>
						
				</tr>
			</thead>
			<tbody>
				<c:choose>					
					<c:when test="${not empty mngrBrdList}">
						<c:forEach items="${mngrBrdList}" var="MngrBrd">
							<tr 
							>
								<td>${MngrBrd.mngrBrdId}</td>
								<td>${MngrBrd.ntcYn}</td>
								<td>
									<a href="${context}/mngrbrd/${MngrBrd.mngrBrdId}">
										${topic.subject} (${mngrBrdList.rplList.size()})
									</a>
								</td>
								<td>${MngrBrd.mbrVO.nm}</td>
								<td>${MngrBrd.mngrBrdWrtDt}</td>
								<td>${MngrBrd.mdfyr}</td>
								<td>${MngrBrd.mdfyDt}</td>
								<td>${MngrBrd.useYn}</td>
								
								
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="8">
							
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	
	
	
	
	
	
	<div>
		<a href="${pageContext.request.contextPath}/mngrbrd/write">토픽 작성</a>
	</div>

</body>
</html>