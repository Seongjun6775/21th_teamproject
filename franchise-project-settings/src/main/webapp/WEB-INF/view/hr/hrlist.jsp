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
		$("#create_btn").click(function() {
			location.href="${context}/hr/hrcreate"
		});
		
		$("#hr_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.hrid != null && (data.hrid) != "") {
				location.href="${context}/hr/hrdetail/" + data.hrid;
			}
		});
		
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
				<span class="fs-5 fw-bold">회원 채용 페이지 테스트</span>
		    </div>
			<div id="hr_table_grid" class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
				<div style="margin: 13px;">총 ${myHrList.size() > 0 ? myHrList.get(0).totalCount : 0}건</div>
				<table class="table caption-top table-hover" style="text-align: center;">
				  <thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
				    <tr>
				      <th scope="col" style="border-radius: 6px 0 0 0; padding: 20px 20px 8px 20px;">채용 번호</th>
					  <th scope="col" style="padding: 20px 20px 8px 20px;">작성자 ID</th>
					  <th scope="col" style="padding: 20px 20px 8px 20px;">제목</th>
					  <th scope="col" style="padding: 20px 20px 8px 20px;">등록일</th>
					  <th scope="col" style="border-radius: 0 6px 0 0; padding: 20px 20px 8px 20px;">채용 상태</th>
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
								    data-delyn="${hr.delYn}"
								    style="${hr.ntcYn eq 'Y' ? 'font-weight: bold' : ''};">
									<td>${hr.hrId}</td>
									<td>${hr.mbrId}</td>
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
				<div style="float: right;">
					<button id="create_btn" class="btn btn-success">작성</button>
				</div>
			</div>
		
<jsp:include page="../include/closeBody.jsp" />
</html>
