<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$(".odrdtl_table_grid > table > tbody > tr").not(".delete_btn").click(function() {
			var data = $(this).data();
			if (data.odrdtlid != null && (data.odrdtlid) != "") {
				location.href="${context}/odrdtl/" + data.odrdtlid;
			}
		});
		
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
		
		$(".delete_btn").click(function(){
			
			if (!confirm("해당 물품을 삭제하시겠습니까?")) {
				return;
			}
			var odrDtlId = $(this).val();
			$.post("${context}/api/odrdtl/delete/" + odrDtlId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/odrdtl/list/${odrLstId}"
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			})
			
		});
		
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			
			<h2>구매 예정 물품 조회 페이지</h2>
			<div>총 ${odrDtlList.size() > 0 ? odrDtlList.get(0).totalCount : 0}건</div>
			<button id="check_del_btn" class="btn btn-danger btn-sm">일괄삭제</button>
			
			<div class="odrdtl_table_grid">
				<table class="table table-striped">
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
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
										data-strnm="${odr.strVO.strNm}"
										data-strcallnum="${odr.strVO.strCallNum}">
										<td onclick="event.cancelBubble=true"><input type="checkbox" class="check_idx" value="${odr.odrDtlId}" /></td>
										<td><img src=""></td>
										<td>${odr.prdtVO.prdtNm}</td>
										<td>${odr.odrDtlPrdtCnt}</td>
										<td>${odr.prdtVO.prdtPrc}</td>
										<td>${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</td>
										<td onclick="event.cancelBubble=true"><button type="button" class="btn btn-danger btn-sm delete_btn"
													 value="${odr.odrDtlId}">삭제</button></td>
									</tr>
									<c:set var="sum" value="${sum + odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}" />
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="9">주문 내역이 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div>
					<div>합계 : <span><c:out value="${sum > 0 ? sum : 0}" /></span>원</div>
					<div><button type="button" class="btn btn-success">결제하기</button></div>
				</div>
			</div>
			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
