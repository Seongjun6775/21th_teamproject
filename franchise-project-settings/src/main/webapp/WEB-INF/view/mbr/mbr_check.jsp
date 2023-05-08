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
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '비밀번호를 확인해 주세요.',
			    	  showConfirmButton: false,
			    	  timer: 2500
		    	});
				/* alert("비밀번호를 확인해 주세요."); */
				return;
			}
			$.post("${context}/api/mbr/pwd/check", $("#pwdCheck_form").serialize(), function(resp){
				if(resp.status == "200 OK"){
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
		$("#mbrPwd").keydown(function (key) {
	        if (key.keyCode == 13) {
	        	$("#pwd-check-btn").click();
	        }
	    });
	});
</script>
</head>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<span class="fs-5 fw-bold">회원 > 회원정보 > 본인확인</span>
	    </div>
    	<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px; margin: auto;width:270px; height:220px;  display: flex; justify-content: center; align-items: center;">
    		<div class="checkGroup">
				<h5>회원정보 확인</h5>
				<form id="pwdCheck_form" class="needs-validation" style="margin-bottom: 10px;">
					<div class="input-group mt-16">
						<span class="input-group-text"><i class='bx bx-lock'></i></span>
						<input type="password" id="mbrPwd" name="mbrPwd" class="form-control" placeholder="비밀번호 입력" autocomplete="off" maxlength="8" data-field-name="비밀번호">
						<!-- <input type="password" id="mbrPwd" name="mbrPwd" placeholder="비밀번호 입력" maxlength="8" data-field-name="비밀번호" autocomplete="off" > -->
					</div>
				</form>
				<div class="btn-div">
					<button class="btn btn-outline-primary btn-default" id="pwd-check-btn">확인</button>
				</div>
			</div>
    	</div>
	
<jsp:include page="../include/closeBody.jsp" />
</html>
