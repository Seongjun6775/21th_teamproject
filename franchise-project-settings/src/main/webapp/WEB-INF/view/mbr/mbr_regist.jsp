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
		<input type="text" id="mbrId" name="mbrId" placeholder="ID"/>
		<label for="mbrPwd" >PWD</label>
		<input type="password" id="mbrPwd" name="mbrPwd" placeholder="비밀번호"/>
		<label for="mbrPwdChck" >PWD</label>
		<input type="password" id="mbrPwdChck" name="mbrPwdChck" placeholder="비밀번호확인"/>
		<label for="mbrNm" >Name</label>
		<input type="text" id="mbrNm" name="mbrNm" placeholder="이름"/>
		<label for="mbrEml" >E-MAIL</label>
		<input type="email" id="mbrEml" name="mbrEml" placeholder="E-MAIL"/>
	</form>
		<button id="mbr_regist_btn">가입</button>

</body>
</html>