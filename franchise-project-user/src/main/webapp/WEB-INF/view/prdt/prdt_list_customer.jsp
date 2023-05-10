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
<title>메뉴 관리</title>
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
		location.href = "${context}/prdt/list2/"+$(this).data("prdtid");
	});

	
	var srt = "${prdtVO.prdtSrt}"
	$("div[id=menuCategory] a").each(function() {
		if ($(this).attr("value") == srt) {
			$(this).addClass("menuOn");
		}
	})
	
	
	$("div[id=menuCategory] a").click(function() {
		var srt = $(this).attr("value");
		var queryString = "prdtSrt=" + srt;
		location.href = "${context}/prdt/list2?" + queryString;
	});
	
	
// 	$(".prdt1").click(function() {
// 		var data = $(this).data();
// 		location.href="${context}/prdt/list2/"+data.prdtid
// 	})
	
	
	



		
	
	
});


function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	var prdtNm= $("#search-keyword-prdtNm").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	
	var queryString = "prdtSrt=" + srt;
	queryString += "&prdtNm=" + prdtNm;
	queryString += "&useYn=" + useYn;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/prdt/list2?" + queryString; // URL 요청
} 

</script>

</head>
<body class="scroll">

	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">메뉴</div>
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
		
	
		<div id="itemList" class="flow-wrap">
			<c:choose>
				<c:when test="${not empty prdtList}">
					<c:forEach items="${prdtList}"
								var="prdt">
						<div class="itemList" data-prdtid="${prdt.prdtId}">
							<div class="prdt card shadow" style="padding: 24px; border-radius: 24px;">
								<div class="img-box" style="width: 100%">
									<c:choose>
										<c:when test="${empty prdt.uuidFlNm}">
											<img src="${context}/img/default_photo.jpg">
										</c:when>
										<c:otherwise>
											<img src="${context}/prdt/img/${prdt.uuidFlNm}/">
										</c:otherwise>
									</c:choose>	
								</div>
								<div class="prdt3">
									<div class="discount">
										<c:choose>
											<c:when test="${not empty prdt.evntVO.evntId}">
												<span><i class='bx bxs-star'></i>Event</span>
											</c:when>
										</c:choose>
									</div>
									<div class="name ellipsis">${prdt.prdtNm}</div>
									<div class="price">
										<c:choose>
											<c:when test="${not empty prdt.evntVO.evntId}">
												<span style="font-size: 15px; color: #888;"><del><fmt:formatNumber>${prdt.prdtPrc}</fmt:formatNumber></del></span>
												<fmt:formatNumber>${prdt.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber><span>원</span>
											</c:when>
											<c:otherwise>
												<fmt:formatNumber>${prdt.prdtPrc}</fmt:formatNumber><span>원</span>
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
	
	
	<jsp:include page="../include/footer_user.jsp" />


</body>
</html>