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
	$().ready(function(){
		
		function Salert(str){
			Swal.fire({
		    	  icon: 'error',
		    	  title: str,
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
		}
		
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

</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/strMgmtSideMenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<!-- 조회영역 -->
			<div class="grid">
				<div class="detail-header">
					<h1>점원 조회</h1>
				</div>
				<div class="detail-content">
					<div class="content-block">
						<div class="content-subject">
							<h1>아이디</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrId}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>이름</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrNm}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>이메일</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrEml}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>소속</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.strVO.strNm}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>직급</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" value="${mbr.cmmnCdVO.cdNm}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>이력서</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" style="width:200px;" value="${empty mbr.hrVO.orgnFlNm ? '파일이 없습니다.' : mbr.hrVO.orgnFlNm}"/>
								<c:choose>
									<c:when test ="${empty mbr.hrVO.hrId}">
										<a href="javascript:Salert('파일이 없습니다.')"><i class='bx bx-file'></i></a>
									</c:when>
									<c:otherwise>
										<a href="#" id="fileDown"><i class='bx bx-file'></i></a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>최근 로그인</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrRcntLgnDt}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>차단 여부</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrLgnBlckYn}"/>
							</div>
						</div>
					</div>
					<div class="content-block">
						<div class="content-subject">
							<h1>가입일?</h1>
						</div>
						<div class="content-items">
							<div class="item">
								<input type="text" readonly value="${mbr.mbrRgstrDt}"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>