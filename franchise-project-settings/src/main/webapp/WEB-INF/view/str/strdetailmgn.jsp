<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<link rel="stylesheet" href="${context}/css/str_common.css?p=${date}" />
	<script type="text/javascript">
$().ready(function() {
		
		$(".grid > table > tbody > tr").click(function(){
			$("#isModify").val("true"); //수정모드
			var data = $(this).data();
			$("#strId").val(data.strid);
			$("#strNm").val(data.strnm);
			$("#strAddr").val(data.straddr);
			$("#strCallNum").val(data.strcallnum);
			$("#mbrId").val(data.mbrid);
			$("#strOpnTm").val(data.stropntm);
			$("#strClsTm").val(data.strclstm);
			$("#useYn").prop("checked", data.useyn == "Y");
		});

		$("#new_btn").click(function() {
			$("#isModify").val("false"); //등록모드
			$("#strId").val("");
			$("#strNm").val("");
			$("#strAddr").val("");
			$("#strCallNum").val("");
			$("#mbrId").val("");
			$("#strOpnTm").val("");
			$("#strClsTm").val("");
			$("#useYn").prop("checked", false);

		});
		
		$("#list_btn").click(function(){
			location.href= "${context}/str/list";
		});
		
		$("#delete_btn").click(function(){
				var strId = $("#strId").val();
				if(strId == ""){
					alert("선택한 매장이 없습니다.")
					return;	
				}
				if(!confirm("정말 삭제하시겠습니까?")){
					return;
				}
			$.post("${context}/api/str/delete/" + strId, function(response){	
				if(response.status == "200 OK"){
					location.href="${context}/str/list"; // 새로고침
				}
				else{
					
					alert(respones.errorCode + " / " + response.message);
				}
			});
		})
		
		$("#save_btn").click(function(){
			
			console.log($("#useYn").val())
			
				var strNm = $("#strNm").val();
				if(strNm == ""){
					alert("선택한 매장명이 없습니다.")
					return;	
				}
				/* else if(strNm == $("#strNm").val()){
					alert("지정한 매장명이 같습니다.")
					return;	
				} */
				var strAddr = $("#strAddr").val();
				if(strAddr == ""){
					alert("선택한 주소가 없습니다.")
					return;	
				}
				var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}");
				var res = patt.test( $("#strCallNum").val());
	
				if( !patt.test( $("#strCallNum").val()) ){
				    alert("'-'을 작성하여 전화번호를 정확히 입력하여 주십시오.");
				    return false;
				}
				/* if(strCallNum = "#strCallNum"){
					alert("선택한 전화번호는 있는 전화번호입니다.")
					return;	
				} */
				var strOpnTm = $("#strOpnTm").val();
				var strClsTm = $("#strClsTm").val();
				if(strOpnTm >= strClsTm){
					alert("선택한 오픈 시간이 클로즈 시간보다 느립니다.")
					return;	
				}
			if($("#isModify").val() == "false"){
					//수정
					$.post("${context}/api/str/update", $("#strdetailmgn_form").serialize(), function(response) {
						console.log($("#strdetailmgn_form").serialize());
					if(response.status == "200 OK"){
						location.reload(); // 새로고침
					}
					else{
						alert(response.errorCode + " / " + response.message);
						}
					});
				}
			});
			$("#search-btn").click(function(){
				movePage(0);
			});
			
			$("#all_check").change(function(){
				console.log($(this).prop("checked"));
				$(".check_idx").prop("checked", $(this).prop("checked"));
			});
			
			$(".check_idx").change(function(){
				var count = $(".check_idx").length;
				var checkCount = $(".check_idx:checked").length;
				$("#all_check").prop("checked", count == checkCount);
			});
		});
		function movePage(pageNo){
		//전송
		//입력 값.
		var strNm = $("#search-keyword").val();
		//url요청
		location.href = "${context}/str/list?strNm=" +strNm + "&pageNo=" + pageNo;
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/sidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>

			<div class="path"> 매장 관리 > 상세 조회</div>
			
			<h1>매장 상세 조회</h1>
			<div class="grid">
			<h2>중간 관리자는 오직 전화번호, 오픈시간, 클로즈시간, 사용여부만 관리가능합니다.</h2>
			<div class="grid-strdetailmgn">
				<form id="strdetailmgn_form">
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="strId" style="width:180px">매장 ID</label>
						<input type="text" id="strId" name="strId" readonly value="${strVO.strId}"/>
					</div>
					<div class="input-group inline">
						<label for="strNm" style="width:180px">매장명</label>
						<input type="text" id="strNm" name="strNm" maxlength="1000" readonly value="${strVO.strNm}"/>
					</div>
					<div class="input-group inline">
						<label for="strAddr" style="width:180px">매장주소</label>
						<input type="text" id="strAddr" name="strAddr" maxlength="200" readonly value="${strVO.strAddr}"/>
						<%-- <select name="strAddr" id="strAddr">
						<option>지역 선택</option>
							<option value="서울" ${strVO.strAddr eq '서울' ? 'selected' : ''}>서울</option>
							<option value="부산">부산</option>
							<option value="강원">강원</option>
							<option value="경기">경기</option>
							<option value="인천">인천</option>
							<option value="대구">대구</option>
						</select> --%>
					</div>
					
				    <div class="input-group inline">
				        <label for="strCallNum" style="width:180px">전화번호</label>
				        <input type="tel" name="strCallNum" id="strCallNum" title="전화번호를 입력하세요." placeholder="00*-000*-000*" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" value="${strVO.strCallNum}">
				    </div>	
				
					<div class="input-group inline">
						<label for="mbrId" style="width:180px">관리자ID</label>
						<input type="text" id="mbrId" name="mbrId" maxlength="20" readonly value="${strVO.mbrId}"/>
					</div>
					<div class="input-group inline">
						<label for="strOpnTm" style="width:180px">오픈시간</label>
						<input type="time" id="strOpnTm" name="strOpnTm" value="${strVO.strOpnTm}"/>
					</div>
					<div class="input-group inline">
						<label for="strClsTm" style="width:180px">종료시간</label>
						<input type="time" id="strClsTm" name="strClsTm" value="${strVO.strClsTm}"/>
					</div>
					
					<div class="input-group inline">
						<label for="useYn" style="width:180px">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" ${strVO.useYn == "Y" ? 'checked' : ''} value="${strVO.useYn}"/>
					</div>
				</form>
			</div>
		</div>
			<div class="align-right">
				<button id="save_btn" class="btn-primary">수정</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
				<button id="list_btn" class="btn-list">목록</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
