<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 등록 페이지</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	$("#btn-create").click(function(){
		$.post(
				// 1. 호출할 주소
				"${context}/api/evnt/createNewEvnt",
				
				// 2. 파라미터
				{
					evntId: $("#evntId").val(),
					evntTtl: $("#evntTtl").val(),
					evntCntnt: $("#evntCntnt").val(),
					evntStrtDt: $("#evntStrtDt").val(),
					evntEndDt: $("#evntEndDt").val(),
					evntPht: $("#evntPht").val(),
					useYn: $('#useYn').is(":checked"),
					delYn: $('#delYn').is(":checked")
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
	
})
</script>

</head>
<body>

	<div class="main-layout">
		<div>
			<table border=1 style="width: 600px;">
				<tr>
					<td colspan="4"><h1 style="text-align: center;">이벤트 등록
							페이지</h1></td>
				</tr>
				<tr>
					<td>이벤트 ID</td>
					<td colspan="3"><input type="text" id="evntId"
						style="width: 99%;" value="" /></td>
				</tr>

				<tr>
					<td>이벤트 제목</td>
					<td colspan="3"><input type="text" id="evntTtl"
						style="width: 99%;" value="" /></td>
				</tr>

				<tr>
					<td>이벤트 내용</td>
					<td colspan="3"><input type="text" id="evntCntnt"
						style="width: 99%; height: 99px" value="" /></td>
				</tr>

				<tr>
					<td>이벤트 시작일</td>
					<td><input type="date" id="evntStrtDt" value="" /></td>
					<td>이벤트 종료일</td>
					<td><input type="date" id="evntEndDt" value="" /></td>
				</tr>

				<tr>
					<td>이벤트 사진</td>
					<td colspan="3"><input type="file" id="evntPht"
						style="width: 99%;" value="" /></td>
				</tr>

				<tr>
					<td>사용 여부</td>
					<td><input type="checkbox" id="useYn"
						value="" checked/></td>
					<td>삭제 여부</td>
					<td><input type="checkbox" id="delYn" value="" /></td>
				</tr>

				<tr>
					<td></td>
					<td></td>
					<td><button id="btn-create" class="btn-primary" style="width:100%;">등록</button></td>
					<td><button id="btn-cencle" class="btn-primary" style="width:100%;">취소</button></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>