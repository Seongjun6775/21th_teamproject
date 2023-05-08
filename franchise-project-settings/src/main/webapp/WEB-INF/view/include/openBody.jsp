<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body class="bg-dark bg-opacity-10 ">
	<!-- spinner -->
	<div id="overlay">
	  <div class="cv-spinner">
	    <span class="spinner"></span>
	  </div>
	</div>	
<jsp:include page="../include/logo.jsp" />
<main class="d-flex flex-nowrap ">	
		<jsp:include page="./sidemenu.jsp" />
		<div style="margin:0px 0px 0px 250px; width: 100%; overflow: auto;
					display: flex; height: 100vh; flex-direction: column;">
			<jsp:include page="./header.jsp" />
