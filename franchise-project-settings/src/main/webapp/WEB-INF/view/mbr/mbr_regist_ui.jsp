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
	// 특수문자 모두 제거    
	function chkId(obj){
	    var RegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;   //정규식 구문
	    if (RegExp.test(obj.value)) {
	      obj.value="";
	      alert("아이디에 특수문자를 입력할 수 없습니다. 다시 입력해주세요");
	    }
	  }
	var emailRegExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
 	$().ready(function(){
		var valueUtil = new ValueUtil();
		var idMinLength = 5;
		var pwMinLength = 8;
		var authCode="";
		
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
			if($("#doneAuth").val() == "false" ? true : false){
				alert("이메일 인증을 진행해 주세요.")
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
		var display=$("#timer");
		var leftSec=30;
		var timer = null;
		var isRunning = false;
		function startTimer(count, display) {  
		  var minutes, seconds;
		  timer = setInterval(function () {
		    minutes = parseInt(count / 60, 10);
		    seconds = parseInt(count % 60, 10);

		    minutes = minutes < 10 ? "0" + minutes : minutes;
		    seconds = seconds < 10 ? "0" + seconds : seconds;

		    display.text(minutes + ":" + seconds);

		    // 타이머 끝
		    if (--count < 0) {
		      clearInterval(timer);
		      alert("시간초과");
		      display.text("시간초과");
		      $("#auth-btn").attr("disabled", true);
		      isRunning = false;
		    }
		  }, 1000);
		  isRunning = true;
		}
		$("#send-auth-btn").click(function(event){
			event.preventDefault();
			var email = $("#mbrEml").val();
			if( email == "" || !emailRegExp.test(email)){
				alert("이메일을 확인하세요.");
				return;
			}
			$("#timer").show();
			if(!valueUtil.requires("#mbrEml")){
				return;
			}
			var mbrEml = $("#mbrEml").val();
			$.post("${context}/api/mbr/emailSend", {"email": mbrEml},function(resp){
				if(resp.status == "200 OK"){
					authNumber=resp.message;
					//버튼 누르면 시간 연장
					if(isRunning){
						clearInterval(timer);
					    display.text("");
					    startTimer(leftSec, display);
					  }else{
					  	startTimer(leftSec, display);
					  }
					alert("전송되었습니다. 이메일을 확인해 주세요");
				}else{
					alert(resp.message);
				}
			});
		});
		$("#auth-btn").click(function(event){
			event.preventDefault();
			if(!valueUtil.requires("#mbrEml")){
				return;
			}
			if(!valueUtil.requires("#authEml")){
				return;
			}
			var authEml = $("#authEml").val();
			if(authNumber == authEml){
				$("#doneAuth").val("true");
				$(".timer").hide();
				$("#send-auth-btn").attr("disabled", "true");
				$("#auth-btn").attr("disabled", "true");
				$("#authEml").attr("disabled", "true");
				$("#mbrEml").attr("readonly", "readonly");
				clearInterval(timer);
				alert("인증번호가 일치합니다.");
			}else{
				//TODO alert말고 sapn으로 처리(타이머 시간때문에)
				alert("인증번호가 불일치 합니다. 다시 입력해주세요.")
			}
		});
		$("#mbrEml").change(function(){
			$("#doneAuth").val("false");
		});
	});
</script>
</head>
<body>

	<form id="regist_form">
		<label for="mbrId" >ID</label>
		<input type="text" id="mbrId" name="mbrId" maxlength="12" placeholder="ID" data-field-name="아이디" onkeyup="chkId(this)"/>
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
		<input type="text" id="mbrNm" name="mbrNm" maxlength="10" placeholder="이름" data-field-name="이름" onkeyup="chkId(this)"/>
		
		<label for="mbrEml" >E-MAIL</label>
		<input type="email" id="mbrEml" name="mbrEml" maxlength="100" placeholder="E-MAIL" data-field-name="이메일" required />
		<button id="send-auth-btn">인증번호 발송</button>
		<input type="text" id="authEml" name="authEml" maxlength="8" placeholder="인증번호 확인" data-field-name="인증번호"/>
		<input type="hidden" id="doneAuth" name="doneAuth" value ="false"/>
		<span class="timer" id="timer" style="display: none;"></span>
		<button id="auth-btn">확인</button>
		
	</form>
		<button id="mbr_regist_btn">가입</button>

</body>
</html>