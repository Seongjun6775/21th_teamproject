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
<meta charset="UTF-8">
<title>매출 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<script type="text/javascript">
	function secId(mbrId) {
		return mbrId.substring(0, mbrId.length - 3) + "***";
	}

	
	$().ready(function() {

		console.log("ready function!")
		var ajaxUtil = new AjaxUtil();

		$("#search-keyword-str").val("${odrDtlVO.odrDtlStrId}");

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
			var myElementEnd = document.getElementById("search-keyword-enddt");
		
		    var yyyy = parseInt(myElementEnd.value.substr(0, 4));
		    var mm = parseInt(myElementEnd.value.substr(5, 2));
		    var dd = parseInt(myElementEnd.value.substr(8, 2));
		  
		    var bdate = new Date(yyyy, mm, dd);
		    var oneMonthAgo = new Date(bdate.setMonth(bdate.getMonth() - 1));
		    var twoMonthAgo = new Date(bdate.setMonth(bdate.getMonth() - 1));
		    var threeMonthAgo = new Date(bdate.setMonth(bdate.getMonth() - 1));
		    
		    console.log("bdate : " + bdate);
		    console.log("oneMonthAgo : " + oneMonthAgo);
		    console.log("twoMonthAgo : " + twoMonthAgo);
		    console.log("threeMonthAgo : " + threeMonthAgo);
		    
// 			myElementStrt.value = dateAdd(myElementEnd.value, -30);
			
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
				<button id="btn-1month" class="btn btn-outline-success btn-default" style="width:60px;height:30px;font-size:8px;">1개월</button>
				<button id="btn-3months" class="btn btn-outline-success btn-default" style="width:60px;height:30px;font-size:8px;">3개월</button>
				<button id="btn-6months" class="btn btn-outline-success btn-default" style="width:60px;height:30px;font-size:8px;">6개월</button>
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







	<!-- /contents -->

	<jsp:include page="../include/closeBody.jsp" />

</body>
</html>