<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
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
</script>



</head>
<body>
	<div class="main-layout">
		<div>
			<h1>이벤트참여매장 리스트 목록 조회</h1>
			<div>총 ${evntStrList.size()}건</div>
		</div>
		<div class="content">
			<div class="grid">
				<table>
					<thead>
						<tr>
							<th style="width: 100px">이벤트 참여번호</th>
							<th style="width: 200px">이벤트 ID</th>
							<th style="width: 200px">이벤트 참여매장 ID</th>
							<th style="width: 200px">이벤트 참여매장명</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty evntStrList}">
								<c:forEach items="${evntStrList}" var="evntStr">
									<tr>
										<td>${evntStr.evntStrId}</td>
										<td>${evntStr.evntId}</td>
										<td>${evntStr.strId}</td>
										<td>${evntStr.strNm}</td>
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
			</div>
			
			<button id="btn-close" class="btn-primary">닫기</button>

		</div>
	</div>
</body>
</html>