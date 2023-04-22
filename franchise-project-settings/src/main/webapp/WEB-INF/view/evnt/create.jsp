<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 등록 페이지</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${context}/js/AjaxUtil.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	
	// 1. 등록 버튼을 누르면 수행할 내용
	$("#btn-create").click(function(){
		
		var ajaxUtil = new AjaxUtil();
		ajaxUtil.upload("#form-create" , "${context}/api/evnt/create", function(response) {
			console.log("업데이트돌고있음")
			if (response.status == "200 OK") {
				console.log("200임")
				alert(response.message);
				
				//location.href="${context}/evnt/list"
				//location.reload(); // 새로고침
			} else {
				console.log("안됨")
				alert(response.errorCode + " / " + response.message);
			}
		}, {"orgnFlNm" : "uploadFile"})
	});
	
	
	//'돌아가기'버튼 누르면 뒤로 돌아가기
	$("#btn-cancle").click(function() {
		//location.href="${context}/evnt/list3"
		history.pushState(null, null, '${context}/evnt/list');
	});

});
	
	
	
	
	
	

</script>

</head>
<body>

   <div class="main-layout" >
		<form id="form-create" enctype="multipart/form-data">
			<div>
				<table border=1 style="width: 600px;">
				<tr>
					<td colspan="4"><h1 style="text-align: center;">이벤트 등록
							페이지</h1></td>
				</tr>
				<tr>
					<td>이벤트 ID</td>
					<td colspan="3"><input type="text" id="evntId"
						style="width: 99%;" readonly="readonly" placeholder="이벤트ID는 입력할 수 없습니다."value=""  /></td>
				</tr>

				<tr>
					<td>이벤트 제목</td>
					<td colspan="3"><input type="text" id="evntTtl"
						style="width: 99%;" value="" /></td>
				</tr>

				<tr>
					<td>이벤트 내용</td>
					<td colspan="3"><input type="text" id="evntCntnt"
						style="width: 99%; height: 99px" value="" /></td>
				</tr>

				<tr>
					<td>이벤트 시작일</td>
					<td><input type="date" id="evntStrtDt" value="" /></td>
					<td>이벤트 종료일</td>
					<td><input type="date" id="evntEndDt" value="" /></td>
				</tr>
				<tr>
					<td>이벤트 사진</td>
					<td colspan="3">
					<input type="file" name="orgnFlNm" id="orgnFlNm"
						   style="width: 200px;" value="" />					
				    <!-- <input type="submit" value="사진 업로드"></td>		 -->		
				</tr>
				<tr>
					<td>사용 여부</td>
					<td><input type="checkbox" id="useYn"
						value="Y" checked/></td>
					<td>삭제 여부</td>
					<td><input type="checkbox" id="delYn" value="" /></td>
				</tr>
				<tr>
				</tr>
				
				<tr>
					<td></td>
					<td></td>
					<td><button type="button" id="btn-create" class="btn-primary" style="width:100%;">등록</button></td>
					<td><button id="btn-cancle" class="btn-primary" style="width:100%;">돌아가기</button></td>
				</tr>
			</table>
		</div>
	</form>
</div>
</body>
</html>