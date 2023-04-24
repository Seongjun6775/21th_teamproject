<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/rv_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#delete_btn").click(function(){
		
			if(confirm("정말 삭제하시겠습니까?")) {
				$.post("${context}/api/rv/delete/${rvDetail.rvId}", function(response){
					if(response.status == "200 OK"){
						location.href = "${context}/rv/list" + response.redirectURL;
						alert("리뷰가 삭제되었습니다.")
					}else{
						alert(response.errorCode + "권한이 없습니다." + response.message);
					}
				})
			}
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
			
			<div class="path"> 리뷰 > 리뷰목록 > 리뷰상세</div>	
													
				<div>
					<form id="detail_form" method="post">
						<div class="detail-group-inline">
							<label for="rvId">리뷰 ID</label>
							<input type="text" id="rvId" name="rvId" disabled value="${rvDetail.rvId}">
						</div>
						<div class="detail-group-inline">
							<label for="mbrId">회원 ID</label>
							<input type="text" id="mbrId" name="mbrId" disabled value="${rvDetail.mbrId}">
						</div>
						<div class="detail-group-inline">
							<label for="strNm">매장명</label>
							<input type="text" id="strNm" name="strNm" disabled value="${rvDetail.strVO.strNm}">
						</div>
						<div class="detail-group-inline">
							<label for="odrLstId">주문서 ID</label>
							<input type="text" id="odrLstId" name="odrLstId" disabled value="${rvDetail.odrLstId}">
						</div>
						<div class="detail-group-inline">
							<label for="rvTtl">제목</label>
							<input type="text" id="rvTtl" name="rvTtl" 
								   style="width: 665px;"
								   disabled value="${rvDetail.rvTtl}">
						</div>
						<div class="detail-group-inline">
							<label for="rvCntnt">내용</label>
							<div id="rvCntnt" 
								 style="display: grid; 
								   		margin: 3px; 
								   		width: 700px; 
								   		height: 400px; 
								   		resize: none; 
								   		border: none; 
								   		background-color: #3331; 
								   		white-space: pre-wrap;">${rvDetail.rvCntnt}</div>
						</div>
						<div class="detail-group-inline">
							<label for="rvLkDslk">좋아요/싫어요</label>
							<input type="text" id="rvLkDslk" name="rvLkDslk" disabled value="${rvDetail.rvLkDslk}">
						</div>
						<div class="detail-group-inline" style= "display: inline-flex;">
							<label for="rvRgstDt">등록일</label>
							<input type="text" id="rvRgstDt" name="rvRgstDt"								    
								   disabled value="${rvDetail.rvRgstDt}">
						</div>
						<div class="detail-group-inline" style= "display: inline-flex;">
							<label for="mdfyDt">수정일</label>
							<input type="text" id="mdfyDt" name="mdfyDt"								   
								   disabled value="${rvDetail.mdfyDt}">
						</div>
					</form>
				</div>
			<div class="align-right">
				<button id="delete_btn" class="btn-delete">삭제</button>
			</div>
				
		</div> 
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>