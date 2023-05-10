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
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		var delYn = ("${hr.delYn}");
		var mbrId = ("${hr.mbrId}");
		var hrStat = ("${hr.hrStat}");
		
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
		
		$("#list_btn").click(function() {
			location.href="${context}/hr/hrlist";
		});
		
		$("#delete_btn").click(function() {

			if (delYn == 'Y') {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 삭제 처리된 글입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 삭제 처리된 글입니다."); */
				return;
			}
			
			if (mbrId != "${mbrVO.mbrId}") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '자기가 작성한 글만\n삭제할 수 있습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("자기가 작성한 글만 삭제할 수 있습니다."); */
				return;
			}
			
			if (hrStat == "002-02") {
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '현재 심사중인 지원입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("현재 심사중인 지원입니다."); */
				return;
			}
			
			Swal.fire({
			     title: '지원서 삭제',
			     text: "지원서를 삭제하시겠습니까?",
			     icon: 'warning',
			     showCancelButton: true,
			     confirmButtonColor: '#3085d6',
			     cancelButtonColor: '#d33',
			     cancelButtonText: '아니오',
			     confirmButtonText: '예'
			   }).then((result) => {
			      if(result.isConfirmed){
			    	  $.post("${context}/api/hr/delete/${hr.hrId}", function(response) {
							if (response.status == "200 OK") {
								Swal.fire({
							    	  icon: 'success',
							    	  title: '정상적으로 삭제되었습니다.',
							    	  showConfirmButton: true,
							    	  confirmButtonColor: '#3085d6'
								}).then((result)=>{
									if(result.isConfirmed){
										location.href="${context}/hr/hrlist";
									}
								});
								/* alert("정상적으로 삭제되었습니다."); */
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
			         return;
			      }
			});
			
		});
		
		$("#update_btn").click(function() {
			if (delYn == "Y") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 삭제된 글은\n수정할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 삭제된 글은 수정할 수 없습니다."); */
				return;
			}
			
			if (mbrId != "${mbrVO.mbrId}") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '자기가 작성한 글만\n수정할 수 있습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("자기가 작성한 글만 수정할 수 있습니다."); */
				return;
			}
			
			if (hrStat != "002-01") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '접수 상태의 게시글만\n수정할 수 있습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("접수 상태의 게시글만 수정할 수 있습니다."); */
				return;
			}
			
			location.href="${context}/hr/hrupdate/${hr.hrId}";
		});
		
		$("#fileDown").click(function(){
			
			var hrId = "${hr.hrId}";
			location.href="${context}/hr/hrfile/" + hrId;
		
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
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">인재채용
			<div style="color: #ccc; padding-top: 10px;"></div>
		</div>
		<div class="overlay absolute"></div>
	</div>
	
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px;  margin:80px;">
			<div style="float:right;">
				<button id="update_btn" class="btn btn-outline-primary btn-default" >수정</button>
				<button id="delete_btn" class="btn btn-outline-danger btn-default" style="margin-right:10px">삭제</button>
				<button id="list_btn" class="btn btn-secondary" >목록</button>
			</div>
			
			<div style="padding:10px;">
				<span class="fs-5 fw-bold">${hr.hrTtl}</span>
				<div class="hr_detail_header">(${hr.hrId})</div>
				
			</div>
			<div style="margin-top: 10px">
			
			<div style="border-bottom: 1px solid #e0e0e0; padding-bottom: 15px; text-align: right;">
				<div class="hr_detail_header">등록일 : ${hr.hrRgstDt}</div>
				<c:if test="${hr.ntcYn eq 'Y'}">
					<div class="hr_detail_header">마감일 : ${hr.hrDdlnDt}</div>
				</c:if>
				<div class="hr_detail_header">작성자 : ${hr.mbrId}</div>
				<div class="hr_detail_header">${hr.delYn == 'Y' ? '삭제 여부 : 삭제됨' : ''}</div>
			</div>
				<div style="padding:10px; ">
					<div class="bg-warning rounded bg-opacity-25 padding: 10px; margin: 10px;"> 
						<div style="display: ${hr.orgnFlNm == null ? '' : 'none'}; ">
							<div class="hr_detail_header">첨부파일 : 등록된 파일이 없습니다.</div>
						</div>
						<div style="display: ${hr.orgnFlNm == null ? 'none' : ''}; margin-bottom: 20px; padding: 10px;">
							<div class="hr_detail_header" style="display: inline-block;">첨부파일 : <span style="font-weight: bold;"><a href="${context}/hr/hrfile/${hr.hrId}">${hr.orgnFlNm}</a></span></div>
							<div class="hr_detail_header" style="display: inline-block;"> ${hr.flSize/1024}KB</div>
						</div>
					</div>
					<div style="padding: 10px;">
						<div>
							<textarea class="fw-semibold" 
									   style="margin-bottom: 100px; width: 600px; height:400px;
									          overflow: auto; word-break: break-all;
									          border: none; resize: none;" readonly>${hr.hrCntnt}</textarea>
						</div>
					</div>
				<div style="display: ${hr.ntcYn eq 'Y' ? 'none' : ''};">
					<div style="display: flex;align-content: center;flex-wrap: wrap; flex-direction: column;">
					<div class="card p-3">
					<ul class="list-group mb-3" style="width: 300px;">
				         <li class="list-group-item d-flex justify-content-between lh-sm">
				           <div>
				             <h6 class="my-0">지원 상태</h6>
				           </div>
				           <strong>
				            <c:choose>
							<c:when test="${hr.hrStat eq '002-01'}"><div>접수</div></c:when>
							<c:when test="${hr.hrStat eq '002-02'}"><div>심사중</div></c:when>
							<c:when test="${hr.hrStat eq '002-03'}"><div>심사완료</div></c:when>
							<c:otherwise></c:otherwise>
							</c:choose>
				           </strong>
				         </li>
				         <li class="list-group-item d-flex justify-content-between bg-light">
				           <div>
				             <h6 class="my-0">지원직군</h6>
				           </div>
				           <strong> ${hr.cdNm}</strong>
				         </li>
				
				         <li class="list-group-item d-flex justify-content-between lh-sm">
				           <div>
				             <h6 class="my-0">승인 여부 변경일자</h6>
				             <small class="text-muted">${hr.hrAprDt}</small>
				           </div>
				           <strong class="text-muted">${hr.hrAprYn}</strong>
				         </li> 
			         </ul>
					</div>
			       </div>
			    </div>
				</div>
			</div>
		</div>
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>
