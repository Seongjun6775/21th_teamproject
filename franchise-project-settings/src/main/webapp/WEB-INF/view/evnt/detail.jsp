<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 상세 페이지</title>

</head>
<body>

	<div class="main-layout">
		<div>
			<table border=1 style="width: 600px;">
				<tr>
					<td colspan="4"><h1 style="text-align: center;">이벤트 상세
							페이지</h1></td>
				</tr>
				<tr>
					<td>이벤트 ID</td>
					<td colspan="3"><input type="text" id="evntId"
						style="width: 99%;" value="" /></td><td>${data.evntId}</td>
				</tr>

				<tr>
					<td>이벤트 제목</td>
					<td colspan="3"><input type="text" id="evntTtl"
						style="width: 99%;" value="" /></td><td>${data.evntTtl}</td>
				</tr>

				<tr>
					<td>이벤트 내용</td>
					<td colspan="3"><input type="text" id="evntCntnt"
						style="width: 99%; height: 99px" value="" /></td><td>${data.evntCntnt}</td>
				</tr>

				<tr>
					<td>이벤트 시작일</td>
					<td><input type="date" id="evntStrtDt" value="" /></td><td>${data.evntStrtDt}</td>
					<td>이벤트 종료일</td>
					<td><input type="date" id="evntEndDt" value="" /></td><td>${data.evntEndDt}</td>
				</tr>

				<tr>
					<td>이벤트 사진</td>
					<td colspan="3"><input type="file" id="evntPht"
						style="width: 99%;" value="" /></td><td>${data.evntPht}</td>
				</tr>

				<tr>
					<td>사용 여부</td>
					<td><input type="checkbox" id="useYn"
						value="" checked/></td><td>${data.useYn}</td>
					<td>삭제 여부</td>
					<td><input type="checkbox" id="delYn" value="" /></td><td>${data.delYn}</td>
				</tr>

				<tr>
					<td></td>
					<td></td>
					<td><button id="btn-create" class="btn-primary" style="width:100%;">등록</button></td>
					<td><button id="btn-cencle" class="btn-primary" style="width:100%;">취소</button></td>
				</tr>
			</table>
			<a href="/evnt/update?no=${data.no}"role="button" class="btn-primary">수정</a>
		</div>
	</div>
</body>
</html>