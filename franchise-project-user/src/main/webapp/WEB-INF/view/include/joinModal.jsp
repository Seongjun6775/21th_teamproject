<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt() %>" />
<script type="text/javascript" src="${context}/js/join.js"></script>
<script type="text/javascript">
// 특수문자 모두 제거    

/* Swal.fire({
	  title: '로그인 필요',
	  text: "로그인이 필요합니다.\n로그인 하시겠습니까?",
	  icon: 'warning',
	  showCancelButton: true,
	  confirmButtonColor: '#3085d6',
	  cancelButtonColor: '#d33',
	  cancelButtonText: '취소',
	  confirmButtonText: '로그인'
	}).then((result) => {
		if(result.isConfirmed){
			$("#img_btn").click();
		}else{
			$("#btn-modal-close").click();
		}
}); */



function chkId(obj){
    var RegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;   //정규식 구문
    if (RegExp.test(obj.value)) {
      obj.value="";
      Swal.fire({
    	  icon: 'error',
    	  title: "잘못된 입력",
    	  text: '아이디에 특수문자를 입력할 수 없습니다.',
    	  showConfirmButton: false,
    	  timer: 2500
    	})
      /* alert("아이디에 특수문자를 입력할 수 없습니다. 다시 입력해주세요"); */
    }
  }
var emailRegExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	$().ready(function(){
		
	var valueUtil = new ValueUtil();
	var idMinLength = 5;
	var pwMinLength = 8;
	var authCode="";
	localStorage.setItem("failCount", 0);
	$(".modal").on("show.bs.modal", function(){
		$("#sign-in").click();
	});
	$('.modal').on('hidden.bs.modal', function () {
	  clearInterval(timer);
	  isRunning=false;
	  $("form").each(function(){
		  this.reset();
		  $("#ableId").hide();
		  $("#idLen").hide();
		  $("#dupId").hide();
		  $("#notMatchPwd").hide();
			$("#matchPwd").hide();
			$("#checkPwd").hide();
			$("#timer").hide();
	  })
	});	
	
	$("#login_btn").click(function(event){
		var failCount = localStorage.getItem("failCount");
		var data ={
				mbrId: $("#lgn_mbrId").val(),
				mbrPwd: $("#lgn_mbrPwd").val()
		}
		$.post("${context}/login", data, function(resp){
			if(resp.status == "200 OK"){
				localStorage.clear();
				$("#btn-modal-close").click();
				/* location.href = "${context}"+resp.redirectURL; */
				location.reload();
			}
			else if(resp.message=="계정정보없음"){
				localStorage.setItem("failCount", parseInt(failCount)+1);
				if(failCount <= 5){
					Swal.fire({
				    	  icon: 'error',
				    	  title: '입력값이 다릅니다.',
				    	  html: "아이디 또는 비밀번호를 확인해 주세요.<br/>5회이상 실패시 계정이 차단됩니다. <br/>"+ failCount + " / 5",
				    	  showConfirmButton: false,
				    	  timer: 2500
			    	});
					/* alert("아이디 또는 비밀번호를 확인해 주세요. 5회이상 실패시 계정이 차단됩니다. "+ failCount + " / 5"); */
				}else{
					Swal.fire({
				    	  icon: 'error',
				    	  title: "계정이 잠겼습니다.\n관리자에게 문의하세요.",
				    	  showConfirmButton: false,
				    	  timer: 2500
			    	});
					/* alert("계정이 잠겼습니다. 관리자에게 문의하세요."); */
				}
			}else if(resp.errorCode=="400"){
				Swal.fire({
			    	  icon: 'error',
			    	  title: '오류',
			    	  html: resp.message,
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
			}else{
				console.log(resp);
				var str = (resp.message).split(".");
				Swal.fire({
			    	  icon: 'error',
			    	  title: '입력값이 다릅니다.',
			    	  html: str[0]+".<br/>"+str[1]+".<br/>"+str[2],
			    	  showConfirmButton: false,
			    	  timer: 2500
		    	});
				/* alert(resp.message) */
			}
		});
	});
	
	$("#find-mbrId").keyup(function(){
		var mbrIdVal = $(this).val();
		mbrIdVal = mbrIdVal.replace(/\s/gi, "");
		$("#find-mbrId").val(mbrIdVal);
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
			
		$.get("${context}/check/"+mbrIdVal,function(resp){
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
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '비밀번호 8자리를 먼저 입력하세요',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("비밀번호 8자리를 먼저 입력하세요"); */
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
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '이미 사용중인 아이디 입니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("이미 사용중인 아이디 입니다."); */
			return;
		}
		var idLen = $("#idLen").css("display");
		if(idLen != "none"){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '아이디는 5자 이상입니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("아이디는 5자 이상입니다."); */
			return;
		}
		var shortPwd = $("#shortPwd").css("display");
		if(shortPwd != "none"){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '비밀번호는 8자 이상입니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("비밀번호는 8자 이상입니다."); */
			return;
		}
		if(!valueUtil.requires("#mbrPwd")){
			return;
		}
		var matchPwd= $("#matchPwd").css("display");
		if(matchPwd == "none"){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '비밀번호가 일치하지 않습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("비밀번호가 일치하지 않습니다."); */
			return;
		}
		if(!valueUtil.requires("#mbrEml")){
			return;
		}
		if($("#doneAuth").val() == "false" ? true : false){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '이메일 인증을 진행해 주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("이메일 인증을 진행해 주세요.") */
			return;
		}
		$.post("${context}/regist", $("#login-up").serialize(), function(resp){
			if(resp.status == "200 OK"){
				Swal.fire({
			    	  icon: 'success',
			    	  title: '회원가입 성공',
			    	  showConfirmButton: true,
			    	  confirmButtonColor: '#3085d6'
				}).then((result)=>{
					if(result.isConfirmed){
						location.href="${context}"+resp.redirectURL;
					}
				});
				/* alert("회원가입 성공!"); */
			}else if(resp.errorCode=="403" || resp.errorCode=="500"){
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
	      Swal.fire({
	    	  icon: 'error',
	    	  title: '시간초과',
	    	  text: '다시 시도하세요.',
	    	  showConfirmButton: false,
	    	  timer: 2500
    	  });
	      /* alert("시간초과"); */
	      display.text("시간초과 다시 시도하세요.");
	      $("#auth-btn").attr("disabled", true);
	      isRunning = false;
	    }
	  }, 1000);
	  isRunning = true;
	}
	$("#send-auth-btn").click(function(event){
		event.preventDefault();
		var email = $("#mbrEml").val();
		$("#auth-btn").attr("disabled", false);
		
		if( email == "" || !emailRegExp.test(email)){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '이메일을 확인하세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("이메일을 확인하세요."); */
			return;
		}
		$("#timer").show();
		if(!valueUtil.requires("#mbrEml")){
			return;
		}
		var mbrEml = $("#mbrEml").val();
		$('#spinner-div').show();
		
		$.ajax({
			  url: "${context}/emailSend",
			  type: 'post',
			  data: {"email": mbrEml},
				  beforeSend: function() {
					  	$("#overlay").show();
					  },
				  success: function(resp) {
					  	$("#overlay").hide();
					    if(resp.status == "200 OK"){
					      authNumber=resp.message;
					      //버튼 누르면 시간 연장
					      if(isRunning){
					        clearInterval(timer);
					        display.text("");
					        startTimer(leftSec, display);
					      } else{
					        startTimer(leftSec, display);
					      }
					      Swal.fire({
					    	  icon: 'success',
					    	  title: '전송되었습니다.\n이메일을 확인해 주세요.',
					    	  showConfirmButton: false,
					    	  timer: 2500
			    			});
					      /* alert("전송되었습니다. 이메일을 확인해 주세요"); */
					    } else{
					    	Swal.fire({
						    	  icon: 'error',
						    	  title: resp.message,
						    	  showConfirmButton: false,
						    	  timer: 2500
				    			});
					      /* alert(resp.message); */
					    }
					  },
				  error: function(){
					  	$("#overlay").hide();
					  	Swal.fire({
					    	  icon: 'error',
					    	  title: '에러가 발생했습니다.\n다시 시도해주세요.',
					    	  showConfirmButton: false,
					    	  timer: 2500
		    			});
					    /* alert("에러가 발생했습니다. 다시 시도해주세요"); */
					  },
				  complete: function() {
					  $("#overlay").hide();
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
			Swal.fire({
		    	  icon: 'success',
		    	  title: '인증번호가 일치합니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
				});
			/* alert("인증번호가 일치합니다."); */
		}else{
			//TODO alert말고 sapn으로 처리(타이머 시간때문에)
			Swal.fire({
		    	  icon: 'error',
		    	  title: '인증번호가 불일치 합니다.\n다시 입력해주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
				});
			/* alert("인증번호가 불일치 합니다. 다시 입력해주세요.") */
		}
	});
	$("#mbrEml").change(function(){
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
		$('#spinner-div').show();
		
		$.ajax({
			  url: "${context}/find",
			  type: 'post',
			  data: {email: email, type: type},
				  beforeSend: function() {
					  	$("#overlay").show();
					  },
				  success: function(resp) {
					  	$("#overlay").hide();
					    if(resp.status == "200 OK"){
					    	Swal.fire({
						    	  icon: 'success',
						    	  title: '이메일 전송완료',
						    	  showConfirmButton: true,
						    	  confirmButtonColor: '#3085d6'
							}).then((result)=>{
								if(result.isConfirmed){
									location.href="${context}/"+resp.redirectURL;
								}
							});
					    	
				    		/* alert("이메일로 전송완료, 확인 해 주세요."); */
					    } else{
					    	Swal.fire({
						    	  icon: 'error',
						    	  title: resp.message,
						    	  showConfirmButton: false,
						    	  timer: 2500
			  				});
					      /* alert(resp.message); */
					    }
					  },
				  error: function(){
					  	$("#overlay").hide();
					  	Swal.fire({
					    	  icon: 'error',
					    	  title: '에러가 발생했습니다.\n다시 시도해주세요',
					    	  showConfirmButton: false,
					    	  timer: 2500
		  				});
					    /* alert("에러가 발생했습니다. 다시 시도해주세요"); */
					  },
				  complete: function() {
					  $("#overlay").hide();
				  }
		  });
	});
	$("#find_pw_btn").click(function(event){
		var email = $("#find-pw-mbrEml").val();
		var mbrId = $("#find-mbrId").val();
		var type = "pw";
		if(!valueUtil.requires("#find-pw-mbrEml")){
			return;
		}
		if(!valueUtil.requires("#find-mbrId")){
			return;
		}
		
		$.ajax({
			  url: "${context}/find",
			  type: 'post',
			  data: {email: email, type: type, mbrId: mbrId},
				  beforeSend: function() {
					  	$("#overlay").show();
					  },
				  success: function(resp) {
					  	$("#overlay").hide();
					    if(resp.status == "200 OK"){
					    	Swal.fire({
						    	  icon: 'success',
						    	  title: '이메일 전송완료',
						    	  showConfirmButton: true,
						    	  confirmButtonColor: '#3085d6'
							}).then((result)=>{
								if(result.isConfirmed){
									location.href="${context}/"+resp.redirectURL;
								}
							});
				    		/* alert("이메일로 전송완료, 확인 해 주세요."); */
					    } else{
					    	Swal.fire({
						    	  icon: 'error',
						    	  title: resp.message,
						    	  showConfirmButton: false,
						    	  timer: 2500
			  				});
					      /* alert(resp.message); */
					    }
					  },
				  error: function(){
					  	$("#overlay").hide();
					  	Swal.fire({
					    	  icon: 'error',
					    	  title: '에러가 발생했습니다.\n다시 시도해주세요.',
					    	  showConfirmButton: false,
					    	  timer: 2500
		  				});
					    /* alert("에러가 발생했습니다. 다시 시도해주세요"); */
					  },
				  complete: function() {
					  $("#overlay").hide();
				  }
		  });			
	
	});
});
</script>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<!-- spinner -->
<div id="overlay">
  <div class="cv-spinner">
    <span class="spinner"></span>
  </div>
</div>	
<!-- Modal -->
<div class="modal fade" id="loginModal" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content" style="background: none; border: 0px; overflow: hidden;height: 790px; position: relative; top: 50%; left: 50%; transform: translateY(-50%) translateX(-50%);">
			<!-- <div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel"></h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div> -->
			<!-- <div class="modal-body"> -->
			<!-- 로그인 부분 Start -->
			  
			  <div class="login modal-body">
			    <div class="login__content">
			      <div class="login__forms">
						<!--로그인 영역 -->
			        <form class="login__register" id="login-in" autocomplete="off">
			          <h1 class="login__title">Sign In</h1>
			          <div class="login__box">
			            <i class='bx bx-user login__icon'></i>
			            <input type="text" id="lgn_mbrId" name="mbrId" placeholder="UserID" class="login__input mbrId">
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
			        <form class="login__create none" id="login-up" autocomplete="off">
			          <h1 class="login__title">Create Account</h1>
			          <div class="login__box">
			          	<div class="icon__box">
			            	<i class='bx bx-user login__icon'></i>
			          	</div>
			          	<div class="content__box content__one" >
			            	<input type="text" id="mbrId" name="mbrId" maxlength="12" placeholder="UserID" data-field-name="아이디" onkeyup="chkId(this)" class="login__input mbrId">
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
					            <input type="email" id="mbrEml" name="mbrEml" maxlength="100" data-field-name="이메일" required placeholder="Email" class="login__input mbrEml" autocomplete="off">
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
			
			        </form>
			        
			        <form class="login__find none" id="login-find" autocomplete="off">
			        	<h1 class="login__title">Find ID</h1>
			        	
			        	<div class="login__box margin-Bot-10">
			            	<i class='bx bx-at login__icon'></i>
			            	<input type="email" id="find-id-mbrEml" name="mbrEml" maxlength="100" data-field-name="이메일" required placeholder="Email" class="login__input mbrEml" autocomplete="off">
			          	</div>
			       		<a id="find_id_btn" class="login__button">Find-ID</a>
			        	<h1 class="login__title">Find PW</h1>
			        	<div class="login__box">
			            	<i class='bx bx-user login__icon'></i>
			            	<input type="text" id="find-mbrId" name="mbrId" maxlength="12" placeholder="UserID" data-field-name="아이디" onkeyup="chkId(this)" class="login__input mbrId">
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
			<!-- 로그인 부분 End   -->
			
			<!-- </div> -->
			<div class="modal-footer" style="border-top: 0px;">
				<button type="button" id="btn-modal-close" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
