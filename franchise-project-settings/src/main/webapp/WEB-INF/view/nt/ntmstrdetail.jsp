<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/ntcommon.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">

	$().ready(function() {
		
		var ntId = ("${nt.ntId}");
		
		$("#del_btn").click(function() {
			var delYn = ("${nt.delYn}");
			if (delYn == "Y") {
				alert("이미 삭제 처리된 쪽지입니다!");
				return;
			}
			
			var rdYn = ("${nt.ntRdDt}");
			if (rdYn != null) {
				alert("이미 확인된 쪽지는 지울 수 없습니다!")
				return;
			}
			
			else if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/nt/delete/" + ntId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/nt/ntmstrlist";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#list_btn").click(function() {
			location.href = "${context}/nt/ntmstrlist";
		});
		
		
		$("#upd_btn").click(function() {
			var delYn = ("${nt.delYn}");
			var ntRdDt = ("${nt.ntRdDt}");
			
			if (delYn == "Y") {
				alert("이미 삭제된 쪽지는 수정할 수 없습니다!");
				return;
			}
			
			else if ( ("${nt.sndrId}") != ("${mbrVO.mbrId}")) {
				alert("내가 보내지 않은 쪽지는 수정할 수 없습니다!")
				return;
			}
			else {
				if (ntRdDt == "") {
					location.href = "${context}/nt/ntupdate/" + ntId;
				}
				else {
					alert("이미 수신한 쪽지는 수정할 수 없습니다!");
					return;
				}
			}
		});
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<h2>쪽지 상세보기 페이지</h2>
			<div>
				<div class="detail_header">제목 : ${nt.ntTtl}</div>
			</div>
			<div>
				<div class="detail_header">발신자 : ${nt.sndrId}</div>
				<div class="detail_header">수신자 : ${nt.rcvrId}</div>
			</div>
			<div>
				<div class="detail_header">쪽지 발송 일자 : ${nt.ntSndrDt}</div>
				<div class="detail_header">쪽지 확인 일자 : ${nt.ntRdDt}</div>
			</div>
			<div>
				<div class="detail_header">삭제여부 : ${nt.delYn eq 'Y' ? '삭제됨' : '	'}</div>
				<div class="detail_header">쪽지 번호 : ${nt.ntId}</div>
			</div>
			
			<div>
				<div class="nt_cntnt">${nt.ntCntnt}</div>
			</div>
			
			<button id="upd_btn">수정</button>
			<button id="del_btn">삭제</button>
			<button id="list_btn">목록</button>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
