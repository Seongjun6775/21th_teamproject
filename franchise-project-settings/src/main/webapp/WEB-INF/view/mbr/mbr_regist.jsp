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
				
			$.get("${context}/api/mbr/check/"+mbrIdVal,function(response){
				if(response.status == "200 OK"){
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
		$("#mbrPwd").keyup(function(){
			var mbrPwd = $(this).val();
			mbrPwd = mbrPwd.replace(/\s/gi, "");
			$("#mbrPwd").val(mbrPwd);
		});
		$("#mbrPwdChck").keyup(function(){
			var mbrPwdChck = $(this).val();
			mbrPwdChck = mbrPwdChck.replace(/\s/gi, "");
			$("#mbrPwdChck").val(mbrPwdChck);
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
			var dupStatus = $("#dupId").css("display");
			if(!valueUtil.requires("#mbrId")){
				return;
			}
			if(dupStatus == "inline"){
				alert("이미 사용중인 아이디 입니다.");
				return;
			}
			if(!valueUtil.requires("#mbrPwd")){
				return;
			}
			if(!valueUtil.requires("#mbrEml")){
				return;
			}
			$.post("${context}/api/mbr/regist", $("#regist_form").serialize(), function(response){
				
			});
		});
	});
</script>
</head>
<body>

	<form id="regist_form">
		<label for="mbrId" >ID</label>
		<input type="text" id="mbrId" name="mbrId" maxlength="12" placeholder="ID" data-field-name="ID"/>
		<span id="dupId" style="display: none;">이미 사용중인 아이디입니다.</span>
		<span id="ableId" style="display: none;">사용가능한 아이디입니다.</span>
		<span id="idLen" style="display: none;">아이디가 너무 짧습니다.</span>
		<label for="mbrPwd" >PWD</label>
		<input type="password" id="mbrPwd" name="mbrPwd" maxlength="12" placeholder="비밀번호"/>
		<label for="mbrPwdChck" >PWD</label>
		<input type="password" id="mbrPwdChck" name="mbrPwdChck" maxlength="12" placeholder="비밀번호확인"/>
		<label for="mbrNm" >Name</label>
		<input type="text" id="mbrNm" name="mbrNm" maxlength="10" placeholder="이름"/>
		<label for="mbrEml" >E-MAIL</label>
		<input type="email" id="mbrEml" name="mbrEml" maxlength="100" placeholder="E-MAIL"/>
	</form>
		<button id="mbr_regist_btn">가입</button>

</body>
</html>