<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/hr_mstr.css?p=${date}">
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("#list_btn").click(function() {
			location.href="${context}/mbr/rv/list";
		});
		
		$("#delete_btn").click(function(){
			
			if(confirm("정말 삭제하시겠습니까?")) {
				var form = $("<form></form>")
				var myMbrId = "${rvDetail.mbrId}";
				var myMbrLvl = "${sessionScope.__MBR__.mbrLvl}";
				var mbrId = "${sessionScope.__MBR__.mbrId}";
				if (myMbrLvl == "001-04" && myMbrId != mbrId) {
					alert("자신의 리뷰만 삭제 가능합니다.");
					return;		
				}
				$.post("${context}/mbr/api/rv/delete/${rvDetail.rvId}", function(response){
					if(response.status == "200 OK"){
						location.href = "${context}/mbr/rv/list" + response.redirectURL;
						alert("리뷰가 삭제되었습니다.")
					}
					else {
						alert(response.errorCode + "권한이 없습니다." + response.message);
					}
				})
			}
		});
	});
</script>
</head>
<%-- <jsp:include page="../include/openBody.jsp" /> --%>
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px; position: relative;">	
			<span class="fs-5 fw-bold"> 리뷰 > 리뷰목록 > 리뷰상세</span>
			<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-04'}">
			<div style="position: absolute; right: 0;top: 0; margin: 20px;">
				<button id="delete_btn" class="btn btn-danger">삭제</button>
				<button id="list_btn" class="btn btn-secondary" >목록</button>
			</div>
		</c:if>	
	    </div>		   		
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin:20px;">
			<div style="padding:10px;">
				<span class="fs-5 fw-bold">${rvDetail.rvTtl}</span>
				<div class="hr_detail_header">(${rvDetail.rvId})</div>
			</div>
			<div style="margin-top: 10px">
			
			<div style="border-bottom: 1px solid #e0e0e0; padding-bottom: 15px; text-align: right;">
				<div class="hr_detail_header">등록일 : ${rvDetail.rvRgstDt}</div>
				<div class="hr_detail_header">작성자 : ${rvDetail.mbrId}</div>
			</div>
				<div style="padding:10px;">

					<div style="padding: 10px;">
						<div class="fw-semibold" style="margin-bottom: 100px; height:220px; overflow: auto;">${rvDetail.rvCntnt}</div>
					</div>
				</div>
			</div>
		</div>		
<%-- <jsp:include page="../include/closeBody.jsp" /> --%>
</html>