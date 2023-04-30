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
<link rel="stylesheet" href="../css/evnt_common_customer.css?p=${date}">
<meta charset="UTF-8">
<title>이벤트 목록 조회</title>
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
	});
</script>
<script>
	$(document).ready(function() {

		$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
		})

	})
</script>

<script>
	$(function() {
		$("div").slice(0, 1).show(); // 초기갯수
		$("#more").click(function(e) { // 클릭시 more
			e.preventDefault();
			$("div:hidden").slice(0, 1).show(); // 클릭시 more 갯수 지저정
			if ($("div:hidden").length == 0) { // 컨텐츠 남아있는지 확인
				alert("게시물의 끝입니다."); // 컨텐츠 없을시 alert 창 띄우기 
			}
		});
	});
</script>

</head>
<body>
	<div class="main-layout">
		<%-- 		<jsp:include page="../include/header.jsp" /> --%>
		<!-- 		<div> -->
		<%-- 			<jsp:include page="../include/evntSidemenu.jsp" /> --%>
		<%-- 			<jsp:include page="../include/content.jsp" /> --%>
		<div>
			<h1 class="head-title">이벤트 조회</h1>
			<p class="head-content">
				붕어빵 프렌차이즈의 <br> 다양한 이벤트를 만나보세요!
			</p>
			<div class="head-count">총 ${evntList.size() > 0 ? evntList.get(0).totalCount : 0}건</div>
		</div>

		<!-- 여기부터 -->
		<div class="container">

			<ul class="tabs">
				<li class="tab-link" data-tab="tab-1"><a
					href="${context}/evnt/ongoingList" class="btn">진행중인 이벤트</a></li>
				<li class="tab-link current" data-tab="tab-2"><a
					href="${context}/evnt/pastEvntList" class="btn">종료된 이벤트</a></li>
				<li class="tab-link" data-tab="tab-3"><a
					href="${context}/evnt/planEvntList" class="btn">진행예정 이벤트</a></li>
			</ul>

			<div id="tab-1" class="tab-content"></div>
			<div id="tab-2" class="tab-content current"></div>
			<div id="tab-3" class="tab-content"></div>

		</div>

		<div class="content">

			<div style="clear: both;">
				<c:choose>
					<c:when test="${not empty evntList}">
						<c:forEach items="${evntList}" var="evnt">
							<div class="evntImgBox" id="${evnt.evntId}">
								<div class="img-box">
									<c:choose>
										<c:when test="${empty evnt.uuidFlNm}">
											<img src="${context}/img/default_photo.jpg"
												style="width: 500px; height: 400px;">
										</c:when>
										<c:otherwise>
											<a href="${context}/evnt/detail_customer/${evnt.evntId}"> <img
												src="${context}/evnt/img/${evnt.uuidFlNm}/"
												style="width: 500px; height: 400px;">
											</a>
										</c:otherwise>
									</c:choose>
									<div class="evntPhoto">
										<div class="evntTtl">${evnt.evntTtl}</div>
										<div class="evntDate">${evnt.evntStrtDt} ~
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

<!-- 			<div class="button"> -->

<!-- 				<div></div> -->
<!-- 				<button class="more" id="more" type="button" -->
<!-- 					onclick="paging.view();">더보기</button> -->
<!-- 			</div> -->



		</div>

		<%-- 			<jsp:include page="../include/footer.jsp" /> --%>
		<!-- 		</div> -->
	</div>
</body>
</html>