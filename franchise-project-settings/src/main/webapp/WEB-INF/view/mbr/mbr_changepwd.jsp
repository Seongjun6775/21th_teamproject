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
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '비밀번호를 확인해 주세요.',
			    	  showConfirmButton: false,
			    	  timer: 2500
		    	});
				/* alert("비밀번호를 확인해 주세요."); */
				return;
			}
			if(newMbrPwd != newMbrPwdChck){
				Swal.fire({
			    	  icon: 'warning',
			    	  title:'새 비밀번호 두 값이 다릅니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
		    	});
				/* alert("새 비밀번호의 두 값이 다릅니다."); */
				return;
			}
			$.post("${context}/api/mbr/pwd/update", {mbrPwd: mbrPwd, newMbrPwd: newMbrPwd}, function(resp){
				if(resp.status == "200 OK"){
					Swal.fire({
				    	  icon: 'success',
				    	  title:'비밀번호가 변경되었습니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
			    	});
					/* alert("비밀번호가 변경되었습니다."); */
					location.href="${context}"+resp.redirectURL;
				}
				else{
					Swal.fire({
				    	  icon: 'error',
				    	  title: resp.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
			    	});
					/* alert(resp.message); */
				}
			});
		});
	});
</script>
</head>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">회원 > 회원정보 > 비밀번호 변경</span>
    </div>
    <div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px; margin: auto;width:400px; height:370px;  display: flex; justify-content: center; align-items: center;">
	    <div class="checkGroup">
	    	<h5>비밀번호 변경</h5>
			<form id="pwdChange_form" class="needs-validation margin-Bot-10">
				<div class="input-group mt-16">
					<span class="input-group-text">기존 비밀번호</span>
					<input type="password" id="mbrPwd" name="mbrPwd" class="form-control" placeholder="기존 비밀번호" maxlength="8" data-field-name="기존비밀번호" autocomplete="off">
				</div>
				<div class="input-group mt-16">
					<span class="input-group-text">&nbsp;&nbsp;새 비밀번호&nbsp;</span>
					<input type="password" id="newMbrPwd" name="newMbrPwd" class="form-control" placeholder="새 비밀번호" maxlength="8" data-field-name="새 비밀번호" autocomplete="off">
				</div>
				<div class="input-group mt-16">
					<span class="input-group-text">새 비밀번호 확인</span>
					<input type="password" id="newMbrPwdChck" name="newMbrPwdChck" class="form-control" placeholder="새 비밀번호 확인" maxlength="8" data-field-name="새 비밀번호확인" autocomplete="off">
				</div>
			</form>
			<div class="btn-div">
				<button class="btn btn-outline-primary btn-default" id="pwd-check-btn">변경</button>
			</div>
		</div>
	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>