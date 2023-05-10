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
<link rel="stylesheet" href="${context}/css/hr_mstr.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">
	$().ready(function() {
		
		$.ajaxSetup({
			  beforeSend: function() {
				  $("#overlay").show();
			  },
			  complete: function() {
				  $("#overlay").hide();
			  }
		});
		
		var delYn = "${hr.delYn}";
		var mbrId = "${hr.mbrId}";
		var aprYn = "${hr.hrAprYn}";
		var ntcYn = "${hr.ntcYn}";
		
		console.log("${hr.hrAprYn}");
		
		
		$("#list_btn").click(function() {
			location.href="${context}/hr/list";
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
			    	  title: '자기가 작성한 글만 삭제할 수 있습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("자기가 작성한 글만 삭제할 수 있습니다."); */
				return;
			}
			
			Swal.fire({
			     title: '지원서 삭제',
			     text: "정말 삭제하시겠습니까?",
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
										location.href="${context}/hr/list";
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
			    	  title: '이미 삭제된 글은 수정할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 삭제된 글은 수정할 수 없습니다."); */
				return;
			}
			
			if (mbrId != "${mbrVO.mbrId}") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '다른 사람의 글은 수정할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("다른 사람의 글은 수정할 수 없습니다."); */
				return;
			}
			
			location.href="${context}/hr/hrupdate/${hr.hrId}";
		});
		
		$("#hrApr_Y_btn").click(function() {
			if (ntcYn == "Y") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '공지 게시글은 채용처리할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("공지 게시글은 채용 처리를 할 수 없습니다!"); */
				return;
			}
			
			if (delYn == "Y") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 삭제된 글은 채용 처리할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 삭제된 글은 채용 처리할 수 없습니다."); */
				return;
			}
			
			if (aprYn != null && aprYn != "") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 채용/미채용 처리된 건입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 채용/미채용이 완료된 건입니다.") */
				return;
			}
			
			if (!confirm("정말 채용하시겠습니까?")) {
				return;
			}
			var form = $("<form></form>");
			form.append("<input type='hidden' name='mbrVO.mbrId' value='${hr.mbrId}'>");
			form.append("<input type='hidden' name='hrLvl' value='${hr.hrLvl}'>");
			form.append("<input type='hidden' name='hrId' value='${hr.hrId}'>");
			form.append("<input type='hidden' name='hrAprYn' value='Y'>");
			
			
			$.post("${context}/api/hr/updateapr", form.serialize(), function(response) {
				if (response.status == "200 OK") {
					Swal.fire({
				    	  icon: 'success',
				    	  title: '정상적으로 채용처리 되었습니다.',
				    	  showConfirmButton: true,
				    	  confirmButtonColor: '#3085d6'
					}).then((result)=>{
						if(result.isConfirmed){
							location.href = "${context}/hr/hrmstrdetail/${hr.hrId}";
						}
					});
					/* alert("정상적으로 채용 처리 되었습니다."); */
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
		
		$("#hrApr_N_btn").click(function() {
			if (ntcYn == "Y") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '공지 게시글은 채용 처리할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("공지 게시글은 채용 처리를 할 수 없습니다!"); */
				return;
			}
			
			if (delYn == "Y") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 삭제된 글은 미채용 처리할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 삭제된 글은 미채용 처리할 수 없습니다."); */
				return;
			}
			
			if (aprYn != null && aprYn != "") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 채용/미채용 처리된 건입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 채용/미채용이 완료된 건입니다.") */
				return;
			}
			
			if (!confirm("정말 미채용하시겠습니까?")) {
				return;
			}
			
			var form = $("<form></form>");
			form.append("<input type='hidden' name='mbrVO.mbrId' value='${hr.mbrId}'>");
			form.append("<input type='hidden' name='hrLvl' value='${hr.hrLvl}'>");
			form.append("<input type='hidden' name='hrId' value='${hr.hrId}'>");
			form.append("<input type='hidden' name='hrAprYn' value='N'>");
			
			$.post("${context}/api/hr/updateapr", form.serialize(), function(response) {
				if (response.status == "200 OK") {
					Swal.fire({
				    	  icon: 'success',
				    	  title: '정상적으로 미채용 처리되었습니다.',
				    	  showConfirmButton: true,
				    	  confirmButtonColor: '#3085d6'
					}).then((result)=>{
						if(result.isConfirmed){
							location.href = "${context}/hr/hrmstrdetail/${hr.hrId}";
						}
					});
					/* alert("정상적으로 미채용 처리 되었습니다."); */
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
		
		$("#fileDown").click(function(){
			
			var hrId = "${hr.hrId}";
			location.href="${context}/hr/hrfile/" + hrId;
		
		});
		
		var url;
		$(".open-layer").click(function(event) {
			var mbrId = $(this).text();
			$("#layer_popup").css({
				"padding": "5px",
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF",
				"position": "absolute",
				"border": "solid 1px #222",
				"z-index": "10px"
			}).show();
			mbrId = mbrId.trim();
			if (mbrId == '${sessionScope.__MBR__.mbrId}') {
				url = "cannot"
			} else {
				url = "${context}/nt/ntcreate/" + mbrId
			}
		});
		
		$(".send-memo-btn").click(function() {
			if (url !== "cannot") {
				location.href = url;
			} else {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '자신에게는 쪽지를<br>보낼 수 없습니다.',
			    	  showConfirmButton: true,
			    	  confirmButtonColor: '#3085d6'
				});
			}
		});
		$('body').on('click', function(event) {
			if (!$(event.target).closest('#layer_popup').length) {
				$('#layer_popup').hide();
			}
		});
		$(".close-memo-btn").click(function() {
			url = undefined;
			$("#layer_popup").hide();
		});
		
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
	        <span class="fs-5 fw-bold">회원 > 채용 관리 > 상세 조회</span>
	    	<div style="position: absolute;right: 0;top: 0; margin: 20px;">
	          <button id="update_btn" class="btn btn-primary" >수정</button>
			  <button id="delete_btn" class="btn btn-danger" style="margin-right:10px">삭제</button>
			  <button id="list_btn" class="btn btn-secondary" >목록</button>
	        </div>
      	</div>
			
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
			<div style="padding:10px;">
				<span class="fs-5 fw-bold">${hr.hrTtl}</span>
				<div class="hr_detail_header">(${hr.hrId})</div>
			</div>
			<div style="margin-top: 10px">
			
			<div style="border-bottom: 1px solid #e0e0e0; padding-bottom: 15px; text-align: right;">
				<fmt:parseDate value="${hr.hrRgstDt}" var="parseHrRgstDt" pattern="yyyy-MM-dd" />
				<div class="hr_detail_header">등록일 : <fmt:formatDate value="${parseHrRgstDt}" pattern="yyyy-MM-dd" /></div>
				<c:if test="${hr.ntcYn eq 'Y'}">
					<fmt:parseDate value="${hr.hrDdlnDt}" var="parseHrDdlnDt" pattern="yyyy-MM-dd" />
					<div class="hr_detail_header" style="font-weight: bold;">마감일 : <fmt:formatDate value="${parseHrDdlnDt}" pattern="yyyy-MM-dd" /></span></div>
				</c:if>
				<div class="hr_detail_header ellipsis" onclick="event.cancelBubble=true">작성자 : <span><a class="open-layer" href="javascript:void(0);" val="${hr.mbrId}">${hr.mbrId}</a></span></div>
				<div class="hr_detail_header">${hr.delYn == 'Y' ? '삭제 여부 : 삭제됨' : ''}</div>
			</div>
				<div style="padding:10px; ">
					<div class="bg-warning rounded bg-opacity-25 padding: 10px; margin: 10px;"> 
						<div style="display: ${hr.orgnFlNm == null ? '' : 'none'}; ">
							<div class="hr_detail_header">첨부파일 : 등록된 파일이 없습니다.</div>
						</div>
						<div style="display: ${hr.orgnFlNm == null ? 'none' : ''}; margin-bottom: 20px; padding: 10px;">
							<div class="hr_detail_header">첨부파일 : <a href="${context}/hr/hrfile/${hr.hrId}">${hr.orgnFlNm}</a></div>
							<div class="hr_detail_header" style="float: right;"> ${hr.flSize/1024}KB</div>
						</div>
					</div>
					
					<div style="padding: 10px;">
						<div>
							<textarea class="fw-semibold" 
									   style="margin-bottom: 100px; height:220px;
									          overflow: auto; word-break: break-all;
									          border: none; resize: none;" readonly>${hr.hrCntnt}</textarea>
						</div>
					</div>
					<div  style="display: ${hr.ntcYn eq 'Y' ? 'none' : ''};">
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
				         <div style="margin: 0 0 10px 160px;">
								<button id="hrApr_Y_btn" class="btn btn-success">채용</button>
								<button id="hrApr_N_btn" class="btn btn-danger">미채용</button>
						 </div>	
				         </div>
				       </div>
			       </div>
				</div>
			</div>
		</div>
		
		<!-- layer-popup -->
		<div class="layer_popup" id="layer_popup" style="display: none;">
			<div class="popup_box">
				<div class="popup_content">
					<a class="send-memo-btn" href="javascript:void(0);">
						<i class='bx bx-mail-send' ></i>쪽지 보내기
					</a>
				</div>
				<div>
					<a class="close-memo-btn" href="javascript:void(0);">
						<i class='bx bx-x'></i>닫기
					</a>
				</div>
			</div>
		</div>
		
<jsp:include page="../include/closeBody.jsp" />
</html>
