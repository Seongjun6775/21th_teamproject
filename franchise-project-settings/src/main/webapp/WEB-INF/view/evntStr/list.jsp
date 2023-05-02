<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<%-- <link rel="stylesheet" href="../../css/evntCommon.css?p=${date}" /> --%>
<meta charset="UTF-8">
<title>이벤트 참여매장 목록 조회</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		// 창 닫기
		$("#btn-close").click(function() {
			window.close();
		});
	});
	
	/* function movePage(pageNo){
	function movePage(pageNo){
		var queryString = "pageNo=" + pageNo;
		
		location.href = "${context}/evntStr/list?" + queryString;
		
	} */
	
	function movePage(pageNum){
		location.href = "${context}/evntStr/list/${evntId}?pageNum=" + (pageNum);
		
	}
</script>



</head>
<body>
<div style="padding: 23px 18px 23px 18px;">
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin-bottom:20px;" >
	        <span class="fs-5 fw-bold"> 이벤트참여매장 리스트 목록 조회</span>
      	</div>
		<div class="content">
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding:30px 30px 55px 30px;">
			<div style="display: inline-block; margin-bottom: 5px;">총 ${evntStrList.size()}건</div>
				<table class="table caption-top table-hover" style="text-align: center;">
					<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
						<tr>
<!-- 						<th style="width: 100px">이벤트 참여번호</th> -->
							<th>이벤트 ID</th>
							<th>이벤트명</th>
							<th>이벤트 참여매장 ID</th>
							<th>이벤트 참여매장명</th>
							<th>점주 ID</th>
							<th>점주명</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty evntStrList}">
								<c:forEach items="${evntStrList}" var="evntStr">
									<tr>
<%-- 										<td style="text-align:center;">${evntStr.evntStrId}</td> --%>
										<td style="text-align:center;">${evntStr.evntId}</td>
										<td style="text-align:center;">${evntStr.evntTtl}</td>
										<td style="text-align:center;">${evntStr.strId}</td>
										<td style="text-align:center;">${evntStr.strNm}</td>
										<td style="text-align:center;">${evntStr.mbrId}</td>
										<td style="text-align:center;">${evntStr.mbrNm}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5">등록된 이벤트 참여매장 정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div class="pagenate">
					<ul class="pagination" style="text-align: center;">
						<c:set value="${evntStrList.size() > 0 ? evntStrList.get(0).lastPage : 0}" var="lastPage" />
						  <c:set value="${evntStrList.size() > 0 ? evntStrList.get(0).lastGroup : 0}" var="lastGroup" />

						<c:set
							value="${evntStrList.size() > 0 ? evntStrList.get(0).lastPage : 0}"
							var="lastPage" />
						<c:set
							value="${evntStrList.size() > 0 ? evntStrList.get(0).lastGroup : 0}"
							var="lastGroup" />

						<fmt:parseNumber var="nowGroup"
							value="${Math.floor(evntStrVO.pageNo /10)}" integerOnly="true" />
						<c:set value="${nowGroup*10}" var="groupStartPageNo" />
						<c:set value="${nowGroup*10+ 10}" var="groupEndPageNo" />
						<c:set
							value="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo -1}"
							var="groupEndPageNo" />

						<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
						<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
						<c:if test="${nowGroup > 0}">
							<li class="page-item"><a class="page-link text-secondary"  href="javascript:movePage(0)">처음</a></li>
							<li class="page-item"><a class="page-link text-secondary"  href="javascript:movePage(${prevGroupStartPageNo})" >이전</a></li>
						</c:if>

						<c:forEach begin="${groupStartPageNo}"
							end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1"
							var="pageNo">
							<li class="page-item"><a class="page-link text-secondary"  class="${pageNo eq evntStrVO.pageNo ? 'on' : ''}"
								href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
						</c:forEach>
						<c:if test="${lastGroup > nowGroup}">
							<li class="page-item"><a class="page-link text-secondary"  href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li class="page-item"><a class="page-link text-secondary"  href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</div>
			</div>
			<!-- <button id="btn-close" class="btn-primary">닫기</button> -->
		</div>
	</div>
</body>
</html>