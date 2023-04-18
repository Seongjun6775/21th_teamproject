<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 상품 설정</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
		/*
		$("#btn-createPrdt").click(function(){
		//확인 버튼 누르면 수행할 내용
			 $.post(
				// 1. 호출할 주소
				"${context}/api/evntPrdt/create",
				
				// 2. 파라미터
				{
					evntId: $("#evntId").val(),
					evntTtl: $("#evntTtl").val(),
					evntCntnt: $("#evntCntnt").val(),
					evntStrtDt: $("#evntStrtDt").val(),
					evntEndDt: $("#evntEndDt").val(),
					evntPht: $("#evntPht").val(),
					useYn: $('#useYn:checked').val(),
		            delYn: $('#delYn').val()
				},
				
				// 3. 결과 처리
				function(response) {
					if (response.status == "200 OK") {
						alert(response.message);
						//location.reload(); // 새로고침
					} else {
						alert(response.errorCode + " / " + response.message);
					}
				});
		 */
		
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
			<h1>상품 리스트 목록 조회</h1>
			<div>총 ${PrdtList.size()}건</div>
		</div>
		<div class="content">
			<div class="grid">
				<table>
					<thead>
						<tr>
							<th style="width: 100px">상품 ID</th>
							<th style="width: 200px">상품 이름</th>
							<th style="width: 200px">상품 가격</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty PrdtList}">
								<c:forEach items="${PrdtList}" var="Prdt">
									<tr>
										<td>${Prdt.prdtId}</td>
										<td>${Prdt.prdtNm}</td>
										<td>${Prdt.prdtPrc}</td>
							
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="3">선택된 상품 정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<button id="btn-createPrdt" calss="btn-primary">확인</button>
			<button id="btn-close" class="btn-primary">닫기</button>

		</div>
	</div>
</body>
</html>