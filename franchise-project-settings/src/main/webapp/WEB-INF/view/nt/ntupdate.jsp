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
		
		$("#crt_btn").click(function() {
			if($("#ntCntnt").val().length > 4000) {
				alert("최대 4천자까지 입력할 수 있습니다!");
				return;
			}
			
			if (!confirm("쪽지를 수정하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/nt/update/${nt.ntId}", $("#nt_form").serialize(), function(response){
				
				if (response.status == "200 OK") {
					location.href="${context}/nt/ntmstrlist";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#cancel_btn").click(function() {
			
			if (!confirm("쪽지 수정을 취소하시겠습니까?")) {
				return;
			}
			location.href="${context}/nt/ntmstrdetail/${nt.ntId}";
		});
		
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
				<span class="fs-5 fw-bold">쪽지 > 쪽지 수정</span>
			</div>	
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<form id="nt_form">
					<div class="input-group" style="display: flex; flex-direction: row-reverse;">
						<div>
							<input type="text" id="sndrId" name="sndrId" value="${nt.sndrId}" disabled class="form-control" />
						</div>
						<label for="sndrId" class="col-form-label" style="padding-right: 8px; border-right: solid #ffbe2e; ">발신인</label>
					</div>
					<div class="input-group" style="display: flex; flex-direction: row-reverse;">
						<div>
							<input type="text" id="rcvrId" name="rcvrId" value="${nt.rcvrId}" disabled class="form-control" />
						</div>
						<label for="rcvrId" class="col-form-label" style=" padding-right: 8px; border-right: solid #ffbe2e;">수신인</label>
					</div>
					<div>
						<label for="ntTtl" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">쪽지 제목</label>
						<input type="text" id="ntTtl" name="ntTtl" class="form-control" value="${nt.ntTtl}" />
					</div>
					<div>
						<label for="ntCntnt">쪽지 본문</label>
						<textarea id="ntCntnt" name="ntCntnt" maxlength="4000" placeholder="4000자 까지 입력 가능합니다."
								  class="form-control"  style="word-break: bredk-all; resize:none;">${nt.ntCntnt}</textarea>
					</div>
				</form>	
				<div style="float: right; margin:10px">
					<button id="crt_btn" class="btn btn-secondary">작성</button>
					<button id="cancel_btn" class="btn btn-danger">취소</button>
				</div>
			</div>
		
<jsp:include page="../include/closeBody.jsp" />
</html>
