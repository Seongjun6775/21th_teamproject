<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/rv_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready (function() {
		
		$("#new_btn").click(function() {
			$.post("${context}/api/rv/create",		
					{
						rvId:$("#rvId").val(),			
						mbrId:$("#mbrId").val(),
						odrLstId:$("#odrLstId").val(),
						rvTtl:$("#rvTtl").val(),
						rvCntnt:$("#rvCntnt").val(),
						rvLkDslk:$("#rvLkDslk").val(),		
						
					}, function(response) {
						if (response.status == "200 OK") {
							location.href = "${context}" + response.redirectURL;
							alert("리뷰가 등록되었습니다.")
						}
						else {
							alert(response.errorCode + " / " + response.message);
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

			<div class="path">리뷰 > 리뷰관리 > 리뷰등록</div>

			<h1>새 리뷰 등록</h1>
			<div>
				<form id="create_form" method="post">
					<div class="create-group">
						<label for="odrLstId">주문서 ID</label> <input type="text" id="odrLstId"
							name="odrLstId" />
					</div>
					<div class="create-group">
						<label for="rvTtl">제목</label> <input type="text" id="rvTtl"
							name="rvTtl" 
							style="margin: 5px; width: 665px;"
							maxlength="50"
							placeholder="제목을 입력하세요(50자 제한)" />
					</div>
					<div class="create-group">
						<label for="rvCntnt">내용</label> <textarea id="rvCntnt"
							name="rvCntnt" 
							style="display: grid; margin: 5px; width: 700px; height: 400px; resize: none;"
							maxlength="1000"
							placeholder="내용을 입력하세요(1000자 제한)" ></textarea>
					</div>
					<div class="create-group">
						<label for="rvLkDslk">좋아요/싫어요</label> <select id="rvLkDslk"
							style="margin: 5px;"
							name="rvLkDslk">
							<option>선택</option>
							<option value="T">좋아요</option>
							<option value="F">싫어요</option>
						</select>
					</div>		
				</form>
				<div class="align-right">
					<button id="new_btn" class="btn-primary" >등록</button>
				</div>
				<jsp:include page="../include/footer.jsp" />
			</div>
		</div>
	</div>
</body>
</html>