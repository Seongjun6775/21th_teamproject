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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	$('a[href="#"]').click(function(ignore) {
		ignore.preventDefault();
	});
	$('div[class="itemList"]').click(function() {
		if ($(this).children("div.blockMenu").length > 0) {
			return; 
		}
		location.href = "${context}/strprdt/detail/"+$(this).data("strprdtid");
	});
	
	
	var srt = "${strPrdtVO.prdtVO.prdtSrt}"
	$("div[id=menuCategory] a").each(function() {
		if ($(this).attr("value") == srt) {
			$(this).addClass("menuOn");
		}
	})
	
	
	$("div[id=menuCategory] a").click(function() {
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
<body class="scroll">

	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">${strVO.strNm} 매장에 오신것을 환영합니다</div>
		<div class="overlay absolute"></div>
	</div>


	
	<div id="menu" class="flex-column">
		<div id="menuCategory" class="flex">
			<a href="#" value="" class="menu">
				전체메뉴
			</a>
			<c:choose>
				<c:when test="${not empty srtList}">
					<c:forEach items="${srtList}"
								var="srt">
						<a href="#"  class="menu"
							value="${srt.cdId}" >
							${srt.cdNm}
						</a>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
		
	
	
	
	
<%-- 		<br>매장이름임 ${strVO.strNm} (${strVO.strId}) --%>
<%-- 		<br>영업시간 ${strVO.strOpnTm} ~ ${strVO.strClsTm} --%>
<%-- 		<br>리스트 조회개수 ${strPrdtList.size()} --%>
<!-- 		<br> -->
		
		
		
		
		<div>
	
			<div id="itemList" class="flow-wrap">
				<c:choose>
					<c:when test="${not empty strPrdtList}">
						<c:forEach items="${strPrdtList}"
									var="strPrdt">
							<div class="itemList" style="position: relative;" data-strprdtid="${strPrdt.strPrdtId}">
								<c:if test="${strPrdt.useYn eq 'N'}">
									<div class="blockMenu">
										<div>구매할 수 없습니다</div>
									</div>
								</c:if>
								<div class="prdt card shadow" style="padding: 24px; border-radius: 24px;">
									<div class="img-box" style="width: 100%;">
										<c:choose>
											<c:when test="${empty strPrdt.prdtVO.uuidFlNm}">
												<img src="${context}/img/default_photo.jpg">
											</c:when>
											<c:otherwise>
												<img src="${context}/prdt/img/${strPrdt.prdtVO.uuidFlNm}/">
											</c:otherwise>
										</c:choose>	
									</div>
									<div class="prdt3">
										<div class="discount">
											<c:choose>
												<c:when test="${not empty strPrdt.evntVO.evntId}">
													<span><i class='bx bxs-star'></i>Event</span>
												</c:when>
											</c:choose>
										</div>
										<div class="name ellipsis">${strPrdt.prdtVO.prdtNm}</div>
										<div class="price">
											<c:choose>
												<c:when test="${not empty strPrdt.evntVO.evntId}">
													<span style="font-size: 15px; color: #888;"><del><fmt:formatNumber>${strPrdt.prdtVO.prdtPrc}</fmt:formatNumber></del></span>
													<fmt:formatNumber>${strPrdt.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber><span>원</span>
												</c:when>
												<c:otherwise>
													<fmt:formatNumber>${strPrdt.prdtVO.prdtPrc}</fmt:formatNumber><span>원</span>
												</c:otherwise>
											</c:choose>
											
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
				</c:choose>
			</div>
		
		</div>
	
	</div>
	
	
	<jsp:include page="../include/footer_user.jsp" />


</body>
</html>