<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">
	function Salert(str){
		Swal.fire({
	    	  icon: 'error',
	    	  title: str,
	    	  showConfirmButton: false,
	    	  timer: 2500
		});
	}
	$().ready(function(){
		
		
		
		$("#fileDown").click(function(){
			$.get("${context}/hr/hrfile/${mbr.hrVO.hrId}", function(resp){
				if(resp.status == "200 OK"){
					location.reload();
				}
				else{
					Swal.fire({
				    	  icon: 'error',
				    	  title: resp.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
			    	});
					/* alert(resp.message); */
					location.reload();
				}
			});
		});
	});
</script>
<style>
	.input-group{
		width: 300px;
		margin-top: 15px;
	}
</style>
</head>
<jsp:include page="../include/openBody.jsp" />
<!-- contents -->
	<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">매장 > 조회 > 매장직원 조회</span>
    </div>
<!-- /contents -->
<div class="admin_table_grid bg-white rounded shadow-sm" style="margin: 20px;padding: 30px; height: auto;">
	<div class="rounded" style="margin: 20px;">
		<div class="row" style="justify-content: space-between; margin: 0px;">
			<div class="main-layout">
		<div>
			<!-- 조회영역 -->
				<div class="detail-header">
					<h3>점원 조회</h3>
				</div>
				<div class="detail-content">
					<div class="input-group">
						<span class="input-group-text">&nbsp;ID&nbsp;&nbsp;</span>
						<input type="text" id="mbrId" name="mbrId" class="form-control" readonly value="${mbr.mbrId}">
					</div>

					<div class="input-group">
						<span class="input-group-text">이름</span>
						<input type="text" class="form-control" readonly value="${mbr.mbrNm}">
					</div>

					<div class="input-group col-12">
						<span class="input-group-text">&nbsp;@&nbsp;&nbsp;</span>
						<input type="text" class="form-control" readonly value="${mbr.mbrEml}">
					</div>
					
					<div class="input-group col-12">
						<span class="input-group-text">소속</span>
						<input type="text" class="form-control rounded-end" readonly value="${mbr.strVO.strNm}">
					</div>
					
					<div class="input-group col-12">
						<span class="input-group-text">직급</span>
						<input type="text" class="form-control rounded-end" readonly value="${mbr.cmmnCdVO.cdNm}">
					</div>
					
					<div class="input-group">
						<span class="input-group-text">이력서</span>
						<input type="text"  class="form-control"  value="${empty mbr.hrVO.orgnFlNm ? '파일이 없습니다.' : mbr.hrVO.orgnFlNm}">
						<c:choose>
							<c:when test ="${empty mbr.hrVO.hrId}">
								<a href='javascript:Salert("파일이 없습니다.")'><i class='bx bx-file' style="font-size: 30px;"></i></a>
							</c:when>
							<c:otherwise>
								<a href="#" id="fileDown"><i class='bx bx-file' style="font-size: 30px;"></i></a>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="input-group">
						<span class="input-group-text">최근 로그인</span>
						<input type="text"  class="form-control" readonly value="${mbr.mbrRcntLgnDt}">
					</div>

					<div class="input-group">
						<span class="input-group-text">차단여부</span>
						<input type="text" class="form-control" readonly value="${mbr.mbrLgnBlckYn}">
					</div>

					<div class="input-group">
						<span class="input-group-text">가입일</span>
						<input type="text" class="form-control" readonly value="${mbr.mbrRgstrDt}">
					</div>

				</div>
		</div>
	</div>
		</div>
	</div>
	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>