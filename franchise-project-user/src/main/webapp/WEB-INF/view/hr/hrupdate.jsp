<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/hr_common.css?p=${date}">
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
		
		document.getElementById("hrDdlnDt").value = ("${hr.hrDdlnDt}").substring(0,10);
		
		$("#cancel_btn").click(function() {
			Swal.fire({
			     title: '수정 취소',
			     text: "수정을 취소하시겠습니까?",
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
			
			var hrDdlnDt = document.getElementById("hrDdlnDt").value;
			
			Swal.fire({
			     title: '지원서 수정',
			     text: "수정을 완료하시겠습니까?",
			     icon: 'warning',
			     showCancelButton: true,
			     confirmButtonColor: '#3085d6',
			     cancelButtonColor: '#d33',
			     cancelButtonText: '아니오',
			     confirmButtonText: '예'
			   }).then((result) => {
			      if(result.isConfirmed){
			    	  var ajaxUtil = new AjaxUtil();
						ajaxUtil.upload("#hr_form", "${context}/api/hr/update/${hr.hrId}", function(response) {
							if (response.status == "200 OK") {
								Swal.fire({
							    	  icon: 'success',
							    	  title: '정상적으로 수정되었습니다.',
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
			      }else{
			         return;
			      }
			});
			
		});
		
		$("a[id='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
		
	});
	
    function deleteFile(obj) { 
        obj.parent().remove();
        var str = "<div class='file-input' style='float:right;'><input type='file' id='hrFile' class='form-control' name='hrFile'/></div>";
        $("#file-list").append(str);
    }
	
</script>

<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
} 

#menu {
/* 	background-color: #F002; */
	width: 1440px;
	margin: 0 auto;
	margin-bottom: 144px;
}
</style>

</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div style="background: url(../../img/붕어bg.jpg) 50% 50% no-repeat; background-size: 100% auto;
				height: 200px; display: flex; position: relative;">
		<div style="width: 1440px; margin: 0 auto; padding: 24px 0;
					font-weight: bold; font-size: 26pt; color: white;
					z-index: 1; align-self: center;">인재채용
			<div style="color: #ccc; padding-top: 10px;"></div>
		</div>
		<div style="width: 100%; height: 100%; background-color: #00000065; position: absolute;"></div>
	</div>
	<div id="menu">
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 25px 18px; overflow: auto; ">
			<h2 class="fw-bold" style="margin: 20px;">채용 ${mbrVO.mbrLvl == '001-01' ? '공지' : '지원'} 수정</h2>
			<form id="hr_form" enctype="multipart/form-data">
				
				<div>
					<input type="hidden" id="ntcYn" value="${hr.ntcYn}">
				</div>
				
				<div class="input-group" style="display: none; flex-direction: row-reverse;">
					<div>
						<input type="text" id="mbrId" name="mbrId" value="${mbrVO.mbrId}" class="form-control" readonly />
					</div>
					<label class="col-form-label" style="padding-right: 8px; border-right: solid #ffbe2e;">작성자</label>
				</div>
				<div class="input-group" style="display: ${mbrVO.mbrLvl == '001-01' ? 'flex' : 'none'}; flex-direction: row; margin-bottom: 4px;">
					<label for="hrDdlnDt" class="col-form-label" style="padding: 5px; border-left: solid #ffbe2e; margin-right:30px;">마감일</label>
					<div>
						<input type="date" id="hrDdlnDt" name="hrDdlnDt" value="${hr.hrDdlnDt}" class="form-control"/>
					</div>
				</div>
				<div style="display: flex; flex-direction: row; margin-bottom: 4px;">
					<%-- <label for="hrFile" class="col-form-label" style="padding: 4px; border-left: solid #ffbe2e; margin-right:15px;">파일첨부</label>
					<label for="hrFile" class="form-control" style="width: 50%">
						<span style="padding: 8.5px; padding-left: 0px; border-right: 1px solid #aaac;">파일첨부</span>
						<span style="padding-left: 2px; font-weight: bold;">${hr.orgnFlNm}</span>
						<span style="padding-left: 2px; padding-right: 2px;"><fmt:formatNumber type="number" value="${hr.flSize/1024 > 0 ? hr.flSize/1024 : ''}" maxFractionDigits="2"/></span>KB
					</label>
					<input type="file" id="hrFile" name="hrFile" style="display: none;" /> --%>
					<div class="file-group" id="file-list" >
						<label for="hrFile" class="col-form-label" style="padding: 4px; border-left: solid #ffbe2e; margin: 5px 15px 0px 0;">파일첨부</label>
					    <div class="file-input" style="display: inline-block;">
					    	  ${hr.orgnFlNm eq null ? '파일이 없습니다' : hr.orgnFlNm}
					    	  <span><fmt:formatNumber type="number" value="${hr.flSize/1024 > 0 ? hr.flSize/1024 : ''}" maxFractionDigits="2"/></span>
					    	  <span>${hr.orgnFlNm eq null ? '' : 'KB'}</span>
					      <a href='#this' id='file-delete'>${hr.orgnFlNm eq null ? '파일 추가' : '삭제'}</a>
					    </div>
					</div>
				</div>
				<div style="margin-bottom: 4px; display:  ${mbrVO.mbrLvl == '001-01' ? 'none' : 'flex' }">
					<label for="hrLvl" class="col-form-label" style="padding: 5px; border-left: solid #ffbe2e; margin-right: 7px;">지원 직군</label>
					<select id="hrLvl" class="form-select" style="width:15%;">
						<option value="" selected>직군을 선택하세요.</option>
						<option value="005-01" ${hr.hrLvl == '005-01' ? 'selected' : ''}>가맹점주</option>
						<option value="005-02" ${hr.hrLvl == '005-02' ? 'selected' : ''}>점원</option>
					</select>
				</div>
				<div>
					<label for="hrTtl" class="col-form-label" style="margin-bottom: 4px; padding-left: 8px; border-left: solid #ffbe2e;">제목</label>
					<div>
						<input type="text" id="hrTtl" class="form-control" name="hrTtl" value="${hr.hrTtl}"  />
					</div>
				</div>
			     
				<label for="hrCntnt" class="col-form-label" style="margin-bottom: 4px; margin-top: 4px; padding-left: 8px; border-left: solid #ffbe2e;">본문</label>
				<div class="input-group">
					<textarea id="hrCntnt" name="hrCntnt"  maxlength="4000" style="margin-top: 0.5rem;  height: 500px; resize: none;"
							 placeholder="특이사항이 있다면 자유롭게 기술 부탁드립니다." class="form-control">${hr.hrCntnt}</textarea>
				</div>
				<div style="float: right; margin-top: 15px;" >
					<button type="button" id="save_btn" class="btn btn-outline-primary btn-default" >수정</button>
					<button type="button" id="cancel_btn" class="btn btn-outline-danger btn-default">취소</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>
