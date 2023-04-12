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
		var idMinLength = 5;
		var pwMinLength = 8;
		
		$("#mbrId").keyup(function(){
			var mbrIdVal = $(this).val();
			mbrIdVal = mbrIdVal.replace(/\s/gi, "");
			$("#mbrId").val(mbrIdVal);
			if(mbrIdVal.length == 0){
				$("#ableId").hide();
				$("#idLen").hide();
				$("#dupId").hide();
				return;
			}
				
			$.get("${context}/api/mbr/check/"+mbrIdVal,function(resp){
				if(resp.status == "200 OK"){
					if(mbrIdVal.length >= 1 && mbrIdVal.length < idMinLength){
						$("#ableId").hide();
						$("#idLen").show();
						$("#dupId").hide();
					}else if(mbrIdVal.length >= idMinLength){
						$("#ableId").show();
						$("#idLen").hide();
						$("#dupId").hide();
					}
				}else{
					$("#ableId").hide();
					$("#idLen").hide();
					$("#dupId").show();	
				}
			});
		});
		var pwd;
		$("#mbrPwd").keyup(function(){
			var mbrPwd = $(this).val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#mbrPwd").val(mbrPwd);
			pwd=mbrPwd;
			//비밀번호 자리수가 0일때
			if(mbrPwd.length==0){
				$("#shortPwd").hide();
			}
			//비밀번호 자리수가 8자 미만일때
			else if (mbrPwd.length < 8){
				$("#shortPwd").show();	
			}
			//비밀번호 자리수가 8자 이상일때
			else{
				$("#shortPwd").hide();
			}
		});
		$("#mbrPwdChck").keyup(function(){
			var mbrPwdChck = $(this).val();
			mbrPwdChck = mbrPwdChck.replace(/\s/gi, "");
			$("#mbrPwdChck").val(mbrPwdChck);
			//비밀번호 값이 8자 미만일 때 - alert();
			if(pwd == null||pwd.length < pwMinLength){
				alert("비밀번호 8자리를 먼저 입력하세요");
				$("#checkPwd").hide();
				$("#matchPwd").hide();
				$("#notMatchPwd").hide();
				$("#mbrPwdChck").val("");
				return;
			}
			//체크 값이 0일때 - 모두 hide
			if(mbrPwdChck.length == 0){
				$("#checkPwd").hide();
				$("#matchPwd").hide();
				$("#notMatchPwd").hide();
			}
			//비번입력 없이 체크 입력할 때 - checkPwd만 노출
			else if(pwd.length == 0){
				$("#checkPwd").show();
				$("#matchPwd").hide();
				$("#notMatchPwd").hide();
			}
			//비번과 체크가 다를때 - notMatchPwd만 노출
			else if(pwd.length != mbrPwdChck.length){
				$("#checkPwd").hide();
				$("#matchPwd").hide();
				$("#notMatchPwd").show();
			}
			//비번과 체크길이 가 같을 때
			else if(pwd.length == mbrPwdChck.length){
				//두 값이 같으면 - match만 노출
				if(pwd == mbrPwdChck){
					$("#checkPwd").hide();
					$("#matchPwd").show();
					$("#notMatchPwd").hide();
				}
				//두 값이 다르면 - notMatch만 노출
				else{
					$("#checkPwd").hide();
					$("#matchPwd").hide();
					$("#notMatchPwd").show();
				}
			}
		});
		$("#mbrNm").keyup(function(){
			var mbrNm = $(this).val();
			mbrNm = mbrNm.replace(/\s/gi, "");
			$("#mbrNm").val(mbrNm);
		});
		$("#mbrEml").keyup(function(){
			var mbrEml = $(this).val();
			mbrEml = mbrEml.replace(/\s/gi, "");
			$("#mbrEml").val(mbrEml);
		});
		
		$("#mbr_regist_btn").click(function(event){
			$("#mbr_regist_btn").attr("disabled", true);
			event.preventDefault();
			if(!valueUtil.requires("#mbrId")){
				return;
			}
			var dupStatus = $("#dupId").css("display");
			if(dupStatus == "inline"){
				alert("이미 사용중인 아이디 입니다.");
				return;
			}
			var idLen = $("#idLen").css("display");
			if(idLen == "inline"){
				alert("아이디는 5자 이상입니다.");
				return;
			}
			var shortPwd = $("#shortPwd").css("display");
			if(shortPwd == "inline"){
				alert("비밀번호는 8자 이상입니다.");
				return;
			}
			if(!valueUtil.requires("#mbrPwd")){
				return;
			}
			var matchPwd= $("#matchPwd").css("display");
			if(matchPwd != "inline"){
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
			if(!valueUtil.requires("#mbrEml")){
				return;
			}
			$.post("${context}/api/mbr/regist", $("#regist_form").serialize(), function(resp){
				if(resp.status == "200 OK"){
					alert("회원가입 성공!");
					location.href="${context}"+resp.redirectURL;
				}else if(resp.errorCode=="403" || resp.errorCode=="500"){
					alert(resp.message);
				}
			});
		});
	});
</script>
</head>
<body>

	<form id="regist_form">
		<label for="mbrId" >ID</label>
		<input type="text" id="mbrId" name="mbrId" maxlength="12" placeholder="ID" data-field-name="아이디"/>
		<span id="dupId" style="display: none;">이미 사용중인 아이디입니다.</span>
		<span id="ableId" style="display: none;">사용가능한 아이디입니다.</span>
		<span id="idLen" style="display: none;">아이디는 5자 이상입니다.</span>
		
		<label for="mbrPwd" >PWD</label>
		<input type="password" id="mbrPwd" name="mbrPwd" maxlength="12" placeholder="비밀번호" autocomplete="off" data-field-name="비밀번호"/>
		<span id="shortPwd" style="display: none;">비밀번호는 8자 이상입니다.</span>
		
		<label for="mbrPwdChck" >PWD</label>
		<input type="password" id="mbrPwdChck" name="mbrPwdChck" maxlength="12" placeholder="비밀번호확인" autocomplete="off"/>
		<span id="matchPwd" style="display: none;">비밀번호가 일치합니다.</span>
		<span id="notMatchPwd" style="display: none;">비밀번호가 다릅니다.</span>
		<span id="checkPwd" style="display: none;">비밀번호를 입력해주세요.</span>
		
		
		<label for="mbrNm" >Name</label>
		<input type="text" id="mbrNm" name="mbrNm" maxlength="10" placeholder="이름" data-field-name="이름"/>
		
		<label for="mbrEml" >E-MAIL</label>
		<input type="email" id="mbrEml" name="mbrEml" maxlength="100" placeholder="E-MAIL" data-field-name="이메일"/>
	</form>
		<button id="mbr_regist_btn">가입</button>

</body>
</html>