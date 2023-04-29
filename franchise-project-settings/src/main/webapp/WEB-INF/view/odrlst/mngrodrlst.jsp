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
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">











<!-- 현재 사용하지 않는 페이지입니다. -->















$().ready(function() {
		
		$(".odrlst_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.odrlstid != null && (data.odrlstid) != "") {
				location.href="${context}/odrdtl/list/" + data.odrlstid;
			}
		});
		
		$("#all_check").change(function() {
			$(".check_idx").not("[disabled=disabled]").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#check_no_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			
			if (${sessionScope.__MBR__.mbrLvl} != "001-02" || ${sessionScope.__MBR__.mbrLvl} != "001-03") {
				alert("권한이 없습니다!");
				return;
			}
			
			if (checkLen == 0) {
				alert("선택한 쪽지가 없습니다.");
				return;
			}
			
			if (!confirm("선택한 주문을 취소 처리 하시겠습니까?")) {
				return;
			}
			
			/* var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				form.append("<input type='hidden' name='odrLstId' value='" + $(this).val() + "'>")
			});
			
			$.post("${context}/api/odrlst/no", form.serialize(), function(response) {});
			location.reload(); */
		});
		
	});

	function movePage(pageNo) {
		location.href = "${context}/odrlst/mngrodrlst?pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div>총 ${allOdrLst.size() > 0 ? allOdrLst.get(0).totalCount : 0}건</div>
			<div class="odrlst_table_grid">
				<table class="table table-striped">
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>주문 번호</th>
							<th>주문 일자</th>
							<th>주문 매장</th>
							<th>최종 수정자</th>
							<th>주문 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty allOdrLst}">
								<c:forEach items="${allOdrLst}" var="odrLst">
									<tr data-odrlstid="${odrLst.odrLstId}"
										data-mbrid="${odrLst.mbrId}"
										data-odrlstodrprcs="${odrLst.odrLstOdrPrcs}"
										data-odrlstrgstdt="${odrLst.odrLstRgstDt}"
										data-odrlstrgstr="${odrLst.odrLstRgstr}"
										data-mdfydt="${odrLst.mdfyDt}"
										data-mdfyr="${odrLst.mdfyr}"
										data-useyn="${odrLst.useYn}"
										data-delyn="${odrLst.delYn}">
										<td onclick="event.cancelBubble=true"><input type="checkbox" class="check_idx" value="${odrLst.odrLstId}"
										            ${odrLst.delYn eq 'Y' ? 'disabled' : ''}/></td>
										<td>${odrLst.odrLstId}</td>
										<td>${odrLst.odrLstRgstDt}</td>
										<td>${odrLst.strVO.strNm}</td>
										<td>${odrLst.mdfyr}</td>
										<td>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-01'}">주문대기</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-02'}">주문접수</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-03'}">주문처리</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-04'}">주문완료</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-05'}">주문취소</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="3">주문 내역이 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<button type="button" id="check_yes_btn" class="btn btn-success">일괄처리</button>
				<button type="button" id="check_no_btn" class="btn btn-danger">일괄취소</button>
			</div>
			<div class="pagenate">
				<ul>
					<c:set value="${allOdrLst.size() >0 ? allOdrLst.get(0).lastPage : 0}" var="lastPage" />
					<c:set value="${allOdrLst.size() >0 ? allOdrLst.get(0).lastGroup : 0}" var="lastGroup" />
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(odrLstVO.pageNo / 10)}" integerOnly="true" />
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
						<li><a class="${pageNo eq odrLstVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
					
					<c:if test="${lastGroup > nowGroup}">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
