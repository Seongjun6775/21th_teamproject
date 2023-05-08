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

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

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
		var mbrNm = $(this).data().mbrnm;
		var odrLstRgstDt = $(this).data().odrlstrgstdt;
		$("#staticBackdropLabel").html(Id + " / " + mbrNm + " / " + odrLstRgstDt);
// 		$("#staticBackdropLabel").empty();
// 		$("#staticBackdropLabel").empty();
// 		$("div[class=modal-body]").empty();
		
		$.post("${context}/api/odrLst/odrDtl", {odrLstId: Id}, function(data) {
			
			var table = $("<table></table>");
			table.addClass("table table-hover align-center");
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
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '선택된 항목이 없습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("선택된 항목이 없습니다."); */
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
		        	Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
		    }
		});
		
		
	})
	
	$("#btn-cancle02").click(function() {
		var checkLen = $(".check-idx02:checked").length;
		if (checkLen == 0) {
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '선택된 항목이 없습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("선택된 항목이 없습니다."); */
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
		        	Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
		    }
		});
	})
	
	$("#btn-complete03").click(function() {
		var checkLen = $(".check-idx03:checked").length;
		if (checkLen == 0) {
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '선택된 항목이 없습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("선택된 항목이 없습니다."); */
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
		        	Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
		    }
		});
		
		
	})
	
	$("#btn-cancle03").click(function() {
		var checkLen = $(".check-idx03:checked").length;
		if (checkLen == 0) {
			Swal.fire({
		    	  icon: 'error',
		    	  title: '선택된 항목이 없습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("선택된 항목이 없습니다."); */
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
		        	Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
		    }
		});
	});
	
	var url;
	$(".open-layer").click(function(event) {
		var mbrId = $(this).attr('val');
		$("#layer_popup").css({
		    "padding": "5px",
			"top": event.pageY,
			"left": event.pageX,
			"backgroundColor": "#FFF",
			"position": "absolute",
			"border": "solid 1px #222",
			"z-index": "10px"
		}).show();
		if (mbrId == '${sessionScope.__MBR__.mbrId}') {
			url = "cannot"
		} else {
			url = "${context}/nt/ntcreate/" + mbrId
		}
	});
	$(".send-memo-btn").click(function() {
		if (url !== "cannot") {
			location.href = url;
		} else {
			alert("본인에게 쪽지를 보낼 수 없습니다.");
		}
	});
	$('body').on('click', function(event) {
		if (!$(event.target).closest('#layer_popup').length) {
			$('#layer_popup').hide();
		}
	});
	$(".close-memo-btn").click(function() {
		url = undefined;
		$("#layer_popup").hide();
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

	<jsp:include page="../include/openBody.jsp" />
	
		<div class="header">
			<div class="bg-white rounded shadow-sm  " style="padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">매장 > 주문관리</span>
		    </div>
 
			<div class="bg-white rounded shadow-sm  " style="padding: 23px 18px 23px 18px; margin: 20px 20px 0 20px;">
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
 
			<div style="margin-left: 30px;">
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
										class="btn btn-outline-primary btn-default" 
										style="vertical-align: top;">주문처리</button>
										
								<button id="btn-cancle02" 
										class="btn btn-outline-danger btn-default" 
										style="vertical-align: top;">주문취소</button>
							</div>
						</div>
						
						<div class="overflow">
							<table class="table table-striped table-sm table-hover align-center">
								<thead class="table-secondary">
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
													<tr data-odrlstid="${ordLst.odrLstId}"
														data-mbrnm="${ordLst.mbrVO.mbrNm}"
														data-odrlstrgstdt="${ordLst.odrLstRgstDt}">
														<td class="align-center">
															<input type="checkbox" class="check-idx02" value="${ordLst.odrLstId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrVO.mbrNm}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td class="ellipsis"
															onclick="event.cancelBubble=true">
															<a class="open-layer" href="javascript:void(0);" 
															    val="${ordLst.mdfyrMbrVO.mbrId}">
																${ordLst.mdfyr eq null ? '<i class="bx bx-error-alt" ></i>ID없음' : ordLst.mdfyr}</a>
														</td>
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
										class="btn btn-outline-primary btn-default" 
										style="vertical-align: top;">처리완료</button>
										
								<button id="btn-cancle03" 
										class="btn btn-outline-danger btn-default" 
										style="vertical-align: top;">주문취소</button>
							</div>
						</div>
						
						<div class="overflow">
							<table class="table table-striped table-sm table-hover align-center">
								<thead class="table-secondary">
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
													<tr data-odrlstid="${ordLst.odrLstId}"
														data-mbrnm="${ordLst.mbrVO.mbrNm}"
														data-odrlstrgstdt="${ordLst.odrLstRgstDt}">
														<td class="align-center">
															<input type="checkbox" class="check-idx03" value="${ordLst.odrLstId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrVO.mbrNm}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td class="ellipsis"
															onclick="event.cancelBubble=true">
															<a class="open-layer" href="javascript:void(0);" 
															    val="${ordLst.mdfyrMbrVO.mbrId}">
																${ordLst.mdfyr eq null ? '<i class="bx bx-error-alt" ></i>ID없음' : ordLst.mdfyr}</a>
														</td>							
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
						<table class="table table-striped table-sm table-hover align-center">
							<thead class="table-secondary">
								<tr>
									<th></th>
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
											<tr data-odrlstid="${ordLst.odrLstId}"
												data-mbrnm="${ordLst.mbrVO.mbrNm}"
												data-odrlstrgstdt="${ordLst.odrLstRgstDt}">
												<td></td>
												<td>${ordLst.odrLstId}</td>							
												<td>${ordLst.mbrVO.mbrNm}</td>							
												<td>${ordLst.odrLstRgstDt}</td>							
												<td class="ellipsis"
													onclick="event.cancelBubble=true">
													<a class="open-layer" href="javascript:void(0);" 
													    val="${ordLst.mdfyrMbrVO.mbrId}">
														${ordLst.mdfyr eq null ? '<i class="bx bx-error-alt" ></i>ID없음' : ordLst.mdfyr}</a>
												</td>
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
<!-- 							<button type="button" class="btn btn-primary">Understood</button> -->
						</div>
					</div>
				</div>
			</div>


	    </div>
     		<!-- /contents -->
     	
     <div class="layer_popup" id="layer_popup" style="display: none;">
		<div class="popup_box">
			<div class="popup_content">
				<a class="send-memo-btn" href="javascript:void(0);">
				<i class='bx bx-mail-send' ></i>
				쪽지 보내기</a>
			</div>
			<div>
				<a class="close-memo-btn" href="javascript:void(0);">
				<i class='bx bx-x'></i>
				닫기</a>
			</div>
		</div>
	</div>

	<jsp:include page="../include/closeBody.jsp" />
	
</body>
</html>