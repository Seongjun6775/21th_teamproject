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
<link rel="stylesheet" href="${context}/css/hr_common.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		
		$("#cancel_btn").click(function() {
			if (!confirm("수정을 취소하시겠습니까?")) {
				return;
			}
			location.href="${context}/hr/list";
		});
		
		$("#save_btn").click(function() {
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
        var str = "<div class='file-input'><input type='file' id='hrFile' name='hrFile'></div>";
        $("#file-list").append(str);
    }
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<h3>채용 지원 수정 페이지 테스트</h3>
			<form id="hr_form" enctype="multipart/form-data">
				<div>
					<input type="hidden" id="ntcYn" value="${hr.ntcYn}">
				</div>
				<div>
					<label for="mbrId">작성자</label>
					<input type="text" id="mbrId" name="mbrId" value="${mbrVO.mbrId}" disabled/>
				</div>
				<div>
					<select id="hrLvl" >
						<option value="">직군을 선택하세요.</option>
						<option value="005-01" ${hr.hrLvl == '005-01' ? 'selected' : ''}>점주</option>
						<option value="005-02" ${hr.hrLvl == '005-02' ? 'selected' : ''}>직원</option>
					</select>
				</div>
				<div>
					<label for="hrTtl">제목</label>
					<input type="text" id="hrTtl" name="hrTtl" value="${hr.hrTtl}" />
				</div>
				<div class="file-group" id="file-list">
		            <div class="file-input">
		                첨부파일 : ${hr.orgnFlNm eq null ? '파일이 없습니다' : hr.orgnFlNm}
		                <span><fmt:formatNumber type="number" value="${hr.flSize/1024 > 0 ? hr.flSize/1024 : ''}" maxFractionDigits="2"/></span>
		                <span>${hr.orgnFlNm eq null ? '' : KB}</span>
		                <a href='#this' id='file-delete'>${hr.orgnFlNm eq null ? '파일 추가' : '삭제'}</a>
		            </div>
			     </div>
				<div>
					<label for="hrCntnt">본문</label>
					<textarea id="hrCntnt" name="hrCntnt" maxlength="4000" >${hr.hrCntnt}</textarea>
				</div>
			</form>
			
			<div>
				<button id="save_btn">수정</button>
				<button id="cancel_btn">취소</button>
			</div>
			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
