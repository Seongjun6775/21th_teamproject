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
		
		var delYn = ("${hr.delYn}");
		var mbrId = ("${hr.mbrId}");
		var hrStat = ("${hr.hrStat}");
		
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
				alert("자기가 작성한 글만 수정할 수 있습니다.");
				return;
			}
			
			if (hrStat != "접수") {
				alert("접수 상태의 게시글만 수정할 수 있습니다.");
				return;
			}
			
			location.href="${context}/hr/hrupdate/${hr.hrId}";
		});
		
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<h3>채용 지원 상세조회 페이지(회원)</h3>
			
			<div>
				<div class="hr_detail_header">글 번호 : ${hr.hrId}</div>
				<div class="hr_detail_header">작성자 : ${hr.mbrId}</div>
			</div>
			<div>
				<div class="hr_detail_header">제목 : ${hr.hrTtl}</div>
				<div class="hr_detail_header">지원 직군 : ${hr.cdNm}</div>
				<div class="hr_detail_header">지원 상태 : ${hr.hrStat}</div>
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
				<div class="hr_detail_header"><fmt:formatNumber type="number" value="${hr.flSize/1024}" maxFractionDigits="2"/> KB</div>
			</div>
			<div style="display: ${hr.orgnFlNm == null ? '' : 'none'};">
				<div class="hr_detail_header">첨부파일 : 등록된 파일이 없습니다.</div>
			</div>
			<div class="hr_detail_cntnt">${hr.hrCntnt}</div>
			
			<button id="update_btn">수정</button>
			<button id="delete_btn">삭제</button>
			<button id="list_btn">목록</button>
			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
