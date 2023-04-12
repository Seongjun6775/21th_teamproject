<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		$("#new_btn").click(function(){
			console.log("!!");
			
			$.post("${context}/api/mngrbrd/write", $("#create_form").serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
	    
		});

		
	
	});
</script>
</head>
<body>
	<div class="main-layout">

		<div>
		
				
				<h1>작성</h1>
				<div>
					<form id="create_form" >
					
						
						<div class="create-group">
							<label for="mngrBrdTtl">제목</label>
							<input type="text" id="mngrBrdTtl" name="mngrBrdTtl"  />
						</div>
								
						<div class="create-group">
							<label for="mbrId">매니저</label>
							<input type="text" id="mngrId" name="mngrId"  />
						</div>			
						
						<div class="create-group">
							<label for="mngrBrdCntnt">내용</label>
							<textarea  id="mngrBrdCntnt" name="mngrBrdCntnt"></textarea>
					
						</div>
						
						<div class="create-group">
							<label for="useYn">게시여부</label>
							<input type="checkbox" id="useYn" name="useYn"  value="Y" />
						</div>
						
						<div class="create-group">
							<label for="ntcYn">공지여부</label>
							<input type="checkbox" id="ntcYn" name="ntcYn" value="Y" />
						</div>
	
						
					</form>
				
				
					
					<div>
						<button id="new_btn" class="btn-primary">등록</button>
					</div>
					<button><a href="${context}/mngrbrds">목록</a> </button> 
				</div>
				
		
			
		</div>
	</div>
	</div>
</body>
</html>