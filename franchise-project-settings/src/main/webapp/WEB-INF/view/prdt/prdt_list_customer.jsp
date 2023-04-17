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
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	$("li").click(function() {
		var srt = $(this).attr('value');
		var queryString = "prdtSrt=" + srt;
		location.href = "${context}/prdt/list2?" + queryString;
	});
	
	
});


function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	var prdtNm= $("#search-keyword-prdtNm").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	
	var queryString = "prdtSrt=" + srt;
	queryString += "&prdtNm=" + prdtNm;
	queryString += "&useYn=" + useYn;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/prdt/list?" + queryString; // URL 요청
} 

</script>
</head>
<body>

	<div class="headline">
		상단 헤드라인임
		<div>${prdtList}</div>
		<div>${prdtVO}</div>
		<div>${srtList}</div>
			<ul id="prdtSrtList">
				<li value="">전체메뉴</li>
				<c:choose>
					<c:when test="${not empty srtList}">
						<c:forEach items="${srtList}"
									var="srt">
							<li value="${srt.cdId}">${srt.cdNm}</li>
						</c:forEach>
					</c:when>
				</c:choose>
			</ul>
	</div>
	
	<div>
		<c:choose>
			<c:when test="${not empty prdtList}">
				<c:forEach items="${prdtList}"
							var="prdt">
					<div class="prdt1">
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
							<div class="flex">${prdt.prdtNm}</div>
							<div class="flex"><fmt:formatNumber>${prdt.prdtPrc}</fmt:formatNumber><span>원</span></div>
						</div>
					</div>
				</c:forEach>
			</c:when>
		</c:choose>
	</div>
	
	


</body>
</html>