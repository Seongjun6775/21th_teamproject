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
<script type="text/javascript">
	$().ready(function(){
		var valueUtil = new ValueUtil();
		$("#mbrPwd").keyup(function(){
			var mbrPwd = $(this).val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#mbrPwd").val(mbrPwd);
			console.log(mbrPwd)
		});
		$("#pwd-check-btn").click(function(event){
			event.preventDefault();
			var mbrPwd = $("#mbrPwd").val();
			console.log(mbrPwd);
			if(!valueUtil.requires("#mbrPwd")){
				return;
			}
			//비밀번호 자리수가 8자 미만일때
			if(mbrPwd.length < 8){
				alert("비밀번호를 확인해 주세요.");
				return;
			}
			$.post("${context}/pwd/check", $("#pwdCheck_form").serialize(), function(resp){
				if(resp.status == "200 OK"){
					location.href="${context}"+resp.redirectURL;
				}
				else{
					alert(resp.message);
				}
			});
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
				<div class="checkGroup">
					<form id="pwdCheck_form" class="pwdCheck_form">
						<div class="checkBox">
							<label for="mbrPwd">회원정보 확인</label>
							<input type="password" id="mbrPwd" name="mbrPwd" placeholder="비밀번호 입력" maxlength="8" data-field-name="비밀번호" autocomplete="off" >
							<button class="check-btn" id="pwd-check-btn">확인</button>
						</div>
					</form>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
