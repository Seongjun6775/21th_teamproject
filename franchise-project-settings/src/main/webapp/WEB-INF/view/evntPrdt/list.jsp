<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 상품 목록 조회</title>
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
			<h1>이벤트상품 리스트 목록 조회</h1>
			<div>총 ${evntPrdtList.size()}건</div>
		</div>
		<div class="content">
			<div class="grid">
				<table>
					<thead>
						<tr>
							<th style="width: 100px">이벤트 상품 ID</th>
							<th style="width: 200px">이벤트 ID</th>
							<th style="width: 200px">상품 ID</th>
							<th style="width: 200px">변경 후 가격</th>
							<th style="width: 80px">사용유무</th>
							<th style="width: 80px">삭제여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty evntPrdtList}">
								<c:forEach items="${evntPrdtList}" var="evntPrdt">
									<tr>
										<td>${evntPrdt.evntPrdtId}</td>
										<td>${evntPrdt.evntId}</td>
										<td>${evntPrdt.prdtId}</td>
										<td>${evntPrdt.evntPrdtChngPrc}</td>
										<td>${evntPrdt.useYn}</td>
										<td>${evntPrdt.delYn}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6">등록된 이벤트 대상 품목 정보가 없습니다.</td>
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