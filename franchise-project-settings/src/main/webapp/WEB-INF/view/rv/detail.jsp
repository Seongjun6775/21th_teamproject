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
<link rel="stylesheet" href="${context}/css/rv_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">



</script>
</head>
<body>

	<div class="main-layout">
	<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			
			<div class="path"> 리뷰 > 리뷰목록 > 리뷰상세</div>	
			
				<h1>상세 리뷰</h1>	
					
								
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
							<label for="odrDtlId">주문 상세 ID</label>
							<input type="text" id="odrDtlId" name="odrDtlId" disabled value="${rvDetail.odrDtlId}">
						</div>
						<div class="detail-group-inline">
							<label for="rvTtl">제목</label>
							<input type="text" id="rvTtl" name="rvTtl" disabled value="${rvDetail.rvTtl}">
						</div>
						<div class="detail-group-inline">
							<label for="rvCntnt">내용</label>
							<input type="text" id="rvCntnt" name="rvCntnt" 
								   style="display: grid; margin: 5px; width: 700px; height: 500px; resize: none;"
								   disabled value="${rvDetail.rvCntnt}">
						</div>
						<div class="detail-group-inline">
							<label for="rvLkDslk">좋아요/싫어요</label>
							<input type="text" id="rvLkDslk" name="rvLkDslk" disabled value="${rvDetail.rvLkDslk}">
						</div>
						<div class="detail-group-inline">
							<label for="rvRgstDt">등록일</label>
							<input type="text" id="rvRgstDt" name="rvRgstDt" disabled value="${rvDetail.rvRgstDt}">
						</div>
						<div class="detail-group-inline">
							<label for="mdfyDt">수정일</label>
							<input type="text" id="mdfyDt" name="mdfyDt" disabled value="${rvDetail.mdfyDt}">
						</div>
					</form>
				</div>
		</div>
	</div>

</body>
</html>