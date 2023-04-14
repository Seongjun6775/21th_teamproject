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
		$("#fix_btn").click(function(){
			//수정
			$.post("${context}/api/mngrbrd/update/${mngrBrd.mngrBrdId}",$("#create_form").serialize()
					,function(response){
				if(response.status =="200 OK"){
					var url= '${context}/mngrbrd/${mngrBrd.mngrBrdId}'
					//console.log(url);
					location.replace(url);
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
			<button><a href="${context}/mngrbrd/list" >목록</a ></button>
				<h1>조회</h1>
				<div>
					<form id="create_form" >
					
						
						<div class="create-group">
							<label for="mngrBrdTtl">제목 ${mngrBrd.mngrBrdTtl}</label>
							<input type="text" id="mngrBrdTtl" name="mngrBrdTtl"  value="${mngrBrd.mngrBrdTtl} " />
						</div>
								
						<div class="create-group">
							<label for="mbrId">매니저</label>
							<input type="text" id="mngrId" name="mngrId"  value="${mngrBrd.mngrId}" />
						</div>			
						
						<div class="create-group">
							<label for="mngrBrdCntnt">내용</label>
							<textarea  id="mngrBrdCntnt" name="mngrBrdCntnt" >${mngrBrd.mngrBrdCntnt}</textarea>
					
						</div>
						
						<div class="create-group">
							<label for="useYn">게시여부</label>
							<input type="checkbox" id="useYn" name="useYn"  value="Y" ${mngrBrd.useYn =='Y' ? 'checked' : ''}/>
						</div>
						
						<div class="create-group">
							<label for="ntcYn">공지여부</label>
							<input type="checkbox" id="ntcYn" name="ntcYn" value="Y" ${mngrBrd.ntcYn =='Y' ? 'checked' : ''} />
						</div>
	
						
					</form>
				
				
					
					<div>
						<button id="fix_btn" >수정</button>
						<button><a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}" style="text-decoration: none;">취소</a></button>			
					</div> 				
					
				</div>
				
		
			
		</div>
	</div>
	</div>
</body>
</html>