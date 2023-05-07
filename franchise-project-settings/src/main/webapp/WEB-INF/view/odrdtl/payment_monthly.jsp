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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
    
    
    // 시작 시 화면 내용 채우기
	sumMonth();
	groupPrdt($("#clickDaySave").val());
	prdtList();
    
	
	
	$("#btn-search").click(function() {
		var prdtId = $("#search-keyword-prdt").val();
		sumMonth(prdtId);
		startEnd($("#clickMonthSave").val(), prdtId);
		groupPrdt($("#clickDatSave").val() != "" ? $("#clickDaySave").val() : $("#clickMonthSave").val())
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
		if (oneday == null || oneday == "") return; 
		$(this).closest("tbody").find(".on").removeClass("on");
		$(this).addClass("on");
		$("#clickDaySave").val(oneday)
		
		groupPrdt(oneday);
	});


	
	
	// 조건변경 시 데이터 실시간 변경
	$("select[name=selectFilter]").on("change", function() {
		if ($(this).attr("id") == "search-keyword-prdtSrt") {
			prdtList($(this).val());
			var prdtId = "";
		} else {
			var prdtId = $("#search-keyword-prdt").val();
		}
		sumMonth(prdtId);
		startEnd($("#clickMonthSave").val(), prdtId);
		groupPrdt($("#clickDaySave").val() != "" ? $("#clickDaySave").val() : $("#clickMonthSave").val())
	});
	
	
	
	
	
	
	
	$("#btn-type").click(function() {
		if ($("#checkCntPrc").is(":checked")) {
			$("#checkCntPrc").prop("checked", false);
			$(this).text("수량 보기");
			$("#unit").text("단위: 원");
		} else {
			$("#checkCntPrc").prop('checked', true);
			$(this).text("금액 보기");
			$("#unit").text("단위: 개");
		}
		sumMonth();
		startEnd($("#clickMonthSave").val());
	}).mouseover(function() {
		if ($("#checkCntPrc").is(":checked")) {
			$(this).text("금액 보기");
		} else $(this).text("수량 보기");
	}).mouseout(function() {
		if ($("#checkCntPrc").is(":checked")) {
			$(this).text("수량 보기");
		} else $(this).text("금액 보기");
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
			var nmlist = []
			var cntlist = []
			var prclist = []
			$("#paymentStr").empty();
			for (var i = 0; i < data.length; i++) {
				var cdNm = data[i].prdtVO.cmmnCdVO.cdNm;
				var prdtId = data[i].prdtVO.prdtId
				var prdtNm = data[i].prdtVO.prdtNm;
				var sumCnt = data[i].sumCnt;
				var sumPrc = data[i].sumPrc;
				nmlist.push(prdtNm);
				cntlist.push(sumCnt);
				prclist.push(sumPrc);
				var tr = $("<tr data-prdtid="+prdtId+" data-prdtnm="+encodeURIComponent(prdtNm)+"></tr>");
				var tdList = [
					  $("<td>" + cdNm + "</td>"),
					  $("<td>" + prdtNm + "</td>"),
					  $("<td>" + sumCnt.toLocaleString() + "</td>"),
					  $("<td class='money' style='padding-right: 10px;'>" + sumPrc.toLocaleString() + "</td>"),
					];
				if (prdtId == $("#search-keyword-prdt").val()) {
					tr.addClass("selected");
				}
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
			
			var requirement = monthly.length > 8 ? monthly + " 하루" : monthly.length > 4 ? monthly + " 한달" : monthly + " 일년";
			$("#requirement").html(requirement + " 데이터");
			
			
			
			var myChart = $("#myChart");
			var ctx = $("<canvas></canvas>")
			new Chart(ctx, {
				type: 'bar',
				data: {
					labels: nmlist,
					datasets: [{
						type: 'bar',
						label: '판매총액',
						backgroundColor: 'rgb(75, 192, 192)',
						data: prclist,
						xAxisID: 'x',
						borderWidth: 1	
					}, {
						type: 'bar',
						label: '판매수량',
						data: cntlist,
						backgroundColor: 'rgb(255, 99, 132)',
						xAxisID: 'x_sub',
						borderWidth: 1
					}]
				},
				options: {
					grouped: true,
					indexAxis: 'y',
					scales: {
						x: { 
							beginAtZero: true,
							ticks: {
								count:11,
								stepSize: 10000,
							},
							axis: 'x',
							position: 'top',
							title: {
								display: true,
								align: 'end',
								color: '#808080',
								text: '단위: 원',
								font: {
									size: 12,
									family: "'Noto Sans KR', sans-serif",
									weight: 300,
								}
							}
						},
						x_sub: {
							beginAtZero: (c) => {
								c.chart.config.options.scales.x.beginAtZero
							},
							ticks: {
								count:(c) => {
									return c.chart.config.options.scales.x.ticks.count
								},
								stepSize: 10,
							},
							axis: 'x',
							position: 'bottom',
							title: {
								display: true,
								align: 'end',
								color: '#808080',
								text: '단위: 개',
								font: {
									size: 12,
									family: "'Noto Sans KR', sans-serif",
									weight: 300,
								}
							}
						},
						y: { 
							
						},
					},
					plugins: {
			            tooltip: {
			                callbacks: {
			                    labelTextColor: function(context) {
			                        return 'white';
			                    },
								label: (context) => {
									let label = context.dataset.label || '';
									let value = context.parsed.x;
									 if (context.dataset.label === '판매총액') {
										return label + ' : ' + value.toLocaleString() + '원';
									} else if (context.dataset.label === '판매수량') {
										return label + ' : ' + value.toLocaleString() + '개';
									} else {
										return label + ' : ' + value.toLocaleString();
									}
								},
							},
		                }
		            }
				}
			});
			myChart.html(ctx)
			
			  
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
			    var sumPrc = $("#checkCntPrc").is(":checked") ? data[i].sumCnt : data[i].sumPrc;
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
			    var sumPrc = $("#checkCntPrc").is(":checked") ? data[i].sumCnt : data[i].sumPrc;
			    M[monthly-1] += sumPrc;
			    pay += sumPrc;
			    sum += sumPrc;
			    if (monthly == 1) {
			    	var tr = $("<tr></tr>");
			    	var td = [
			    		$("<td data-oneday='"+yearly+"'>"+yearly+"</td>"),
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

function prdtList(srt) {
	
	var prdtVO = {
			prdtSrt : srt
		}
	$.ajax({
		url: "${context}/api/prdt/srtOfPrdt",
		type: "POST",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(prdtVO),
		success: function(data) {
			
			var selectbox = $("#search-keyword-prdt");
			selectbox.empty();
		    selectbox.append($("<option value=''>전체</option>"));
			for (var i = 0; i < data.length; i++) {
			    var id = data[i].prdtId;
			    var nm = data[i].prdtNm;
			    var op = $("<option value='"+id+"'>"+nm+"</option>")
			    selectbox.append(op);
			}
		}
	})
}




</script>
</head>
<body>
	
	<jsp:include page="../include/openBody.jsp" />

		<input id="clickMonthSave" type="text" value="" style="display: none;">
		<input id="clickDaySave" type="text" value="" style="display: none;">
		<input id="checkCntPrc" type="checkbox" value="" style="display: none;">
		
		<!-- contents -->
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<span class="fs-5 fw-bold">상품별 매출 <a href="${context}/payment/">기간조회용</a> </span>
		</div>

		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<div class="top-bar">
				<div>
					<button id="btn-type" type="button" class="btn btn-outline-warning btn-default" >금액 보기</button>
					<label for="search-keyword-str" class="col-form-label">조회 매장</label>
					<select name="selectFilter"
							id="search-keyword-str"
							class="form-select" 
							<c:if test="${sessionScope.__MBR__.mbrLvl ne '001-01'}"> disabled </c:if>
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
					<label for="search-keyword-prdt" class="col-form-label">상품이름</label>
					<select name="selectFilter"
							id="search-keyword-prdt"
							class="form-select" 
							style="width:140px;">
					</select>
				</div>
				<button id="btn-search" class="btn btn-outline-success btn-default" type="submit" >Search</button>
			</div>
		</div>
		
		
		
		
	
		<div class="bg-white rounded shadow-sm flex-column" style="padding: 23px 18px 23px 18px; max-height: 400px; margin: 20px;">
			<div class="flex paymentTop">
<!-- 					<div id="dayCnt"></div> -->
<!-- 					<div id="paymentAvg"></div> -->
				<div class="align-right"><span id="unit">단위: 원</span></div>
			</div>
			<div class="overflow">
				<table class="forStatistics table table-striped table-sm table-hover align-center">
					<thead class="table-secondary">
						<tr>
							<th class="min-width80 width80">연도</th>
							<th class="min-width120">판매총액</th>
							<th class="min-width120">1월</th>
							<th class="min-width120">2월</th>
							<th class="min-width120">3월</th>
							<th class="min-width120">4월</th>
							<th class="min-width120">5월</th>
							<th class="min-width120">6월</th>
							<th class="min-width120">7월</th>
							<th class="min-width120">8월</th>
							<th class="min-width120">9월</th>
							<th class="min-width120">10월</th>
							<th class="min-width120">11월</th>
							<th class="min-width120">12월</th>
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
		
		<div class="bg-white rounded shadow-sm flex" style="padding: 23px 18px 23px 18px; margin: 20px;">
			<div id="myChart" class="overflow chart" style="width: 100%;"></div>
		</div>	
		
	<jsp:include page="../include/closeBody.jsp" />

</body>
</html>