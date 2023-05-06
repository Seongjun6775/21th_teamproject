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
	
	var now = new Date();
	var year = now.getFullYear();//연도
    var month = now.getMonth()+1 < 10 ? "0" + (now.getMonth()+1) : "" + (now.getMonth()+1);//월
    var day = now.getDate() < 10 ? "0" + now.getDate() : "" + now.getDate();//월
	startEnd(year +"-"+ month);
    $("#clickMonthSave").val(year +"-"+ month);
    $("#clickDaySave").val(year +"-"+ month +"-"+ day);
    
    
	sumMonth();
	groupPrdt($("#clickDaySave").val());
    
    
	$("#btn-search").click(function() {
		sumMonth();
	})
	
	$("#sumMonth").on("click", "td", function() {
		var oneday = $(this).data().oneday;
		if (oneday == null || oneday == "") return; 
		$(this).closest("tbody").find(".on").removeClass("on");
		$(this).addClass("on");
		$("#clickMonthSave").val(oneday)
		$("#clickDaySave").val("")
		
		startEnd(oneday);
		groupPrdt(oneday);
	});
	$("#startEnd").on("click", "tr", function() {
		var oneday = $(this).data().oneday;
		console.log(oneday)
		if (oneday == null || oneday == "") return; 
		$(this).closest("tbody").find(".on").removeClass("on");
		$(this).addClass("on");
		$("#clickDaySave").val(oneday)
		
		groupPrdt(oneday);
	});


	
	
	// 조건변경 시 데이터 실시간 변경
	$("select[name=selectFilter]").on("change", function(event) {
// 		groupPrdt();
		sumMonth();
		startEnd($("#clickMonthSave").val());
		
		groupPrdt($("#clickDatSave").val() != "" ? $("#clickDaySave").val() : $("#clickMonthSave").val())
	});
	$("input[type=date]").on("change", function(event) {
		var startDt = new Date($("#search-keyword-startdt").val());
		var endDt = new Date($("#search-keyword-enddt").val());
		console.log(startDt)
		console.log(endDt)
		if (startDt > endDt) {
			var temp = startDt;
			$("#search-keyword-startdt").val($("#search-keyword-enddt").val());
			$("#search-keyword-enddt").val(temp.toISOString().substring(0, 10));
		}
		groupPrdt();
	});
	
	


	
})



function groupPrdt(monthly) {
	
	var odrDtlVO = {
		odrDtlStrId : $("#search-keyword-str").val(),
		monthly : monthly,
		prdtVO :  {prdtSrt : $("#search-keyword-prdtSrt").val()}
	}
	$.ajax({
		url: "${context}/api/payment/groupPrdt",
		type: "POST",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(odrDtlVO),
		success: function(data) {
			
			var cnt = 0;
			var pay = 0;
			$("#paymentStr").empty();
			for (var i = 0; i < data.length; i++) {
			    var cdNm = data[i].prdtVO.cmmnCdVO.cdNm;
			    var prdtNm = data[i].prdtVO.prdtNm;
			    var sumCnt = data[i].sumCnt;
			    var sumPrc = data[i].sumPrc;
			    var tr = $("<tr data-prdtid="+data[i].prdtVO.prdtId+" data-prdtnm="+encodeURIComponent(data[i].prdtVO.prdtNm)+"></tr>");
			    var tdList = [
					  $("<td>" + cdNm + "</td>"),
					  $("<td>" + prdtNm + "</td>"),
					  $("<td>" + sumCnt.toLocaleString() + "</td>"),
					  $("<td class='money' style='padding-right: 10px;'>" + sumPrc.toLocaleString() + "</td>"),
					];
			    cnt += sumCnt;
			    pay += sumPrc;
				tr.append(tdList);
				$("#paymentStr").append(tr);
		    }
			tr =  $("<tr data-prdtid='' data-prdtnm=''></tr>");
			tr.append("<td colspan='2'>합계</td>")
			tr.append("<td>"+cnt.toLocaleString()+"</td>")
			tr.append("<td class='money' style='padding-right: 10px;'>"+pay.toLocaleString()+"</td>")
			$("#paymentStr").append(tr);
			
			var requirement = monthly.length < 8 ? monthly + " 한달" : monthly + " 하루";
			$("#requirement").html(requirement + " 데이터");
			
		}
	})
}

function startEnd(oneday, prdtId) {
	
	var odrDtlVO = {
		odrDtlStrId : $("#search-keyword-str").val(),
		monthly : oneday,
		prdtVO :  {prdtSrt : $("#search-keyword-prdtSrt").val()},
		odrDtlPrdtId : prdtId
	}
	
	$.ajax({
		url: "${context}/api/payment/startEnd",
		type: "POST",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(odrDtlVO),
		success: function(data) {
			
			var dayCnt = 0;
			var pay = 0;
			$("#startEnd").empty();
			for (var i = 0; i < data.length; i++) {
			    var oneDay = data[i].oneDay;
			    var sumPrc = data[i].sumPrc;
			    if(sumPrc > 0) {
			    	dayCnt++;
			    	pay += sumPrc;
			    }
			    
			    var tr = $("<tr data-oneday='"+oneDay+"'></tr>");
			    if ($("#clickDaySave").val() == oneDay) {
					tr.addClass("on")
				}
			    var tdList = [
					  $("<td>" + oneDay + "</td>"),
					  $("<td class='money' style='padding-right: 10px;'>" + sumPrc.toLocaleString() + "</td>"),
					];
				tr.append(tdList);
				$("#startEnd").append(tr);
		    }
			tr =  $("<tr></tr>");
			tr.append("<td>합계</td>")
			tr.append("<td class='money' style='padding-right: 10px;'>"+pay.toLocaleString()+"</td>")
			$("#startEnd").append(tr);
			
		}
	})
}

function sumMonth(prdtId, prdtNm) {
	
	var odrDtlVO = {
		odrDtlStrId : $("#search-keyword-str").val(),
		prdtVO :  {prdtSrt : $("#search-keyword-prdtSrt").val()},
		odrDtlPrdtId : prdtId
	}
	
	$.ajax({
		url: "${context}/api/payment/sumMonth",
		type: "POST",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(odrDtlVO),
		success: function(data) {
			
			var M = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			var pay = 0;
			var sum = 0;
			var tbody = $("#sumMonth");
			tbody.empty();
			for (var i = 0; i < data.length; i++) {
			    var yearly = data[i].yearly;
			    var monthly = data[i].monthly;
			    var sumPrc = data[i].sumPrc;
			    M[monthly-1] += sumPrc;
			    pay += sumPrc;
			    sum += sumPrc;
			    if (monthly == 1) {
			    	var tr = $("<tr></tr>");
			    	var td = [
			    		$("<td>"+yearly+"</td>"),
			    		$("<td class='sumX money' style='padding-right: 10px;'></td>")
		    		]
					tr.append(td);
			    }
			    var td = $("<td data-oneday='"+yearly+"-"+monthly+"' class='money' style='padding-right: 10px;'>" + sumPrc.toLocaleString() + "</td>");
				if ($("#clickMonthSave").val() == (yearly+"-"+monthly)) {
					td.addClass("on")
				}
			    
// 			    if (sumPrc == 0) td.css("color","lightgray")
			    if (monthly == 12) {
			    	tr.children("td.sumX").text(sum.toLocaleString());
			    	sum = 0;
			    }
			    
				tr.append(td);
				tbody.append(tr);
		    }
			tr =  $("<tr></tr>");
			tr.append("<td>합계</td>")
			tr.append("<td class='money' style='padding-right: 10px;'>"+pay.toLocaleString()+"</td>")
			$.each(M, function(i,v) {
				tr.append("<td class='money' style='padding-right: 10px;'>"+v.toLocaleString()+"</td>")
			});
			tbody.append(tr);
			
			
		}
	})
}






</script>
</head>
<body>
	
	<jsp:include page="../include/openBody.jsp" />
		
		<input id="clickMonthSave" type="text" value="" style="display: none;">
		<input id="clickDaySave" type="text" value="" style="display: none;">
		
		<!-- contents -->
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<span class="fs-5 fw-bold">상품별 매출</span>
		</div>

		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<div class="top-bar">
				<div>
					<label for="search-keyword-str" class="col-form-label">조회 매장</label>
					<select name="selectFilter"
							id="search-keyword-str"
							class="form-select" 
							style="width:200px;">
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
				</div>
				<div>
					<label for="search-keyword-prdtSrt" class="col-form-label">상품분류</label>
					<select name="selectFilter"
							id="search-keyword-prdtSrt"
							class="form-select" 
							style="width:140px;">
						<option value="">전체</option>
						<c:choose>
							<c:when test="${not empty srtList}">
								<c:forEach items="${srtList}"
											var="srt">
									<option value="${srt.cdId}">${srt.cdNm}</option>
								</c:forEach>
							</c:when>
						</c:choose>
					</select>
				</div>
				<div>
					<label for="search-keyword-prdtSrt" class="col-form-label">상품이름</label>
					<select name="selectFilter"
							id="search-keyword-prdtSrt"
							class="form-select" 
							style="width:140px;">
						<option value="">전체</option>
						<c:choose>
							<c:when test="${not empty srtList}">
								<c:forEach items="${srtList}"
											var="srt">
									<option value="${srt.cdId}">${srt.cdNm}</option>
								</c:forEach>
							</c:when>
						</c:choose>
					</select>
				</div>
				<button id="btn-search" class="btn btn-outline-success btn-default" type="submit" >Search</button>
			</div>
		</div>
		
		
		
		
	
		<div class="bg-white rounded shadow-sm flex-column" style="padding: 23px 18px 23px 18px; max-height: 400px; margin: 20px;">
			<div class="flex paymentTop">
<!-- 					<div id="dayCnt"></div> -->
<!-- 					<div id="paymentAvg"></div> -->
				<div class="align-right">단위: 원</div>
			</div>
			<div class="overflow">
				<table class="forStatistics table table-striped table-sm table-hover align-center">
					<thead class="table-secondary">
						<tr>
							<th class="min-width80 width80">연도</th>
							<th class="min-width120">판매총액</th>
							<th class="min-width120">JAN</th>
							<th class="min-width120">FEB</th>
							<th class="min-width120">MAR</th>
							<th class="min-width120">APR</th>
							<th class="min-width120">MAY</th>
							<th class="min-width120">JUN</th>
							<th class="min-width120">JUL</th>
							<th class="min-width120">AUG</th>
							<th class="min-width120">SEP</th>
							<th class="min-width120">OCT</th>
							<th class="min-width120">NOV</th>
							<th class="min-width120">DEC</th>
						</tr>
					</thead>
					<tbody id="sumMonth" class="table-group-divider last-tr-sticky">
					</tbody>
				</table>
			</div>
		</div>
			
		
		<div class="flex">
			<div style="flex: 1;"> 
				<div class="bg-white rounded shadow-sm flex-column" style="padding: 23px 18px 23px 18px; height: 640px; margin: 20px;">
					<div class="flex paymentTop">
						<div id="selectPrdtNm"></div>
					</div>
					<div class="overflow">
						<table class="table table-striped table-sm table-hover align-center">
							<thead class="table-secondary">
								<tr>
									<th style="width:45%">날짜</th>
									<th>판매총액</th>
								</tr>
							</thead>
							<tbody id="startEnd" class="table-group-divider last-tr-sticky">
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div style="flex: 2;">
				<div class="bg-white rounded shadow-sm flex-column" style="padding: 23px 18px 23px 18px; height: 640px; margin: 20px;">
					<div class="flex paymentTop">
						<div id="requirement"></div>
					</div>
					<div class="overflow">
						<table class="table table-striped table-sm table-hover align-center">
							<thead class="table-secondary">
								<tr>
									<th style="width:20%">상품분류</th>
									<th>상품이름</th>
									<th style="width:15%">판매수량</th>
									<th style="width:15%">판매총액</th>
								</tr>
							</thead>
							<tbody id="paymentStr" class="table-group-divider last-tr-sticky">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		
	<jsp:include page="../include/closeBody.jsp" />

</body>
</html>