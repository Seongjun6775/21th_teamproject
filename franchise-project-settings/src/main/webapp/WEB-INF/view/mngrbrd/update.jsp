<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<form action="${pageContext.request.contextPath}/mngrbrd/update/${topic.id}" method="post">	
	
		<div>
			<label for="subject">제목</label>
			<input type="text" 
				   name="subject" 
				   id="subject" 
				   value="${topic.subject}"
				   placeholder="제목입력" />
		</div>
		
		<div>	
			<label for="content">내용</label>
			<textarea name="content" 
					  id="content"
					  placeholder="내용">${topic.content}</textarea>
		</div>
		
		<div>
			<input type="submit" value="수정" />
		</div>
		
	</form>
	

</body>
</html>