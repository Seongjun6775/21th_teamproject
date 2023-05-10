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
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/hr_common.css?p=${date}">
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		
		if ("${sessionScope.__MBR__.mbrId}" == "") {
			Swal.fire({
			     title: '로그인 필요',
			     text: "로그인이 필요합니다.\n로그인 하시겠습니까?",
			     icon: 'warning',
			     showCancelButton: true,
			     confirmButtonColor: '#3085d6',
			     cancelButtonColor: '#d33',
			     cancelButtonText: '취소',
			     confirmButtonText: '로그인'
			   }).then((result) => {
			      if(result.isConfirmed){
			         $("#img_btn").click();
			      }else{
			         $("#btn-modal-close").click();
			      }
			});
		}
		
		$("#cancel_btn").click(function() {
			Swal.fire({
			     title: '작성 취소',
			     text: "작성을 취소하시겠습니까?",
			     icon: 'warning',
			     showCancelButton: true,
			     confirmButtonColor: '#3085d6',
			     cancelButtonColor: '#d33',
			     cancelButtonText: '아니오',
			     confirmButtonText: '예'
			   }).then((result) => {
			      if(result.isConfirmed){
			    	  location.href="${context}/hr/hrlist";
			      }else{
			         return;
			      }
			});
		});
		
		$("#save_btn").click(function() {
			Swal.fire({
			     title: '지원서 작성',
			     text: "작성을 완료하시겠습니까?",
			     icon: 'warning',
			     showCancelButton: true,
			     confirmButtonColor: '#3085d6',
			     cancelButtonColor: '#d33',
			     cancelButtonText: '아니오',
			     confirmButtonText: '예'
			   }).then((result) => {
			      if(result.isConfirmed){
			    	  var ajaxUtil = new AjaxUtil();
						ajaxUtil.upload("#hr_form", "${context}/api/hr/create", function(response) {
							if (response.status == "200 OK") {
								Swal.fire({
							    	  icon: 'success',
							    	  title: '정상적으로 등록되었습니다.',
							    	  showConfirmButton: true,
							    	  confirmButtonColor: '#3085d6'
								}).then((result)=>{
									if(result.isConfirmed){
										location.href="${context}/hr/hrlist";
									}
								});
							}
							else if (response.status == "500") {
								Swal.fire({
							    	  icon: 'error',
							    	  title: response.message,
							    	  showConfirmButton: false,
							    	  timer: 2500
								});
								/* alert(response.message); */
							}
							else {
								Swal.fire({
							    	  icon: 'error',
							    	  title: response.message,
							    	  showConfirmButton: false,
							    	  timer: 2500
								});
								/* alert(response.message); */
							}
						}, {"hrFile": "uploadFile"});
			      }
			      else{
			         return;
			      }
			});
			
		});
		
		
		$('.bxs-file-plus').click(function(){
			$("#hrfile").click();
		});
	});
</script>
 <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">인재채용
			<div style="color: #ccc; padding-top: 10px;"></div>
		</div>
		<div class="overlay absolute"></div>
	</div>
			
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin:80px;">
			<h2 class="fw-bold" style="margin: 20px;">채용 ${mbrVO.mbrLvl == '001-01' ? '공지' : '지원'} 작성</h2>
			<div style="float: right; margin: 20px 0 20px 20px">
				<button id="save_btn" class="btn btn-success">작성</button>
				<button id="cancel_btn" class="btn btn-secondary">취소</button>
			</div>
			<form id="hr_form" enctype="multipart/form-data">
				<div>
					<div>
						<input type="hidden" id="ntcYn" value="${mbrVO.mbrLvl == '001-01' ? 'Y' : 'N' }">
					</div>
					<div class="input-group" style="display: none; flex-direction: row-reverse;">
						<div>
							<input type="text" id="mbrId" name="mbrId" value="${mbrVO.mbrId}" class="form-control" readonly />
						</div>
						<label class="col-form-label" style="padding-right: 8px; border-right: solid #ffbe2e;">작성자</label>
					</div>
					<div style="display: flex; display:inline-block ; margin-bottom: 4px;">
						<!-- <i class='bx bx-message-square-add' style="font-size: 30px;"></i> -->
						<label for="hrFile" class="col-form-label" style=" border-left: solid #ffbe2e; padding:0 8px;">파일첨부</label> 
						<input type="file" accept=".hwp" id="hrFile" name="hrFile" class="form-control" style="width: 76%; display:inline-block"/>
					</div>
					<div style="margin-bottom: 4px; display:  ${mbrVO.mbrLvl == '001-01' ? 'none' : 'flex' }">
						<label for="hrLvl" class="col-form-label" style="padding: 5px; border-left: solid #ffbe2e; margin-right: 7px;">지원 직군</label>
							<select id="hrLvl" name="hrLvl" class="form-select" style="width:200px; display:${mbrVO.mbrLvl == '001-01' ? 'none' : ''}">
								<option value=" ">직군을 선택하세요.</option>
								<option value="005-01">가맹점주</option>
								<option value="005-02">점원</option>
							</select>
					</div>
					<div style="display: ${mbrVO.mbrLvl == '001-01' ? 'inline-block' : 'none'}; margin-bottom: 4px; float:right;">
						<label for="hrDdlnDt" class="col-form-label" style="padding: 5px; border-left: solid #ffbe2e; margin-right:30px;">마감일</label>
						<input type="date" id="hrDdlnDt" name="hrDdlnDt" value="${hr.hrDdlnDt}" class="form-control" style="width: 150px; display:inline-block"/>
					</div>
					<div>
						<label for="hrTtl" class="col-form-label" style="margin-top: 5px; margin-bottom:5px; padding-left: 8px; border-left: solid #ffbe2e;">제목</label>
						<div>
							<input type="text" id="hrTtl" class="form-control" name="hrTtl" />
						</div>
					</div>
					<label for="hrCntnt" class="col-form-label" style="margin-top: 5px; padding-left: 8px; border-left: solid #ffbe2e;">본문</label>
					<div class="input-group">
						<textarea id="hrCntnt" name="hrCntnt"  maxlength="4000" style="margin-top: 0.5rem;  height: 500px; resize: none;"
								 placeholder="특이사항이 있다면 자유롭게 기술 부탁드립니다." class="form-control"></textarea>
					</div>
				</div>
			</form>
		</div>
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>
