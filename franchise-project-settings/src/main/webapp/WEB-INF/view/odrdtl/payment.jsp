<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">


function secId(mbrId) {
	return mbrId.substring(0, mbrId.length - 3) + "***";
}

  	
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	$("#search-keyword-str").val("${odrDtlVO.odrDtlStrId}");
	
	
	
	groupPrdt();
	startEnd();
	
	$("#btn-search").click(function() {
		groupPrdt();
		startEnd();
	})
	
	
	
	
	
	
})





function groupPrdt() {
	
	var odrDtlVO = {
		odrDtlStrId : $("#search-keyword-str").val(),
		startDt : $("#search-keyword-startdt").val(),
		endDt : $("#search-keyword-enddt").val()
	}
	
	$.ajax({
		  url: "${context}/api/payment/groupPrdt",
		  type: "POST",
		  contentType: "application/json",
		  dataType: "json",
		  data: JSON.stringify(odrDtlVO),
		  success: function(data) {
		
		var pay = 0;
		$("#paymentStr").empty();
		for (var i = 0; i < data.length; i++) {
		    var cdNm = data[i].prdtVO.cmmnCdVO.cdNm;
		    var prdtNm = data[i].prdtVO.prdtNm;
		    var sumCnt = data[i].sumCnt;
		    var sumPrc = data[i].sumPrc;
		    var tr = $("<tr></tr>");
		    var tdList = [
				  $("<td>" + cdNm + "</td>"),
				  $("<td>" + prdtNm + "</td>"),
				  $("<td>" + sumCnt.toLocaleString() + "</td>"),
				  $("<td class='money' style='padding-right: 10px;'>" + sumPrc.toLocaleString() + "</td>"),
				];
		    pay = pay + sumPrc;
			tr.append(tdList);
			$("#paymentStr").append(tr);
	    }
		
		var div = $("<div> 총 금액 : "+pay.toLocaleString() +"원</div>")
		div.css({
			"text-align":"right",
			"font-weight":"bold",
		});
		$("#paymentTotal").html(div);
	}})
}
function startEnd() {
	
	var odrDtlVO = {
		odrDtlStrId : $("#search-keyword-str").val(),
		startDt : $("#search-keyword-startdt").val(),
		endDt : $("#search-keyword-enddt").val()
	}
	
	$.ajax({
		  url: "${context}/api/payment/startEnd",
		  type: "POST",
		  contentType: "application/json",
		  dataType: "json",
		  data: JSON.stringify(odrDtlVO),
		  success: function(data) {
		
		$("#startEnd").empty();
		for (var i = 0; i < data.length; i++) {
		    var oneDay = data[i].oneDay;
		    var sumPrc = data[i].sumPrc;
		    var tr = $("<tr></tr>");
		    var tdList = [
				  $("<td>" + oneDay + "</td>"),
				  $("<td class='money' style='padding-right: 10px;'>" + sumPrc.toLocaleString() + "</td>"),
				];
			tr.append(tdList);
			$("#startEnd").append(tr);
	    }
		
	}})
}



function movePage(pageNo) {
	var strId = $("#search-keyword-str").val(); 
	var startDt = $("#search-keyword-startdt").val();
	var endDt = $("#search-keyword-enddt").val();
	
	var queryString = "odrDtlStrId=" + strId;
	queryString += "&startDt=" + startDt;
	queryString += "&endDt=" + endDt;
	
	location.href = "${context}/payment?" + queryString; // URL 요청
} 
</script>
</head>
<body>
	
	<jsp:include page="../include/openBody.jsp" />
		
		<!-- contents -->
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<span class="fs-5 fw-bold">상품별 매출</span>
		</div>

		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<div class="top-bar">
				<label for="search-keyword-str" class="col-form-label">조회 매장</label>
				<select name="selectFilter"
						id="search-keyword-str"
						class="form-select" 
						style="width:300px;">
					<option value="">전체</option>
					<c:choose>
						<c:when test="${not empty strList}">
							<c:forEach items="${strList}"
										var="str">
								<c:if test="${str.useYn eq 'Y'}">
									<option value="${str.strId}">${str.strNm} (${str.strId})</option>
								</c:if>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>
				<input type="date" id="search-keyword-startdt" 
						class="form-control width180" value="${odrDtlVO.startDt}"/>
				<input type="date" id="search-keyword-enddt" 
						class="form-control width180" value="${odrDtlVO.endDt}"/>
				<button id="btn-search" class="btn btn-outline-success btn-default" type="submit" >Search</button>
			</div>
		</div>
		
		
		
		
		<div class="bg-white rounded shadow-sm " style="padding: 23px 18px 23px 18px; margin: 20px;">
			<div class="inline-flex">
				
				<div id="paymentTotal"></div>
			</div>
		</div>
		
		
		
		<div class="inline-flex">
			<div class="bg-white rounded shadow-sm " style="padding: 23px 18px 23px 18px; width: 70%; max-height: 640px; margin: 20px;">
				
				<table class="table table-striped table-sm table-hover align-center">
					<thead class="table-secondary">
						<tr>
							<th style="width:15%">상품분류</th>
							<th>상품이름</th>
							<th style="width:15%">판매수량</th>
							<th style="width:15%">판매총액</th>
						</tr>
					</thead>
					<tbody id="paymentStr" class="table-group-divider">
					</tbody>
				</table>
			</div>
			
			<div class="bg-white rounded shadow-sm flex" style="padding: 23px 18px 23px 18px; width: 30%; max-height: 640px; margin: 20px;">
				<div class="overflow">
					<table class="table table-striped table-sm table-hover align-center">
						<thead class="table-secondary">
							<tr>
								<th style="width:50%">Date</th>
								<th>판매총액</th>
							</tr>
						</thead>
						<tbody id="startEnd" class="table-group-divider">
						</tbody>
					</table>
				</div>
			</div>
			
		</div>


		<!-- /contents -->
		
	<jsp:include page="../include/closeBody.jsp" />


</body>
</html>