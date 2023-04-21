<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="../../css/evntPrdtCommon.css">
<meta charset="UTF-8">
<title>이벤트 상품 등록 페이지</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {

		// 1. 등록 버튼을 누르면 수행할 내용
		$("#btn-create").click(function() {
			$.post(
			// 1. 호출할 주소
			"${context}/api/evntPrdt/create",

			// 2. 파라미터
			{
				evntId : "${evntId}",
				evntPrdtId : $("#evntPrdtId").val(),
				prdtId : $("#prdtId").val(),
				prdtNm : $("#prdtNm").val(),
				prdtPrc : $("#prdtPrc").val(),
				evntPrdtChngPrc : $("#evntPrdtChngPrc").val()
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
		});

		//'돌아가기'버튼 누르면 뒤로 돌아가기
		$("#btn-cancle").click(function() {
			window.close();
		});

	})

	function changeSelection() {
		var selectedElement = document.getElementById("selectBoxprdtList");

		// 선택한 option의 value, 텍스트
		var optionVal = selectedElement.options[selectedElement.selectedIndex].value;
		var optionTxt = selectedElement.options[selectedElement.selectedIndex].text;
		
		document.getElementById("prdtId").value = optionVal;
		document.getElementById("prdtNmPrc").value = optionTxt;
	}
</script>

</head>
<body>

	<div class="main-layout">
		<div>
			<table border=1 style="width: 600px;">
				<tr>
					<td colspan="4"><h1 style="text-align: center;">이벤트 상품 등록
							페이지</h1></td>
				</tr>
				<tr>
					<td style="text-align: center;">이벤트 ID</td>
					<td colspan="3"><input type="text" id="evntPrdtId"
						style="width: 99%;" readonly="readonly"
						placeholder="이벤트ID는 입력할 수 없습니다." value="${evntId}" /></td>
				</tr>

				<tr>
					<td style="text-align: center;">전체 상품 리스트</td>
					<td colspan="3" style="text-align: center;">이벤트 상품 가격 설정</td>
				</tr>
				<tr>
					<td rowspan="5"><c:choose>
							<c:when test="${not empty prdtVOList}">
								<select name="selectBoxprdtList" id="selectBoxprdtList" onchange="changeSelection()"
									style="width: 100%; height: 100%; text-align: center;"
									size="10">
									<c:forEach items="${prdtVOList}" var="prdt">
										<option value="${prdt.prdtId}">${prdt.prdtNm}&nbsp;/&nbsp;${prdt.prdtPrc}</option>
									</c:forEach>
								</select>

							</c:when>
							<c:otherwise>
									등록된 상품이 없습니다.
															</c:otherwise>
						</c:choose></td>
					<td>상품 ID</td>
					<td colspan="2"><input type="text" id="prdtId" name="prdtId"
						style="width: 95%; text-align: center;" value="1234"
						readonly="readonly" /></td>
				</tr>
				<tr>

					<td>상품 이름 / 가격</td>
					<td colspan="2"><input type="text" id="prdtNmPrc" name="prdtNmPrc"
						style="width: 95%; text-align: center;" value="1234"
						readonly="readonly" /></td>
				</tr>
				<tr>

					<td colspan="3"></td>
				</tr>
				<tr>

					<td>상품 이벤트 가격</td>
					<td colspan="2"><input type="text" id="evntPrdtChngPrc" name="evntPrdtChngPrc"
						style="width: 95%; text-align: right;" value="" style="" /></td>
				</tr>
				<tr>
					<td></td>
					<td><button id="btn-create" class="btn-primary"
							style="width: 100%;">등록</button></td>
					<td><button id="btn-cancle" class="btn-primary"
							style="width: 100%;">돌아가기</button></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>