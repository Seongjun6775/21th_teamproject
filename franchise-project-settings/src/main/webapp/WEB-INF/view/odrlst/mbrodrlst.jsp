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
	$().ready(function() {
		
		$(".odrlst_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.odrlstid != null && (data.odrlstid) != "") {
				location.href="${context}/odrdtl/list/" + data.odrlstid;
			}
		});
		
	});
	
	function movePage(pageNo) {
		location.href = "${context}/odrlst/mbrodrlst?pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div>총 ${myOdrLst.size() > 0 ? myOdrLst.get(0).totalCount : 0}건</div>
			<div></div>
			<div class="odrlst_table_grid">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>주문 번호</th>
							<th>주문 일자</th>
							<th>주문 매장</th>
							<th>주문 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty myOdrLst}">
								<c:forEach items="${myOdrLst}" var="odrLst">
									<tr data-odrlstid="${odrLst.odrLstId}"
										data-mbrid="${odrLst.mbrId}"
										data-odrlstodrprcs="${odrLst.odrLstOdrPrcs}"
										data-odrlstrgstdt="${odrLst.odrLstRgstDt}"
										data-odrlstrgstr="${odrLst.odrLstRgstr}"
										data-mdfydt="${odrLst.mdfyDt}"
										data-mdfyr="${odrLst.mdfyr}"
										data-useyn="${odrLst.useYn}"
										data-delyn="${odrLst.delYn}">
										<td>${odrLst.odrLstId}</td>
										<td>${odrLst.odrLstRgstDt}</td>
										<td>${odrLst.strVO.strNm}</td>
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
			</div>
			<div class="pagenate">
				<ul>
					<c:set value="${myOdrLst.size() >0 ? myOdrLst.get(0).lastPage : 0}" var="lastPage" />
					<c:set value="${myOdrLst.size() >0 ? myOdrLst.get(0).lastGroup : 0}" var="lastGroup" />
					
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
