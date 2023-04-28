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
			form.append("<input type='hidden' name='hrAprYn' value='N'>");
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
			/*  */
			$.post("${context}/api/hr/updateapr", {hrId: "${hr.hrId}", hrAprYn : "N", mbrId: "${hr.mbrId}"}, function(response) {
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
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/mbrMgmtSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<h3>채용 지원 상세조회 페이지(최고관리자)</h3>
			
			<div>
				<div class="hr_detail_header">글 번호 : ${hr.hrId}</div>
				<div class="hr_detail_header">작성자 : ${hr.mbrId}</div>
				<div class="hr_detail_header">${hr.delYn == 'Y' ? '삭제 여부 : 삭제됨' : ''}</div>
			</div>
			<div>
				<div class="hr_detail_header">제목 : ${hr.hrTtl}</div>
				<div class="hr_detail_header">지원 직군 : ${hr.cdNm}</div>
				<c:choose>
					<c:when test="${hr.hrStat eq '002-01'}"><div>지원 상태 : 접수</div></c:when>
					<c:when test="${hr.hrStat eq '002-02'}"><div>지원 상태 : 심사중</div></c:when>
					<c:when test="${hr.hrStat eq '002-03'}"><div>지원 상태 : 심사완료</div></c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
			</div>
			<div>
				<div class="hr_detail_header">등록일 : ${hr.hrRgstDt}</div>
				<div class="hr_detail_header">최종 수정일 : ${hr.hrMdfyDt}</div>
			</div>
			<div>
				<div class="hr_detail_header">승인 여부 : ${hr.hrAprYn}</div>
				<div class="hr_detail_header">승인 여부 변경 일자 : ${hr.hrAprDt}</div>
			</div>
			<div style="display: ${hr.orgnFlNm == null ? 'none' : ''};">
				<div class="hr_detail_header">첨부파일 : <a href="${context}/hr/hrfile/${hr.hrId}">${hr.orgnFlNm}</a></div>
				<div class="hr_detail_header">${hr.flSize/1024}</div>
			</div>
			<div style="display: ${hr.orgnFlNm == null ? '' : 'none'};">
				<div class="hr_detail_header">첨부파일 : 등록된 파일이 없습니다.</div>
			</div>
			<div class="hr_detail_cntnt">${hr.hrCntnt}</div>
			
			<button id="update_btn">수정</button>
			<button id="delete_btn">삭제</button>
			<button id="list_btn">목록</button>
			<button id="hrApr_Y_btn">채용</button>
			<button id="hrApr_N_btn">미채용</button>
			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
