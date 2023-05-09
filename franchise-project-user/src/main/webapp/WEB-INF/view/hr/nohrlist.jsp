<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#create_btn").click(function() {
			location.href="${context}/hr/hrcreate"
		});
		
		$("#hr_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.hrid != null && (data.hrid) != "") {
				location.href="${context}/hr/hrdetail/" + data.hrid;
			}
		});
		
	});
	
	function movePage(pageNo) {
		location.href = "${context}/hr/hrlist?pageNo=" + pageNo;
	}
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
				<span class="fs-5 fw-bold">회원 > 채용 지원</span>
		    </div>
			<div id="hr_grid" class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
				<div>
					<div>
						<h3 style="text-align: center; font-weight: bold;">진행중인 채용 공고가 없습니다.</h3>
					</div>
					<div style="text-align: center; margin-top: 50px;">
						현재 진행중인 채용 공고가 없습니다.<br>
						채용 공고는 공지사항을 통해 알려드리니, 주기적인 확인 부탁드립니다.
					</div>
				</div>
			</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
