<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${strVO.strNm} - 주문하기</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<link rel="stylesheet" href="${context}/css/strprdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	$('a[href="#"]').click(function(ignore) {
		ignore.preventDefault();
	});

	
	$("li").click(function() {
		var srt = $(this).attr('value');
		if (srt == "" || srt == null) {
			srt = '%'
		}
		var queryString = "?prdtVO.prdtSrt=" + srt;
		location.href = "${context}/strprdt/${strVO.strId}" + queryString;
	});
	
	
	
	
	
});


function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	
	var queryString = "?prdtSrt=" + srt;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/strprdt/${strVO.strId}"+ queryString; // URL 요청
} 

</script>
</head>
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div>
			<jsp:include page="../include/sidemenu.jsp"></jsp:include>
			<jsp:include page="../include/content.jsp"></jsp:include>


			<div>
				<br>매장이름임 ${strVO.strNm} (${strVO.strId})
				<br>영업시간 ${strVO.strOpnTm} ~ ${strVO.strClsTm}
				<br>
				
				
				<div class="flex full">
					<div class="half-left">
						<div class="half-top">
							<div>주문접수</div>
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" id="all-check"/></th>
										<th>주문서ID</th>
										<th>주문자</th>
										<th>주문날짜</th>
										<th>처리자</th>
										<th>처리날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty ordLstList}">
											<c:forEach items="${ordLstList}"
														var="ordLst">
												<c:if test="${ordLst.odrLstOdrPrcs eq '003-02'}">
													<tr>
														<td class="align-center">
															<input type="checkbox" class="check-idx" value="${prdt.prdtId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrId}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td>${ordLst.odrLstRgstr}</td>							
														<td>${ordLst.mdfyDt}</td>							
													</tr>
												</c:if>
											</c:forEach>
										</c:when>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div class="half-bottom">
							<div>주문처리</div>
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" id="all-check"/></th>
										<th>주문서ID</th>
										<th>주문자</th>
										<th>주문날짜</th>
										<th>처리자</th>
										<th>처리날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty ordLstList}">
											<c:forEach items="${ordLstList}"
														var="ordLst">
												<c:if test="${ordLst.odrLstOdrPrcs eq '003-03'}">
													<tr>
														<td class="align-center">
															<input type="checkbox" class="check-idx" value="${prdt.prdtId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrId}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td>${ordLst.odrLstRgstr}</td>							
														<td>${ordLst.mdfyDt}</td>							
													</tr>
												</c:if>
											</c:forEach>
										</c:when>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="half-right">
						<div>처리완료</div>
						<table>
							<thead>
								<tr>
									<th>주문서ID</th>
									<th>주문자</th>
									<th>주문날짜</th>
									<th>처리자</th>
									<th>처리날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty ordLstCompleteList}">
										<c:forEach items="${ordLstCompleteList}"
													var="ordLst">
											<tr>
												<td>${ordLst.odrLstId}</td>							
												<td>${ordLst.mbrId}</td>							
												<td>${ordLst.odrLstRgstDt}</td>							
												<td>${ordLst.odrLstRgstr}</td>							
												<td>${ordLst.mdfyDt}</td>							
											</tr>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				
				
			</div>
			
	
	
	
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>


</body>
</html>