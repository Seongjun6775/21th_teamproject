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
		
		$("#crt_btn").click(function() {
			if($("#ntCntnt").val().length > 4000) {
				alert("최대 4천자까지 입력할 수 있습니다!");
				return;
			}
			
			if (!confirm("쪽지를 전송하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/nt/create", $("#nt_form").serialize(), function(response){
				
				if (response.status == "200 OK") {
					location.href="${context}/nt/mstrlist";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#cancel_btn").click(function() {
			
			if (!confirm("쪽지 작성을 취소하시겠습니까?")) {
				return;
			}
			location.href="${context}/nt/mstrlist";
		});
		
		
	});

</script>
</head>
<body>
	<h2>쪽지 작성 페이지</h2>
	<form id="nt_form">
		<div>
			<!-- 로그인 기능 완성되면 readonly로 바꾸고 송신인 ID 받아와서 setting할 것 -->
			<label for="sndrId">발신인</label>
			<input type="text" id="sndrId" name="sndrId" />
		</div>
		<div>
			<label for="rcvrId">수신인</label>
			<input type="text" id="rcvrId" name="rcvrId" />
		</div>
		<div>
			<label for="ntTtl">쪽지 제목</label>
			<input type="text" id="ntTtl" name="ntTtl" />
		</div>
		<div>
			<label for="ntCntnt">쪽지 본문</label>
			<textarea id="ntCntnt" name="ntCntnt" placeholder="4000자 까지 입력 가능합니다."></textarea>
		</div>
	</form>
	
	<button id="crt_btn">작성</button>
	<button id="cancel_btn">취소</button>
	
	
</body>
</html>