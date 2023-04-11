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
		$("#login_btn").click(function(){
/* 			var data ={
					mbrId: $("#mbrID").val(),
					mbrPwd: $("#mbrPwd").val()
			} */
			$.post("${context}/api/mbr/login", $("#login_form").serialize, function(res){
				console.log(res)
				if(res.status == "200 OK"){
					alert("로그인");
				}
				else{
					alert("아이디 비밀번호를 확인하세요.");
				}
			});
		});
	});
</script>
</head>
<body>
	<form id="login_form">
		<label for="mbrId" >ID</label>
		<input type="text" id="mbrId" name="mbrId" placeholder="ID를 입력하세요."/>
		<label for="mbrPwd">PASSWORD</label>
		<input type="password" id="mbrPwd" name="mbrPwd" placeholder="PASSWORD를 입력하세요."/>
		<button id="login_btn">로그인</button>
	</form>
</body>
</html>