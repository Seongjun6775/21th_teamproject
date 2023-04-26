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
<link rel="stylesheet" href="${context}/css/prdt_common_customer.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	$('a[href="#"]').click(function(ignore) {
		ignore.preventDefault();
	});

	
	var srt = "${prdtVO.prdtSrt}"
	$("div[id=menuCategory] a").each(function() {
		if ($(this).attr("value") == srt) {
			$(this).addClass("on");
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

	<div class="headline relative">
		상단 헤드라인임 //////// <a href="${context}/prdt/list">관리자 메뉴로 돌아가깅</a>
		<br><a href="${context}/strprdt/list2">주문가볼까</a>
		
	</div>
	
	
	<div id="menu">
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
		
	
		<div id="itemList">
			<c:choose>
				<c:when test="${not empty prdtList}">
					<c:forEach items="${prdtList}"
								var="prdt">
						<a href="${context}/prdt/list2/${prdt.prdtId}">
							<div class="prdt1" id="${prdt.prdtId}"
								data-prdtid="${prdt.prdtId}">
								<div class="img-box">
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
									<div class="name">${prdt.prdtNm}
										<c:choose>
											<c:when test="${not empty prdt.evntVO.evntId}">
												<span>할인중!!</span>
											</c:when>
										</c:choose>
									</div>
									<div class="price"><fmt:formatNumber>${prdt.prdtPrc}</fmt:formatNumber><span>원</span></div>
								</div>
							</div>
						</a>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
	
	</div>
	
	
	


</body>
</html>