<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 목록 조회</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	
	$().ready(function() {
		//이벤트 리스트 조회(검색)
		$("#btn-init").click(function() {
			document.getElementById("evntId").value = "";
			document.getElementById("evntTtl").value = "";
			document.getElementById("evntCntnt").value = "";
			document.getElementById("evntStrtDt").value = "";
			document.getElementById("evntEndDt").value = "";
			document.getElementById("useYn").value = "ALL";
		});

		//이벤트 등록(생성)          
		$("#btn-create").click(function() {
			location.href = "${context}/evnt/create"
		});

	});
</script>
</head>
<body>
	<div class="main-layout">
		<div>
			<h1>이벤트 리스트 목록 조회</h1>
			<div>총 ${evntList.size()}건</div>
		</div>
		<div class="content">
			<div class="search-group">
				<div>
					<form action="/evnt/list" method="post">
						<table style="width: 100%;">
							<tr>
								<td>이벤트 ID</td>
								<td><input id="evntId" type="text" name="evntId" value="${evntId}"
									style="width: 90%;" /></td>
								<td>이벤트 제목</td>
								<td><input id="evntTtl" type="text" name="evntTtl" value="${evntTtl}"
									style="width: 90%;" /></td>
								<td>이벤트 내용</td>
								<td><input id="evntCntnt" type="text" name="evntCntnt"
									value="${evntCntnt}" style="width: 90%;" /></td>

							</tr>
							<tr>
								<td>이벤트 시작일자</td>
								<td><input id="evntStrtDt" type="date" name="evntStrtDt"
									value="${evntStrtDt}" style="width: 90%;" /></td>
								<td>이벤트 종료일자</td>
								<td><input id="evntEndDt" type="date" name="evntEndDt"
									value="${evntEndDt}" style="width: 90%;" /></td>
								<td>이벤트 사용유무</td>
								<td><select id="useYn" name="useYn" style="width: 90%;">
										<option value="ALL">전체</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
								</select></td>
								<td colspan="2"><button type="submit" class="btn-search"
										id="search-btn">검색</button></td>
							</tr>
						</table>
					</form>
				</div>
				<button id="btn-init" class="btn-primary">초기화</button>

				<button id="btn-create" class="btn-primary">등록</button>

				<!--             </form> -->
			</div>
			<div class="grid">
				<table>
					<thead>
						<tr>
							<th style="width: 100px">이벤트 ID</th>
							<th style="width: 200px">이벤트 제목</th>
							<th style="width: 200px">이벤트 내용</th>
							<th style="width: 200px">시작일</th>
							<th style="width: 200px">종료일</th>
							<th style="width: 100px">사진</th>
							<th style="width: 80px">사용유무</th>
							<th style="width: 80px">삭제여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty evntList}">
								<c:forEach items="${evntList}" var="evnt">
									<tr>
										<td>${evnt.evntId}</td>
										<td><a href="${context}/evnt/detail/${evnt.evntId}">${evnt.evntTtl}</a></td>
										<td>${evnt.evntCntnt}</td>
										<td>${evnt.evntStrtDt}</td>
										<td>${evnt.evntEndDt}</td>
										<td>${evnt.evntPht}</td>
										<td>${evnt.useYn}</td>
										<td>${evnt.delYn}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="8">등록된 이벤트가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div>추후 페이지로 개발 필요</div>


		</div>
	</div>
</body>
</html>