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
		$("#login_btn").click(function(event){
			var data ={
					mbrId: $("#mbrId").val(),
					mbrPwd: $("#mbrPwd").val()
			}
			$.post("${context}/api/mbr/login", data, function(resp){
				if(resp.status == "200 OK"){
					location.href = "${context}"+resp.redirectURL;
					
					alert("로그인");
				}
				else{
					console.log(resp)
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
		<input type="password" id="mbrPwd" name="mbrPwd" placeholder="PASSWORD를 입력하세요." autocomplete="off"/>
	</form>
	<button id="login_btn">로그인</button>
</body>
</html>