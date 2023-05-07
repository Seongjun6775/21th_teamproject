<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%=new Random().nextInt()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<style>
  .chart div {
      font: 10px sans-serif;
      background-color: orange;
      text-align: right;
      padding: 3px;
      margin: 1px;
      color: white;
  }
    .chart:hover {
	    fill-opacity: 1;
  }
          svg{
            width: 500px; height: 150px; border:1px solid black;
        }
        #myGraph rect{
            stroke : rgb(0, 100, 0);
            stroke-width: 1px;
            fill:rgb(0, 160, 0)
        }
        .axis text{
            font-family: sans-serif;
            font-size: 12px;
        }
        .axis path,.axis line{
            fill:none;
            stroke: black;
        }
</style>

<meta charset="UTF-8">
<title>매출 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script src="https://d3js.org/d3.v4.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<script type="text/javascript">
	var d3ChartDataSet = [];
	
	function secId(mbrId) {
		return mbrId.substring(0, mbrId.length - 3) + "***";
	}

	function drawChart(max){
		
// // 		var xAxis = d3.axisBottom(xScale);

		var maxWidthPx = 1000;
// 		// 그래프의 크기를 최대 1000으로 고정
		var maxWidth =  maxWidthPx / max;
		
// 		var xScale = d3.scaleLinear()
//         .domain([ 0, maxWidthPx])
//         .range([ 0 , maxWidthPx]);
// // 		  const yScale = d3.scaleLinear()
// // 	      .domain([1, 9])
// // 	      .range([330, 20]);

// 		const xAxisSVG = d3.select(".chart").append("g");
// // 	    const yAxisSVG = d3.select(".chart").append("g");
// 	    //축을 만드는 함수를 만든다.
// 	    const xAxis = d3.axisTop(xScale).tickSize(200).ticks(5);
// // 	    const yAxis = d3.axisRight(yScale).tickSize(10).ticks(10);
// // 	    xAxis(xAxisSVG);  //x축을 만드는 함수로 SVG > G 태그에 축을 생성한다.
// // 	    yAxis(yAxisSVG);  //y축을 만드는 함수로 SVG > G 태그에 축을 생성한다.
	    
// 		d3.select(".chart").selectAll("div").data(d3ChartDataSet)
//         .enter().append("div")
//         .style("width", function(d) { return d.sumPrc * maxWidth + "px"; })
//         .attr("x", function(d) {return xScale(d.sumPrc);})
// //         .attr("y", function(d) {return d.strNm;})
//         .append("g")
// //         .call(xAxis)
// //         .attr("class","axis")
// // 		.attr("transform","translate(10,"+((1+dataSet.length)*20+5)+")")
// 		.call(d3.axisBottom(xScale))
//         .text(function(d) { return "["+d.strNm +"] "+ d.sumPrc; });
		
		
		
// 		var dataSet = [400,200,90,190,240];

	d3.select("#myGraph") //svg 요소 선택
	.selectAll("rect")
	.data(d3ChartDataSet)
	.enter()
	.append("rect")
	.attr("x",0)
	.attr("y",function(d,i){
	    return i * 25;
	})
	.attr("width",function(d,i){
	    return d.sumPrc * maxWidth + "px";
	})
	.attr("height","20px")
	
	d3.select("#update")
	.on("click",function(){
	    for(var i = 0; i < dataSet.length;i++){
	        dataSet[i] = Math.floor(Math.random()*400);
	    }
	
	d3.select("#myGraph")
	.selectAll("rect")
	.data(dataSet)
	.transition()
	.delay(function(d,i){return i*500;})
	.duration(2500)
	.attr("width",function(d,i){
	    return d + "px";
	})
	})
	
	var xScale = d3.scaleLinear()
	.domain([0,1000])
	.range([0,1000])
	d3.select("#myGraph")
	.append("g")
	.attr("class","axis")
	.attr("transform","translate(10,"+((1+dataSet.length)*20+5)+")")
	.call(d3.axisBottom(xScale))
		
	}
	
	// 날짜 포맷("yyyy-MM-dd")형식으로 반환
	dateFormatter = function(newDay, today){
	
		let year = newDay.getFullYear()
		let month = newDay.getMonth()+1
		let date = newDay.getDate()
		
		//기존 날짜와 새로운 날짜가 다를 경우
		if(today){
			let todayDate = today.getDate()
			
			if(date != todayDate){
				if(month == 0 ) year-=1
				month = (month + 11) % 12
				date = new Date(year, month, 0).getDate() // 해당 달의 마지막 날짜를 반환	
			}
		}
		
		month = ("0" + month).slice(-2)
		date = ("0" + date).slice(-2)
		
		return year+"-"+month+"-"+date
	}
	
	$().ready(function() {

		console.log("ready function!")
		var ajaxUtil = new AjaxUtil();

		groupStr();

		$("#btn-search").click(function() {
			groupStr();
		})

		var ctyChangedList;
		$("#search-keyword-strLctn").change(function() {
			var select = $("#search-keyword-strCty");
			var strLctn = $("#search-keyword-strLctn").val();
			var option;
			select.children().remove();
		
			$.get("${context}/api/str/changecty", {"lctId": strLctn}, function(response){
				if(response.status=="200 OK"){
					ctyChangedList = response.data;
					option="<option value=''>전체</option>"
					select.append(option);
					for(var i=0; i<ctyChangedList.length; i++){
						option="<option value='"+ ctyChangedList[i].ctyId +"'>"+ ctyChangedList[i].ctyNm +"</option>"
						select.append(option);
			        }
				}
				else{
					alert("실패!");
				}
			})
		});
		
		$("#btn-1month").click(function() {
			var myElementStrt = document.getElementById("search-keyword-startdt");
			let replaceDate = new Date($("#search-keyword-enddt").val());
			
			replaceDate.setMonth(replaceDate.getMonth()-1);
			replaceDate = dateFormatter(replaceDate);

			myElementStrt.value = replaceDate;
			groupStr();
		});
		
		$("#btn-3months").click(function() {
			var myElementStrt = document.getElementById("search-keyword-startdt");
			let replaceDate = new Date($("#search-keyword-enddt").val());
			
			replaceDate.setMonth(replaceDate.getMonth()-3);
			replaceDate = dateFormatter(replaceDate);

			myElementStrt.value = replaceDate;
			groupStr();
		});
		
		$("#btn-6months").click(function() {
			var myElementStrt = document.getElementById("search-keyword-startdt");
			let replaceDate = new Date($("#search-keyword-enddt").val());
			
			replaceDate.setMonth(replaceDate.getMonth()-6);
			replaceDate = dateFormatter(replaceDate);

			myElementStrt.value = replaceDate;
			groupStr();
		});
	})



	function groupStr() {

		console.log("strLctn : " + $("#search-keyword-strLctn").val() + "\n"
				+ "strCty : " + $("#search-keyword-strCty").val() + "\n"
				+ "startDt : " + $("#search-keyword-startdt").val() + "\n"
				+ "endDt : " + $("#search-keyword-enddt").val() + "\n");

		var odrDtlVO = {
			ctyCdVO : {
				lctId : $("#search-keyword-strLctn").val(),
				ctyId : $("#search-keyword-strCty").val()
			},
			startDt : $("#search-keyword-startdt").val(),
			endDt : $("#search-keyword-enddt").val()
		}

		$.ajax({
			url : "${context}/api/payment/groupStr",
			type : "POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(odrDtlVO),
			success : function(data) {

				var pay = 0;
				d3ChartDataSet = [];
				var max = data[0].sumPrc;
				$("#paymentStr").empty();
			
				for (var i = 0; i < data.length; i++) {
					var lctNm = data[i].lctCdVO.lctNm;
					var ctyNm = data[i].ctyCdVO.ctyNm;
					var strNm = data[i].strVO.strNm;
					var sumCnt = data[i].sumCnt;
					var sumPrc = data[i].sumPrc;
					var tr = $("<tr></tr>");
					var tdList = [
							$("<td>" + lctNm + "</td>"),
							$("<td>" + ctyNm + "</td>"),
							$("<td>" + strNm + "</td>"),
							$("<td>" + sumCnt.toLocaleString() + "</td>"),
							$("<td class='money' style='padding-right: 10px;'>"
									+ sumPrc.toLocaleString() + "</td>"), ];
					d3ChartDataSet[i] = { strNm : strNm, sumPrc : sumPrc };
					if (max < data[i].sumPrc){
						max = data[i].sumPrc;
					}
					console.log(i +" : " + sumPrc + ", d3ChartDataSet[i] : " + d3ChartDataSet[i]);
					pay = pay + sumPrc;
					tr.append(tdList);
					$("#paymentStr").append(tr);
				}

				var div = $("<div> 총 금액 : " + pay.toLocaleString() + "원</div>")
				div.css({
					"text-align" : "right",
					"font-weight" : "bold",
				});
				$("#paymentTotal").html(div);
				
				drawChart(max);
			}
		})
	}
</script>
</head>
<body>

	<jsp:include page="../include/openBody.jsp" />

	<!-- contents -->
	<div class="bg-white rounded shadow-sm  "
		style="padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">매장별 매출</span>
	</div>

	<div class="bg-white rounded shadow-sm  "
		style="padding: 23px 18px 23px 18px; margin: 20px;">
		<div class="top-bar">

			<div class="input-group inline" style="width: 300px">
				<span class="input-group-text ">지역명</span> <select
					class="form-select" name="strLctn" id="search-keyword-strLctn">
					<option id="optionStrLctn" value="">지역명</option>
					<c:choose>
						<c:when test="${not empty lctList}">
							<c:forEach items="${lctList}" var="lct">
								<option value="${lct.lctId}"
									${strVO.strLctn eq lct.lctId ? 'selected' : ''}>${lct.lctNm}</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>
			</div>

			<div class="input-group inline" style="width: 300px">
				<span class="input-group-text">도시명</span> <select
					class="form-select" name="strCty" id="search-keyword-strCty">
					<option value="">도시명</option>
					<c:choose>
						<c:when test="${not empty ctyChangedList}">
							<c:forEach
								items="${ctyChangedList != null ? ctyChangedList : ctyList}"
								var="cty">
								<option value="${cty.ctyId}"
									${strVO.strCty eq cty.ctyId ? 'selected' : ''}>${cty.ctyNm}</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>
			</div>
			<input type="date" id="search-keyword-startdt"
				class="form-control width180" value="${odrDtlVO.startDt}" /> <input
				type="date" id="search-keyword-enddt" class="form-control width180"
				value="${odrDtlVO.endDt}" />
				<button id="btn-1month" class="btn btn-outline-success btn-default" style="width:60px;height:30px;font-size:8px;" value = "1">1개월</button>
				<button id="btn-3months" class="btn btn-outline-success btn-default" style="width:60px;height:30px;font-size:8px;" value = "2">3개월</button>
				<button id="btn-6months" class="btn btn-outline-success btn-default" style="width:60px;height:30px;font-size:8px;" value = "3">6개월</button>
			<button id="btn-search" class="btn btn-outline-success btn-default"
				type="submit">Search</button>
		</div>
	</div>

	<div class="bg-white rounded shadow-sm "
		style="padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">

		<div id="paymentTotal"></div>

		<table class="table table-striped table-sm table-hover align-center">
			<thead class="table-secondary">
				<tr>
					<th>지역명</th>
					<th>도시명</th>
					<th>매장이름</th>
					<th>총수량</th>
					<th>판매총액</th>
				</tr>
			</thead>
			<tbody id="paymentStr" class="table-group-divider">
			</tbody>
		</table>
	</div>


	<div class="bg-white rounded shadow-sm "
		style="padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">
		<span class="fs-5 fw-bold">매장별 매출 그래프</span>
		<div class="chart"></div>
		<svg id="myGraph"></svg>
	</div>





	<!-- /contents -->

	<jsp:include page="../include/closeBody.jsp" />

</body>
</html>