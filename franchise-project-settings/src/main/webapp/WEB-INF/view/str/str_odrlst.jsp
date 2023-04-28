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
<title>${strVO.strNm} - 주문하기</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<link rel="stylesheet" href="${context}/css/strprdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	

	
	
	$("#all-check02").change(function(){
		$(".check-idx02").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx02:checked").length;
		//chkCount(checkLen);
	})
	$(".check-idx02").change(function(){
		var count = $(".check-idx02").length;
		var checkCount = $(".check-idx02:checked").length;
		$("#all-check02").prop("checked", count == checkCount);
	});
	
	$("#all-check03").change(function(){
		$(".check-idx03").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx03:checked").length;
		//chkCount(checkLen);
	})
	$(".check-idx03").change(function(){
		var count = $(".check-idx03").length;
		var checkCount = $(".check-idx03:checked").length;
		$("#all-check03").prop("checked", count == checkCount);
	});
	
	
	$("#btn-complete02").click(function() {
		var checkLen = $(".check-id02x:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if (!confirm("체크한 항목이 일괄 수정됩니다.")) {
			return;
		}
		
		var form = $("<form></form>")
		
		$(".check-idx:checked").each(function() {
			console.log($(this).val());
			form.append("<input type='hiedden' name='odrLstList' value='" + $(this).val() + "'>");
		});
		
		$.post("${context}/api/prdt/updateAll", form.serialize(), function(response) {
			if (response.status == "200 OK") {
				location.reload(); //새로고침
			}
			else {
				alert(response.errorCode + " / " + response.message);
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
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div>
			<jsp:include page="../include/sidemenu.jsp"></jsp:include>
			<jsp:include page="../include/content.jsp"></jsp:include>


			<br>매장이름임 ${strVO.strNm} (${strVO.strId})
			<br>영업시간 ${strVO.strOpnTm} ~ ${strVO.strClsTm}
			<br>
			
			<div class="flex full">
				<div class="half-left">
					<div class="half-top div-table">
						<div class="topline">
							<div class="inline-block">주문접수</div>
							<div class="inline-block">
								<button id="btn-complete02" 
										class="btn-primary btn-create" 
										style="vertical-align: top;">완료</button>
										
								<button id="btn-cancle02" 
										class="btn-primary btn-delete" 
										style="vertical-align: top;">취소</button>
							</div>
						</div>
						
						<div class="overflow">
							<table>
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
								<tbody>
									<c:choose>
										<c:when test="${not empty ordLstList}">
											<c:forEach items="${ordLstList}"
														var="ordLst">
												<c:if test="${ordLst.odrLstOdrPrcs eq '003-02'}">
													<tr>
														<td class="align-center">
															<input type="checkbox" class="check-idx02" value="${ordLst.odrLstId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrId}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td>${ordLst.odrLstRgstr}</td>							
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
					
					<div class="half-bottom div-table">
						<div class="topline">
							<div class="inline-block">주문처리</div>
							<div class="inline-block">
								<button id="btn-complete03" 
										class="btn-primary btn-create" 
										style="vertical-align: top;">완료</button>
										
								<button id="btn-cancle03" 
										class="btn-primary btn-delete" 
										style="vertical-align: top;">취소</button>
							</div>
						</div>
						
						<div class="overflow">
							<table>
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
								<tbody>
									<c:choose>
										<c:when test="${not empty ordLstList}">
											<c:forEach items="${ordLstList}"
														var="ordLst">
												<c:if test="${ordLst.odrLstOdrPrcs eq '003-03'}">
													<tr>
														<td class="align-center">
															<input type="checkbox" class="check-idx03" value="${prdt.prdtId}" />
														</td>
														<td>${ordLst.odrLstId}</td>							
														<td>${ordLst.mbrId}</td>							
														<td>${ordLst.odrLstRgstDt}</td>							
														<td>${ordLst.odrLstRgstr}</td>							
														<td>${ordLst.mdfyDt}</td>							
													</tr>
												</c:if>
											</c:forEach>
										</c:when>
									</c:choose>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
									<tr><td>aaa</td></tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			
				<div class="half-right div-table">
					<div class="topline">
						<div class="inline-block">처리완료</div>
					</div>
					
					<div class="overflow">
						<table>
							<thead>
								<tr>
									<th>주문서ID</th>
									<th>주문자</th>
									<th>주문날짜</th>
									<th>처리자</th>
									<th>처리날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty ordLstCompleteList}">
										<c:forEach items="${ordLstCompleteList}"
													var="ordLst">
											<tr>
												<td>${ordLst.odrLstId}</td>							
												<td>${ordLst.mbrId}</td>							
												<td>${ordLst.odrLstRgstDt}</td>							
												<td>${ordLst.odrLstRgstr}</td>							
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
					
	
	
	
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>


</body>
</html>