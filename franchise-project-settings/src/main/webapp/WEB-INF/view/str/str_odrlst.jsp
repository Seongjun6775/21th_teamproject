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
<title>${strVO.strNm eq null ? '정보없음' : strVO.strNm } - 주문관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	
	$("tbody").children("tr").click(function() {
		if ($(event.target).is('td:first-child')) {
			console.log($(this).children("input"));
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
					tdList.forEach(function(td) {
					  tr.append(td);
					});
				tbody.append(tr);
		    }
			table.append(tbody);
			
			$("div[class=modal-body]").html(table);
			
			$("#modal").click();
		});		
		
	});

	
	
	$("#all-check02").change(function(){
		$(".check-idx02").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx02:checked").length;
	})
	$(".check-idx02").change(function(){
		var count = $(".check-idx02").length;
		var checkCount = $(".check-idx02:checked").length;
		$("#all-check02").prop("checked", count == checkCount);
	});
	
	$("#all-check03").change(function(){
		$(".check-idx03").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx03:checked").length;
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

	<jsp:include page="../include/openBody.jsp" />
	
		<div class="header">
			<div class="bg-white rounded shadow-sm  " style="padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">매장 > 주문관리</span>
		    </div>
 
			<div style="margin-left: 30px;">
				<br>매장이름임 ${strVO.strNm} (${strVO.strId})
				<br>영업시간 ${strVO.strOpnTm} ~ ${strVO.strClsTm}
				<br>
			</div>
		</div>
		
	    <!-- contents -->
	    <div class="bg-white rounded shadow-sm" 
	    	 style="height: 100%; margin: 20px;">


		<div class="flex full">
			<div class="half-left">
				<div class="half-top flex-column default-padding" style="overflow: auto;">
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
						<table class="table table-striped table-sm table-hover">
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
							<tbody class="table-group-divider">
								<c:choose>
									<c:when test="${not empty ordLstList}">
										<c:forEach items="${ordLstList}"
													var="ordLst">
											<c:if test="${ordLst.odrLstOdrPrcs eq '003-02'}">
												<tr data-odrlstid="${ordLst.odrLstId}">
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
				
				<div class="half-bottom flex-column default-padding"  style="overflow: auto;">
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
						<table class="table table-striped table-sm table-hover">
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
							<tbody class="table-group-divider">
								<c:choose>
									<c:when test="${not empty ordLstList}">
										<c:forEach items="${ordLstList}"
													var="ordLst">
											<c:if test="${ordLst.odrLstOdrPrcs eq '003-03'}">
												<tr data-odrlstid="${ordLst.odrLstId}">
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
		
			<div class="half-right default-padding"  style="overflow: auto;">
				<div class="topline">
					<div class="inline-block">처리완료</div>
				</div>
				
				<div class="overflow">
					<table class="table table-striped table-sm table-hover">
						<thead>
							<tr>
								<th>주문서ID</th>
								<th>주문자</th>
								<th>주문날짜</th>
								<th>처리자</th>
								<th>처리날짜</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
							<c:choose>
								<c:when test="${not empty ordLstCompleteList}">
									<c:forEach items="${ordLstCompleteList}"
												var="ordLst">
										<tr data-odrlstid="${ordLst.odrLstId}">
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
						
						
						</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Understood</button>
					</div>
				</div>
			</div>
		</div>




	    </div>
     		<!-- /contents -->

	<jsp:include page="../include/closeBody.jsp" />
	
</body>
</html>