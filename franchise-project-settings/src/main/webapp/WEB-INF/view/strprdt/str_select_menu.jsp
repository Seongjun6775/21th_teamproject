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
	
	location.href = "${context}/strprdt/"+${strVO.strId} + queryString; // URL 요청
} 

</script>
</head>
<body>

	<div class="headline relative">
		상단 헤드라인임 //////// <a href="${context}/prdt/list">관리자 메뉴로 돌아가깅</a>
		<br><a href="${context}/strprdt/list2">주문가볼까</a>
		<div>${prdtList}</div>
		<div>${prdtVO}</div>
		<div>${srtList}</div>
			<ul id="prdtSrtList" class="flex absolute" style="list-style-type: none; bottom: 0px;">
				<li value=""><a href="#">전체메뉴</a></li>
				<c:choose>
					<c:when test="${not empty srtList}">
						<c:forEach items="${srtList}"
									var="srt">
							
								<li class="ml-20" value="${srt.cdId}">
									<a href="#">
									${srt.cdNm}
									</a>
								</li>
						</c:forEach>
					</c:when>
				</c:choose>
			</ul>
	</div>
	
	<div>
		<br>매장이름임 ${strVO.strNm} (${strVO.strId})
		<br>영업시간 ${strVO.strOpnTm} ~ ${strVO.strClsTm}
		<br>리스트 조회개수 ${strPrdtList.size()}
		<br>
		<c:choose>
			<c:when test="${not empty strPrdtList}">
				<c:forEach items="${strPrdtList}"
							var="strPrdt">
					<a href="${context}/strprdt/detail/${strPrdt.strPrdtId}">
						<div class="prdt1" id="${strPrdt.strPrdtId}"
							data-strPrdtid="${strPrdt.strPrdtId}">
							<c:if test="${strPrdt.useYn eq 'N'}">
								<div class="bg-black">
									<div class="warning">구매할 수 없습니다</div>
								</div>
							</c:if>
							<div class="img-box">
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
								<div class="name">${strPrdt.prdtVO.prdtNm}
									<c:choose>
										<c:when test="${not empty strPrdt.evntVO.evntId}">
											<span>할인중!!</span>
										</c:when>
									</c:choose>
								</div>
								<div class="price"><fmt:formatNumber>${strPrdt.prdtVO.prdtPrc}</fmt:formatNumber><span>원</span></div>
							</div>
						</div>
					</a>
				</c:forEach>
			</c:when>
		</c:choose>
	</div>
	
	


</body>
</html>