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


//이벤트 리스트 조회
$().ready(function() {
	
	$("#search-btn").click(function(){
// 		alert("a : " + $("#evntId").val());
		$.post(
				// 호출할 주소
				"${context}/evnt/list",
				
				// 파라미터
				{evntId: $("#evntId").val(),
				evntTtl: $("#evntTtl").val(),
				evntCntnt: $("#evntCntnt").val(),
				evntStrtDt: $("#evntStrtDt").val(),
				useYn: $("#useYn").val(),
				delYn: $("#delYn").val()},
				
				// 결과 처리
				function(data, status){
				    if (status == "success"){
				    	location.reload(); // 새로고침
				    } else {
					    console.log("Data: " + data + "\nStatus: " + status);
				     }
				  });                 
               });

	

	//이벤트 수정 팝업창		
		$("#update-btn").click(function(){

		var pop = window.open("${context}/evnt/update_popup", "resPopup", "width=1100, height=900, scrollbars=yes, resizable=yes"); 
			       pop.focus();	
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
			<!-- <form> -->
				검색조건<br/>
				-----------------------------------------------<br/>
				<label for="">이벤트 ID</label>
				<input type="text" id="evntId" value="${evntId}" />
				&nbsp;
				<label for="">이벤트 제목</label>
				<input type="text" id="evntTtl" value="${evntTtl}" />
				&nbsp;
				<label for="">이벤트 내용</label>
				<input type="text" id="evntCntnt" value="${evntCntnt}" />
				&nbsp;
				<label for="">이벤트 시작일</label>
				<input type="date" id="evntStrtDt" value="${evntStrtDt}" />
				&nbsp;
				<label for="">이벤트 종료일</label>
				<input type="date" id="evntEndDt" value="${evntEndDt}" />
				&nbsp;
				<label for="">이벤트 사용유무</label>
				<input type="checkbox" id="useYn" value="${useYn}" />
				&nbsp;
				<label for="">이벤트 삭제여부</label>
				<input type="checkbox" id="delYn" value="${delYn}" />
				&nbsp;
				
<!-- 				<button class="btn-search" id="search-btn">검색</button> -->
				<button id="search-btn" class="btn-primary">조회</button>
				
				<button id="update-btn" class="btn-primary">수정</button>
				
				<button id="update-btn" class="btn-primary">삭제</button>
				
<!-- 				</form> -->
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
										<td>${evnt.evntTtl}</td>
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
			<div>
				<a href="${pageContext.request.contextPath}/evnt/write">이벤트 등록</a>
				<a href="${pageContext.request.contextPath}/evnt/update">이벤트 수정</a>
				<a href="${pageContext.request.contextPath}/evnt/updateDelete">이벤트 삭제</a>
			</div>
			
			
		</div>
	</div>
</body>
</html>