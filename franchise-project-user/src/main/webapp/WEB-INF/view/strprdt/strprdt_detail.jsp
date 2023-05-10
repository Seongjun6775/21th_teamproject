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
<title>${strPrdtVO.strVO.strNm} - ${strPrdtVO.prdtVO.prdtNm}</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	var defaultPrice ;
	if ("${strPrdtVO.evntVO.evntId}" == "") {
		defaultPrice = ${strPrdtVO.prdtVO.prdtPrc}
	}
	else {
		defaultPrice = ${strPrdtVO.evntPrdtVO.evntPrdtChngPrc}
	}
	$("#price").val(defaultPrice.toLocaleString()+"원")
	
	
	
	
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
			$(".total-price").val(price.toLocaleString()+"원");
		}
	});
	
	$("#add_btn").click(function() {
		
		var odrDtlPrc = 0;
		var cnt = $(".cnt").val();
		if ("${strPrdtVO.evntVO.evntId}" == "") {
			odrDtlPrc = ${strPrdtVO.prdtVO.prdtPrc};
		}
		else {
			odrDtlPrc = ${strPrdtVO.evntPrdtVO.evntPrdtChngPrc};
		}
		
		$.post("${context}/api/odrdtl/create/${strPrdtVO.strPrdtId}", {"odrDtlPrdtCnt": cnt, "odrDtlPrc": odrDtlPrc}, function(response) {
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
	
	$("#cancle_btn").click(function() {
		location.href = "${context}/strprdt/${strPrdtVO.strId}"
	})
	
	
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
		<div class="content-setting title">${strPrdtVO.strVO.strNm} 매장에 오신것을 환영합니다</div>
		<div class="overlay absolute"></div>
	</div>
	
	
	
	<div id="menu" class="flex-column relative">
		
		<div class="default-padding flex prdt-detail" style="margin-top: 144px">
		
			<div class="img-box" style="width: 600px; height: 600px;">
				<c:choose>
					<c:when test="${empty strPrdtVO.prdtVO.uuidFlNm}">
						<img src="${context}/img/default_photo.jpg">
					</c:when>
					<c:otherwise>
						<img src="${context}/prdt/img/${strPrdtVO.prdtVO.uuidFlNm}/">
					</c:otherwise>
				</c:choose>	
			</div>
			
			<div class="prdt-text flow-column">
		<%-- 		<div>이벤트명 : <a href="${context}/evnt/detail/${strPrdtVO.prdtVO.evntVO.evntId}">${strPrdtVO.prdtVO.evntVO.evntTtl}</a></div> --%>
				<div style="">
					<div style="font-size: 18px;">${strPrdtVO.cmmnCdVO.cdNm}</div>
					<div class="prdtNm relative flex">${strPrdtVO.prdtVO.prdtNm}</div>
					<c:choose>
						<c:when test="${empty strPrdtVO.evntVO.evntId}">
							<div class="prdtPrc"><fmt:formatNumber>${strPrdtVO.prdtVO.prdtPrc}</fmt:formatNumber><span>원</span></div>
						</c:when>
						<c:otherwise>
							<div class="prdtPrc">
								<div class="delPrdtPrc relative">
									<c:choose>
										<c:when test="${not empty strPrdtVO.evntVO.evntId}">
											<div class="prdtDtlEvnt">이벤트 진행중</div>
										</c:when>
									</c:choose>
									<del><fmt:formatNumber>${strPrdtVO.prdtVO.prdtPrc}</fmt:formatNumber><span>원</span></del>
								</div>
								<div><fmt:formatNumber>${strPrdtVO.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber><span>원</span></div>
							</div>
						</c:otherwise>
					</c:choose>
					<div>${strPrdtVO.prdtVO.prdtCntnt}</div>
					<div class="howMany flex-column">
						<div class="updown flex">수량 :
							<div class="flex relative">
								<button class="minus absolute" style="left: 0;"><i class='bx bx-minus'></i></button>
								<input type="text" class="cnt text-center" value="1" readonly/>
								<button class="plus absolute" style="right:0;"><i class='bx bx-plus' ></i></button>
							</div>
						</div>
						<div class="">합계 : 
							<c:choose>
								<c:when test="${not empty strPrdtVO.evntVO.evntId}">
									<input id="price" type="text" class="total-price text-center" value="" readonly>
								</c:when>
								<c:otherwise>
									<input id="price" type="text" class="total-price text-center" value="" readonly>
								</c:otherwise>
							</c:choose>
						</div>
	
					</div>
					<div>
						<button type="button" id="add_btn"class="btn btn-success">추가</button>
						<button type="button" id="cancle_btn" class="btn btn-secondary">목록</button>
	<%-- 					<button class="btn btn-outline-warning" onclick="location.href='${context}/strprdt/list2'">주문 페이지</button> --%>
					</div>
				</div>
				
			</div>
		</div>			
		
	</div>
	
	
	<jsp:include page="../include/footer_user.jsp" />

	
<!-- 	<div class="container"> -->
<!-- 				<div class="row content text-center"> -->
<!-- 					<div class="col img-grid"> -->
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${empty strPrdtVO.prdtVO.uuidFlNm}"> --%>
<%-- 								<img src="${context}/img/default_photo.jpg"> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<img src="${context}/prdt/img/${strPrdtVO.prdtVO.uuidFlNm}/" alt="이미지 예정"> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose>	 --%>
<!-- 					</div> -->
<!-- 					임시로 style을 넣어 두었습니다. css 작업을 하실 때 지워야 합니다. -->
<!-- 					<div class="col text-grid"> -->
<!-- 						<div style="text-align: left; font-size: 20px;">상품명 :  -->
<%-- 							<span style="text-align: left; font-size: 30px; font-weight: bold;">${strPrdtVO.prdtVO.prdtNm}</span> --%>
<%-- 							<c:if test="${not empty strPrdtVO.evntVO.evntId}"> --%>
<!-- 								<span>이벤트중!!</span> -->
<%-- 							</c:if> --%>
<!-- 						</div> -->
<!-- 						<div style="text-align: left; font-size: 20px;">개당 가격 :  -->
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${not empty strPrdtVO.evntVO.evntId}"> --%>
<!-- 									<span style="text-align: left; font-size: 30px; font-weight: bold;"> -->
<%-- 										<del><fmt:formatNumber>${strPrdtVO.prdtVO.prdtPrc}</fmt:formatNumber></del> --%>
<%-- 										<fmt:formatNumber>${strPrdtVO.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber> --%>
<!-- 									</span>원 -->
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<!-- 									<span style="text-align: left; font-size: 30px; font-weight: bold;"> -->
<%-- 										<fmt:formatNumber>${strPrdtVO.prdtVO.prdtPrc}</fmt:formatNumber> --%>
<!-- 									</span>원 -->
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
<!-- 						</div> -->
<!-- 						<div class="col updown" style="text-align: left; font-size: 20px; padding: 0px;">수량 : -->
<!-- 								<button class="minus">-</button> -->
<!-- 								<input type="text" class="cnt text-center" value="1" readonly/> -->
<!-- 								<button class="plus">+</button> -->
<!-- 						</div> -->
<!-- 						<div class="col price" style="text-align: left; font-size: 20px; padding: 0px;">합계 :  -->
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${not empty strPrdtVO.evntVO.evntId}"> --%>
<%-- 									<input type="text" class="total-price" value="${strPrdtVO.evntPrdtVO.evntPrdtChngPrc}" readonly> --%>
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<%-- 									<input type="text" class="total-price" value="${strPrdtVO.prdtVO.prdtPrc}" readonly> --%>
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<button type="button" id="add_btn"class="btn btn-success">추가</button> -->
<!-- 				<button type="button" id="cancle_btn" class="btn btn-secondary">목록</button> -->
<!-- 			</div> -->
	
<!-- 		<br>정보확인용 -->
<%-- 		<br>상품ID : ${strPrdtVO.strPrdtId} --%>
<%-- 		<br>매장ID : ${strPrdtVO.strId} --%>
<%-- 		<br>이벤트 이름 : ${strPrdtVO.evntVO.evntTtl}	 --%>
<%-- 		<fmt:parseDate value="${strPrdtVO.evntVO.evntStrtDt}" var="startDt" pattern="yyyy-MM-dd"></fmt:parseDate> --%>
<%-- 		<fmt:parseDate value="${strPrdtVO.evntVO.evntEndDt}" var="endDt" pattern="yyyy-MM-dd"></fmt:parseDate> --%>
<%-- 		<br>이벤트 기간 : <fmt:formatDate value="${startDt}" pattern="yyyy.MM.dd"/>  ~ <fmt:formatDate value="${endDt}" pattern="yyyy.MM.dd"/> --%>

</body>
</html>