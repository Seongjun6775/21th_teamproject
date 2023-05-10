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
	
	
	$("#odr-btn").click(function() {
		if ("${sessionScope.__MBR__.mbrId}" == "") {
			Swal.fire({
			     title: '로그인 필요',
			     text: "로그인이 필요합니다.\n로그인 하시겠습니까?",
			     icon: 'warning',
			     showCancelButton: true,
			     confirmButtonColor: '#3085d6',
			     cancelButtonColor: '#d33',
			     cancelButtonText: '취소',
			     confirmButtonText: '로그인'
			   }).then((result) => {
			      if(result.isConfirmed){
			         $("#img_btn").click();
			      }else{
			         $("#btn-modal-close").click();
			      }
			});
		}
		else {
			location.href = "${context}/strprdt/list2";
		}
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
<body class="scroll">

	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">메뉴</div>
		<div class="overlay absolute"></div>
	</div>
	
	
	
	<div id="menu" class="flex-column relative">
		
		<div class="default-padding flex prdt-detail" style="margin-top: 144px">
		
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
				<div style="">
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
					
					<div>
						<button id="odr-btn" class="btn btn-outline-warning" >주문 페이지</button>
					</div>
				</div>
				
			</div>
		</div>			
		
	</div>
	
	
	<jsp:include page="../include/footer_user.jsp" />


</body>
</html>