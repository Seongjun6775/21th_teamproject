<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.ktds.fr.mbr.vo.MbrVO"%>
<%@page import="java.util.Random"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<%
MbrVO mbrVO = (MbrVO) session.getAttribute("__MBR__");
%>
<link rel="stylesheet" href="../css/evnt_common_customer2.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<meta charset="UTF-8">
<title>매장 조회</title>

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {


		//사진 검색 
		$("#picture").click(function() {
			var data = $(this).data();
			location.href = "${context}/str/customer";
		})
		
		var srt = "${str.strId}"
		$("div[id=menuCategory] a").each(function(){
			if($(this).attr("value") == srt){
				$(this).addClass("menuOn");
			}
		})
		
	});
</script>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />
	
	<div class="visualArea flex relative">
		<div class="content-setting title">매장</div>
		<div class="overlay absolute"></div>
	</div>

		<div>
		<br>
			<h1 class="head-title">매장 조회</h1>
		<br>
			<p class="head-content">
				가장 가까운 <br> 매장을 찾아보세요! 
			</p>
			<div class="head-count">총 ${strList.size() > 0 ? strList.get(0).totalCount : 0}건</div>
		</div>

		<div id="menu" class="flex-column">
		<div id="menuCategory" class="flex" >
			<a href="${context}/str/customer" class="btn">매장 찾기</a>
		</div>

		<div id="itemList" class="flow-wrap">
				<c:choose>
					<c:when test="${not empty strList}">
						<c:forEach items="${strList}" var="str">
							<div class="itemList" id="${str.strId}">
								<div class="prdt card shadow" style="padding:24px; border-radius:24px; margin-top:144px;">
									<div class="img-box" style="width: 600px; height: 600px;">
									</div>
								</div>
							</div>
						</c:forEach>

					</c:when>

					<c:otherwise>
						<div>등록된 매장이 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
			
		</div>
	<jsp:include page="../include/footer_user.jsp" />
	
</body>
</html>