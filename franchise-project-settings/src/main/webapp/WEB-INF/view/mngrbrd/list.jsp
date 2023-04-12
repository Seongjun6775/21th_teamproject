<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css"/>
<script type="text/javascript" src= "${pageContext.request.contextPath}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function(){

	});
</script>
</head>
<body>

	
	
	<h1>게시판</h1>
	
	<div> 총 ${mngrBrdList.size()}건</div>
	
	<div>
		<table>
			<thead>
				<tr>
					<th>글번호</th>
					<th>카테고리</th>					
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>

				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty mngrBrdList}" >
						<c:forEach items= "${mngrBrdList}" var="mngrBrd">
							<tr>
								<td>${mngrBrd.id}</td>
								<td>
								
								</td>
								<td>${mngrBrd.mbrVO.nm}</td>
								<td>${mngrBrd.crtDt}</td>
								
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="3">
								
							</td>
						</tr>
					</c:otherwise>
				
				</c:choose>
			</tbody>	
		</table>
</div>


<%-- 	<c:choose>
		<c:when test="${not empty topicList}">
			<c:forEach items="${topicList}" var="topic" >
					${topic.id} <br/>
					${topic.subject} <br/>
					${topic.content} <br/>
					${topic.email} <br/>
					${topic.crtDt} <br/>
					${topic.mdfyDt} <br/>
					${topic.fileName} <br/>
					${topic.originFileName} <br/>
					${topic.memberVO.name} <br/>
					<hr/>
		</c:forEach>
		</c:when>
		<c:otherwise>
			등록된 토픽이 없습니다. 첫 번째 토픽의 주인공이 되어보세요!
		</c:otherwise>
	</c:choose> --%>
	
	
	


	
	
	<a href="${pageContext.request.contextPath}/mngrbrd/write">작성</a>
	
	

</body>
</html>