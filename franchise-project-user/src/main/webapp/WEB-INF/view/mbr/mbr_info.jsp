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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript">
	$().ready(function(){
		var valueUtil = new ValueUtil();
		var originNm = "${myMbr.getMbrNm()}";
		
		$("#info_mbrNm").keyup(function(){
			var mbrNm = $(this).val();
			mbrNm = mbrNm.replace(/\s/gi, "");
			$("#info_mbrNm").val(mbrNm);
		});
		
		$("#update_info_btn").click(function(event){
			event.preventDefault();
			var mbrNm = $("#info_mbrNm").val();
			if(!valueUtil.requires("#info_mbrNm")){
				return;
			}
			if(originNm == info_mbrNm){
				Swal.fire({
			    	  icon: 'error',
			    	  title: '변경된 부분이 없습니다.',
			    	  text: resp.status,
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				alert("변경된 부분이 없습니다.");
				return;
			}
			$.post("${context}/mbr/update", $("#info_form").serialize(), function(resp){
				if(resp.status =="200 OK"){
					Swal.fire({
				    	  icon: 'success',
				    	  title: '비밀번호가 변경되었습니다.',
				    	  showConfirmButton: true,
				    	  confirmButtonColor: '#3085d6'
					}).then((result)=>{
						if(result.isConfirmed){
							location.href="${context}"+resp.redirectURL;
						}
					});
				}
				else{
					Swal.fire({
				    	  icon: 'error',
				    	  title: resp.message,
				    	  text: resp.status,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					alert(resp.message);
				}
			});
		});
		$("#update_pwd_btn").click(function(event){
			location.href="${context}/mbr/change/pwd";
		});
		$("#signout_mbr_btn").click(function(event){
			Swal.fire({
				  title: '회원탈퇴', 
				  text: '회원탈퇴 하시겠습니까?',
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  cancelButtonText: '취소',
				  confirmButtonText: '회워탈퇴'
				}).then((result) => {
					if(result.isConfirmed){
						$.get("${context}/mbr/signout", function(resp){
							if(resp.status == "200 OK"){
								Swal.fire({
							    	  icon: 'success',
							    	  title: '정상적으로 탈퇴되었습니다.',
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
</head>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />
		<div class="visualArea flex relative">
			<div class="content-setting title">회원</div>
			<div class="overlay absolute"></div>
		</div>
		<div id="menu" class="flex-column">	
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">회원 > 회원정보 > 회원정보</span>
		    </div>
	    	<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px; margin: auto;width:270px; height:220px;  display: flex; justify-content: center; align-items: center;">
	    		<div class="infoGroup">
					<h5>회원정보</h5>
					<div style="width: 291px; text-align: center;">
					<form id="info_form" class="">
								<input type="hidden" id="isModify" value="false"/>
								<div class="input-group">
									<span class="input-group-text">&nbsp;ID&nbsp;&nbsp;</span>
									<input type="text" class="readonly form-control" id="mbrId" name="mbrId" readonly value="${myMbr.getMbrId()}" />
								</div>
								<div class="input-group">
									<span class="input-group-text">이름</span>
									<input type="text" class="form-control" id="info_mbrNm" name="mbrNm" value="${myMbr.getMbrNm()}" data-field-name="이름" />
								</div>
								<div class="input-group">
									<span class="input-group-text">&nbsp;@&nbsp;&nbsp;</span>
									<input type="email" class="readonly form-control" id="mbrEml" name="mbrEml" readonly value="${myMbr.getMbrEml()}" />
								</div>
								<div class="input-group">
									<span class="input-group-text">회원등급</span>
									<input type="text" class="readonly form-control" id="mbrLvl" readonly value="${myMbr.getMbrLvl() eq '001-04' ? '이용자' : '관리자'}" />
								</div>
								<div class="input-group" style="margin-bottom: 10px;">
									<span class="input-group-text">이력서</span>
									<input type="text" class="readonly form-control" id="mbrPyMn" readonly value="${myMbr.getMbrPyMn()}" />
								</div>
						</form>
						
							<button class="btn btn-outline-primary" id="update_info_btn">수정</button>
							<button class="btn btn-outline-secondary" id="update_pwd_btn">비밀번호 변경</button>
							<button class="btn btn-outline-danger" id="signout_mbr_btn">회원탈퇴</button>
						</div>

				</div>
	    	</div>
    	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>