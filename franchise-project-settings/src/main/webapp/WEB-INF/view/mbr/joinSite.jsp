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
<script type="text/javascript" src="${context}/js/join.js"></script>
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
		localStorage.setItem("failCount", 0);
		
		$("#login_btn").click(function(event){
			var failCount = localStorage.getItem("failCount");
			var data ={
					mbrId: $("#lgn_mbrId").val(),
					mbrPwd: $("#lgn_mbrPwd").val()
			}
			$.post("${context}/api/mbr/login", data, function(resp){
				if(resp.status == "200 OK"){
					localStorage.clear();
					location.href = "${context}"+resp.redirectURL;
					alert("로그인");
				}
				else if(resp.message=="계정정보없음"){
					localStorage.setItem("failCount", parseInt(failCount)+1);
					if(failCount <= 5){
						alert("아이디 또는 비밀번호를 확인해 주세요. 5회이상 실패시 계정이 차단됩니다. "+ failCount + " / 5");
					}else{
						alert("계정이 잠겼습니다. 관리자에게 문의하세요.");
					}
				}else{
					alert(resp.message)
				}
			});
		});
		
		
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
			var mbrPwdChck = $("#mbrPwdChck").val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#mbrPwd").val(mbrPwd);
			pwd=mbrPwd;
			
			//비밀번호 자리수가 0일때
			if(mbrPwd.length==0){
				$("#shortPwd").hide();
				if(mbrPwdChck.length != 0){
					$("#notMatchPwd").show();
					$("#matchPwd").hide();
					$("#checkPwd").hide();
				}
			}
			//비밀번호 자리수가 8자 미만일때
			else if (mbrPwd.length < 8){
				$("#shortPwd").show();
				if(mbrPwdChck.length != 0){
					$("#notMatchPwd").show();
					$("#matchPwd").hide();
					$("#checkPwd").hide();
				}
			}
			//비밀번호 자리수가 8자 이상일때
			else{
				$("#shortPwd").hide();
				if(mbrPwdChck == mbrPwd){
					$("#notMatchPwd").hide();
					$("#matchPwd").show();
					$("#checkPwd").hide();
				}else{
					$("#notMatchPwd").show();
					$("#matchPwd").hide();
					$("#checkPwd").hide();
				}
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
		$(".mbrEml").keyup(function(){
			var mbrEml = $(this).val();
			mbrEml = mbrEml.replace(/\s/gi, "");
			$(".mbrEml").val(mbrEml);
			$("#timer").hide();
		});
		
		$("#mbr_regist_btn").click(function(event){
			event.preventDefault();
			if(!valueUtil.requires("#mbrId")){
				return;
			}
			var dupStatus = $("#dupId").css("display");
			if(dupStatus != "none"){
				alert("이미 사용중인 아이디 입니다.");
				return;
			}
			var idLen = $("#idLen").css("display");
			if(idLen != "none"){
				alert("아이디는 5자 이상입니다.");
				return;
			}
			var shortPwd = $("#shortPwd").css("display");
			if(shortPwd != "none"){
				alert("비밀번호는 8자 이상입니다.");
				return;
			}
			if(!valueUtil.requires("#mbrPwd")){
				return;
			}
			var matchPwd= $("#matchPwd").css("display");
			if(matchPwd == "none"){
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
			if(!valueUtil.requires(".mbrEml")){
				return;
			}
			if($("#doneAuth").val() == "false" ? true : false){
				alert("이메일 인증을 진행해 주세요.")
				return;
			}
			$.post("${context}/api/mbr/regist", $("#login-up").serialize(), function(resp){
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
		      display.text("시간초과 다시 시도하세요.");
		      $("#auth-btn").attr("disabled", true);
		      isRunning = false;
		    }
		  }, 1000);
		  isRunning = true;
		}
		$("#send-auth-btn").click(function(event){
			event.preventDefault();
			var email = $(".mbrEml").val();
			$("#auth-btn").attr("disabled", false);
			
			if( email == "" || emailRegExp.test(email)){
				alert("이메일을 확인하세요.");
				return;
			}
			$("#timer").show();
			if(!valueUtil.requires(".mbrEml")){
				return;
			}
			var mbrEml = $(".mbrEml").val();
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
			if(!valueUtil.requires(".mbrEml")){
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
				$(".mbrEml").attr("readonly", "readonly");
				clearInterval(timer);
				alert("인증번호가 일치합니다.");
			}else{
				//TODO alert말고 sapn으로 처리(타이머 시간때문에)
				alert("인증번호가 불일치 합니다. 다시 입력해주세요.")
			}
		});
		$(".mbrEml").change(function(){
			$("#doneAuth").val("false");
		});
		$("#lgn_mbrId").keydown(function (key) {
	        if (key.keyCode == 13) {
	        	$("#login_btn").click();
	        }
	    });
		$("#lgn_mbrPwd").keydown(function (key) {
	        if (key.keyCode == 13) {
	        	$("#login_btn").click();
	        }
	    });
		$("#find_id_btn").click(function(event){
			var email = $("#find-id-mbrEml").val();
			var type = "id";
			if(!valueUtil.requires("#find-id-mbrEml")){
				return;
			}
			$.post("${context}/api/mbr/find",{email: email, type: type}, function(resp){
				if(resp.status=="200 OK"){
					alert("이메일로 전송완료, 확인 해 주세요.");
					location.href="${context}/"+resp.redirectURL;
				}else{
					alert(resp.message);
				}
			})
		});
	});
</script>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

  <div class="login">
    <div class="login__content">
      <div class="login__img">
        <img src="https://image.freepik.com/free-vector/code-typing-concept-illustration_114360-3581.jpg" alt="user login">
      </div>
      <div class="login__forms">
			<!--로그인 영역 -->
        <form class="login__register" id="login-in">
          <h1 class="login__title">Sign In</h1>
          <div class="login__box">
            <i class='bx bx-user login__icon'></i>
            <input type="text" id="lgn_mbrId" name="mbrId" placeholder="UserID" class="login__input">
          </div>
          <div class="login__box">
            <i class='bx bx-lock login__icon'></i>
            <input type="password" id="lgn_mbrPwd" name ="mbrPwd" placeholder="Password" class="login__input" autocomplete="off">
          </div>
          <!-- <a href="#" class="login__forgot">Forgot Account? </a> -->
          <span class="login__forgot" id="find-account">Forgot Account?</span>
          
          <a id="login_btn" class="login__button">Sign In</a>
          
          <div>
            <span class="login__account login__account--account">Don't Have an Account?</span>
            <span class="login__signin login__signin--signup" id="sign-up">Sign Up</span>
          </div>
        </form>
        
			<!--회원가입 영역 -->
        <form class="login__create none" id="login-up">
          <h1 class="login__title">Create Account</h1>
          <div class="login__box">
          	<div class="icon__box">
            	<i class='bx bx-user login__icon'></i>
          	</div>
          	<div class="content__box content__one" >
            	<input type="text" id="mbrId" name="mbrId" maxlength="12" placeholder="UserID" data-field-name="아이디" onkeyup="chkId(this)" class="login__input">
            	<span id="dupId" class="warning" style="display: none;">이미 사용중인 아이디입니다.</span>
				<span id="ableId" class="pass" style="display: none;">사용가능한 아이디입니다.</span>
				<span id="idLen" class="warning" style="display: none;">아이디는 5자 이상입니다.</span>
          	</div>
          </div>
          <div class="login__box">
          	<div class="icon__box">
	            <i class='bx bx-lock login__icon'></i>
          	</div>
            <div class="content__box content__one" >
	            <input type="password" id="mbrPwd" name="mbrPwd" maxlength="12" placeholder="Password" autocomplete="off" data-field-name="비밀번호" class="login__input">
	            <span id="shortPwd" class="warning" style="display: none;">비밀번호는 8자 이상입니다.</span>
            </div>
          </div>
          <div class="login__box">
	        <div class="icon__box">
	            <i class='bx bx-lock login__icon'></i>
	        </div>
            <div class="content__box content__one">
	            <input type="password" id="mbrPwdChck" name="mbrPwdChck" maxlength="12" placeholder="Password Check" autocomplete="off" class="login__input">
	            <span id="matchPwd" class="pass" style="display: none;">비밀번호가 일치합니다.</span>
				<span id="notMatchPwd" class="warning" style="display: none;">비밀번호가 다릅니다.</span>
				<span id="checkPwd" class="warning" style="display: none;">비밀번호를 입력해주세요.</span>
            </div>
          </div>
          
          <div class="login__box">
          	<div class="icon__box">
	            <i class='bx bx-user-circle login__icon'></i>
          	</div>
            <div class="content__box content__one">
	            <input type="text" id="mbrNm" name="mbrNm" maxlength="10" placeholder="Name" data-field-name="이름" onkeyup="chkId(this)" class="login__input">
	            
            </div>
          </div>
          <div class="login__box">
          	<div class="icon__box">
	            <i class='bx bx-at login__icon'></i>
          	</div>
            <div class="content__box content__two">
            	<div class="inner__content">
		            <input type="email" id="mbrEml" name="mbrEml" maxlength="100" data-field-name="이메일" required placeholder="Email" class="login__input mbrEml
		            ">
		            <button id="send-auth-btn" class="email__button">인증</button>
            	</div>
            </div>
          </div>
          <div class="login__box">
          	<div class="icon__box">
	            <i class='bx bx-check-shield login__icon'></i>
          	</div>
            <div class="content__box content__two" >
            	<div class="inner__content">
            		<input type="email" id="authEml" name="authEml" maxlength="8"  data-field-name="인증번호" required placeholder="Check Number" class="login__input">
		            <button id="auth-btn" class="email__button">확인</button>
            	</div>
	            <div>
		            <span class="timer" id="timer" style="display: none;"></span>
	            </div>
            </div>
          </div>
          
          
          <a id="mbr_regist_btn" class="login__button">Sign Up</a>
          
          <div>
            <span class="login__account login__account--account">Already have an Account?</span>
            <span class="login__signup login__signup--signup" id="sign-in">Sign In</span>
          </div>
          
          <!-- <div class="login__social">
             <a href="#" class="login__social--icon"><i class='bx bxl-facebook'></i></a>
             <a href="#" class="login__social--icon"><i class='bx bxl-twitter'></i></a>
             <a href="#" class="login__social--icon"><i class='bx bxl-google'></i></a>
             <a href="#" class="login__social--icon"><i class='bx bxl-github'></i></a>
          </div> -->
        </form>
        
        <form class="login__find none" id="login-find">
        	<h1 class="login__title">Find ID</h1>
        	
        	<div class="login__box margin-Bot-10">
            	<i class='bx bx-at login__icon'></i>
            	<input type="email" id="find-id-mbrEml" name="mbrEml" maxlength="100" data-field-name="이메일" required placeholder="Email" class="login__input mbrEml">
          	</div>
       		<a id="find_id_btn" class="login__button">Find-ID</a>
        	<h1 class="login__title">Find PW</h1>
        	<div class="login__box">
            	<i class='bx bx-user login__icon'></i>
            	<input type="text" id="find-mbrId" name="mbrId" maxlength="12" placeholder="UserID" data-field-name="아이디" onkeyup="chkId(this)" class="login__input">
          	</div>
        	<div class="login__box">
            	<i class='bx bx-at login__icon'></i>
            	<input type="email" id="find-pw-mbrEml" name="mbrEml" maxlength="100" data-field-name="이메일" required placeholder="Email" class="login__input">
          	</div>
       		<a id="find_pw_btn" class="login__button">Find-PW</a>
          	<div>
	          	<span class="login__account login__account--account">Already have an Account?</span>
	            <span class="login__signup login__signup--signup" id="sign-in2">Sign In</span>
          	</div>
        	<div>
            	<span class="login__account login__account--account">Don't Have an Account?</span>
            	<span class="login__signin login__signin--signup" id="sign-up2">Sign Up</span>
          	</div>
        </form>
        
      </div>
    </div>
   </div>
</body>
</html>