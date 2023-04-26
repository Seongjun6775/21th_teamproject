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
				
				/* $(".grid > table > tbody > tr").click(function(){
					$("#isModify").val("true"); //수정모드
					var data = $(this).data();
					$("#strId").val(data.strid);
					$("#strNm").val(data.strnm);
					$("#strLctn").val(data.strlctn);
					$("#strCty").val(data.strcty);
					$("#strAddr").val(data.straddr);
					$("#strCallNum").val(data.strcallnum);
					$("#mbrId").val(data.mbrid);
					$("#strOpnTm").val(data.stropntm);
					$("#strClsTm").val(data.strclstm);
					$("#strRgstr").val(data.strrgstr);
					$("#strRgstDt").val(data.strrgstdt);
					$("#mdfyr").val(data.mdfyr);
					$("#mdfyDt").val(data.mdfydt);
					$("#useYn").prop("checked", data.useyn == "Y");
				});
				$("#new_btn").click(function() {
					$("#isModify").val("false"); //등록모드
					$("#strId").val("");
					$("#strNm").val("");
					$("#strLctn").val("");
					$("#strCty").val("");
					$("#strAddr").val("");
					$("#strCallNum").val("");
					$("#mbrId").val("");
					$("#strOpnTm").val("");
					$("#strClsTm").val("");
					$("#strRgstr").val("");
					$("#strRgstDt").val("");
					$("#mdfyr").val("");
					$("#mdfyDt").val("");
					$("#useYn").prop("checked", false);
				}); */
				
				$("#list_btn").click(function(){
					location.href= "${context}/str/list";
				});
				
				$("#index_btn").click(function(){
					location.href= "${context}/index";
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
					if (!confirm("정말 수정하시겠습니까?")) {
						return;	
				    }
					if($("#isModify").val() == "false"){
							//수정
							$.post("${context}/api/str/update", $("#strdetailmst_form").serialize(), function(response) {
								console.log($("#strdetailmst_form").serialize());
							if(response.status == "200 OK"){
				            	alert("수정되었습니다.");
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
			
			<div class="grid-strdetailmst">
				<form id="strdetailmst_form">
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="strId" style="width:180px">매장 ID</label>
						<input type="text" id="strId" name="strId" readonly value="${strVO.strId}" style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="strNm" style="width:180px">매장명</label>
						<input type="text" id="strNm" name="strNm" maxlength="1000" value="${strVO.strNm}"/>
					</div>
					
					<div class="input-group inline">
						<label for="strLctn" style="width:180px">지역</label>
						<select id="strLctn" name="strLctn" >
							<option value="">지역명</option>
							<c:choose>
								<c:when test="${not empty lctList}">
									<c:forEach items="${lctList}"
												var="lct"> 
										<option value="${lct.lctId}" ${lct.lctId eq strVO.strLctn ? 'selected' : ''}>${lct.lctNm} </option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
						<label for="strCty" style="width:180px">도시</label>
						<select id="strCty" name="strCty">
							<option value="">도시</option>
							<c:choose>
								<c:when test="${not empty ctyList}">
									<c:forEach items="${ctyList}"
												var="cty" >
										<option value="${cty.ctyId}" ${cty.ctyId eq	 strVO.strCty ? 'selected' : ''}>${cty.ctyNm}</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
					</div>
					
				    <div class="input-group inline">
						<label for="strAddr" style="width:180px">매장주소</label>
						<input type="text" id="strAddr" name="strAddr" maxlength="200" value="${strVO.strAddr}"/>
					</div>
				    <div class="input-group inline">
				        <label for="strCallNum" style="width:180px">전화번호</label>
				        <input type="tel" name="strCallNum" id="strCallNum" title="전화번호를 입력하세요." placeholder="00*-000*-000*" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" value="${strVO.strCallNum}">
				    </div>	
				
					<div class="input-group inline">
						<label for="mbrId" style="width:180px">점주ID</label>
						<input type="text" id="mbrId" name="mbrId" maxlength="20" value="${strVO.mbrId}" />
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
						<label for="strRgstr" style="width:180px">등록자</label>
						<input type="text" id="strRgstr" name="strRgstr" maxlength="20" readonly value="${strVO.strRgstr}" style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="strRgstDt" style="width:180px">등록일</label>
						<input type="date" id="strRgstDt" name="strRgstDt" readonly value="${strVO.strRgstDt}" style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="mdfyr" style="width:180px">수정자</label>
						<input type="text" id="mdfyr" name="mdfyr" maxlength="20" readonly value="${MbrVO.mbrId}" style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="mdfyDt" style="width:180px">수정일</label>
						<input type="date" id="mdfyDt" name="mdfyDt" readonly value="${strVO.mdfyDt}" style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="useYn" style="width:180px">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" ${strVO.useYn == "Y" ? 'checked' : ''} value="Y"/>
					</div>
				</form>
			</div>
		</div>
			<div class="align-right">
				<button id="save_btn" class="btn-primary">수정</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
				<button id="list_btn" class="btn-list">목록</button>
				<button id="index_btn" class="btn-index">처음 페이지로 돌아가기</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
