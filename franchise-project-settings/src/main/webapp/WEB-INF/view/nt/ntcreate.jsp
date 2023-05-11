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
<link rel="stylesheet" href="${context}/css/ntcommon.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">

	var mbr;
	function addMbrFn(search){
		$("#rcvrId").val(search.mbrid);
		if($("#rcvrId").val() == "${mbrVO.mbrId}") {
			Swal.fire({
		    	  icon: 'error',
		    	  title: '자신에게 쪽지를 보낼 수 없습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("자기 자신에게 쪽지를 보낼 수 없습니다!"); */
			return;
		}
	}

	$().ready(function() {
		
		$("#crt_btn").click(function() {
			// 자기 자신에게 쪽지를 보낼 수 없도록 제한했습니다.
			// 굳이 막을 이유는 없지 않나 싶어서 고민했는데, 일단 막아 두고 나중에 필요 없다 싶으면 지우겠습니다.
			if ($("#rcvrId").val() == $("#sndrId").val()) {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '자신에게 쪽지를 보낼 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("자기 자신에게 쪽지를 보낼 수 없습니다!") */
				return;
			}
			Swal.fire({
				  title: '쪽지보내기',
				  text: '쪽지를 전송하시겠습니까?',
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  cancelButtonText: '취소',
				  confirmButtonText: '전송'
				}).then((result) => {
					if(result.isConfirmed){
						$.post("${context}/api/nt/create", $("#nt_form").serialize(), function(response){
							
							if (response.status == "200 OK") {
								Swal.fire({
							    	  icon: 'success',
							    	  title: '정상적으로 전송되었습니다.',
							    	  showConfirmButton: true,
							    	  confirmButtonColor: '#3085d6'
								}).then((result)=>{
									if(result.isConfirmed){
										location.href="${context}/nt/ntmstrlist";
									}
								});
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
					}else{
						Swal.fire({
					    	  icon: 'success',
					    	  title: '취소 되었습니다.',
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						return;
					}
			});

		});
		
		$("#cancel_btn").click(function() {
			
			Swal.fire({
				  title: '취소',
				  text: '쪽지 작성을 취소하시겠습니까?',
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  cancelButtonText: '취소',
				  confirmButtonText: '작성취소'
				}).then((result) => {
					if(result.isConfirmed){
						location.href="${context}/nt/ntmstrlist";
					}else{
						Swal.fire({
					    	  icon: 'success',
					    	  title: '취소 되었습니다.',
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						return;
					}
			});
		});
		
		$("#rcvrId").click(function() {
			event.preventDefault();
			mbr = window.open("${context}/mbr/search", "회원 검색", "width=700, height=650");
		});
		
		
	});

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
		<span class="fs-5 fw-bold">쪽지 > 쪽지 관리 > 쪽지 작성</span>
	</div>	
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<form id="nt_form">
					<div class="input-group" style="display: none; flex-direction: row; margin-bottom: 4px;">
						<label for="sndrId" class="col-form-label" style="padding: 5px;  border-left: solid #ffbe2e; ">발신인</label>
						<div>
							<input type="text" id="sndrId" name="sndrId" value="${mbrVO.mbrId}" class="form-control" style="display: inline;"readonly/>
						</div>
					</div>
					<div class="input-group" style="display: flex; flex-direction: row; margin-bottom: 20px;">
						<label for="rcvrId" class="col-form-label" style="padding: 5px; border-left: solid #ffbe2e;">수신인</label>
						<div>
							<input type="text" id="rcvrId" name="rcvrId" value="${rcvrId}" class="form-control" placeholder="클릭 시 회원 검색"/>
						</div>
					</div>
					<div style="margin-bottom: 5px;">
						<label for="ntTtl" style="padding: 5px; border-left: solid #ffbe2e;margin-bottom:10px;">쪽지</label>
						<input type="text" id="ntTtl" name="ntTtl" class="form-control" placeholder="쪽지 제목"/>
					</div>
					<div>
						<textarea id="ntCntnt" name="ntCntnt" maxlength="4000" placeholder=""
								  class="form-control"  style="word-break: bredk-all; resize:none;"></textarea>
					</div>
				</form>
				<div style="float: right; margin:10px">
					<button id="crt_btn" class="btn btn-outline-secondary btn-default">작성</button>
					<button id="cancel_btn" class="btn btn-outline-danger btn-default">취소</button>
				</div>
			</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
