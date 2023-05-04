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
			<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin: 20px;">
	        	<span class="fs-5 fw-bold"> 회원 > 채용 > 채용 ${mbrVO.mbrLvl == '001-01' ? '공지' : '지원'} 작성</span>
      		</div>
			
			<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin:20px;">
				<h2 class="fw-bold" style="margin: 20px;">채용 ${mbrVO.mbrLvl == '001-01' ? '공지' : '지원'} 작성</h2>
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
						<div style="display: flex; flex-direction: row; margin-bottom: 4px;">
							<label for="hrFile" class="col-form-label" style="padding: 4px; border-left: solid #ffbe2e; margin-right:15px;">파일첨부</label>
							<input type="file" accept=".hwp" id="hrFile" name="hrFile" class="form-control" style="width: 50%;"/>
						</div>
						<div style="margin-bottom: 4px; display:  ${mbrVO.mbrLvl == '001-01' ? 'none' : 'flex' }">
							<label for="hrLvl" class="col-form-label" style="padding: 5px; border-left: solid #ffbe2e; margin-right: 7px;">지원 직군</label>
							<select id="hrLvl" name="hrLvl" class="form-select" style="width:15%;">
								<option value=" ">직군을 선택하세요.</option>
								<option value="005-01">점주</option>
								<option value="005-02">직원</option>
							</select>
						</div>
						<div class="input-group" style="display: ${mbrVO.mbrLvl == '001-01' ? 'flex' : 'none'}; flex-direction: row; margin-bottom: 4px;">
							<label for="hrDdlnDt" class="col-form-label" style="padding: 5px; border-left: solid #ffbe2e; margin-right:30px;">마감일</label>
							<div>
								<input type="date" id="hrDdlnDt" name="hrDdlnDt" value="${hr.hrDdlnDt}" class="form-control"/>
							</div>
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
			<div style="float: right; margin: 20px 0 20px 20px">
				<button id="save_btn" class="btn btn-success">작성</button>
				<button id="cancel_btn" class="btn btn-secondary">취소</button>
			</div>
		</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
