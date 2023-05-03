<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%=new Random().nextInt()%>" />




<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>	
<script type="text/javascript" src="${context}/js/AjaxUtil.js"></script>
<script type="text/javascript" src="${context}/js/ValueUtil.js"></script>

 <link rel="stylesheet" href="${context}/css/mbr_common.css?p=${date}" />

<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}" />
<link rel="stylesheet" href="${context}/css/sidebars.css?p=${date}" />
<script type="text/javascript" src="${context}/js/bootstrap.bundle.min.js"></script>

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>