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

	$().ready(function() {
		
		console.log("${nt.ntRdDt}");
		
		var ntId = ("${nt.ntId}");
		
		$("#del_btn").click(function() {
			var delYn = ("${nt.delYn}");
			if (delYn == "Y") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 삭제 처리된 쪽지입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 삭제 처리된 쪽지입니다!"); */
				return;
			}
			
			var rdYn = ("${nt.ntRdDt}");
			if (rdYn != "") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 확인된 쪽지는 지울 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 확인된 쪽지는 지울 수 없습니다!") */
				return;
			}
			
			else if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/nt/delete/" + ntId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/nt/ntmstrlist";
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
		
		$("#list_btn").click(function() {
			location.href = "${context}/nt/ntmstrlist";
		});
		
		
		$("#upd_btn").click(function() {
			var delYn = ("${nt.delYn}");
			var ntRdDt = ("${nt.ntRdDt}");
			
			if (delYn == "Y") {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '이미 삭제된 쪽지는 수정할 수 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 삭제된 쪽지는 수정할 수 없습니다!"); */
				return;
			}
			
			else if ( ("${nt.sndrId}") != ("${mbrVO.mbrId}")) {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '자기 쪽지만 수정할 수 있습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("내가 보내지 않은 쪽지는 수정할 수 없습니다!") */
				return;
			}
			else {
				if (ntRdDt == "") {
					location.href = "${context}/nt/ntupdate/" + ntId;
				}
				else {
					Swal.fire({
				    	  icon: 'error',
				    	  title: '이미 수신한 쪽지는 수정할 수 없습니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert("이미 수신한 쪽지는 수정할 수 없습니다!"); */
					return;
				}
			}
		});
	});
</script>
<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
} 

.nt-table > div{
	margin-bottom:10px;
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
			<div class="nt-table" style="margin: 20px;">
				<div style="float: right;">
					<button id="upd_btn" class="btn btn-outline-success btn-default">수정</button> 
					<button id="del_btn" class="btn btn-outline-danger btn-default">삭제</button>
				</div>
				<div>
					<label class="d-inline fw-bolder" style="float: left;width: 67px;">제목</label>
					<div class="d-inline">${nt.ntTtl} <span style="color: #f00;">${nt.delYn eq 'Y' ? '(삭제됨)' : '	'}</span> </div>
				</div>
				<div>
					<label class="d-inline fw-bolder" style="float: left;width: 67px;" >발신자</label>
					<div class="d-inline rounded-pill bg-warning text-dark bg-opacity-25" style="padding: 5px;" >${nt.sndrId}</div>
				</div>
				<div>
					<label class="d-inline fw-bolder" style="float: left;width: 67px;">수신자</label>
					<div class="d-inline rounded-pill bg-warning text-dark bg-opacity-25" style="padding: 5px;">${nt.rcvrId}</div>
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
			
<jsp:include page="../include/closeBody.jsp" />
</html>
