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
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="../css/evnt_common_customer2.css?p=${date}">
<meta charset="UTF-8">
<title>이벤트 목록 조회</title>

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {

		//현재진행중 이벤트 확인          
		$("#btn-ongoingEvntList").click(function() {
			location.href = "${context}/evnt/ongoingList";
		});
		//과거 이벤트 확인
		$("#btn-pastEvntList").click(function() {
			location.href = "${context}/evnt/pastEvntList";
		});
		//진행예정중인 이벤트 확인
		$("#btn-planEvntList").click(function() {
			location.href = "${context}/evnt/planEvntList";
		});

		//사진 검색 
		$("#picture").click(function() {
			var data = $(this).data();
			location.href = "${context}/evnt/detail/" + data.evntid;
		})
		
		var srt = "${evnt.evntId}"
		$("div[id=menuCategory] a").each(function(){
			if($(this).attr("value") == srt){
				$(this).addClass("menuOn");
			}
		})
		
	});
</script>

<style>
.prdt:hover img {
	transform: scale(1.2);
}

</style>

</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />
	
	<div class="visualArea flex relative">
		<div class="content-setting title">이벤트</div>
		<div class="overlay absolute"></div>
	</div>

		<div>
		<br>
			<h1 class="head-title">이벤트 조회</h1>
		<br>
			<p class="head-content">
				붕어빵 프렌차이즈의 <br> 다양한 이벤트를 만나보세요!
			</p>
			<div class="head-count">총 ${evntList.size() > 0 ? evntList.get(0).totalCount : 0}건</div>
		</div>

		<div id="menu" class="flex-column">
		<div id="menuCategory" class="flex" >
			<a href="${context}/evnt/ongoingList" class="btn">진행중인 이벤트</a>
			<a href="${context}/evnt/pastEvntList" class="btn">종료된 이벤트</a>
			<a href="${context}/evnt/planEvntList" class="btn">진행예정 이벤트</a>
		</div>

		<div id="itemList" class="flow-wrap">
				<c:choose>
					<c:when test="${not empty evntList}">
						<c:forEach items="${evntList}" var="evnt">
							<div class="itemList" id="${evnt.evntId}">
								<div class="prdt card shadow" style="padding:24px; border-radius:24px; margin-top:144px;">
									<div class="img-box" style="width: 600px; height: 600px;">
										<c:choose>
											<c:when test="${empty evnt.uuidFlNm}">
												<img src="${context}/img/default_photo.jpg" style="width:600px; height:600px;" >
											</c:when>
											<c:otherwise>
												<a href="${context}/evnt/detail_customer/${evnt.evntId}"> 
												<img src="${context}/evnt/img/${evnt.uuidFlNm}/" style="width:600px; height:600px;" ></a>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="prdt3">
										<div class="name ellipsis">${evnt.evntTtl}</div>
										<div class="price">${evnt.evntStrtDt} ~
											${evnt.evntEndDt}</div>
									</div>
								</div>
							</div>
						</c:forEach>

					</c:when>

					<c:otherwise>
						<div>등록된 이벤트가 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
			
		</div>
	<jsp:include page="../include/footer_user.jsp" />
	
</body>
</html>