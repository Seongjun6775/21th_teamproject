<%@page import="org.apache.commons.fileupload.DefaultFileItem"%>
<%@page import="org.springframework.web.multipart.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>파일 업로드 처리</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$().ready(function() {
   
	

})

</script>    
</head>
<body>
  <%-- 
      <%
      	MultipartRequest multi = new MultipartRequest(request,
      			                                    "C:\\upload", 
      			                                    10*1024*1024,
      			                                    "utf-8",
      			                                    new DefaultFileRenamePolicy());
      multi.getp
      %> --%>
</body>
</html>