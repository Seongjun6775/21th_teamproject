<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<h1>${topic.subject}</h1>
	
	<div>
		${topic.memberVO.name} (${topic.memberVO.email})
	</div>
	
	<div>
		작성일: ${topic.crtDt} 
		/수정일: ${topic.mdfyDt}
		
	</div>
	<div>
		첨부파일: <a href= "${pageContext.request.contextPath}/mngrbrd/download/${topic.id}"> ${topic.originFileName}</a>
	</div>
	
	<div>
		${topic.content}
	</div>
	
	<hr/>
	
	<form action="${pageContext.request.contextPath}/topic/reply/create" method="post">
		<input type = "hidden" name ="topicId" value="${topic.id}"/>
		<input type = "hidden" name ="prntReplyId" value="0"/>
	
		
		<div>
			<label for="reply"> 댓글 내용</label>
			<textarea name="reply" id="reply"></textarea>
		</div>
		
		<div>
			<input type = "submit" value="등록" />
		</div>
	</form>
	
	<hr/>
	<ul>
		<c:forEach items="${topic.replyList}" var="reply">
			<li style="margin-left: ${reply.depth * 30}px">${reply.reply}</li>
		</c:forEach>
	</ul>

	
	<hr/>
	<a href="${pageContext.request.contextPath}/topics">목록</a>
	<a href="${pageContext.request.contextPath}/topic/update/${topic.id}">수정</a> 
	<a href="${pageContext.request.contextPath}/topic/delete/${topic.id}">삭제</a>

</body>
</html>