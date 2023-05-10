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
<script type="text/javascript">
	$().ready(function(){
		var valueUtil = new ValueUtil();
		var originNm = "${myMbr.getMbrNm()}";
		
		$("#mbrNm").keyup(function(){
			var mbrNm = $(this).val();
			mbrNm = mbrNm.replace(/\s/gi, "");
			$("#mbrNm").val(mbrNm);
		});
		
		$("#update_info_btn").click(function(event){
			event.preventDefault();
			var mbrNm = $("#mbrNm").val();
			if(!valueUtil.requires("#mbrNm")){
				return;
			}
			if(originNm == mbrNm){
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '변경된 부분이 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
		    	});
				/* alert("변경된 부분이 없습니다."); */
				return;
			}
			$.post("${context}/api/mbr/update", $("#info_form").serialize(), function(resp){
				if(resp.status =="200 OK"){
					location.href="${context}"+resp.redirectURL;
				}
				else{
					Swal.fire({
				    	  icon: 'error',
				    	  title: resp.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
			    	});
					/* alert(resp.message); */
				}
			});
		});
		$("#update_pwd_btn").click(function(event){
			location.href="${context}/mbr/change/pwd";
		});
		$("#signout_mbr_btn").click(function(event){
			
			Swal.fire({
				  title: '회원탈퇴',
				  text: '회원탈퇴를 진행하시겠습니까?',
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  cancelButtonText: '취소',
				  confirmButtonText: '회원탈퇴'
				}).then((result) => {
					if(result.isConfirmed){
						$.get("${context}/api/mbr/signout", function(resp){
							if(resp.status == "200 OK"){
								Swal.fire({
							    	  icon: 'success',
							    	  title: '정상적으로 탈퇴되었습니다.',
							    	  text: '이용해 주셔서 감사합니다.',
							    	  showConfirmButton: true,
							    	  confirmButtonColor: '#3085d6'
								}).then((result)=>{
									if(result.isConfirmed){
										location.href="${context}"+resp.redirectURL;
									}
								});
							}else{
								Swal.fire({
							    	  icon: 'error',
							    	  title: resp.message,
							    	  showConfirmButton: false,
							    	  timer: 2500
						    	});
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
	});
</script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">회원 > 회원정보 > 정보수정</span>
    </div>
    <div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px; margin: auto;height: auto; width: 400px;  display: flex; justify-content: center; align-items: center;">
    	<div class="infoGroup">
    		<div>
    			<h5 class="mt-10">회원 정보</h5>
				<form id="info_form" class="needs-validation margin-Bot-10">
					<!-- 
						 isModity== true -> 수정(update)
						 isModity== false -> 등록(insert) 
					-->
					<input type="hidden" id="isModify" value="false"/>
					<div class="input-group mt-16">
						<span class="input-group-text">&nbsp;&nbsp;&nbsp;ID&nbsp;&nbsp;&nbsp;</span>
						<input type="text" id="mbrId" name="mbrId" class="form-control readonly" readonly value="${myMbr.getMbrId()}" >
					</div>
					<div class="input-group mt-16">
						<span class="input-group-text">&nbsp;이름&nbsp;&nbsp;</span>
						<input type="text" id="mbrNm" name="mbrNm" class="form-control" value="${myMbr.getMbrNm()}" data-field-name="이름" />
					</div>
					<div class="input-group mt-16">
						<span class="input-group-text">&nbsp;&nbsp;&nbsp;@&nbsp;&nbsp;&nbsp;</span>
						<input type="email" id="mbrEml" class="form-control readonly" readonly value="${myMbr.getMbrEml()}" >	
					</div>
					<div class="input-group mt-16">
						<span class="input-group-text">회원등급</span>
						<input type="text" id="mbrLvl" class="form-control readonly" readonly value="${myMbr.getCmmnCdVO().getCdNm()}" >
					</div>
					<div class="input-group mt-16">
						<span class="input-group-text">내지갑</span>
						<input type="text" id="mbrPyMn" class="form-control readonly" readonly value="${myMbr.getMbrPyMn()}" >
					</div>
				</form>
				<button class="btn btn-outline-primary btn-default" id="update_info_btn">수정</button>
				<button class="btn btn-outline-secondary btn-default" id="update_pwd_btn">비밀번호 변경</button>
				<button class="btn btn-outline-danger btn-default" id="signout_mbr_btn">회원탈퇴</button>
			</div>
		</div>
    </div>
<jsp:include page="../include/closeBody.jsp" />
</html>