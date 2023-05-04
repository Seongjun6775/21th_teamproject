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
		
		document.getElementById("hrDdlnDt").value = ("${hr.hrDdlnDt}").substring(0,10);
		
		$("#cancel_btn").click(function() {
			if (!confirm("수정을 취소하시겠습니까?")) {
				return;
			}
			location.href="${context}/hr/list";
		});
		
		$("#update_btn").click(function() {
			
			var hrDdlnDt = document.getElementById("hrDdlnDt").value;

			if (!confirm("수정을 완료하시겠습니까?")) {
				return;
			}
			
			var ajaxUtil = new AjaxUtil();
			ajaxUtil.upload("#hr_form", "${context}/api/hr/update/${hr.hrId}", function(response) {
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
		
		$("a[id='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
		
	});
	
    function deleteFile(obj) {
        obj.parent().remove();
        var str = "<div class='file-input' style='margin:5px; float:right;'><input type='file' id='hrFile' class='form-control' name='hrFile'></div>";
        $("#file-list").append(str);
    }
	
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">회원 > 채용 > 채용 ${mbrVO.mbrLvl == '001-01' ? '공지' : '지원'} 수정</span>
		<div style="position: absolute;right: 0;top: 0; margin: 20px;">
	          <button id="update_btn" class="btn btn-primary" >수정</button>
			  <button id="cancel_btn" class="btn btn-secondary" >취소</button>
	    </div>
	</div>
	<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
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
					<div class="file-group" id="file-list" style="margin-bottom: 4px;" >
						<label for="hrFile" class="col-form-label" style="padding: 4px; border-left: solid #ffbe2e; margin-right:15px;">파일첨부</label>
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
						<option value="005-01" ${hr.hrLvl == '005-01' ? 'selected' : ''}>점주</option>
						<option value="005-02" ${hr.hrLvl == '005-02' ? 'selected' : ''}>직원</option>
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
			</form>
			
			<div>
				<button id="save_btn">수정</button>
				<button id="cancel_btn">취소</button>
			</div>
	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
