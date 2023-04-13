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
			
			// ntCntnt가 VARCHAR2(4000 CHAR) 라서, 글자수를 제한했습니다.
			if($("#ntCntnt").val().length > 4000) {
				alert("최대 4천자까지 입력할 수 있습니다!");
				return;
			}
			
			// 자기 자신에게 쪽지를 보낼 수 없도록 제한했습니다.
			// 굳이 막을 이유는 없지 않나 싶어서 고민했는데, 일단 막아 두고 나중에 필요 없다 싶으면 지우겠습니다.
			if ($("#rcvrId").val() == $("#sndrId").val()) {
				alert("자기 자신에게 쪽지를 보낼 수 없습니다!")
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
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<h2>쪽지 작성 페이지</h2>
				<form id="nt_form">
					<div>
						<!-- 로그인 기능 완성되면 readonly로 바꾸고 송신인 ID 받아와서 setting할 것 -->
						<label for="sndrId">발신인</label>
						<input type="text" id="sndrId" name="sndrId" value="${mbrVO.mbrId}" readonly/>
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
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
