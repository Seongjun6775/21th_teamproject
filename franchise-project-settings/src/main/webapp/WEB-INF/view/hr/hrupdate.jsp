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
		
		$("#save_btn").click(function() {
			
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
        var str = "<div class='file-input' style='margin:5px; float:right;'><input type='file' id='hrFile' name='hrFile'></div>";
        $("#file-list").append(str);
    }
	
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
		<span class="fs-5 fw-bold">회원 > 채용 지원 > 수정</span>
	</div>
	<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
		<h2 class="fw-bold" style="margin: 20px;">채용 지원 수정</h2>
			<form id="hr_form" enctype="multipart/form-data">
				<div>
					<input type="hidden" id="ntcYn" value="${hr.ntcYn}">
				</div>
				
				<div class="input-group" style="display: flex; flex-direction: row-reverse;">
					<div>
						<input type="text" id="mbrId" name="mbrId" value="${mbrVO.mbrId}" class="form-control" readonly />
					</div>
					<label class="col-form-label" style="padding-right: 8px; border-right: solid #ffbe2e;">작성자</label>
				</div>
				<div style="display:  ${mbrVO.mbrLvl == '001-01' ? '' : 'none' }">
					<label for="hrDdlnDt">채용 마감일</label>
					<input type="date" id="hrDdlnDt" name="hrDdlnDt" />
				</div>
				<div>
					<select id="hrLvl" style="display: ${mbrVO.mbrLvl eq '001-01' ? 'none' : ''};">
						<option value="" selected>직군을 선택하세요.</option>
						<option value="005-01" ${hr.hrLvl == '005-01' ? 'selected' : ''}>가맹점주</option>
						<option value="005-02" ${hr.hrLvl == '005-02' ? 'selected' : ''}>점원</option>
					</select>
				</div>
				<div>
					<label for="hrTtl" class="col-form-label" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">제목</label>
					<div>
						<input type="text" id="hrTtl" class="form-control" name="hrTtl" value="${hr.hrTtl}"  />
					</div>
				</div>
				<div class="file-group" id="file-list" style="margin:5px;" >
		            <div class="file-input" style="float:right;">
		                 ${hr.orgnFlNm eq null ? '파일이 없습니다' : hr.orgnFlNm}
		                <span><fmt:formatNumber type="number" value="${hr.flSize/1024 > 0 ? hr.flSize/1024 : ''}" maxFractionDigits="2"/></span>
		                <span>${hr.orgnFlNm eq null ? '' : 'KB'}</span>
		                <a href='#this' id='file-delete'>${hr.orgnFlNm eq null ? '파일 추가' : '삭제'}</a>
		            </div>
			     </div>
			     
				<label for="hrCntnt" class="col-form-label" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">본문</label>
				<div class="input-group">
					<textarea id="hrCntnt" name="hrCntnt"  maxlength="4000" style="margin-top: 0.5rem;  height: 500px; resize: none;"
							 placeholder="간단하게 자기소개 부탁드립니다." class="form-control">${hr.hrCntnt}</textarea>
				</div>
			</form>
			
			<div>
				<button id="save_btn">수정</button>
				<button id="cancel_btn">취소</button>
			</div>
	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
