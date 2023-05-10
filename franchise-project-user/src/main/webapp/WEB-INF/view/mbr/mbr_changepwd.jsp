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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript">
	$().ready(function(){
		var valueUtil = new ValueUtil();
		$("#chng_mbrPwd").keyup(function(){
			var mbrPwd = $(this).val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#chng_mbrPwd").val(mbrPwd);
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
			var mbrPwd = $("#chng_mbrPwd").val();
			var newMbrPwd = $("#newMbrPwd").val();
			var newMbrPwdChck = $("#newMbrPwdChck").val();
			if(!valueUtil.requires("#chng_mbrPwd")){
				return;
			}
			if(!valueUtil.requires("#chng_mbrPwd")){
				return;
			}
			//비밀번호 자리수가 8자 미만일때
			if(mbrPwd.length < 8 || newMbrPwd.length < 8 || newMbrPwdChck.length < 8){
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '비밀번호를 하세요.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				return;
			}
			if(newMbrPwd != newMbrPwdChck){
				Swal.fire({
			    	  icon: 'error',
			    	  title: '다른값',
			    	  text: '새 비밀번호의 두 값이 다릅니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				return;
			}
			$.post("${context}/mbr/pwd/update", {mbrPwd: mbrPwd, newMbrPwd: newMbrPwd}, function(resp){
				if(resp.status == "200 OK"){
					Swal.fire({
				    	  icon: 'success',
				    	  title: '비밀번호가 변경되었습니다.',
				    	  showConfirmButton: true,
				    	  confirmButtonColor: '#3085d6'
					}).then((result)=>{
						if(result.isConfirmed){
							location.href="${context}"+resp.redirectURL;
						}
					});

				}
				else{
					Swal.fire({
				    	  icon: 'error',
				    	  title: '비밀번호가 다릅니다.',
				    	  text: resp.status,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
				}
			});
		});
	});
</script>
</head>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />
		<div class="visualArea flex relative">
			<div class="content-setting title">회원</div>
			<div class="overlay absolute"></div>
		</div>
		<div id="menu" class="flex-column">	
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">회원 > 회원정보 > 비밀번호 변경</span>
		    </div>
	    	<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px; margin: auto;width:396px; height:220px;  display: flex; justify-content: center; align-items: center;">
	    		<div class="checkGroup">
					<form id="pwdChange_form" class="">
						
							<div class="input-group">
								<span class="input-group-text">기존 비밀번호</span>
								<input type="password" class="form-control"  id="chng_mbrPwd" name="mbrPwd" placeholder="기존 비밀번호" maxlength="16" data-field-name="기존비밀번호" autocomplete="off" >
							</div>
							<div class="input-group">
								<span class="input-group-text">새 비밀번호</span>
								<input type="password" class="form-control"  id="newMbrPwd" name="newMbrPwd" placeholder="새 비밀번호 입력" maxlength="16" data-field-name="새 비밀번호" autocomplete="off" >
							</div>
							<div class="input-group">
								<span class="input-group-text">새 비밀번호 확인</span>
								<input type="password" class="form-control"  id="newMbrPwdChck" name="newMbrPwdChck" placeholder="새 비밀번호 확인" maxlength="16" data-field-name="새 비밀번호확인" autocomplete="off" >
							</div>

					</form>
							<button class="btn btn-outline-primary"  id="pwd-check-btn">변경</button>
				</div>
	    	</div>
    	</div>

<jsp:include page="../include/closeBody.jsp" />
</html>