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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
	
		$("#list_btn").click(function() {
			location.href="${context}/user/rv/list";
		});
	}
	
</script>
</head>
<%-- <jsp:include page="../include/openBody.jsp" /> --%>
<div class="bg-white rounded shadow-sm"
	style="padding: 23px 18px 23px 18px; margin: 20px; position: relative;">
	<span class="fs-5 fw-bold"> 리뷰 > 리뷰목록 > 리뷰상세</span>
	<div style="position: absolute; right: 0; top: 0; margin: 20px;">
		<button id="list_btn" class="btn btn-secondary">목록</button>
	</div>
</div>
<div class="bg-white rounded shadow-sm"
	style="padding: 23px 18px 23px 18px; margin: 20px;">
	<div style="padding: 10px;">
		<span class="fs-5 fw-bold">${rvDetail.rvTtl}</span>
		<div class="hr_detail_header">(${rvDetail.rvId})</div>
	</div>
	<div style="margin-top: 10px">

		<div
			style="border-bottom: 1px solid #e0e0e0; padding-bottom: 15px; text-align: right;">
			<div class="hr_detail_header">등록일 : ${rvDetail.rvRgstDt}</div>
			<div class="hr_detail_header">작성자 : ${rvDetail.mbrId}</div>
		</div>
		<div style="padding: 10px;">

			<div style="padding: 10px;">
				<div class="fw-semibold"
					style="margin-bottom: 100px; height: 220px; overflow: auto;">${rvDetail.rvCntnt}</div>
			</div>
		</div>
	</div>
</div>
<%-- <jsp:include page="../include/closeBody.jsp" /> --%>
</html>