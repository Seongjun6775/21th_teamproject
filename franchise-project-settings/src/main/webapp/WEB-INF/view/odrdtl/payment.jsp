<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">


function secId(mbrId) {
	return mbrId.substring(0, mbrId.length - 3) + "***";
}

  	
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	
	
	
	
})


function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	var prdtNm= $("#search-keyword-prdtNm").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	var evntYn= $("#search-keyword-evntYn").val(); 
	if (evntYn == "" || srt == null) {
		evntYn = '%'
	}
	
	var queryString = "prdtSrt=" + srt;
	queryString += "&prdtNm=" + prdtNm;
	queryString += "&useYn=" + useYn;
	queryString += "&evntVO.evntId=" + evntYn;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/prdt/list?" + queryString; // URL 요청
} 
</script>
</head>
<body>
	
	<jsp:include page="../include/openBody.jsp" />
		
		<!-- contents -->
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<span class="fs-5 fw-bold">매출 관리</span>
		</div>

		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<div class="top-bar">
				<input type="date" id="search-keyword-startdt" 
						class="form-control width180" value="${odrDtlVO.startDt}"/>
				<input type="date" id="search-keyword-enddt" 
						class="form-control width180" value="${odrDtlVO.endDt}"/>
				<button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px;">Search</button>
			</div>
		</div>
		
		
		<div class="bg-white rounded shadow-sm " style=" padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">
		
		
			<table class="table table-striped table-sm table-hover align-center">
				<thead class="table-secondary">
					<tr>
						<th>매장ID</th>
						<th>상품분류</th>
						<th>상품ID</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:choose>
						<c:when test="${not empty groupPrdt}">
							<c:forEach items="${groupPrdt}"
										var="prdt">
								<tr >
									<td>${prdt.prdtVO.cmmnCdVO.cdId}</td>							
									<td>${prdt.prdtVO.cmmnCdVO.cdNm}</td>							
									<td>${prdt.prdtVO.prdtId}</td>							
									<td>${prdt.prdtVO.prdtNm}</td>							
									<td>${prdt.sumPrc} 매출합</td>							
									<td>${prdt.sumCnt} 수량합</td>							
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>
			</table>
			
			
			매장별 매출
			<table class="table table-striped table-sm table-hover align-center">
				<thead class="table-secondary">
					<tr>
						<th>매장ID</th>
						<th>상품분류</th>
						<th>상품ID</th>
						<th>수량</th>
						<th>단가</th>
						<th>구매자</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:choose>
						<c:when test="${not empty odrDtlList}">
							<c:forEach items="${odrDtlList}"
										var="odrDtl">
								<tr >
									<td>${odrDtl.odrDtlStrId}</td>							
									<td>${odrDtl.prdtVO.cmmnCdVO.cdId}</td>							
									<td>${odrDtl.odrDtlPrdtId}</td>							
									<td>${odrDtl.odrDtlPrdtCnt}</td>							
									<td>${odrDtl.odrDtlPrc}</td>							
									<td>${odrDtl.mbrId}</td>							
									<td>${odrDtl.odrLstVO.mdfyDt}</td>							
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>
			</table>
			
			
			
			
			
			
			
			
			
			
		
		
		
		
		
		
		</div>
		<!-- /contents -->
		
	<jsp:include page="../include/closeBody.jsp" />


</body>
</html>