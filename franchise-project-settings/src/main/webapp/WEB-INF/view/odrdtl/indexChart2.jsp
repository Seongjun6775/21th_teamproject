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
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">

$().ready(function() {
	
	$("#myChartUl").on("click","li", (function() {
		var srt = $(this).data().id;
		groupData(null,null,null, srt)
	})).on("click", "a", (function(e) {
		e.preventDefault();
	}));
	
    // 시작 시 화면 내용 채우기
	getSrtList();
    groupData();
    
})

function groupData(monthly, lct, cty, srt) {
	
	var strId = ""
	if ("${sessionScope.__MBR__.mbrLvl}" != "001-01") {
		strId = "${sessionScope.__MBR__.strId}"
	}
	
	var odrDtlVO = {
		odrDtlStrId : strId,
		monthly : monthly,
		orderBy : null,
		lctCdVO : {lctId : lct},
		ctyCdVO : {ctyId : cty},
		prdtVO :  {prdtSrt : srt}
	}
	$.ajax({
		url: "${context}/api/index/paymentPrdtOneWeek",
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
			var limitCnt = 5;
			for (var i = 0; i <  (data.length < limitCnt ? data.length : limitCnt) ; i++) {
				var cdNm = data[i].prdtVO.cmmnCdVO.cdNm;
				var prdtId = data[i].prdtVO.prdtId
				var prdtNm = data[i].prdtVO.prdtNm;
				var sumCnt = data[i].sumCnt;
				var sumPrc = data[i].sumPrc;
				if (srt == null || srt.length == 0) {
					nmlist.push(cdNm);
				} else {
					nmlist.push(prdtNm);
				}
				cntlist.push(sumCnt);
				prclist.push(sumPrc);
		    }
			
			var myChart = $("#myChartPrc");
			var ctx = makeChart(nmlist, prclist, "판매금액", "원");
			myChart.html(ctx)
		}
	})
			
			
	odrDtlVO = {
		odrDtlStrId : strId,
		monthly : monthly,
		orderBy : "SUM_CNT DESC",
		lctCdVO : {lctId : lct},
		ctyCdVO : {ctyId : cty},
		prdtVO :  {prdtSrt : srt}
	}
	$.ajax({
		url: "${context}/api/index/paymentPrdtOneWeek",
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
			var limitCnt = 5;
			for (var i = 0; i <  (data.length < limitCnt ? data.length : limitCnt) ; i++) {
				var cdNm = data[i].prdtVO.cmmnCdVO.cdNm;
				var prdtId = data[i].prdtVO.prdtId
				var prdtNm = data[i].prdtVO.prdtNm;
				var sumCnt = data[i].sumCnt;
				var sumPrc = data[i].sumPrc;
				if (srt == null || srt.length == 0) {
					nmlist.push(cdNm);
				} else {
					nmlist.push(prdtNm);
				}
				cntlist.push(sumCnt);
				prclist.push(sumPrc);
		    }
			
			var myChart = $("#myChartCnt");
			var ctx = makeChart(nmlist, cntlist, "판매수량", "개");
			myChart.html(ctx)
		}
	})
}

function getRandomColor() {
	var letters = '0123456789ABCDEF'.split('');
	var color = '#';
	for (var i = 0; i < 6; i++ ) {
	    color += letters[Math.floor(Math.random() * 16)];
	}
	return color;
}

function makeChart(nmlist, datalist, label ,labelText) {

	var colors=[];
	for(var i=0 ; i<datalist.length ; i++){
	      colors.push(getRandomColor());
	}
	var ctx = $("<canvas></canvas>")
	new Chart(ctx, {
		type: 'doughnut',
		data: {
			labels: nmlist,
			datasets: [{
				label: label,
				data: datalist,
				backgroundColor: colors,
				xAxisID: 'x',
				borderWidth: 1,
				pointStyle: 'Rounded',
				pointRadius: 1,
			}]
		},
		options: {
			animateRotate : true,
			legend: {
				usePointStyle: true,
	            display: true,
	            labels: {
	            },
	        },
		}
	});
	return ctx;
	
}

function getSrtList() {
	
	var cmmnCdVO = {};
		
	$.ajax({
		url: "${context}/api/cmmnCd/prdtSrt",
		type: "GET",
		success: function(data) {
			
			var ul = $("#myChartUl");
			var li = $("<li data-id=''><a href='#'>전체</li>");
			
			ul.empty();
// 			li.text("전체");
			ul.append(li);
			for (var i = 0; i < data.length ; i++) {
				var id = data[i].cdId;
				var nm = data[i].cdNm;
				var a = $("<a href='#'>"+nm+"</a>");
				li = $("<li data-id='"+id+"'></li>");
				li.css("margin-left","10px")
				li.append(a);
				ul.append(li);
		    }
			
		}
	})

}

</script>
</head>
<body>
		<div class="indexChart2 flex-column align-center">	
			<div style="align-self: center;">
				<ul id="myChartUl"class="indexChartUl" style="width:100%; display: flex; padding:0; list-style-type: none;">
				</ul>
			</div>
			<div class="flex-row">
				<div class="half-left">
					<div id="myChartPrc" class="overflow chart"></div>
					<div>판매금액</div>
				</div>
				<div class="half-right">
					<div id="myChartCnt" class="overflow chart"></div>
					<div>판매수량</div>
				</div>
			</div>
		</div>
</body>
</html>