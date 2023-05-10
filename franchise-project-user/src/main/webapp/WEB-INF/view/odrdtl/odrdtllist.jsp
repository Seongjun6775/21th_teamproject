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
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		var odrPrcs = "${odrPrcs.odrLstOdrPrcs}";
		var listSize = ${odrDtlList ne null ? odrDtlList.size() : 0};
		
		if (listSize == 0) {
			location.href = "${context}/odrlst/list";
		}
		
		$(".odrdtl-card").not(".delete_btn").click(function() {
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: '주문 취소된 주문서입니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert("주문 취소된 주문서입니다."); */
					return;
				}
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '이미 주문 접수된 주문서 입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 주문 접수된 주문서입니다."); */
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
			});
			
		});
 
 		$("#delete_all_btn").click(function() {
 			if (odrPrcs != "003-01" && odrPrcs != "003-05") {
 				Swal.fire({
			    	  icon: 'warning',
			    	  title: '이미 주문 처리된 주문서입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
 				/* alert("이미 주문 처리된 주문서입니다."); */
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
 			});
 			
 		});
		
		$("#pay_btn").click(function() {
			
			var pyMn = ${mbrVO.mbrPyMn};
			var sumPrice = parseInt($("#sum").val());
			
			if (odrPrcs != "003-01") {
				if (odrPrcs == "003-05") {
					Swal.fire({
				    	  icon: 'warning',
				    	  title: '주문 취소된 주문서입니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert("주문 취소된 주문서입니다."); */
					return;
				}
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '이미 결제 처리된 주문서입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 결제 처리된 주문서입니다."); */
				return;
			}
			
			if (listSize == 0) {
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '주문할 물품이 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("주문할 물품이 없습니다."); */
				return;
			}
			
			if (sumPrice > pyMn) {
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '잔액 부족',
			    	  text: '잔액이 부족합니다. 먼저 금액을 충전해 주세요.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("충전 잔량이 부족합니다. 먼저 금액을 충전해 주세요!"); */
				return;
			}
			var restMn = pyMn - sumPrice;
			$.post("${context}/api/odrlst/update/${odrLstId}", {"mbrPyMn": restMn}, function(response){
				if (response.status == "200 OK") {
					Swal.fire({
				    	  icon: 'success',
				    	  title: '주문이 접수되었습니다.',
				    	  showConfirmButton: true,
				    	  confirmButtonColor: '#3085d6'
					}).then((result)=>{
						if(result.isConfirmed){
							location.href = "${context}/odrlst/list";
						}
					});
					/* alert("주문이 접수되었습니다."); */
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
			});
		});
		
		$("#list_btn").click(function() {
			location.href = "${context}/odrlst/list";
		});
		
		$("#rv_btn").click(function() {
			location.href = "${context}/rv/create/${odrLstId}";
		})
		
	});
	
	function movePage(pageNo) {
		location.href = "${context}/odrdtl/list/${odrLstId}?pageNo=" + pageNo;
	}
	
</script>

<style>
#menu {
/* 	background-color: #F002; */
	width: 1440px;
	margin: 0 auto;
	margin-bottom: 144px;
}
</style>

</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">주문조회
			<div style="color: #ccc; padding-top: 10px;"></div>
		</div>
		<div class="overlay absolute"></div>
	</div>
			<!-- <button id="check_del_btn" class="btn btn-danger btn-sm">일괄삭제</button> -->
			<div class="odrdtl_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<div id="menu">
					<div>총 ${odrDtlList.size() > 0 ? odrDtlList.get(0).totalCount : 0}건</div>
					<c:choose>
						<c:when test="${not empty odrDtlList}">
						<c:set var="sum" value="0" />
							<c:forEach items="${odrDtlList}" var="odr">
								<div class="odrdtl-card flex" style="width:100%; background-color: #efefef; border-radius: 16px;"
									data-odrdtlid="${odr.odrDtlId}"
									data-odrlstid="${odr.odrLstId}"
									data-odrdtlprdtid="${odr.odrDtlPrdtId}"
									data-odrdtlprdtcnt="${odr.odrDtlPrdtCnt}"
									data-odrdtlstrid="${odr.odrDtlStrId}"
									data-useyn="${odr.useYn}"
									data-delyn="${odr.delYn}"
									data-mbrid="${odr.mbrId}"
									data-odrdtlprc="${odr.odrDtlPrc}"
									data-prdtnm="${odr.prdtVO.prdtNm}"
									data-prdtprc="${odr.prdtVO.prdtPrc}"
									data-uuidflnm="${odr.prdtVO.uuidFlNm}"
									data-strnm="${odr.strVO.strNm}"
									data-strcallnum="${odr.strVO.strCallNum}">
									<div class="flex" style="padding: 24px; border-right: 1px solid #ccc;">
										<div class="img-box" style="width: 180px; height: 200px;">
											<img class="" src="${context}/prdt/img/${odr.prdtVO.uuidFlNm}">
										</div>
									</div>
									<div class="relative" style="align-self: center; padding: 24px; width:100%;">
										<div class="dtl-prdtNm" style="margin-bottom: 8px; font-size: 24px;">상품명<span class="padding10-bold" style="font-size: 24px;">${odr.prdtVO.prdtNm}</span></div>
										<div class="dtl-prdtCnt" style="margin-bottom: 8px; font-size: 24px;">수량<span class="padding10-bold" style="font-size: 24px;">${odr.odrDtlPrdtCnt}</span>개</div>
										<div class="dtl-prdtPrc" style="margin-bottom: 8px; font-size: 24px;">개당 가격
											<c:choose>
												<c:when test="${odrPrcs.odrLstOdrPrcs eq '003-01'}">
													<c:choose>
														<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
															<del class="evntPrdtPrc" style="font-size: 24px; color: #333;">${odr.prdtVO.prdtPrc}</del>  <span style="font-weight: bold; font-size: 24px;">${odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}</span>원
														</c:when>
														<c:otherwise>
															<span class="padding10-bold" style="font-size:24px;">${odr.prdtVO.prdtPrc}</span>원
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span style="font-weight: bold; font-size:24px;">${odr.odrDtlPrc}</span>원
												</c:otherwise>
											</c:choose>
										</div>
										<div class="dtl-sumPrc" style="font-size: 24px;">합계
											<c:choose>
												<c:when test="${odrPrcs.odrLstOdrPrcs eq '003-01'}">
													<c:choose>
														<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
															<del class="evntPrdtPrc" style="font-size: 24px; color: #333;">${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</del>  <span style="font-weight: bold; font-size: 24px;">${odr.odrDtlPrdtCnt * odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}</span>원
														</c:when>
														<c:otherwise>
															<span class="padding10-bold" style="font-size: 24px;">${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</span>원
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span class="padding10-bold" style="font-size: 24px;">${odr.odrDtlPrdtCnt * odr.odrDtlPrc}</span>원
												</c:otherwise>
											</c:choose>
										</div>
										<div class="delete" style="" onclick="event.cancelBubble=true">
											<button type="button" class="btn btn-danger btn-sm delete_btn"
													 value="${odr.odrDtlId}">X</button>
										</div>
										<c:choose>
											<c:when test="${not empty odr.prdtVO.evntPrdtVO.evntId}">
												<c:set var="sum" value="${sum + odr.odrDtlPrdtCnt * odr.prdtVO.evntPrdtVO.evntPrdtChngPrc}" />
											</c:when>
											<c:otherwise>
												<c:set var="sum" value="${sum + odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</c:forEach>
							<input type="hidden" id="sum" value='<c:out value="${sum}"/>'/>
						</c:when>
					</c:choose>
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
					<div id="div-pay">
						<div style="position: relative;">
							<div style="position: absolute; right: 10px; top:0px;">
								<div style="display: inline-block; margin-right: 10px;">합계 : <span class="padding10-bold"><c:out value="${sum > 0 ? sum : 0}" /></span>원</div>
								<div style="display: inline-block;">충전 잔량 : <span class="padding10-bold">${mbrVO.mbrPyMn}</span>원</div>
							</div>
							<div style="position: absolute; right: 10px; top: 30px;">
								<c:if test="${odrPrcs.odrLstOdrPrcs eq '003-04'}">
									<button id="rv_btn" type="button" class="btn btn-primary">리뷰 작성</button>
								</c:if>
								<button id="pay_btn" type="button" class="btn btn-success">결제하기</button>
								<button id="list_btn" type="button" class="btn btn-secondary">목록</button>
								<button id="delete_all_btn" type="button" class="btn btn-danger">전체 삭제</button>
							</div>
						</div>
					</div>

				</div>
			</div>
				
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>
