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
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/rvMgmtSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />

			<div class="path">리뷰 > 리뷰관리 > 리뷰등록</div>

			<h1>새 리뷰 등록</h1>
			<div>
				<form id="create_form" enctype="multipart/form-data">

					<div class="create-group">
						<label for="rvId">리뷰ID</label> <input type="text" id="rvId"
							name="rvId" />
					</div>
					<div class="create-group">
						<label for="mbrId">회원ID</label> <input type="text" id="mbrId"
							name="mbrId" />
					</div>
					<div class="create-group">
						<label for="odrId">주문ID</label> <input type="text" id="odrId"
							name="odrId" />
					</div>
					<div class="create-group">
						<label for="rvTtl">제목ID</label> <input type="text" id="rvTtl"
							name="rvTtl" />
					</div>
					<div class="create-group">
						<label for="rvCntnt">내용</label> <input type="text" id="rvCntnt"
							name="rvCntnt" />
					</div>
					<div class="create-group">
						<label for="rvLkDslk">좋아요/싫어요</label> <select id="rvLkDslk"
							name="rvLkDslk">
							<option>선택</option>
							<option value="좋아요">좋아요</option>
							<option value="싫어요">싫어요</option>
						</select>
					</div>
					<div class="create-group">
						<label for="rvRgstDt">등록일</label> <input type="date" id="rvRgstDt"
							name="rvRgstDt" />
					</div>
					<div class="create-group">
						<label for="mdfyDt">수정일</label> <input type="date" id="mdfyDt"
							name="mdfyDt" />
					</div>					
					<div class="create-group">
								<label for="useYn" style= "width: 180px;">사용유무</label>
								<input type="checkbox" id="useYn" name="useYn" value="Y"/>
					</div>
					<div class="create-group">
								<label for="delYn" style= "width: 180px;">삭제여부</label>
								<input type="checkbox" id="delYn" name="delYn" value="N"/>
					</div>					
				</form>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">등록</button>
					<button id="delete_btn" class="btn-delete">삭제</button>
				</div>
				<jsp:include page="../include/footer.jsp" />
			</div>
		</div>
	</div>
</body>
</html>