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
<title>${strVO.strNm} - 주문 전체보기</title>
<jsp:include page="../include/stylescript.jsp" />
<%-- <link rel="stylesheet" href="${context}/css/strprdt_common.css?p=${date}" /> --%>
<script type="text/javascript">
$().ready(function() {
	
// 	const myModal = document.getElementById('myModal')
// 	const myInput = document.getElementById('myInput')

// 	myModal.addEventListener('shown.bs.modal', () => {
// 	  myInput.focus()
// 	})
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	
	
	$("tbody").children("tr").click(function(event) {
		if ($(event.target).is('td:first-child')) {
			return;
		}
		if ($(event.target).is('input[type="checkbox"]')) {
		    event.stopPropagation();
		    return;
		  }
		
		var Id = $(this).data().odrlstid;
		$("#staticBackdropLabel").html(Id + " : 주문서 상세");
// 		$("#staticBackdropLabel").empty();
// 		$("#staticBackdropLabel").empty();
		
// 		$("div[class=modal-body]").empty();
		
		$.post("${context}/api/odrLst/odrDtl", {odrLstId: Id}, function(data) {
			
			var table = $("<table></table>");
			var thead = $("<thead></thead>");
			table.addClass("table table-striped");
			var tr = $("<tr></tr>");
			var thList = [
			  $("<th>주문상세ID</th>"),
			  $("<th>상품이름</th>"),
			  $("<th>단가</th>"),
			  $("<th>수량</th>"),
			  $("<th>금액</th>"),
			];
			thList.forEach(function(th) {
			  tr.append(th);
			});
			thead.append(tr);
			table.append(thead);
			
			var tbody = $("<tbody></tbody>");
			var pay = 0;
			for (var i = 0; i < data.length; i++) {
			    var odrDtlId = data[i].odrDtlId;
			    var prdtNm = data[i].prdtVO.prdtNm;
			    var odrDtlPrdtCnt = data[i].odrDtlPrdtCnt;
			    var odrDtlPrc = data[i].odrDtlPrc;
			    var tr = $("<tr></tr>");
			    var tdList = [
					  $("<td>" + odrDtlId + "</td>"),
					  $("<td>" + prdtNm + "</td>"),
					  $("<td>" + odrDtlPrc.toLocaleString() + "</td>"),
					  $("<td>" + odrDtlPrdtCnt.toLocaleString() + "</td>"),
					  $("<td>" + (odrDtlPrc * odrDtlPrdtCnt).toLocaleString() + "</td>"),
					];
			    pay = pay + (odrDtlPrc * odrDtlPrdtCnt);
			    
					tdList.forEach(function(td) {
					  tr.append(td);
					});
				tbody.append(tr);
		    }
			table.append(tbody);
			
			$("div[class=modal-body]").html(table);
			var div = $("<div> 총 금액 : "+pay.toLocaleString() +"원</div>")
			div.css({
				"text-align":"right",
				"font-weight":"bold",
			});
			table.after(div);
			
			$("#modal").click();
		});		
		
	});
	
	
	
	
	
	$("#all-check").change(function(){
		$(".check-idx00").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx00:checked").length;
		//chkCount(checkLen);
	})
	$(".check-idx00").change(function(){
		var count = $(".check-idx00").length;
		var checkCount = $(".check-idx00:checked").length;
		$("#all-check").prop("checked", count == checkCount);
	});

	
	
	
	
	
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
			
<!-- 			<div class="flex full"> -->
				<div class="overflow">
					<table class="table table-striped table-sm table-hover">
						<thead>
							<tr>
								<th><input type="checkbox" id="all-check"/></th>
								<th>처리상태</th>
								<th>주문서ID</th>
								<th>주문자</th>
								<th>주문날짜</th>
								<th>처리자</th>
								<th>처리날짜</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
							<c:choose>
								<c:when test="${not empty ordLstList}">
									<c:forEach items="${ordLstList}"
												var="ordLst">
										<tr data-odrlstid="${ordLst.odrLstId}">
											<td class="align-center">
												<input type="checkbox" class="check-idx00" value="${ordLst.odrLstId}" />
											</td>
											<td>${ordLst.cmmnCdVO.cdNm}</td>							
											<td>${ordLst.odrLstId}</td>							
											<td>${ordLst.mbrVO.mbrNm}</td>							
											<td>${ordLst.odrLstRgstDt}</td>							
											<td>${ordLst.mdfyrMbrVO.mbrNm}</td>							
											<td>${ordLst.mdfyDt}</td>							
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>
					
					
					<!-- Button trigger modal -->
					<button id="modal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" style="display: none">
					  Launch static backdrop modal
					</button>
					<!-- Modal -->
					<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog modal-dialog-scrollable">
							<div class="modal-content" style="width:960px; max-height: 70%; position: relative; top: 50%; left: 50%; transform: translateY(-50%) translateX(-50%);">
								<div class="modal-header">
									<h1 class="modal-title fs-5" id="staticBackdropLabel"></h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
									<div class="modal-body">
									
										<div id="pay"></div>
									</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Understood</button>
								</div>
							</div>
						</div>
					</div>
					
					
				</div>
<!-- 			</div> -->




		    </div>
      		<!-- /contents -->
		</div>
	</main>
	
</body>
</html>
