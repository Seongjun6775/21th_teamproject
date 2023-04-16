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
				else if (response.status =="400"){
					//파라미터를 전달하지 않은 경우
					console.log(response.message);
					alert(response.message);
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
		<!-- 상세화면 헤더 -->
			<div class="header-option-bar">
				<div class="header-option-right">
					<div class="article-action">						
						<a href="${context}/mngrbrd/list" class="btn-m" style="text-decoration: none;">목록</a> 
					</div>
				</div>
			</div>
		</div>
		<!-- //상세화면 헤더 -->
		<div>
			<div class="list-title "> 작성 </div>
			<div>
				<form id="create_form" >
					<div class="header-option-right">
						<div class="create-group" style="display: inline-block;">		
							게시여부<input type="checkbox" id="useYn" name="useYn"  value="Y" ${mngrBrd.useYn =='Y' ? 'checked' : ''}/>
						</div>
						<div class="create-group" style="display: inline-block;">
							공지여부<input type="checkbox" id="ntcYn" name="ntcYn" value="Y" ${mngrBrd.ntcYn =='Y' ? 'checked' : ''} />
						</div>
					</div>	
					
					<div class="create-group">
						<label for="mngrBrdTtl" class="label">제목</label> 
						<input type="text" id="mngrBrdTtl" name="mngrBrdTtl" placeholder="제목을 입력해주세요." value="${mngrBrd.mngrBrdTtl}" />
					</div>
							
					<div  class="create-group"> 
						<label for="mngrId" class="label">사용자</label> 
						<input type="text" id="mngrId" name="mngrId"  placeholder="Admin / session 받으면 삭제"  value="${mngrBrd.mngrId}" />
					</div>			
					
					<div class="create-group">
						<label for="mngrBrdCntnt" class="label">본문</label> 
						<textarea  id="mngrBrdCntnt" name="mngrBrdCntnt" placeholder="내용을 입력해주세요." >${mngrBrd.mngrBrdCntnt}</textarea>
					</div>
				</form>	
				<div style="padding: 10px;text-align: right;"> 
					<button id="new_btn" class="blue-btn">등록</button>
				</div> 					
			</div>
		</div>
	</div>
</body>
</html>