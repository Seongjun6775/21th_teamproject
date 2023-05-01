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
<title>${prdtVO.prdtNm}</title>
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
<body>

	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">붕어빵 파는곳</div>
		<div class="overlay absolute"></div>
	</div>
	
	
	
	<div id="menu" class="flex-column">
<!-- 		<div id="menuCategory" class="flex"> -->
<!-- 			<a href="#" value="" class="menu"> -->
<!-- 				전체메뉴 -->
<!-- 			</a> -->
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${not empty srtList}"> --%>
<%-- 					<c:forEach items="${srtList}" --%>
<%-- 								var="srt"> --%>
<!-- 						<a href="#"  class="menu" -->
<%-- 							value="${srt.cdId}" > --%>
<%-- 							${srt.cdNm} --%>
<!-- 						</a> -->
<%-- 					</c:forEach> --%>
<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
<!-- 		</div> -->
		
		<div class="default-padding flex prdt-detail" style="margin: 0 auto;">
		
			<div class="img-box" style="width: 600px; height: 600px;">
				<c:choose>
					<c:when test="${empty prdtVO.uuidFlNm}">
						<img src="${context}/img/default_photo.jpg">
					</c:when>
					<c:otherwise>
						<img src="${context}/prdt/img/${prdtVO.uuidFlNm}/">
					</c:otherwise>
				</c:choose>	
			</div>
			
			<div class="prdt-text flow-column">
				
		<%-- 		<div>이벤트명 : <a href="${context}/evnt/detail/${prdtVO.evntVO.evntId}">${prdtVO.evntVO.evntTtl}</a></div> --%>
				<div style="font-size: 18px;">${prdtVO.cmmnCdVO.cdNm}</div>
				<div class="prdtNm relative flex">${prdtVO.prdtNm}</div>
				<c:choose>
					<c:when test="${empty prdtVO.evntVO.evntId}">
						<div class="prdtPrc"><fmt:formatNumber>${prdtVO.prdtPrc}</fmt:formatNumber><span>원</span></div>
					</c:when>
					<c:otherwise>
						<div class="prdtPrc">
							<div class="delPrdtPrc relative">
								<c:choose>
									<c:when test="${not empty prdtVO.evntVO.evntId}">
										<div class="prdtDtlEvnt">이벤트 진행중</div>
									</c:when>
								</c:choose>
								<del><fmt:formatNumber>${prdtVO.prdtPrc}</fmt:formatNumber><span>원</span></del>
							</div>
							<div><fmt:formatNumber>${prdtVO.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber><span>원</span></div>
						</div>
					</c:otherwise>
				</c:choose>
				<div>${prdtVO.prdtCntnt}</div>
				
				<button>주문 페이지</button>
			</div>
		</div>			
		
	</div>
	
	
	<jsp:include page="../include/footer_user.jsp" />


</body>
</html>