<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="./include/stylescript.jsp" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<script type="text/javascript">
	var dataSet = [];

	function secId(mbrId) {
		return mbrId.substring(0, mbrId.length - 3) + "***";
	}

	// 매장별 매출 그래프
	function drawChart(dataSet, max, min) {

		google.charts.load("current", {
			packages : [ 'corechart' ]
		});
		google.charts.setOnLoadCallback(drawChart);

		var maxColor = "#f28f8c";
		var middleColor = "#fbfba1";
		var minColor = "#f4d8ad";

		var arrays = [ [ "매출일자", "매출액", {
			role : "style"
		} ] ];
		var i;
		if (dataSet.length == 0) {
			arrays[1] = [ '', 0, middleColor ];
		} else {
			for (i = 0; i < dataSet.length + 1; i++) {
				var color;
				if (dataSet[i].sumPrc == max) {
					color = maxColor;
				} else if (dataSet[i].sumPrc == min) {
					color = minColor;
				} else {
					color = middleColor;
				}

				console.log("dataSet[i].mdfyDt : " + dataSet[i].mdfyDt
						+ ", dataSet[i].sumPrc : " + dataSet[i].sumPrc
						+ ", color : " + color);
				arrays[i + 1] = [ dataSet[i].mdfyDt, dataSet[i].sumPrc, color ];
			}
		}

		function drawChart() {
			var data = google.visualization.arrayToDataTable(arrays);

			var view = new google.visualization.DataView(data);
			view.setColumns([ 0, 1, {
				calc : "stringify",
				sourceColumn : 1,
				type : "string",
				role : "annotation"
			}, 2 ]);

			var options = {
				title : "",
				width : 600,
				height : 500,
				bar : {
					groupWidth : "50%"
				},
				legend : {
					position : "none"
				},
			};
			var chart = new google.visualization.ColumnChart(document
					.getElementById("columnchart_values"));
			chart.draw(view, options);
		}

	}

	// 매장별 상품 그래프
	function drawChart2(dataSet, max, min) {

		google.charts.load("current", {
			packages : [ 'corechart' ]
		});
		google.charts.setOnLoadCallback(drawChart);

		var maxColor = "#f28f8c";
		var middleColor = "#fbfba1";
		var minColor = "#f4d8ad";

		var arrays = [ [ "매출일자", "매출액", {
			role : "style"
		} ] ];
		var i;
		if (dataSet.length == 0) {
			arrays[1] = [ '', 0, middleColor ];
		} else {
			for (i = 0; i < dataSet.length + 1; i++) {
				var color;
				if (dataSet[i].sumPrc == max) {
					color = maxColor;
				} else if (dataSet[i].sumPrc == min) {
					color = minColor;
				} else {
					color = middleColor;
				}

				console.log("dataSet[i].mdfyDt : " + dataSet[i].mdfyDt
						+ ", dataSet[i].sumPrc : " + dataSet[i].sumPrc
						+ ", color : " + color);
				arrays[i + 1] = [ dataSet[i].mdfyDt, dataSet[i].sumPrc, color ];
			}
		}

		function drawChart() {
			var data = google.visualization.arrayToDataTable(arrays);

			var view = new google.visualization.DataView(data);
			view.setColumns([ 0, 1, {
				calc : "stringify",
				sourceColumn : 1,
				type : "string",
				role : "annotation"
			}, 2 ]);

			var options = {
				title : "",
				width : 600,
				height : 500,
				bar : {
					groupWidth : "50%"
				},
				legend : {
					position : "none"
				},
			};
			var chart = new google.visualization.ColumnChart(document
					.getElementById("columnchart_values2"));
			chart.draw(view, options);
		}

	}
	// 날짜 포맷("yyyy-MM-dd")형식으로 반환
	dateFormatter = function(newDay, today) {

		let year = newDay.getFullYear()
		let month = newDay.getMonth() + 1
		let date = newDay.getDate()

		//기존 날짜와 새로운 날짜가 다를 경우
		if (today) {
			let todayDate = today.getDate()

			if (date != todayDate) {
				if (month == 0)
					year -= 1
				month = (month + 11) % 12
				date = new Date(year, month, 0).getDate() // 해당 달의 마지막 날짜를 반환   
			}
		}

		month = ("0" + month).slice(-2)
		date = ("0" + date).slice(-2)

		return year + "-" + month + "-" + date
	}

	$().ready(
			function() {

				console.log("ready function!")
				var ajaxUtil = new AjaxUtil();

				groupStr();

				$("#btn-search").click(function() {
					groupStr();
				})

				$("#btn-1month").click(
						function() {
							var myElementStrt = document
									.getElementById("search-keyword-startdt");
							let replaceDate = new Date($(
									"#search-keyword-enddt").val());

							replaceDate.setMonth(replaceDate.getMonth() - 1);
							replaceDate = dateFormatter(replaceDate);

							myElementStrt.value = replaceDate;
							groupStr();
						});

				$("#btn-3months").click(
						function() {
							var myElementStrt = document
									.getElementById("search-keyword-startdt");
							let replaceDate = new Date($(
									"#search-keyword-enddt").val());

							replaceDate.setMonth(replaceDate.getMonth() - 3);
							replaceDate = dateFormatter(replaceDate);

							myElementStrt.value = replaceDate;
							groupStr();
						});

				$("#btn-6months").click(
						function() {
							var myElementStrt = document
									.getElementById("search-keyword-startdt");
							let replaceDate = new Date($(
									"#search-keyword-enddt").val());

							replaceDate.setMonth(replaceDate.getMonth() - 6);
							replaceDate = dateFormatter(replaceDate);

							myElementStrt.value = replaceDate;
							groupStr();
						});
			})

	function groupStr() {

		console.log("strId : " + $("#search-keyword-strId").val() + "\n"
				+ "startDt : " + $("#search-keyword-startdt").val() + "\n"
				+ "endDt : " + $("#search-keyword-enddt").val() + "\n");

		var odrDtlVO = {
			strVO : {
				strId : $("#search-keyword-strId").val(),
			},
			startDt : $("#search-keyword-startdt").val(),
			endDt : $("#search-keyword-enddt").val()
		}

		$.ajax({
			url : "${context}/api/index/viewStrPayments",
			type : "POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(odrDtlVO),
			success : function(data) {
				
				for(var i = 0 ; i<data.sumYearOfStr.length; i+=1){
					console.log(data.sumYearOfStr[i].strVO.strNm);
					console.log(data.sumYearOfStr[i].sumPrc);
				}

				var pay = 0;
				var max = 0;
				var min = 0;
				dataSet = [];
				if (data.groupStr.length > 0) {
					max = data.groupStr[0].sumPrc;
					min = data.groupStr[0].sumPrc;
				}

				for (var i = 0; i < data.groupStr.length; i++) {
					var strNm = data.groupStr[i].strVO.strNm;
					var mdfyDt = data.groupStr[i].mdfyDt;
					var sumCnt = data.groupStr[i].sumCnt;
					var sumPrc = data.groupStr[i].sumPrc;

					dataSet[i] = {
						"mdfyDt" : mdfyDt,
						"sumPrc" : sumPrc
					};
					if (max < data.groupStr[i].sumPrc) {
						max = data.groupStr[i].sumPrc;
					}
					if (min > data.groupStr[i].sumPrc) {
						min = data.groupStr[i].sumPrc;
					}
					pay = pay + sumPrc;
				}
				drawChart(dataSet, max, min);
				drawChart2(dataSet, max, min);
			}
		})
	}
</script>




</head>
<body>
	<jsp:include page="./include/openBody.jsp" />
	<!-- contents -->
	<div class="bg-white rounded shadow-sm  "
		style="padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">${sessionScope.__MBR__.mbrNm}님,
			안녕하세요</span>
	</div>


	<!-- contents -->


	<div class="bg-white rounded shadow-sm  "
		style="padding: 23px 18px 23px 18px; margin: 20px;">
		<div class="top-bar">

			<div class="input-group inline" style="width: 300px">
				<span class="input-group-text ">매장명</span> <select
					class="form-select" name="strId" id="search-keyword-strId">
					<c:if test="${strList.size() > 1}">
						<option id="optionStrLctn" value="">매장명</option>
					</c:if>
					<c:choose>
						<c:when test="${not empty strList}">
							<c:forEach items="${strList}" var="str">
								<option value="${str.strId}"
									${strVO.strId eq str.strId ? 'selected' : ''}>${str.strNm}</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>
			</div>


			<input type="date" id="search-keyword-startdt"
				class="form-control width180" value="${odrDtlVO.startDt}" /> <input
				type="date" id="search-keyword-enddt" class="form-control width180"
				value="${odrDtlVO.endDt}" />
			<button id="btn-1month" class="btn btn-outline-success btn-default"
				style="width: 60px; height: 30px; font-size: 8px;" value="1">1개월</button>
			<button id="btn-3months" class="btn btn-outline-success btn-default"
				style="width: 60px; height: 30px; font-size: 8px;" value="2">3개월</button>
			<button id="btn-6months" class="btn btn-outline-success btn-default"
				style="width: 60px; height: 30px; font-size: 8px;" value="3">6개월</button>
			<button id="btn-search" class="btn btn-outline-success btn-default"
				type="submit">Search</button>
		</div>
	</div>




	<div class="bg-white rounded shadow-sm "
		style="padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">
		<div style="float: left">
			<span class="fs-5 fw-bold">매장별 매출 그래프</span>
			<div id="columnchart_values"></div>
		</div>
		<div style="float: left">
			<span class="fs-5 fw-bold">매장별 상품 그래프</span>
			<div id="columnchart_values2"></div>
		</div>
	</div>


	<!-- /contents -->
	<jsp:include page="./include/closeBody.jsp" />
</body>
</html>
