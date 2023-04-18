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
<title>매장별 메뉴 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	
})


function movePage(pageNo) {
	var srt = $("#search-keyword-strPrdtSrt").val(); 
	var strPrdtNm= $("#search-keyword-strPrdtNm").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	
	var queryString = "strPrdtPageNo=" + pageNo;
	/* queryString = "&strPrdtSrt=" + srt;
	queryString += "&strPrdtNm=" + strPrdtNm;
	queryString += "&useYn=" + useYn; */
	
	location.href = "${context}/strprdt/list?" + queryString; // URL 요청
} 
</script>
</head>
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div>
			<jsp:include page="../include/sidemenu.jsp"></jsp:include>
			<jsp:include page="../include/content.jsp"></jsp:include>
			<div class="grid">
				<div class="space-between mb-10">
					
					
				</div>
				<table id="dataTable"
						class="mb-10">
					<thead>
						<tr>
							<th><input type="checkbox" id="all-check"/></th>
							<th>ID</th>
							<th>매장ID</th>
							<th>
								<select class="selectFilter" name="selectFilter"
									id="search-keyword-srt">
								<option value="">매장목록</option>
								<c:choose>
									<c:when test="${not empty strList}">
										<c:forEach items="${strList}"
													var="str">
											<option value="${str.strId}">${str.strNm} (${str.strId})</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
							</th>
							<th>상품ID</th>
							<th>상품이름</th>
							<th>수정자</th>
							<th>수정일</th>
							<th>
							<select class="selectFilter" name="selectFilter"
									id="search-keyword-useYn">
								<option value="">사용유무</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty strPrdtList}">
								<c:forEach items="${strPrdtList}"
											var="strPrdt"
											varStatus="index">
									<tr data-strPrdtId="${strPrdt.strPrdtId}" 
										> 
										<td class="align-center">
											<input type="checkbox" class="check-idx" value="${strPrdt.strPrdtId}" />
										</td>
										<td>${strPrdt.strPrdtId}</td>
										<td>${strPrdt.strVO.strId}</td>
										<td>${strPrdt.strVO.strNm}</td>
										<td>${strPrdt.prdtVO.prdtId}</td>
										<td>${strPrdt.prdtVO.prdtNm}</td>
										<td>${strPrdt.mdfyr}(${strPrdt.mdfyrMbrVO.mbrNm})</td>
										<td>${strPrdt.mdfyDt}</td>
										<td>${strPrdt.useYn}</td>
									</tr>
								</c:forEach>	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" class="no-items">
										등록된 항목이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<div class="relative">
					<div class="align-left absolute fontsize14">
						<!-- 페이지네이션용  -->
						총 ${strPrdtList.size() > 0 ? strPrdtList.get(0).totalCount : 0}건
						<%-- 총 ${strPrdtList.size() > 0 ? strPrdtList.size() : 0}건 --%>
					</div>
					<div class="align-right absolute " style="right: 0px;" >
						<button class="btn-primary" 
								id="btn-search-reset">검색초기화</button>
						<button id="btn-delete-all" 
								class="btn-primary btn-delete" 
								style="vertical-align: top;">일괄삭제</button>
					</div>
					
					<div class="pagenate">
						<ul>
							<c:set value="${strPrdtList.size() > 0 ? strPrdtList.get(0).lastPage : 0}" var="lastPage"></c:set>
							<c:set value="${strPrdtList.size() > 0 ? strPrdtList.get(0).lastGroup : 0}" var="lastGroup"></c:set>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(strPrdtVO.strPrdtPageNo / strPrdtVO.strPrdtPageCnt)}" integerOnly="true" />
							<c:set value="${nowGroup * strPrdtVO.strPrdtPageCnt}" var="groupStartPageNo"></c:set>
							<c:set value="${groupStartPageNo + strPrdtVO.strPrdtPageCnt}" var="groupEndPageNo"></c:set>
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1}" var="groupEndPageNo"></c:set>
							
							<c:set value="${(nowGroup - 1) * strPrdtVO.strPrdtPageCnt}" var="prevGroupStartPageNo"></c:set>
							<c:set value="${(nowGroup + 1) * strPrdtVO.strPrdtPageCnt}" var="nextGroupStartPageNo"></c:set>
							
							 
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo+strPrdtVO.strPrdtPageCnt-1})">이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1"	var="strPrdtPageNo">
								<li><a class="${strPrdtPageNo eq strPrdtVO.strPrdtPageNo ? 'on' : ''}"  href="javascript:movePage(${strPrdtPageNo})">${strPrdtPageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li><a href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div>
				</div>
				strPrdtPageNo: ${strPrdtPageNo}
				strPrdtVO.strPrdtPageNo: ${strPrdtVO.strPrdtPageNo}
				
				<div class="align-right grid-btns">
					<a href="${context}/prdt/list">메뉴리스트</a>
				</div>
				
			</div>
			
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>
	
</body>
</html>