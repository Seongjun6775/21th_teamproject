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
<%-- <link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}"> --%>
<jsp:include page="../include/stylescript.jsp" />

<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

	$().ready(function() {
		
		$("#list_btn").click(function() {
			location.href="${context}/user/rv/list";
		});
	});	
</script>
<style>
.label-left-border{
	padding: 5px;
	border-left: solid #ffbe2e;
}
 .half-left , .half-right {
	width: 50%;
	display: inline-block;
}

.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
}

</style>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">리뷰</div>
		<div class="overlay absolute"></div>
	</div>	
		<div class="bg-white rounded shadow-sm" style="padding: 60px;  margin:20px;">
			<div class="flex">			
				<div class="input-group" style="flex: 1; margin-top: 10px;">
					<label for="prdtCntnt" class="col-form-label label-left-border">상품이름</label>
					<div>
						<textarea id="prdtCntnt" style="height:20px; resize: none;" readonly
								class="form-control">${rvDetail.prdtVO.prdtNm} 외 ${odrDtl.size() -1}건</textarea>
					</div>
				</div>
			</div>
			<div class="half-right">
				<div class="input-group">
					<label for="prdtNm" class="col-form-label label-left-border">제목</label>
					<div>
						<input type="text" class="form-control" readonly value="${rvDetail.rvTtl}"/>
					</div>
				</div>
				<div class="input-group">
					<label for="prdtNm" class="col-form-label label-left-border">평가</label>
					<div>
						<input type="text" id="rvLkDslk" name="rvLkDslk" class="form-control" readonly value="${rv.rvLkDslk eq 'T' ? '좋아요' : '싫어요'}">
					</div>
				</div>
				<div class="input-group" style="flex: 1;">
					<label for="prdtCntnt" class="col-form-label label-left-border" style="height: 40px;">내용</label>
					<div>
						<textarea id="prdtCntnt" style="margin-top: 0.5rem; height:220px; resize: none;" readonly
								class="form-control">${rvDetail.rvCntnt}</textarea>
					</div>
				</div>
			</div>
			<div style="right: 0;top: 0; margin: 20px;">
				<button id="list_btn" class="btn btn-secondary" >목록</button>
		</div>
		</div>										
<jsp:include page="../include/footer_user.jsp" />
</body>
</html>