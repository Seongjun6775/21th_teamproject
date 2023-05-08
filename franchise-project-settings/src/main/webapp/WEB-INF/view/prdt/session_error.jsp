<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session Error</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	Swal.fire({
  	  icon: 'error',
  	  title: '권한이 없습니다.',
  	  showConfirmButton: true,
  	  confirmButtonColor: '#3085d6'
	}).then((result)=>{
		if(result.isConfirmed){
			location.href = "${context}/index";
		}
	});
	/* alert("권한이 없습니다"); */	
});
</script>
</head>
<body>
	Session Error
</body>
</html>