<%@page import="com.ktds.fr.mbr.vo.MbrVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	$(".nav-item").mouseenter(function() {
		$(this).addClass("on");
		$(this).find(".sub-item").addClass("on");
	}).mouseleave(function() {
		$(this).removeClass("on");
		$(this).find(".sub-item").removeClass("on");
	});
	
}); 
</script>
<div class="header bg-black">
	<ul class="nav">
		<li class="nav-item active">
			<a href="${context}/mbr/list">회원관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/prdt/list">메뉴관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/str/list">매장관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/evnt/list">이벤트관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/hr/list">채용 관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/nt/list">쪽지 관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/rv/list">리뷰관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/rpl/list">댓글관리</a>
		</li>
		<li class="nav-item">
			<a href="${context}/mngrbrd/list">관리자게시판</a>
		</li>
		<li class="nav-item">
			<a href="${context}/hlpdsk/list">고객센터</a>
		</li>
		<li class="nav-item">
			<a href="${context}/odrlst/list">주문목록</a>	
		</li>
		<li class="nav-item">
			<a href="${context}/prdt/list2">소비자화면</a>	
		</li>
	</ul>
	<!--TODO 로그아웃 주소 추가 -->
	<div class="inline profile">

		<a href="${context}/mbr/pwdCheck" >
			${sessionScope.__MBR__.mbrNm} 님
		</a> 
		<a href="${context}/logout">
			(Logout)
		</a>
	</div>
</div>

