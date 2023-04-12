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
<script type="text/javascript">
	

	$().ready(function(){

		
		
		$("#new_btn").click(function(){
			var ajaxUtil = new AjaxUtil();
			ajaxUtil.upload("#create_form","${context}/api/mv/update",function(response){
				if(response.status == "200 OK"){
					location.href= "${context}" + response.redirectURL;
				}
				else if(response.errorCode =="500") {
					alert(response.message);	
				}
				else{
					alert("영화 등록에 실패 했습니다.");
				}
			},{"pstr": "uploadFile"});
			
		});
		
		$("del_btn").click(function(){
			
		})
		
	
	});
</script>
</head>
<body>
	<div class="main-layout">

		<div>
		
			   
			
			
				
				<h1>작성</h1>
				<div>
					<form id="create_form" enctype="multipart/form-data">
						
						<div class="create-group">
							<label for="mvTtl">제목</label>
							<input type="text" id="mvTtl" name="mvTtl" value="${mvVO.mvTtl}" />
						</div>
											
						
						<div class="create-group">
							<label for="smr">내용</label>
							<textarea  id="smr" name="smr">${mvVO.smr}</textarea>
						</div>
			
						
						<div class="create-group">
							<label for="useYn">공지여부</label>
							<input type="checkbox" id="useYn" name="useYn" value="Y" ${mvVO.useYn =='Y' ? 'checked' : ''}>
						</div>
	
						
					</form>
				
				<div class="align-right">
					<button id="new_btn" class="btn-primary">등록</button>
					<button><a href="${pageContext.request.contextPath}/mngrbrds">목록</a> </button> 
				</div>
				
		
			
		</div>
	</div>
	</div>
</body>
</html>