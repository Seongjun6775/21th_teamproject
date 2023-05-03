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
					location.href = "${context}/nt/ntlist";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#list_btn").click(function() {
			location.href = "${context}/nt/ntlist";
		});
		
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
	        <span class="fs-5 fw-bold">쪽지 > 쪽지 관리 > 쪽지 상세조회</span>
	        <div style="position: absolute;right: 0;top: 0; margin: 20px;">
	           <button id="del_btn" class="btn btn-danger" style="margin-right:10px">삭제</button>
			  <button id="list_btn" class="btn btn-secondary" >목록</button>
	        </div>
      	</div>
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
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
			</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
