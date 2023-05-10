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
<%-- <link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}"> --%>
<jsp:include page="../include/stylescript.jsp" />

<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

	$().ready(function() {
		
		$("#list_btn").click(function() {
			location.href="${context}/user/rv/list";
		});
		
		$("#delete_btn").click(function(){
			
			if(confirm("정말 삭제하시겠습니까?")) {
				var form = $("<form></form>")
				var myMbrId = "${rvDetail.mbrId}";
				var myMbrLvl = "${sessionScope.__MBR__.mbrLvl}";
				var mbrId = "${sessionScope.__MBR__.mbrId}";
				if (myMbrLvl == "001-04" && myMbrId != mbrId) {
					Swal.fire({
				    	  icon: 'error',
				    	  title: '자신의 리뷰만 삭제 가능합니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert("자신의 리뷰만 삭제 가능합니다."); */
					return;		
				}
				$.post("${context}/api/rv/delete/${rvDetail.rvId}", function(response){
					if(response.status == "200 OK"){
						Swal.fire({
					    	  icon: 'success',
					    	  title: '리뷰가 삭제되었습니다.',
					    	  showConfirmButton: true,
					    	  confirmButtonColor: '#3085d6'
						}).then((result)=>{
							if(result.isConfirmed){
								location.href = "${context}/user/rv/list" + response.redirectURL;
							}
						});
						/* alert("리뷰가 삭제되었습니다.") */
					}
					else {
						Swal.fire({
					    	  icon: 'error',
					    	  title: response.message,
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						/* alert(response.errorCode + "권한이 없습니다." + response.message); */
					}
				})
			}
		});
	});
</script>
<style>
.label-left-border{
	padding: 5px;
	border-left: solid #ffbe2e;
}
 .half-left , .half-right {
	width: 50%;
	display: inline-block;
}

.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
}
.ntc-label{ 
    border: 1px solid;
    padding: 3px 8px;
    border-radius: 5px;
}
</style>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">리뷰</div>
		<div class="overlay absolute"></div>
	</div>
	<div style="background-color: #ccc; height: 250px; display: flex;align-items: center;">
		<p style="margin: 0 auto; color: #fff; font-weight: bold; font-size: 20px;">변화를 만나는 곳, 변화를 만드는 곳.<br>프랜차이즈의 리뷰를 작성해보세요. </p>
	</div>
	<div id="menu" class="flex-column">	
							
		<div class="bg-white rounded shadow-sm" style="padding: 60px;  margin:20px; position: relative;">
			<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrId eq rvDetail.mbrId }">
				<div style="position: absolute; right: 0;top: 0; margin: 20px;">
					<button id="delete_btn" class="btn btn-outline-danger btn-default">삭제</button>
					<button id="list_btn" class="btn btn-secondary" >목록</button>
				</div>
			</c:if>	
			<h2 class="fw-bold" style="margin: 30px 30px 80px 30px;">구매후기</h2>
			<div class="flex">
				<div class="input-group" style="flex: 1; margin-top: 10px;">
					<label for="prdtCntnt" class="col-form-label">상품이름</label>
					<div>
						<textarea id="prdtCntnt" style="height:20px; resize: none; width: 45.5%;" readonly
								class="form-control">${rvDetail.prdtVO.prdtNm} 외 ${odrDtl.size() -1}건</textarea> 
					</div>
				</div>
			</div>
			<div class="half-right">
				<div class="input-group">
					<label for="prdtNm" class="col-form-label">제목</label>
					<div>
						<input type="text" class="form-control" readonly value="${rvDetail.rvTtl}"/>
					</div>
				</div>
				<div class="input-group">
					<label for="prdtNm" class="col-form-label">평가</label> 
					<div>
						<input type="text" id="rvLkDslk" name="rvLkDslk" class="form-control fw-bold" readonly style="color:${rvDetail.rvLkDslk eq 'T' ? '#00f' : '#f00'};" value="${rvDetail.rvLkDslk eq 'T' ? '좋아요!' : '싫어요!'}">
					</div>
				</div>
				<div class="input-group" style="flex: 1;">
					<label for="prdtCntnt" class="col-form-label" style="height: 40px;">내용</label>
					<div>
						<textarea id="prdtCntnt" style="height:220px; resize: none;" readonly
								class="form-control">${rvDetail.rvCntnt}</textarea>
					</div>
				</div>
			</div>
		</div>
	</div>					
	
<jsp:include page="../include/footer_user.jsp" />
</body>
</html>