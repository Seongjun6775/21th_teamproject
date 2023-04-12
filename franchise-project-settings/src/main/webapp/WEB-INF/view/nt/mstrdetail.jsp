<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">

	$().ready(function() {
		
		$("#del_btn").click(function() {
			var ntId = ("${nt.ntId}");
			var delYn = ("${nt.delYn}");
			if (delYn == "Y") {
				alert("이미 삭제 처리된 쪽지입니다!");
				return;
			}
			else if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/nt/delete/" + ntId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/nt/mstrlist";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#list_btn").click(function() {
			location.href = "${context}/nt/mstrlist";
		});
		
		
		
	});

</script>
</head>
<body>
	<h2>쪽지 상세보기 페이지</h2>
	<div>
		<div class="detail_header">제목 : ${nt.ntTtl}</div>
	</div>
	<div>
		<div class="detail_header">발신자 : ${nt.sndrId}</div>
		<div class="detail_header">수신자 : ${nt.rcvrId}</div>
	</div>
	<div>
		<div class="detail_header">확인 일자 : ${nt.ntRdDt}</div>
		<div class="detail_header">삭제여부 : ${nt.delYn eq 'Y' ? '삭제됨' : '	'}</div>
		<div class="detail_header">쪽지 번호 : ${nt.ntId}</div>
	</div>
	
	<div>
		<div>쪽지 본문 :</div>
		<div>${nt.ntCntnt}</div>
	</div>
	
	<button id="upd_btn">수정</button>
	<button id="del_btn">삭제</button>
	<button id="list_btn">목록</button>
	
	
</body>
</html>