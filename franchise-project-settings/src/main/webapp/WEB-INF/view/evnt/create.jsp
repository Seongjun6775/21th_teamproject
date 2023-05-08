<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Random"%> 
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 등록 페이지</title>
<%-- <link rel="stylesheet" href="../css/evntCommon.css?p=${date}"> --%>
<jsp:include page="../include/stylescript.jsp" />
<%-- <link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" /> --%>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${context}/js/AjaxUtil.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	
	// 1. 등록 버튼을 누르면 수행할 내용
	$("#btn-create").click(function(){
		var evntTtl = document.getElementById("evntTtl").value;
		var evntCntnt = document.getElementById("evntCntnt").value;
		var evntStrtDt = document.getElementById("evntStrtDt").value;
		var evntEndDt = document.getElementById("evntEndDt").value;
		var orgnFlNm = document.getElementById("orgnFlNm").value;
		
		if (evntTtl == ""){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '이벤트 제목을 입력해주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("이벤트 제목을 입력해주세요."); */
			return;
		}
		if (evntCntnt == ""){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '이벤트 내용을 입력해주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("이벤트 내용을 입력해주세요."); */
			return;
		}
		if (evntStrtDt == ""){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '이벤트 시작일자를 입력해주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("이벤트 시작일자를 입력해주세요."); */
			return;
		}
		if (evntEndDt == ""){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '이벤트 종료일자를 입력해주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("이벤트 종료일자를 입력해주세요."); */
			return;
		}
		if (orgnFlNm == ""){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '사진을 등록해주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("사진을 등록해주세요."); */
			return;
		}
		if(evntStrtDt > evntEndDt){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '잘못된 날짜 입력',
		    	  html: "시작일자("+evntStrtDt+")<br/>종료일자("+evntEndDt+")",
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("시작일자("+evntStrtDt+")가 종료일자("+evntEndDt+")보다 큽니다"); */
			return;
		}
		
		var ajaxUtil = new AjaxUtil();
		ajaxUtil.upload("#form-create" , "${context}/api/evnt/create", function(response) {
			if (response.status == "200 OK") {
				console.log("200임")
				Swal.fire({
			    	  icon: 'success',
			    	  title: response.message,
			    	  showConfirmButton: true,
			    	  confirmButtonColor: '#3085d6'
				}).then((result)=>{
					if(result.isConfirmed){
						location.href = "${context}/evnt/list";
					}
				});
				/* alert(response.message); */
				
				//location.reload(); // 새로고침
			} else {
				console.log("안됨")
				Swal.fire({
			    	  icon: 'error',
			    	  title: response.message,
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert(response.errorCode + " / " + response.message); */
			}
		}, {"orgnFlNm" : "uploadFile"})
	});
	
	
	//'돌아가기'버튼 누르면 뒤로 돌아가기
	$("#btn-cancle").click(function() {
		//location.href="${context}/evnt/list3"
		history.pushState(null, null, '${context}/evnt/list');
	});
});
	
	
	
	function check(box) {
		if (box.checked == true) {
			box.value = "Y";
		} else {
			box.value = "N";
		}
	}
</script>
 <style>
.btn-default {
    border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
}
</style>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">이벤트 > 이벤트 등록</span>
	    </div>
	    <div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<h5 class="fs-5 fw-bold" style="padding:20px">이벤트 등록</h5>
			<form id="form-create" enctype="multipart/form-data">
				<input type="hidden" id="evntId"
							style="width: 99%;" readonly="readonly" placeholder="이벤트ID는 입력할 수 없습니다."value=""  />
				<div style="margin: 20px;">
					<div style="margin-bottom: 15px">
						<div style="display:inline-block;width: 20%;">
							<div class="input-group" >
								<span class="input-group-text">시작일</span>
								<input type="date" id="evntStrtDt" class="form-control" value="" />
							</div>
						</div>
						<div style="display:inline-block; width: 20%; margin-right: 140px;">
							<div class="input-group">
								<span class="input-group-text">종료일</span>
								<input type="date" id="evntEndDt" class="form-control" value="" />
							</div>
						</div>
						<div style="display:inline-block; width: 50%;">
							<div class="input-group">
								<span class="input-group-text">이벤트사진</span>
								<input type="file" name="orgnFlNm" id="orgnFlNm" class="form-control"
									   value="" accept="image/png, image/jpeg" />					
							</div>
						</div>
					</div>
					
					<div class="input-group" style="margin-bottom: 15px">
						<span class="input-group-text">이벤트제목</span>
						<input type="text" id="evntTtl"class="form-control"value="" />
					</div>
					
					<div class="input-group" style="margin-bottom: 15px">
						<span class="input-group-text">이벤트내용</span>
						<textarea id="evntCntnt" class="form-control" 
							style="height: 200px; resize: none;" /></textarea>
					</div>

				
				



					
						<div style="float:right; margin-top: 40px;" >
							<div style="display:inline-block; margin-right:10px;">
								<label class="form-check-label">사용여부</label>
								<input  class="form-check-input"  type="checkbox" id="useYn" onClick="check(this)" value=""/>		
							</div>
							<button type="button" id="btn-create" class="btn btn-outline-primary btn-default">등록</button>
							<button id="btn-cancle" class="btn btn-outline-danger btn-default">취소</button>
						</div>

			</div>
		</form>
	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>