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
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		
		$("#new_btn").click(function(){	
			$.post("${context}/api/hlpdsk/write", $("#create_form").serialize(),function(response){
				if(response.status =="200 OK"){
					var url= '${context}/hlpdsk/list'
						//console.log(url);
						location.replace(url);
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
	<jsp:include page="../include/header.jsp" />
		<div>
		<jsp:include page="../include/sidemenu.jsp" />
		<jsp:include page="../include/content.jsp" />
			<div>
			<!-- 상세화면 헤더 -->
				<div class="header-option-bar">
					<div class="header-option-right">
						<div class="article-action">						
							<a href="${context}/hlpdsk/list" class="btn-m" style="text-decoration: none;">목록</a> 
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
							<div class=" col-sm-3 col-xs-4"> 
								<select id="hlpDskSbjct" class="input-text" style="width: 20%;">
									<option>문의/건의</option>
									<option value="문의하기">문의하기</option>				
									<option value="건의하기">건의하기</option>
								</select> 
							</div>
						</div>	
						<div class="create-group">
							<label for="mngrBrdTtl" class="label">제목</label> 
							<input type="text" id="mngrBrdTtl" name="mngrBrdTtl" placeholder="제목을 입력해주세요." value="${hlpDsk.mngrBrdTtl}" />
						</div>
					
						
						<div class="create-group">
							<label for="mngrBrdCntnt" class="label">본문</label> 
							<textarea  id="mngrBrdCntnt" name="mngrBrdCntnt" placeholder="내용을 입력해주세요." >${hlpDsk.mngrBrdCntnt}</textarea>
						</div>
					</form>	
					<div style="padding: 10px;text-align: right;"> 
						<button id="new_btn" class="blue-btn">등록</button>
					</div> 					
				</div>
			</div>			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>