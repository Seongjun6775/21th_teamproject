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
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="${context}/css/hr_common.css?p=${date}">
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
		
		$("#check_del_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			
			if (checkLen == 0) {
				alert("선택한 글이 없습니다.");
				return;
			}
			
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='hrId' value='" + $(this).val() + "'>")
			});
			
			$.post("${context}/api/hr/delete", form.serialize(), function(response) {});
			location.reload();
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
			<h3>회원 채용 페이지 테스트</h3>
			<div>
				<div>총 ${myHrList.size() > 0 ? myHrList.get(0).totalCount : 0}건</div>
				<button id="check_del_btn">일괄삭제</button>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th>채용 번호</th>
							<th>지원자 ID</th>
							<th>제목</th>
							<th>등록일</th>
							<th>승인 여부</th>
							<th>채용 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty myHrList}">
								<c:forEach items="${myHrList}" var="hr">
									<tr data-hrid="${hr.hrId}"
									    data-mbrid="${hr.mbrId}"
									    data-hrttl="${hr.hrTtl}"
									    data-hrrgstdt="${hr.hrRgstDt}"
									    data-hrapryn="${hr.hrAprYn}"
									    data-hrstat="${hr.hrStat}"
									    data-delyn="${hr.delYn}">
										<td>${hr.hrId}</td>
										<td>${hr.mbrId}</td>
										<td><a href="${context}/hr/hrdetail/${hr.hrId}">${hr.hrTtl}</a></td>
										<td>${hr.hrRgstDt}</td>
										<td>${hr.hrAprYn}</td>
										<td>${hr.hrStat}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="6">등록된 지원서가 없습니다.</td>
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
