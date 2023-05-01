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
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
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
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">리뷰 > 리뷰관리 > 리뷰등록</span>
	    </div>
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<form id="create_form" method="post">
					<div class="create-group">
						<label for="odrLstId" style="margin:5px;">주문서 ID</label> 
						<select id="odrLstId" style="width:40%;"
								class="form-control"name="odrLstId">
							<option value="ordLstId">${ordLstId}</option>
						</select>
					</div>
					<div class="create-group">
						<label for="rvTtl" style="margin:5px;">제목</label> <input type="text" id="rvTtl"
							name="rvTtl" 
							style="width:40%; margin:5px;"
							maxlength="50" class="form-control"
							placeholder="제목을 입력하세요(50자 제한)" />
					</div>
					<div class="create-group">
						<label for="rvCntnt" style="margin:5px;">내용</label> <textarea id="rvCntnt"
							name="rvCntnt" 
							style="display: grid; margin: 5px; width: 700px; height: 400px; resize: none;"
							maxlength="1000" class="form-control"
							placeholder="내용을 입력하세요(1000자 제한)" ></textarea>
					</div>
					<div class="create-group">
						<label for="rvLkDslk" style="margin:5px;">좋아요/싫어요</label> <select id="rvLkDslk"
							style="margin: 5px; width:20%" class="form-select" 
							name="rvLkDslk">
							<option>선택</option>
							<option value="T">좋아요</option>
							<option value="F">싫어요</option>
						</select>
					</div>		
				</form>
				<div class="align-right">
					<button id="new_btn" class="btn btn-primary">등록</button>
				</div>
				<jsp:include page="../include/footer.jsp" />
			</div>
<jsp:include page="../include/closeBody.jsp" />
</html>