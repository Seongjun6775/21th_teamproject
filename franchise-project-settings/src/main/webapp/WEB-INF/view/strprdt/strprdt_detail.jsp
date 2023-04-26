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
	
	location.href = "${context}/prdt/list2?" + queryString; // URL 요청
} 

</script>
</head>
<body>

	<%-- <div class="headline relative">
		상단 헤드라인임 //////// <a href="${context}/prdt/list">관리자 메뉴로 돌아가깅</a>
		<div>${prdtList}</div>
		<div>${prdtVO}</div>
		<div>${srtList}</div>
			<ul id="prdtSrtList" class="flex absolute" style="list-style-type: none; bottom: 0px;">
				<li value="">전체메뉴</li>
				<c:choose>
					<c:when test="${not empty srtList}">
						<c:forEach items="${srtList}"
									var="srt">
							<li class="ml-20" value="${srt.cdId}">${srt.cdNm}</li>
						</c:forEach>
					</c:when>
				</c:choose>
			</ul>
	</div>
	
	<div>
		<div class="img-box">
			<c:choose>
				<c:when test="${empty prdtVO.uuidFlNm}">
					<img src="${context}/img/default_photo.jpg">
				</c:when>
				<c:otherwise>
					<img src="${context}/prdt/img/${prdtVO.uuidFlNm}/">
				</c:otherwise>
			</c:choose>	
		</div>
		<c:choose>
			<c:when test="${not empty prdtVO.evntVO.evntId}">
				<div>할인중!!</div>
			</c:when>
		</c:choose>
		<div>이벤트명 : <a href="${context}/evnt/detail/${prdtVO.evntVO.evntId}">${prdtVO.evntVO.evntTtl}</a></div>
		<div>${prdtVO.cmmnCdVO.cdNm}</div>
		<div>${prdtVO.prdtNm}</div>
		<c:choose>
			<c:when test="${empty prdtVO.evntVO.evntId}">
				<div><fmt:formatNumber>${prdtVO.prdtPrc}</fmt:formatNumber><span>원</span></div>
			</c:when>
			<c:otherwise>
				<div><del><fmt:formatNumber>${prdtVO.prdtPrc}</fmt:formatNumber><span>원</span></del></div>
				<div><fmt:formatNumber>${prdtVO.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber><span>원</span></div>
			</c:otherwise>
		</c:choose>
		<div>${prdtVO.prdtCntnt}</div>
	</div> --%>
	
	
	<div class="container">
				<div class="row content text-center">
					<div class="col img-grid">
						<img src="" alt="사진이 들어갈 예정입니다.">
					</div>
					<!-- 임시로 style을 넣어 두었습니다. css 작업을 하실 때 지워야 합니다. -->
					<div class="col text-grid">
						<div style="text-align: left; font-size: 20px;">상품명 : 
							<span style="text-align: left; font-size: 30px; font-weight: bold;">${odrDtl.prdtVO.prdtNm}</span>
						</div>
						<div style="text-align: left; font-size: 20px;">개당 가격 : 
							<span style="text-align: left; font-size: 30px; font-weight: bold;">${odrDtl.prdtVO.prdtPrc}</span>원
						</div>
						<div class="col updown" style="text-align: left; font-size: 20px; padding: 0px;">수량 :
								<button class="minus">-</button>
								<input type="text" class="cnt text-center" value="${odrDtl.odrDtlPrdtCnt}" readonly/>
								<button class="plus">+</button>
						</div>
						<div class="col price" style="text-align: left; font-size: 20px; padding: 0px;">합계 : 
							<input type="text" class="total-price" value="${odrDtl.odrDtlPrdtCnt * odrDtl.prdtVO.prdtPrc}" readonly>
						</div>
					</div>
				</div>
				<button type="button" id="modify_btn"class="btn btn-success">수정</button>
				<button type="button" id="list_btn" class="btn btn-secondary">목록</button>
				<button type="button" id="delete_btn" class="btn btn-danger">삭제</button>
			</div>
	
	


</body>
</html>