<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- <link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}"> --%>
<jsp:include page="../include/stylescript.jsp" />

<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

	$().ready (function() {
		
		$("#new_btn").click(function() {
			$.post("${context}/mbr/api/rv/create",		
					{
						rvId:$("#rvId").val(),			
						mbrId:$("#mbrId").val(),
						odrLstId:$("#odrLst").val(),
						rvTtl:$("#rvTtl").val(),
						rvCntnt:$("#rvCntnt").val(),
						rvLkDslk:$("#rvLkDslk").val(),		
						
					}, function(response) {
						if (response.status == "200 OK") {
							Swal.fire({
						    	  icon: 'success',
						    	  title: '리뷰가 등록되었습니다.',
						    	  showConfirmButton: true,
						    	  confirmButtonColor: '#3085d6'
							}).then((result)=>{
								if(result.isConfirmed){
									location.href = "${context}/mbr/rv/list" + response.redirectURL;
								}
							});
							/* alert("리뷰가 등록되었습니다.") */
						}
						else {
							Swal.fire({
						    	  icon: 'error',
						    	  title: response.message,
						    	  showConfirmButton: false,
						    	  timer: 2500
							});
							/* alert(response.errorCode + " / " + response.message); */
						}	
						
					});				
		});			
	});		
</script>
</head>
<body class="scroll">
<jsp:include page="../include/header_user.jsp" />
	<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">리뷰 > 리뷰관리 > 리뷰등록</span>
	</div>
	<div class="bg-white rounded shadow-sm" style="padding: 30px 50px; margin:20px; width:100%;">
		<h2 class="fw-bold" style="margin: 20px; display: flex; flex-direction: row-reverse;">구매후기</h2>				
		<form id="create_form" method="post">
			<div class="create-group">
				<label for="odrLst" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">주문서 ID</label> 
				<select id="odrLst" style="width:40%;"
						class="form-control"name="odrLst">
					<c:choose>
						<c:when test="${not empty odrLst}">
							<c:forEach items="${odrLst}"
									   var="rv">
									<option value="${rv.odrLstId}" ${rv.odrLstId eq odrLstId ? 'selected' : '' }>
										${rv.odrLstId}
									</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>
			</div>    
			<div class="create-group">
				<label for="rvTtl" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">제목</label> <input type="text" id="rvTtl"
					name="rvTtl" 
					style="margin:5px; width: 100%;"
					class="form-control" maxlength="50"
					placeholder="제목을 입력하세요(50자 제한)" />
			</div>
			<div class="create-group">
				<label for="rvCntnt" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">내용</label> 
				<textarea id="rvCntnt"
					name="rvCntnt" 
					style="display: grid; margin: 5px; height: 400px; resize: none;"
					maxlength="1000" class="form-control"
					placeholder="내용을 입력하세요(1000자 제한)" ></textarea>
			</div>
			<div class="create-group">
				<label for="rvLkDslk" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">좋아요/싫어요</label>
				<select id="rvLkDslk"
					style="margin: 5px; width:20%" class="form-select" 
					name="rvLkDslk">
					<option>선택</option>
					<option value="T">좋아요</option>
					<option value="F">싫어요</option>
				</select>
				<div class="align-right">
					<button type="button" id="new_btn" class="btn btn-outline-primary">등록</button>
				</div>
			</div>					
		</form>
	</div>
</body>
<%-- <jsp:include page="../include/footer_user.jsp" /> --%>
</html>