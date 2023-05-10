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
<link rel="stylesheet" href="${context}/css/ntcommon.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">

	$().ready(function() {
		
		$("#list_btn").click(function() {
			location.href = "${context}/str/strlist";
		});
		
		var ntId = ("${nt.ntId}");
		
		$("#del_btn").click(function() {
			var delYn = ("${nt.delYn}");
			
			Swal.fire({
				  title: '삭제 하시겠습니까?',
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  cancelButtonText: '취소',
				  confirmButtonText: '삭제하기'
				}).then((result) => {
					if(result.isConfirmed){
						$.post("${context}/api/nt/delete/" + ntId, function(response) {
							if (response.status == "200 OK") {
								Swal.fire({
							    	  icon: 'success',
							    	  title: '정상적으로 채용처리 되었습니다.',
							    	  showConfirmButton: true,
							    	  confirmButtonColor: '#3085d6'
								}).then((result)=>{
									if(result.isConfirmed){
										location.href = "${context}/nt/ntmngrlist";
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
		
		$("#list_btn").click(function() {
			location.href = "${context}/nt/ntmngrlist";
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
<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
} 
</style>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
	        <span class="fs-5 fw-bold">쪽지 > 쪽지 관리 > 쪽지 상세조회</span>
			<div style="position: absolute;right: 0;top: 0; margin: 20px;">
			  <button id="list_btn" class="btn btn-secondary" >목록</button>
	        </div>
      	</div>
		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<div style="margin: 20px;">
				<div style="float: right;">
					<button id="del_btn" class="btn btn-outline-danger btn-default">삭제</button>
				</div>
				<div>
					<label class="d-inline fw-bolder" style="float: left;width: 67px;">제목</label>
					<div class="d-inline">${nt.ntTtl} <span style="color: #f00;">${nt.delYn eq 'Y' ? '(삭제됨)' : '	'}</span> </div>
				</div>
				<div>
					<label class="d-inline fw-bolder" style="float: left;width: 67px;" >발신자</label>
					<div class="d-inline rounded-pill bg-warning text-dark bg-opacity-25 ellipsis" style="padding: 0 5px 0 5px;" onclick="event.cancelBubble=true">
						<a class="open-layer" href="javascript:void(0);" val="${nt.sndrId}">${nt.sndrId}</a>
					</div>
				</div>
				<div>
					<label class="d-inline fw-bolder" style="float: left;width: 67px;">수신자</label>
					<div class="d-inline rounded-pill bg-warning text-dark bg-opacity-25 ellipsis" style="padding: 0 5px 0 5px;" onclick="event.cancelBubble=true">
						<a class="open-layer" href="javascript:void(0);" val="${nt.rcvrId}">${nt.rcvrId}</a>
					</div>
				</div>
				<div>
					<div >쪽지 발송 일자 : ${nt.ntSndrDt}</div>
					<div >쪽지 확인 일자 : ${nt.ntRdDt}</div>
				</div>
			</div>
			<div>
				<div class="nt_cntnt fw-bolder" style="word-break: break-all; border-top: 2px solid #e0e0e0;">${nt.ntCntnt}</div>
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
