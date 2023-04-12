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

	</script>
</head>
<body>
	<div class="main-layout">
		<form method="post" action="list.evnt" id="list">
			<input type="hidden" name="curPage" value="1" />

			<div id="list-top">
				<div>
					<ul>
						<li><select name="search" class="w-px80">
								<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
								<option value="evntTtl"
									${page.search eq 'evntTtl' ? 'selected' : '' }>제목</option>
								<option value="evntCntnt"
									${page.search eq 'evntCntnt' ? 'selected' : '' }>내용</option>
								<option value="evntStrtDt"
									${page.search eq 'evntStrtDt' ? 'selected' : '' }>시작일</option>
								<option value="evntEndDt"
									${page.search eq 'evntEndDt' ? 'selected' : '' }>종료일</option>
								<option value="useYn"
									${page.search eq 'useYn' ? 'selected' : '' }>사용유무</option>
								<option value="delYn"
									${page.search eq 'delYn' ? 'selected' : '' }>삭제여부</option>
						</select></li>
						<li><input value="${page.keyword }" type="text"
							name="keyword" class="w-px300" /></li>
						<li><a class="btn-fill" onclick="$('form').submit()">검색</a></li>
					</ul>
					<ul>
						<c:if test="${login_info.admin eq 'Y' }">
							<li><a class="btn-fill" href="">글쓰기</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</form>

		<table>
			<tr>
				<th class="w-px60">글번호</th>
				<th></th>
				<th class="w-px100">이벤트 ID</th>
				<th class="w-px120">이벤트 제목</th>
				<th class="w-px60">이벤트 내용</th>
				<th class="w-px60">이벤트 시작일</th>
				<th class="w-px60">이벤트 종료일</th>
				<th class="w-px60">사용유무</th>
				<th class="w-px60">삭제여부</th>
			</tr>
		
		</table>
		<div class="btnSet">
			<jsp:include page="/WEB-INF/view/evnt/list2.jsp" />
		</div>
	</div>
</body>
</html>