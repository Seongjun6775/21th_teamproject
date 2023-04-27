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
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	$(".updown button").click(function(e) {
		e.preventDefault();
		var count = $(this).closest(".updown").find(".cnt");
		var now = parseInt(count.val());
		var min = 1;
		var max = 999;
		var num = now;
		
		if($(this).hasClass("minus")){
			var type="m";
		} else {
			var type="p"
		}
		
		if (type == "m") {
			if (now > min) {
				num = now - 1;
			}
		} else {
			if (now < max) {
				num = now + 1;
			}
		}
		
		if (num != now) {
			count.val(num);
			
			var prdtPrc = ${strPrdtVO.evntVO.evntId != null ? strPrdtVO.evntPrdtVO.evntPrdtChngPrc : strPrdtVO.prdtVO.prdtPrc}
			
			var price = num * prdtPrc;
			$(".total-price").val(price);
		}
	});
	
	$("#add_btn").click(function() {
		
		var cnt = $(".cnt").val();
		
		$.post("${context}/api/odrdtl/create/${strPrdtVO.strPrdtId}", {"odrDtlPrdtCnt": cnt}, function(response) {
			if (response.status == "200 OK") {
				if(confirm("상품을 저장했습니다. 지금 결제 페이지로 이동할까요?")) {
					location.href = "${context}/odrlst/list";
				}
				else{
					location.href = "${context}/strprdt/${strPrdtVO.strId}"
				}
			}
		})
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
						<c:choose>
							<c:when test="${empty strPrdtVO.prdtVO.uuidFlNm}">
								<img src="${context}/img/default_photo.jpg">
							</c:when>
							<c:otherwise>
								<img src="${context}/prdt/img/${strPrdtVO.prdtVO.uuidFlNm}/" alt="이미지 예정">
							</c:otherwise>
						</c:choose>	
					</div>
					<!-- 임시로 style을 넣어 두었습니다. css 작업을 하실 때 지워야 합니다. -->
					<div class="col text-grid">
						<div style="text-align: left; font-size: 20px;">상품명 : 
							<span style="text-align: left; font-size: 30px; font-weight: bold;">${strPrdtVO.prdtVO.prdtNm}</span>
							<c:if test="${not empty strPrdtVO.evntVO.evntId}">
								<span>이벤트중!!</span>
							</c:if>
						</div>
						<div style="text-align: left; font-size: 20px;">개당 가격 : 
							<c:choose>
								<c:when test="${not empty strPrdtVO.evntVO.evntId}">
									<span style="text-align: left; font-size: 30px; font-weight: bold;">
										<del><fmt:formatNumber>${strPrdtVO.prdtVO.prdtPrc}</fmt:formatNumber></del>
										<fmt:formatNumber>${strPrdtVO.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber>
									</span>원
								</c:when>
								<c:otherwise>
									<span style="text-align: left; font-size: 30px; font-weight: bold;">
										<fmt:formatNumber>${strPrdtVO.prdtVO.prdtPrc}</fmt:formatNumber>
									</span>원
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col updown" style="text-align: left; font-size: 20px; padding: 0px;">수량 :
								<button class="minus">-</button>
								<input type="text" class="cnt text-center" value="1" readonly/>
								<button class="plus">+</button>
						</div>
						<div class="col price" style="text-align: left; font-size: 20px; padding: 0px;">합계 : 
							<c:choose>
								<c:when test="${not empty strPrdtVO.evntVO.evntId}">
									<input type="text" class="total-price" value="${strPrdtVO.evntPrdtVO.evntPrdtChngPrc}" readonly>
								</c:when>
								<c:otherwise>
									<input type="text" class="total-price" value="${strPrdtVO.prdtVO.prdtPrc}" readonly>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<button type="button" id="add_btn"class="btn btn-success">추가</button>
				<button type="button" id="cancle_btn" class="btn btn-danger">취소</button>
			</div>
	
		<br>정보확인용
		<br>상품ID : ${strPrdtVO.strPrdtId}
		<br>매장ID : ${strPrdtVO.strId}
		<br>이벤트 이름 : ${strPrdtVO.evntVO.evntTtl}	
		<fmt:parseDate value="${strPrdtVO.evntVO.evntStrtDt}" var="startDt" pattern="yyyy-MM-dd"></fmt:parseDate>
		<fmt:parseDate value="${strPrdtVO.evntVO.evntEndDt}" var="endDt" pattern="yyyy-MM-dd"></fmt:parseDate>
		<br>이벤트 기간 : <fmt:formatDate value="${startDt}" pattern="yyyy.MM.dd"/>  ~ <fmt:formatDate value="${endDt}" pattern="yyyy.MM.dd"/>

</body>
</html>