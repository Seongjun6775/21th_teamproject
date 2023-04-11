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
		
		$("#mbrId").keyup(function(){
			var mbrIdVal = $(this).val();
			mbrIdVal = mbrIdVal.replace(/\s/gi, "");
			$("#mbrId").val(mbrIdVal);
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
		
		$("#mbr_regist_btn").click(function(){
			$.post("${context}/api/mbr/regist", $("#regist_form").serialize(), function(response){
				
			});
		});
	});
</script>
</head>
<body>

	<form id="regist_form">
		<label for="mbrId" >ID</label>
		<input type="text" id="mbrId" name="mbrId" maxlength="12" placeholder="ID"/>
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