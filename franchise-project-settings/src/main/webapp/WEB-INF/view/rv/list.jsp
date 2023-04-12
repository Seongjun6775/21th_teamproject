<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#new_btn").click(function() {
			location.href = "${context}/rv/create";
		});
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/rvMgmtSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">리뷰 > 리뷰목록</div>
			
			<h1>리뷰 목록</h1>
			
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>순번</th>
						<th>리뷰ID</th>
						<th>회원ID</th>
						<th>주문ID</th>
						<th>제목</th>
						<th>내용</th>
						<th>좋아요/싫어요</th>
						<th>등록일</th>
						<th>수정일</th>
						<th>사용유무</th>
						<th>삭제여부</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty rvList}">
							<c:forEach items="${rvList}"
									   var="rv">
								<tr>
									<td>
										<input type="checkbox" 
											   class="check_idx" 
											   value="${rv.rvId}"/>
									</td>
									<td>${rv.rvId}</td>
									<td>${rv.rvId}</td>
									<td>${rv.mbrId}</td>
									<td>${rv.odrId}</td>					
									<td>${rv.rvTtl}</td>					
									<td>${rv.rvCntnt}</td>					
									<td>${rv.rvLkDslk}</td>					
									<td>${rv.rvRgstDt}</td>					
									<td>${rv.mdfyDt}</td>					
									<td>${rv.useYn}</td>					
									<td>${rv.delYn}</td>					
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<td colspan="12" class="no-item">
								등록된 리뷰가 없습니다.
							</td>
						</c:otherwise>
					</c:choose>			
				</tbody>
			</table>		
			<div class="align-right">
				
				<button id="search_btn" class="btn-search">검색</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
				<button id="new_btn" class="btn-primary">등록</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>