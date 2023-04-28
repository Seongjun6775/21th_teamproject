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
<link rel="stylesheet" href="${context}/css/strprdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	

	
	
	$("#all-check02").change(function(){
		$(".check-idx02").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx02:checked").length;
		//chkCount(checkLen);
	})
	$(".check-idx02").change(function(){
		var count = $(".check-idx02").length;
		var checkCount = $(".check-idx02:checked").length;
		$("#all-check02").prop("checked", count == checkCount);
	});
	
	$("#all-check03").change(function(){
		$(".check-idx03").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx03:checked").length;
		//chkCount(checkLen);
	})
	$(".check-idx03").change(function(){
		var count = $(".check-idx03").length;
		var checkCount = $(".check-idx03:checked").length;
		$("#all-check03").prop("checked", count == checkCount);
	});

	
	$("#btn-complete02").click(function() {
		var checkLen = $(".check-idx02:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if (!confirm("체크한 항목이 일괄 수정됩니다.")) {
			return;
		}
		
		
		var odrLstIdList = [];
		$(".check-idx02:checked").each(function() {
		    odrLstIdList.push($(this).val());
		});
		console.log(odrLstIdList);
		var odrLstVO = {
				"mdfyr" : "${mbrVO.mbrId}",
				"odrLstOdrPrcs" : "003-03",
				"odrLstIdList" : odrLstIdList
		};
		
		$.ajax({
		    type: "POST",
		    url: "${context}/api/odrLst/updateCheckAll",
		    data: JSON.stringify(odrLstVO),
            contentType: "application/json",
		    success: function(response) {
		        if (response.status == "200 OK") {
		            location.reload(); //새로고침
		        }
		        else {
					alert(response.errorCode + " / " + response.message);
				}
		    }
		});
		
		
	})
	
	$("#btn-cancle02").click(function() {
		var checkLen = $(".check-idx02:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if (!confirm("주문취소 ? ")) {
			return;
		}
		
		
		var odrLstIdList = [];
		$(".check-idx02:checked").each(function() {
			console.log($(this).val());
		    odrLstIdList.push($(this).val());
		});
		console.log(odrLstIdList);
		var odrLstVO = {
				"mdfyr" : "${mbrVO.mbrId}",
				"odrLstOdrPrcs" : "003-05",
				"odrLstIdList" : odrLstIdList
		};
		
		$.ajax({
		    type: "POST",
		    url: "${context}/api/odrLst/updateCheckAll",
		    data: JSON.stringify(odrLstVO),
            contentType: "application/json",
		    success: function(response) {
		        if (response.status == "200 OK") {
		            location.reload(); //새로고침
		        }
		        else {
					alert(response.errorCode + " / " + response.message);
				}
		    }
		});
	})
	
	$("#btn-complete03").click(function() {
		var checkLen = $(".check-idx03:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if (!confirm("체크한 항목이 일괄 수정됩니다.")) {
			return;
		}
		
		
		var odrLstIdList = [];
		$(".check-idx03:checked").each(function() {
		    odrLstIdList.push($(this).val());
		});
		console.log(odrLstIdList);
		var odrLstVO = {
				"mdfyr" : "${mbrVO.mbrId}",
				"odrLstOdrPrcs" : "003-04",
				"odrLstIdList" : odrLstIdList
		};
		
		$.ajax({
		    type: "POST",
		    url: "${context}/api/odrLst/updateCheckAll",
		    data: JSON.stringify(odrLstVO),
            contentType: "application/json",
		    success: function(response) {
		        if (response.status == "200 OK") {
		            location.reload(); //새로고침
		        }
		        else {
					alert(response.errorCode + " / " + response.message);
				}
		    }
		});
		
		
	})
	
	$("#btn-cancle03").click(function() {
		var checkLen = $(".check-idx03:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if (!confirm("주문취소 ? ")) {
			return;
		}
		
		
		var odrLstIdList = [];
		$(".check-idx03:checked").each(function() {
			console.log($(this).val());
		    odrLstIdList.push($(this).val());
		});
		console.log(odrLstIdList);
		var odrLstVO = {
				"mdfyr" : "${mbrVO.mbrId}",
				"odrLstOdrPrcs" : "003-05",
				"odrLstIdList" : odrLstIdList
		};
		
		$.ajax({
		    type: "POST",
		    url: "${context}/api/odrLst/updateCheckAll",
		    data: JSON.stringify(odrLstVO),
            contentType: "application/json",
		    success: function(response) {
		        if (response.status == "200 OK") {
		            location.reload(); //새로고침
		        }
		        else {
					alert(response.errorCode + " / " + response.message);
				}
		    }
		});
	})
	
	
});


function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	
	var queryString = "?prdtSrt=" + srt;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/strprdt/${strVO.strId}"+ queryString; // URL 요청
} 

</script>
</head>
<body class="bg-dark bg-opacity-10 ">
<jsp:include page="../include/logo.jsp" />
	<main class="d-flex flex-nowrap ">	
		<jsp:include page="../include/sidemenu.jsp" />
		<div style="margin:0px 0px 0px 250px; width: 100%;">
			<jsp:include page="../include/header.jsp" />
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">기본페이지</span>
		    </div>
 
		    <!-- contents -->
		    <div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">



			<br>매장이름임 ${strVO.strNm} (${strVO.strId})
			<br>영업시간 ${strVO.strOpnTm} ~ ${strVO.strClsTm}
			<br>
			
			<div class="flex full">
				<div class="half-left">
					<div class="half-top div-table">
						<div class="topline">
							<div class="inline-block">주문접수</div>
							<div class="inline-block">
								<button id="btn-complete02" 
										class="btn-primary btn-create" 
										style="vertical-align: top;">주문처리</button>
										
								<button id="btn-cancle02" 
										class="btn-primary btn-delete" 
										style="vertical-align: top;">주문취소</button>
							</div>
						</div>
						
						<div class="overflow">
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" id="all-check02"/></th>
										<th>주문서ID</th>
										<th>주문자</th>
										<th>주문날짜</th>
										<th>처리자</th>
										<th>처리날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty ordLstList}">
											<c:forEach items="${ordLstList}"
														var="ordLst">
												<c:if test="${ordLst.odrLstOdrPrcs eq '003-02'}">
													<tr>
														<td class="align-center">
															<input type="checkbox" class="check-idx02" value="${ordLst.odrLstId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrId}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td>${ordLst.mdfyr}</td>							
														<td>${ordLst.mdfyDt}</td>							
													</tr>
												</c:if>
											</c:forEach>
										</c:when>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="half-bottom div-table">
						<div class="topline">
							<div class="inline-block">주문처리</div>
							<div class="inline-block">
								<button id="btn-complete03" 
										class="btn-primary btn-create" 
										style="vertical-align: top;">처리완료</button>
										
								<button id="btn-cancle03" 
										class="btn-primary btn-delete" 
										style="vertical-align: top;">주문취소</button>
							</div>
						</div>
						
						<div class="overflow">
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" id="all-check03"/></th>
										<th>주문서ID</th>
										<th>주문자</th>
										<th>주문날짜</th>
										<th>처리자</th>
										<th>처리날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty ordLstList}">
											<c:forEach items="${ordLstList}"
														var="ordLst">
												<c:if test="${ordLst.odrLstOdrPrcs eq '003-03'}">
													<tr>
														<td class="align-center">
															<input type="checkbox" class="check-idx03" value="${ordLst.odrLstId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrId}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td>${ordLst.mdfyr}</td>							
														<td>${ordLst.mdfyDt}</td>							
													</tr>
												</c:if>
											</c:forEach>
										</c:when>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			
				<div class="half-right div-table">
					<div class="topline">
						<div class="inline-block">처리완료</div>
					</div>
					
					<div class="overflow">
						<table>
							<thead>
								<tr>
									<th>주문서ID</th>
									<th>주문자</th>
									<th>주문날짜</th>
									<th>처리자</th>
									<th>처리날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty ordLstCompleteList}">
										<c:forEach items="${ordLstCompleteList}"
													var="ordLst">
											<tr>
												<td>${ordLst.odrLstId}</td>							
												<td>${ordLst.mbrId}</td>							
												<td>${ordLst.odrLstRgstDt}</td>							
												<td>${ordLst.mdfyr}</td>							
												<td>${ordLst.mdfyDt}</td>							
											</tr>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
					
	

		    </div>
      		<!-- /contents -->
		</div>
	</main>


</body>
</html>