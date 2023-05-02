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
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#cancel_btn").click(function() {
			if (!confirm("작성을 취소하시겠습니까?")) {
				return;
			}
			location.href="${context}/hr/list";
		});
		
		$("#save_btn").click(function() {
			if (!confirm("작성을 완료하시겠습니까?")) {
				return;
			}
			
			var ajaxUtil = new AjaxUtil();
			ajaxUtil.upload("#hr_form", "${context}/api/hr/create", function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/hr/list";
				}
				else if (response.status == "500") {
					alert(response.message);
				}
				else {
					alert(response.message);
				}
			}, {"hrFile": "uploadFile"});
		});
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">채용지원 > 지원서 작성</span>
	</div>
	<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
		<form id="hr_form" enctype="multipart/form-data">
			<div>
				<input type="hidden" id="ntcYn" value="${mbrVO.mbrLvl == '001-01' ? 'Y' : 'N' }">
			</div>
			<div>
				<label for="mbrId">작성자</label>
				<input type="text" id="mbrId" name="mbrId" value="${mbrVO.mbrId}" disabled/>
			</div>
			<div style="display:  ${mbrVO.mbrLvl == '001-01' ? 'none' : '' }">
				<select id="hrLvl">
					<option value=" ">직군을 선택하세요.</option>
					<option value="005-01">점주</option>
					<option value="005-02">직원</option>
				</select>
			</div>
			<div>
				<label for="hrTtl">제목</label>
				<input type="text" id="hrTtl" name="hrTtl" />
				
			</div>
			<div>
				<label for="hrFile">파일 첨부</label>
				<input type="file" id="hrFile" name="hrFile" />
			</div>
			<div>
				<label for="hrCntnt">본문</label>
				<textarea id="hrCntnt" name="hrCntnt" maxlength="4000"
				 placeholder="4000자 까지 입력하실 수 있습니다"
				 style="width: 600px; height: 400px; resize: none;"></textarea>
			</div>
		</form>
		<div>
			<button id="save_btn">작성</button>
			<button id="cancel_btn">취소</button>
		</div>
	</div>
			
<jsp:include page="../include/closeBody.jsp" />
</html>
