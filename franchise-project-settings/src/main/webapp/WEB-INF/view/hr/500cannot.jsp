<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		Swal.fire({
	    	  icon: 'error',
	    	  title: '권한이 없습니다.',
	    	  showConfirmButton: true,
	    	  confirmButtonColor: '#3085d6'
		}).then((result)=>{
			if(result.isConfirmed){
				location.href = "${context}/hr/list";
			}
		});
		/* alert("권한이 없습니다."); */
	});
</script>
</head>
<body>

</body>
</html>