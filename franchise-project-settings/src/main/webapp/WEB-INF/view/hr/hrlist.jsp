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
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<script type="text/javascript">
	$().ready(function() {
		$(".create_btn").click(function() {
			location.href="${context}/hr/hrcreate"
		});
		
		$(".hr_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.hrid != null && (data.hrid) != "") {
				location.href="${context}/hr/hrdetail/" + data.hrid;
			}
		});
		
	});
	
	function movePage(pageNo) {
		location.href = "${context}/hr/hrlist?pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/mbrMgmtSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			
			<div class="container">
			    <header class="d-flex justify-content-center py-3">
			      <ul class="nav nav-pills">
			        <li class="nav-item"><h3>회원 채용 페이지 테스트</h3></li>
			      </ul>
			    </header>
			</div>
			
			
			
			<div>
				<div>총 ${myHrList.size() > 0 ? myHrList.get(0).totalCount : 0}건</div>
			</div>
			<div class="hr_table_grid">
				<table class="table">
				  <thead>
				    <tr>
				      <th>채용 번호</th>
					  <th>작성자</th>
					  <th>제목</th>
					  <th>등록일</th>
					  <th>채용 상태</th>
				    </tr>
				  </thead>
				  <tbody>
				    <c:choose>
						<c:when test="${not empty myHrList}">
							<c:forEach items="${myHrList}" var="hr">
								<tr data-hrid="${hr.hrId}"
								    data-mbrid="${hr.mbrId}"
								    data-mbrnm="${hr.mbrVO.mbrNm}"
								    data-hrttl="${hr.hrTtl}"
								    data-hrrgstdt="${hr.hrRgstDt}"
								    data-hrapryn="${hr.hrAprYn}"
								    data-hrstat="${hr.hrStat}"
								    data-delyn="${hr.delYn}"
								    style="${hr.ntcYn eq 'Y' ? 'font-weight: bold' : ''};">
									<td>${hr.hrId}</td>
									<td>${hr.mbrVO.mbrNm}</td>
									<td><a href="${context}/hr/hrdetail/${hr.hrId}">${hr.hrTtl}</a></td>
									<td>${hr.hrRgstDt}</td>
									<c:choose>
											<c:when test="${hr.hrStat eq '002-01'}"><td>접수</td></c:when>
											<c:when test="${hr.hrStat eq '002-02'}"><td>심사중</td></c:when>
											<c:when test="${hr.hrStat eq '002-03'}"><td>심사완료</td></c:when>
											<c:otherwise><td></td></c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<td colspan="5">등록된 지원서가 없습니다.</td>
						</c:otherwise>
					</c:choose>
				  </tbody>
				</table>
			</div>
			<div style="position: relative;">
				<div class="pagenate">
					<nav aria-label="Page navigation example">
						<ul class="pagination" style="text-align: center;">
							<c:set value="${myHrList.size() >0 ? myHrList.get(0).lastPage : 0}" var="lastPage" />
							<c:set value="${myHrList.size() >0 ? myHrList.get(0).lastGroup : 0}" var="lastGroup" />
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(hrVO.pageNo / 10)}" integerOnly="true" />
							<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
							<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
							
							<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
							<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							
							
							<c:if test="${nowGroup > 0}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
						
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
								<li class="page-item"><a class="${pageNo eq hrVO.pageNo ? 'on' : ''} page-link text-secondary" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</nav>
				</div>
				<div>
					<button class="create_btn">작성</button>
				</div>
			</div>
			<footer class="footer mt-auto py-3 bg-light">
			  <div class="container">
			    <span class="text-muted">이건 Footer입니다~</span>
			  </div>
			</footer>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
