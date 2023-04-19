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
<link rel="stylesheet" href="${context}/css/hr_common.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$(".create_btn").click(function() {
			location.href="${context}/hr/create"
		});
		
		$("#all_check").change(function() {
			$(".check_idx").not("[disabled=disabled]").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#check_download_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			
			if (checkLen == 0) {
				alert("선택한 글이 없습니다.");
				return;
			}
			
			$(".check_idx:checked").each(function() {
				location.href= "${context}/hr/hrfile/" + $(this).val();
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
			<h3>master 채용 페이지 테스트</h3>
			<div>
				<div>총 ${hrList.size() > 0 ? hrList.get(0).totalCount : 0}건</div>
				<button id="check_download_btn">전체 다운로드</button>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>채용 번호</th>
							<th>지원자 ID</th>
							<th>채용 종류</th>
							<th>제목</th>
							<th>등록일</th>
							<th>승인 여부</th>
							<th>채용 상태</th>
							<th>삭제 여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty hrList}">
								<c:forEach items="${hrList}" var="hr">
									<tr data-hrid="${hr.hrId}"
									    data-mbrid="${hr.mbrId}"
									    data-hrlvl="${hr.hrLvl}"
									    data-hrttl="${hr.hrTtl}"
									    data-hrrgstdt="${hr.hrRgstDt}"
									    data-hrapryn="${hr.hrAprYn}"
									    data-hrstat="${hr.hrStat}"
									    data-delyn="${hr.delYn}">
									    <c:set var="checkYn" value="" />
									    <c:choose>
									    	<c:when test="${hr.delYn eq 'Y'}">
									    		<c:set var="checkYn" value="disabled" />
									    	</c:when>
									    	<c:when test="${hr.ntcYn eq 'Y'}">
									    		<c:set var="checkYn" value="disabled" />
									    	</c:when>
									    	<c:when test="${hr.orgnFlNm eq null}">
									    		<c:set var="checkYn" value="disabled" />
									    	</c:when>
									    </c:choose>
										<td><input type="checkbox" class="check_idx" value="${hr.hrId}" ${checkYn}/></td>
										<td>${hr.hrId}</td>
										<td>${hr.mbrId}</td>
										<td>${hr.cdNm}</td>
										<td><a href="${context}/hr/mstrdetail/${hr.hrId}">${hr.hrTtl}</a></td>
										<td>${hr.hrRgstDt}</td>
										<td>${hr.hrAprYn}</td>
										<td>${hr.hrStat}</td>
										<td>${hr.delYn eq 'Y' ? '삭제됨' : ''}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="8">등록된 지원서가 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div>
				<button class="create_btn">작성</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
