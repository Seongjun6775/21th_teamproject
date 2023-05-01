<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	$().ready(function(){
		var valueUtil = new ValueUtil();
		$("#mbrPwd").keyup(function(){
			var mbrPwd = $(this).val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#mbrPwd").val(mbrPwd);
		});
		$("#newMbrPwd").keyup(function(){
			var mbrPwd = $(this).val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#newMbrPwd").val(mbrPwd);
		});
		$("#newMbrPwdChck").keyup(function(){
			var mbrPwd = $(this).val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#newMbrPwdChck").val(mbrPwd);
		});
		$("#pwd-check-btn").click(function(event){
			event.preventDefault();
			var mbrPwd = $("#mbrPwd").val();
			var newMbrPwd = $("#newMbrPwd").val();
			var newMbrPwdChck = $("#newMbrPwdChck").val();
			console.log(mbrPwd);
			if(!valueUtil.requires("#mbrPwd")){
				return;
			}
			if(!valueUtil.requires("#mbrPwd")){
				return;
			}
			//비밀번호 자리수가 8자 미만일때
			if(mbrPwd.length < 8 || newMbrPwd.length < 8 || newMbrPwdChck.length < 8){
				alert("비밀번호를 확인해 주세요.");
				return;
			}
			if(newMbrPwd != newMbrPwdChck){
				alert("새 비밀번호의 두 값이 다릅니다.");
				return;
			}
			$.post("${context}/mbr/pwd/update", {mbrPwd: mbrPwd, newMbrPwd: newMbrPwd}, function(resp){
				if(resp.status == "200 OK"){
					alert("비밀번호가 변경되었습니다.");
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
					<form id="pwdChange_form" class="pwdChange_form">
						<div class="checkBox">
							<label for="mbrPwd">기존 비밀번호</label>
							<input type="password" id="mbrPwd" name="mbrPwd" placeholder="기존 비밀번호" maxlength="8" data-field-name="기존비밀번호" autocomplete="off" >
							<label for="newMbrPwd">새 비밀번호</label>
							<input type="password" id="newMbrPwd" name="newMbrPwd" placeholder="새 비밀번호 입력" maxlength="8" data-field-name="새 비밀번호" autocomplete="off" >
							<label for="newMbrPwdChck">새 비밀번호 확인</label>
							<input type="password" id="newMbrPwdChck" name="newMbrPwdChck" placeholder="새 비밀번호 확인" maxlength="8" data-field-name="새 비밀번호확인" autocomplete="off" >
							<button class="check-btn" id="pwd-check-btn">확인</button>
						</div>
					</form>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>