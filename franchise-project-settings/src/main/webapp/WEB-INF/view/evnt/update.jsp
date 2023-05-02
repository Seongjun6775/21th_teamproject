<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Random"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css?p=${date}" />
<meta charset="UTF-8">
<title>이벤트 수정 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${context}/js/AjaxUtil.js"></script>
<script type="text/javascript">
$().ready(function() {
 	$("#useYn").prop("checked", "${evntVO.useYn}" == "Y");
	
	//수정 완료 버튼
   $("#btn-update-success").click(function(){
	   
// 	   var useyn = $('#useYn').is(':checked') ? 'Y' : 'N' ;
	  
	   
		var ajaxUtil = new AjaxUtil();
		ajaxUtil.upload("#form-update" , "${context}/api/evnt/update", function(response) {
			
			if (response.status == "200 OK") {
				console.log("200임")
				alert(response.message);
				var evntId = document.getElementById("evntId").value;
				location.href = "${context}/evnt/detail/"+evntId;
				//location.reload(); // 새로고침
			} else {
				console.log("안됨")
				alert(response.errorCode + " / " + response.message);
			}
		}, {"orgnFlNm" : "uploadFile"})
   });
	
	
	
	
	
   //'닫기'버튼 누르면 뒤로 돌아가기
   $("#btn-update-close").click(function(){
	   //location.href="${context}/evnt/list3"
	   //history.go(-1);
	   //뒤로가기 먹통 에러가 너무 잦아서 코드 변경
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
		<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
	        <span class="fs-5 fw-bold">이벤트 > 상세페이지 > 수정</span>
      	</div>
		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<form id="form-update" enctype="multipart/form-data">
				<div>
					<table>
						<tr>
							<td style="width:150px;">이벤트 ID</td>
							<td colspan="3"><input type="text" id="evntId"
								style="width: 99%;" readonly="readonly" value="${evntVO.evntId}" /></td>
						</tr>
	
						<tr>
							<td>이벤트 제목</td>
							<td colspan="3"><input type="text" id="evntTtl"
								style="width: 99%;" value="${evntVO.evntTtl}" /></td>
						</tr>
	
						<tr>
							<td>이벤트 내용</td>
							<td colspan="3"><input type="text" id="evntCntnt"
								style="width: 99%; height: 99px" value="${evntVO.evntCntnt}" />	</td>
						</tr>
	
						<tr>
							<td style="width:150px;">이벤트 시작일</td>
							<td style="width:150px;"><input type="date" id="evntStrtDt"
								value="${evntVO.evntStrtDt}" /></td>
							<td style="width:150px;">이벤트 종료일</td>
							<td style="width:150px;"><input type="date" id="evntEndDt"
								value="${evntVO.evntEndDt}" /></td>
						</tr>
	
						<tr>
							<td>이벤트 사진</td>
							<td colspan="3"><img
								src="${context}/evnt/img/${evntVO.uuidFlNm}"  style="width:100%;"/> <input
								type="file" id="orgnFlNm" style="width: 99%;" accept="image/png, image/jpeg"
								value="${evntVO.orgnFlNm eq null ? '파일이 없습니다' : evntVO.orgnFlNm}" /></td>
						</tr>
						<tr>
							<td><br></td>
							<td><br></td>
							<td><br></td>
							<td><br></td>
						</tr>
						<tr>
							<td>사용 여부</td>
							<td><input type="checkbox" id="useYn" name="useYn" onClick="check(this)" value="Y"/></td>
							<td><button id="btn-update-success" type="button" class="btn-primary"
									style="width: 100%;">완료</button></td>
							<td><button id="btn-update-close" class="btn-primary"
									style="width: 100%;">닫기</button></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
<jsp:include page="../include/closeBody.jsp" />
</html>