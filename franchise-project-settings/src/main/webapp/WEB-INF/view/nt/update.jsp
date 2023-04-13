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
					location.href="${context}/nt/mstrlist";
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
			location.href="${context}/nt/mstrdetail/${nt.ntId}";
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
			<h2>쪽지 수정 페이지</h2>
			<form id="nt_form">
				<div>
					<!-- 로그인 기능 완성되면 readonly로 바꾸고 송신인 ID 받아와서 setting할 것 -->
					<label for="sndrId">발신인</label>
					<input type="text" id="sndrId" name="sndrId" value="${nt.sndrId}" disabled />
				</div>
				<div>
					<label for="rcvrId">수신인</label>
					<input type="text" id="rcvrId" name="rcvrId" value="${nt.rcvrId}" disabled />
				</div>
				<div>
					<label for="ntTtl">쪽지 제목</label>
					<input type="text" id="ntTtl" name="ntTtl" value="${nt.ntTtl}" />
				</div>
				<div>
					<label for="ntCntnt">쪽지 본문</label>
					<textarea id="ntCntnt" name="ntCntnt">${nt.ntCntnt}</textarea>
				</div>
			</form>
			
			<button id="crt_btn">수정</button>
			<button id="cancel_btn">취소</button>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
