<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/odrdtl_odrdtllist.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		var odrPrcs = "${odrPrcs.odrLstOdrPrcs}";
		var listSize = ${odrDtlList ne null ? odrDtlList.size() : 0};
		
		if (listSize == 0) {
			location.href = "${context}/odrlst/list";
		}
		
		$(".odrdtl_table_grid > table > tbody > tr").not(".delete_btn").click(function() {
			var data = $(this).data();
			if (data.odrdtlid != null && (data.odrdtlid) != "") {
				location.href="${context}/odrdtl/" + data.odrdtlid;
			}
		});
	/*
	
	
		선택 삭제 기능입니다. 현재 사용하지 않는 상태입니다.
		
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#check_del_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			
			if (checkLen == 0) {
				alert("선택하신 주문 상품이 없습니다.")
				return;
			}
			
			if (odrPrcs != "003-01") {
				if (odrPrcs == "003-05") {
					alert("주문 취소된 주문서입니다.");
					return;
				}
				alert("이미 주문 접수된 주문서입니다.");
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			var form = $("<form></form>");
			$(".check_idx:checked").each(function() {
				form.append("<input type='hidden' name='odrDtlId' value ='" + $ (this).val() +"'>")
			});
			
			$.post("${context}/api/odrdtl/delete", form.serialize(), function(response) {});
			location.reload();
			
		});
 */		
		$(".delete_btn").click(function(){
			
			if (odrPrcs != "003-01") {
				if (odrPrcs == "003-05") {
					alert("주문 취소된 주문서입니다.");
					return;
				}
				alert("이미 주문 접수된 주문서입니다.");
				return;
			}
			
			if (!confirm("해당 물품을 삭제하시겠습니까?")) {
				return;
			}
			var odrDtlId = $(this).val();
			$.post("${context}/api/odrdtl/deleteone/" + odrDtlId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/odrdtl/list/${odrLstId}"
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
			
		});
 
 		$("#delete_all_btn").click(function() {
 			if (odrPrcs != "003-01" && odrPrcs != "003-05") {
 				alert("이미 주문 처리된 주문서입니다.");
 				return;
 			}
 			
 			if (!confirm("주문서에서 모든 상품들을 삭제하시겠습니까?")) {
 				return;
 			}
 			
 			$.post("${context}/api/odrdtl/delete/${odrLstId}", function(response) {
 				if (response.status == "200 OK") {
					location.href = "${context}/odrdtl/list/${odrLstId}"
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
 			});
 			
 		});
		
		$("#pay_btn").click(function() {
			
			var pyMn = ${mbrVO.mbrPyMn};
			var sumPrice = parseInt($("#sum").val());
			
			if (odrPrcs != "003-01") {
				if (odrPrcs == "003-05") {
					alert("주문 취소된 주문서입니다.");
					return;
				}
				alert("이미 결제 처리된 주문서입니다.");
				return;
			}
			
			if (listSize == 0) {
				alert("주문할 물품이 없습니다.");
				return;
			}
			
			if (sumPrice > pyMn) {
				alert("충전 잔량이 부족합니다. 먼저 금액을 충전해 주세요!");
				return;
			}
			var restMn = pyMn - sumPrice;
			$.post("${context}/api/odrlst/update/${odrLstId}", {"mbrPyMn": restMn}, function(response){
				if (response.status == "200 OK") {
					alert("주문이 접수되었습니다.");
					location.href = "${context}/odrlst/list";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#list_btn").click(function() {
			location.href = "${context}/odrlst/list";
		});
		
	});
	
	function movePage(pageNo) {
		location.href = "${context}/odrdtl/list/${odrLstId}?pageNo=" + pageNo;
	}
	
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
				<span class="fs-5 fw-bold">주문목록 > 주문조회</span>
			</div>
			<div>총 ${odrDtlList.size() > 0 ? odrDtlList.get(0).totalCount : 0}건</div>
			<!-- <button id="check_del_btn" class="btn btn-danger btn-sm">일괄삭제</button> -->
			<div class="odrdtl_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<div>
					<c:choose>
						<c:when test="${not empty odrDtlList}">
						<c:set var="sum" value="0" />
							<c:forEach items="${odrDtlList}" var="odr">
								<div class="odrdtl-card">
									<div class="col-sm-4">
										<div class="dtl-img">
											<img src="${context}/prdt/img/${odr.prdtVO.uuidFlNm}">
										</div>
									</div>
									<div class="col-sm-6">
										<div class="dtl-prdtNm">${odr.prdtVO.prdtNm}</div>
										<div class="dtl-prdtCnt">${odr.odrDtlPrdtCnt}</div>
										<div class="dtl-prdtPrc">
											<c:choose>
												<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
													<td><del style="font-size: 12px; color: #333;">${odr.prdtVO.prdtPrc}</del>  <span>${odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}</span></td>
												</c:when>
												<c:otherwise>
													<td>${odr.prdtVO.prdtPrc}</td>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="dtl-sumPrc">
											<c:choose>
												<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
													<td><del style="font-size: 12px; color: #333;">${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</del>  <span>${odr.odrDtlPrdtCnt * odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}</span></td>
												</c:when>
												<c:otherwise>
													<td>${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</td>
												</c:otherwise>
											</c:choose>
										</div>
										<div>
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-square" viewBox="0 0 16 16">
											  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
											  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
											</svg>
											<%-- <button type="button" class="btn btn-danger btn-sm delete_btn" value="${odr.odrDtlId}">삭제</button> --%>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				<%-- <table class="table table-striped">
					<thead>
						<tr>
							<!-- <th><input type="checkbox" id="all_check"/></th> -->
							<th>사진</th>
							<th>상품명</th>
							<th>수량</th>
							<th>가격</th>
							<th>총액</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty odrDtlList}">
								<c:set var="sum" value="0" />
								<c:forEach items="${odrDtlList}" var="odr">
									<tr data-odrdtlid="${odr.odrDtlId}"
										data-odrlstid="${odr.odrLstId}"
										data-odrdtlprdtid="${odr.odrDtlPrdtId}"
										data-odrdtlprdtcnt="${odr.odrDtlPrdtCnt}"
										data-odrdtlstrid="${odr.odrDtlStrId}"
										data-useyn="${odr.useYn}"
										data-delyn="${odr.delYn}"
										data-mbrid="${odr.mbrId}"
										data-prdtnm="${odr.prdtVO.prdtNm}"
										data-prdtprc="${odr.prdtVO.prdtPrc}"
										data-uuidflnm="${odr.prdtVO.uuidFlNm}"
										data-strnm="${odr.strVO.strNm}"
										data-strcallnum="${odr.strVO.strCallNum}">
										<!-- <td onclick="event.cancelBubble=true"><input type="checkbox" class="check_idx" value="${odr.odrDtlId}" /></td> -->
										<td><img src="${context}/prdt/img/${odr.prdtVO.uuidFlNm}"></td>
										<td>${odr.prdtVO.prdtNm}</td>
										<td>${odr.odrDtlPrdtCnt}</td>
										<c:choose>
											<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
												<td><del style="font-size: 12px; color: #333;">${odr.prdtVO.prdtPrc}</del>  <span>${odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}</span></td>
											</c:when>
											<c:otherwise>
												<td>${odr.prdtVO.prdtPrc}</td>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
												<td><del style="font-size: 12px; color: #333;">${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</del>  <span>${odr.odrDtlPrdtCnt * odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}</span></td>
											</c:when>
											<c:otherwise>
												<td>${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</td>
											</c:otherwise>
										</c:choose>
										<td onclick="event.cancelBubble=true"><button type="button" class="btn btn-danger btn-sm delete_btn"
													 value="${odr.odrDtlId}">삭제</button></td>
									</tr>
									<c:choose>
										<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
											<c:set var="sum" value="${sum + odr.odrDtlPrdtCnt * odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}" />
										</c:when>
										<c:otherwise>
											<c:set var="sum" value="${sum + odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}" />
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<input type="hidden" id="sum" value='<c:out value="${sum}"/>'/>
							</c:when>
							<c:otherwise>
								<td colspan="8">주문 내역이 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table> --%>
				
				<div>
					<div style="position: relative;'">
						<div style="position: absolute; right: 10px; top:0px;">
							<div style="display: inline-block;">합계 : <span><c:out value="${sum > 0 ? sum : 0}" /></span>원</div>
							<div style="display: inline-block;">충전 잔량 : <span><c:out value="${mbrVO.mbrPyMn}" /></span>원</div>
						</div>
						<div style="position: absolute; right: 10px; top: 30px;">
							<button id="pay_btn" type="button" class="btn btn-success">결제하기</button>
							<button id="list_btn" type="button" class="btn btn-secondary">목록</button>
							<button id="delete_all_btn" type="button" class="btn btn-danger">전체 삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div class="pagenate">
				<ul style="list-style: none;">
					<c:set value="${odrDtlList.size() >0 ? odrDtlList.get(0).lastPage : 0}" var="lastPage" />
					<c:set value="${odrDtlList.size() >0 ? odrDtlList.get(0).lastGroup : 0}" var="lastGroup" />
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(odrDtlVO.pageNo / 10)}" integerOnly="true" />
					<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
					<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
					<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
					
					<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
					<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
					
					
					<c:if test="${nowGroup > 0}">
						<li><a href="javascript:movePage(0)">처음</a></li>
						<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
					</c:if>
				
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li><a class="${pageNo eq odrDtlVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
					
					<c:if test="${lastGroup > nowGroup}">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>
			<jsp:include page="../include/footer.jsp" />
<jsp:include page="../include/closeBody.jsp" />
</html>
