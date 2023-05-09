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
<title>주문 전체보기 - ${strVO.strNm eq null ? mbrVO.mbrLvl eq '001-01' ? '관리자' : '소속없음' : strVO.strNm }</title>
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
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
		var mbrNm = $(this).data().mbrnm;
		var odrLstRgstDt = $(this).data().odrlstrgstdt;
		$("#staticBackdropLabel").html(Id + " / " + mbrNm + " / " + odrLstRgstDt);
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
			tbody.addClass("table-group-divider");
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

	$('body').on('click', function(event) {
		if ($("#staticBackdrop").attr("class").includes("show")) {
			if (!$(event.target).closest('.modal-content').length) {
				$('button[data-bs-dismiss=modal]').click();
			}
		}
	});
	$('body').keydown(function(key) {
		if (key.keyCode == 27) {
			$('button[data-bs-dismiss=modal]').click();
		}
	})
	
	
	
	
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
<body>
	
	<jsp:include page="../include/openBody.jsp" />
			
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">매장 > 처리주문조회</span>
		    </div>
		    
		    <div class="bg-white rounded shadow-sm  " style="padding: 23px 18px 23px 18px; margin: 0 20px;">
				<div>
					<span class="fs-5 fw-bold">${strVO.strNm} (${strVO.strId})</span>
				</div>
				<div class="flex">
					<div class="half-left">
						<div>매니저 : ${strVO.mbrId}</div>
						<div>연락처 : ${strVO.strCallNum}</div>
					</div>
					<div class="half-right">
						<div>주소 : ${strVO.strAddr}</div>
						<fmt:parseDate value="${strVO.strOpnTm}" pattern="HH:mm:ss" var="strOpnTm"/>
						<fmt:parseDate value="${strVO.strClsTm}" pattern="HH:mm:ss" var="strClsTm"/>
						<div>영업시간 : <fmt:formatDate value="${strOpnTm}" pattern="HH:mm"/> 
									  ~ <fmt:formatDate value="${strClsTm}" pattern="HH:mm"/></div>
					</div>				
				</div>
		    </div>
		    
		    <!-- contents -->
		    <div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">

				완료된 주문서와 취소된 주문서 목록을 불러옵니다.
<!-- 			<div class="flex full"> -->
				<div class="overflow">
					<table class="table table-striped table-sm table-hover align-center">
						<thead class="table-secondary">
							<tr>
								<th><input type="checkbox" id="all-check"/></th>
								<c:if test="${mbrVO.mbrLvl eq '001-01'}">
									<th>매장명</th>
								</c:if>
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
								<c:when test="${not empty odrLstList}">
									<c:forEach items="${odrLstList}"
												var="odrLst">
										<tr data-odrlstid="${odrLst.odrLstId}"
											data-mbrnm="${odrLst.mbrVO.mbrNm}"
											data-odrlstrgstdt="${odrLst.odrLstRgstDt}">
											<td class="align-center">
												<input type="checkbox" class="check-idx00" value="${odrLst.odrLstId}" />
											</td>
											<c:if test="${mbrVO.mbrLvl eq '001-01'}">
												<td>${odrLst.strVO.strNm}</td>
											</c:if>
											<td>${odrLst.cmmnCdVO.cdNm}</td>							
											<td>${odrLst.odrLstId}</td>							
											<td>${odrLst.mbrVO.mbrNm}</td>							
											<td>${odrLst.odrLstRgstDt}</td>							
											<td>${odrLst.mdfyrMbrVO.mbrNm}</td>							
											<td>${odrLst.mdfyDt}</td>							
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
<!-- 									<button type="button" class="btn btn-primary">Understood</button> -->
								</div>
							</div>
						</div>
					</div>
					
					
				</div>


		    </div>
		    
      		<!-- /contents -->
	<jsp:include page="../include/closeBody.jsp" />
	
</body>
</html>
