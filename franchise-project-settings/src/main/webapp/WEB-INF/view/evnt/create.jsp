<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Random"%> 
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 등록 페이지</title>
<link rel="stylesheet" href="../css/evntCommon.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${context}/js/AjaxUtil.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	
	// 1. 등록 버튼을 누르면 수행할 내용
	$("#btn-create").click(function(){
		var evntTtl = document.getElementById("evntTtl").value;
		var evntCntnt = document.getElementById("evntCntnt").value;
		var evntStrtDt = document.getElementById("evntStrtDt").value;
		var evntEndDt = document.getElementById("evntEndDt").value;
		var orgnFlNm = document.getElementById("orgnFlNm").value;
		
		if (evntTtl == ""){
			alert("이벤트 제목을 입력해주세요.");
			return;
		}
		if (evntCntnt == ""){
			alert("이벤트 내용을 입력해주세요.");
			return;
		}
		if (evntStrtDt == ""){
			alert("이벤트 시작일자를 입력해주세요.");
			return;
		}
		if (evntEndDt == ""){
			alert("이벤트 종료일자를 입력해주세요.");
			return;
		}
		if (orgnFlNm == ""){
			alert("사진을 등록해주세요.");
			return;
		}
		if(evntStrtDt > evntEndDt){
			alert("시작일자("+evntStrtDt+")가 종료일자("+evntEndDt+")보다 큽니다");
			return;
		}
		
		var ajaxUtil = new AjaxUtil();
		ajaxUtil.upload("#form-create" , "${context}/api/evnt/create", function(response) {
			if (response.status == "200 OK") {
				console.log("200임")
				alert(response.message);
				
				location.href = "${context}/evnt/list";
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
	
	
	
	function check(box) {
		if (box.checked == true) {
			box.value = "Y";
		} else {
			box.value = "N";
		}
	}
</script>

</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">이벤트 > 이벤트 등록</span>
	    </div>
	    <div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; width:60%; margin: 20px; ">
			<form id="form-create" enctype="multipart/form-data">
				<input type="hidden" id="evntId"
							style="width: 99%;" readonly="readonly" placeholder="이벤트ID는 입력할 수 없습니다."value=""  />
				<div style="margin: 60px 60px 60px 90px;">
					<table style="border-spacing: 10px; ">
					<tr>
						<td>이벤트 제목</td>
						<td colspan="3"><input type="text" id="evntTtl"class="form-control"
							style="width: 99%;" value="" /></td>
					</tr>
	
					<tr>
						<td>이벤트 내용</td>
						<td colspan="3"><textarea id="evntCntnt" class="form-control" 
							style="width: 99%; height: 200px; resize: none;" /></textarea></td>
					</tr>
	
					<tr>
						<td>이벤트 시작일</td>
						<td><input type="date" id="evntStrtDt" class="form-control" value="" /></td>
						<td>이벤트 종료일</td>
						<td><input type="date" id="evntEndDt" class="form-control" value="" /></td>
					</tr>
					<tr>
						<td>이벤트 사진</td>
						<td colspan="3">
						<input type="file" name="orgnFlNm" id="orgnFlNm" class="form-control"
							   value="" accept="image/png, image/jpeg"/>					
					    <!-- <input type="submit" value="사진 업로드"></td>		 -->		
					</tr>
					<tr>
						<td>사용 여부</td>
						<td><input type="checkbox" id="useYn" class="form-check-input" onClick="check(this)" value=""/></td>
						<td >삭제 여부</td>
						<td><input type="checkbox" id="delYn" class="form-check-input"  onClick="check(this)" value="" /></td>
					</tr>
					<tr>
						<td></td>
						<td></td> 
						<td ><br></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td><button type="button" id="btn-create" class="btn-primary" style="width:100%; height: 30px">등록</button></td>
						<td><button id="btn-cancle" class="btn-primary" style="width:100%; height: 30px">돌아가기</button></td>
					</tr>
				</table>
				<div></div>
			</div>
		</form>
	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>