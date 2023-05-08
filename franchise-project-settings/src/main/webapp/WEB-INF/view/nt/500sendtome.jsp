<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/ntcommon.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">

	$().ready(function() {
		Swal.fire({
	    	  icon: 'error',
	    	  title: '자신에게는 쪽지를<br>보낼 수 없습니다.',
	    	  showConfirmButton: true,
	    	  confirmButtonColor: '#3085d6'
		});.then((result)=>{
			if(result.isConfirmed){
				location.href = "${context}/nt/list";
			}
		});
		/* alert("자기 자신에게는 쪽지를 보낼 수 없습니다."); */
	});

</script>
</head>
<jsp:include page="../include/openBody.jsp" />
<jsp:include page="../include/closeBody.jsp" />
</html>
