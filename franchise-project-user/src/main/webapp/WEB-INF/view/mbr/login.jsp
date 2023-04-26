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
		localStorage.setItem("failCount", 0);
		$("#login_btn").click(function(event){
			var failCount = localStorage.getItem("failCount");
			var data ={
					mbrId: $("#mbrId").val(),
					mbrPwd: $("#mbrPwd").val()
			}
			$.post("${context}/api/mbr/login", data, function(resp){
				if(resp.status == "200 OK"){
					localStorage.clear();
					location.href = "${context}"+resp.redirectURL;
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