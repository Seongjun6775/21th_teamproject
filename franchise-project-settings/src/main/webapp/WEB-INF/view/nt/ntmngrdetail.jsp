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
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="${context}/css/ntcommon.css?p=${date}" />
<script type="text/javascript">

	$().ready(function() {
		
		var ntId = ("${nt.ntId}");
		
		$("#del_btn").click(function() {
			var delYn = ("${nt.delYn}");
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/nt/delete/" + ntId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/nt/ntmngrlist";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#list_btn").click(function() {
			location.href = "${context}/nt/ntmngrlist";
		});
		
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
			<h2>중간관리자 쪽지 상세보기 페이지</h2>
			<div>
				<div class="detail_header">제목 : ${nt.ntTtl}</div>
			</div>
			<div>
				<div class="detail_header">쪽지 번호 : ${nt.ntId}</div>
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
				<div class="nt_cntnt" style="word-break: break-all;">${nt.ntCntnt}</div>
			</div>
			
			<button id="del_btn">삭제</button>
			<button id="list_btn">목록</button>
<jsp:include page="../include/closeBody.jsp" />
</html>
