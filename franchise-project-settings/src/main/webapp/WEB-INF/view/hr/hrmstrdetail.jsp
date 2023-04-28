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
<link rel="stylesheet" href="${context}/css/hr_mstr.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
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
				alert("이미 삭제 처리된 글입니다.");
				return;
			}
			
			if (mbrId != "${mbrVO.mbrId}") {
				alert("자기가 작성한 글만 삭제할 수 있습니다.");
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			$.post("${context}/api/hr/delete/${hr.hrId}", function(response) {
				if (response.status == "200 OK") {
					alert("정상적으로 삭제되었습니다.");
					location.href="${context}/hr/list";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#update_btn").click(function() {
			if (delYn == "Y") {
				alert("이미 삭제된 글은 수정할 수 없습니다.");
				return;
			}
			
			if (mbrId != "${mbrVO.mbrId}") {
				alert("다른 사람의 글은 수정할 수 없습니다.");
				return;
			}
			
			location.href="${context}/hr/hrupdate/${hr.hrId}";
		});
		
		$("#hrApr_Y_btn").click(function() {
			if (ntcYn == "Y") {
				alert("공지 게시글은 채용 처리를 할 수 없습니다!");
				return;
			}
			
			if (aprYn != null && aprYn != "") {
				alert("이미 채용/미채용이 완료된 건입니다.")
				return;
			}
			
			if (!confirm("정말 채용하시겠습니까?")) {
				return;
			}
			var form = $("<form></form>");
			form.append("<input type='hidden' name='mbrVO.mbrId' value='${hr.mbrId}'>");
			form.append("<input type='hidden' name='mbrVO.mbrLvl' value='${hr.hrLvl}'>");
			form.append("<input type='hidden' name='hrId' value='${hr.hrId}'>");
			form.append("<input type='hidden' name='hrAprYn' value='Y'>");
			$.post("${context}/api/hr/updateapr",  form.serialize(), function(response) {
				if (response.status == "200 OK") {
					alert("정상적으로 채용 처리 되었습니다.");
					location.href = "${context}/hr/hrmstrdetail/${hr.hrId}";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#hrApr_N_btn").click(function() {
			if (ntcYn == "Y") {
				alert("공지 게시글은 채용 처리를 할 수 없습니다!");
				return;
			}
			
			if (aprYn != null && aprYn != "") {
				alert("이미 채용/미채용이 완료된 건입니다.")
				return;
			}
			
			if (!confirm("정말 미채용하시겠습니까?")) {
				return;
			}
			$.post("${context}/api/hr/updateapr", {hrId: "${hr.hrId}", hrAprYn : "N"}, function(response) {
				if (response.status == "200 OK") {
					alert("정상적으로 미채용 처리 되었습니다.");
					location.href = "${context}/hr/hrmstrdetail/${hr.hrId}";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
	        <span class="fs-5 fw-bold">master 채용 디테일 테스트 / 채용 지원 상세조회 페이지(최고관리자)</span>
	        <div style="position: absolute;right: 0;top: 0; margin: 20px;">
	          <button id="update_btn" class="btn btn-primary" >수정</button>
			  <button id="delete_btn" class="btn btn-danger" style="margin-right:10px">삭제</button>
			  
			  <button id="list_btn" class="btn btn-secondary" >목록</button>
	        </div>
      	</div>
			
		<div class="bg-white rounded shadow-sm" style="width: 50%; padding: 23px 18px 23px 18px; overflow: auto;  margin:20px; display:inline-block">
			<div style="padding:10px;">
				<span class="fs-5 fw-bold">${hr.hrTtl}</span>
				<div class="hr_detail_header">(${hr.hrId})</div>
			</div>
			
			<div style="margin-top: 10px">
			
			<div style="border-bottom: 1px solid #e0e0e0; padding-bottom: 15px; text-align: right;">
				<div class="hr_detail_header">등록일 : ${hr.hrRgstDt}</div>
				<%-- <div class="hr_detail_header">최종 수정일 : ${hr.hrMdfyDt}</div> --%>
				<div class="hr_detail_header">작성자 : ${hr.mbrId}</div>
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
					<div class="fw-semibold" style="margin-bottom: 100px; height:250px; overflow: auto;">${hr.hrCntnt}</div>
				</div>
				<div class="bg-white rounded shadow-sm" style="height:250px; width: 500px; padding: 23px 18px 23px 18px; overflow: auto;  margin:20px; display:inline-block">
				<div style="margin-top: 10px">
					<div style="padding:10px; ">
						<div style="padding: 10px;">
							<div>
							<div class="container text-center margin-bottom: 20px">
							  <div class="row">
							    <div class="col border border-secondary">
							      지원 직군
							    </div>
							    <div class="col border border-secondary">
							      ${hr.cdNm}
							    </div>
							  </div>
							  <div class="row">
							    <div class="col border border-secondary">
							      지원 상태
							    </div>
							    <div class="col border border-secondary">
								    <c:choose>
										<c:when test="${hr.hrStat eq '002-01'}"><div>접수</div></c:when>
										<c:when test="${hr.hrStat eq '002-02'}"><div>심사중</div></c:when>
										<c:when test="${hr.hrStat eq '002-03'}"><div>심사완료</div></c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
							    </div>
							  </div>
							  <div class="row">
							    <div class="col border border-secondary">
							      승인여부
							    </div>
							    <div class="col border border-secondary">
							      ${hr.hrAprYn}
							    </div>
							  </div>
							  <div class="row">
							    <div class="col border border-secondary">
							      승인 여부 변경 일자
							    </div>
							    <div class="col border border-secondary">
							      ${hr.hrAprDt}
							    </div>
							  </div>
							</div>
							
							</div> 
						</div>
						</div>
					</div>
					
				</div>	
					
			</div>
			<div style="margin: 0 0 10px 20px; float: right;">
					<button id="hrApr_Y_btn" class="btn btn-success">채용</button>
					<button id="hrApr_N_btn" class="btn btn-danger">미채용</button>
			</div>
			</div>
		</div>


<jsp:include page="../include/closeBody.jsp" />
</html>
