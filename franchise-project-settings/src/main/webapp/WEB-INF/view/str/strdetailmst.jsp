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
	<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
	<link rel="stylesheet" href="${context}/css/str_common.css?p=${date}" />
	
	<script type="text/javascript">
	function mkMap(addr, strNm){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
	
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {
	
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
	
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
	
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+strNm+'</div>'
		        });
		        infowindow.open(map, marker);
	
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        mapContainer.style.display = "block";
		        map.relayout();
		        
		        map.setCenter(coords);
		        
		        marker.setPosition(coords);
		        
		    } 
		}); 
	}
		$().ready(function() {
			/* mkMap(data.straddr, data.strnm); */
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
					mkMap(data.straddr, data.strnm);
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
						Swal.fire({
					    	  icon: 'error',
					    	  title: '선택한 매장이 없습니다.',
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						/* alert("선택한 매장이 없습니다.") */
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
							Swal.fire({
						    	  icon: 'error',
						    	  title: response.message,
						    	  showConfirmButton: false,
						    	  timer: 2500
							});
							/* alert(respones.errorCode + " / " + response.message); */
						}
					});
				})
				
				$("#save_btn").click(function(){
					var strNm = $("#strNm").val();
					if(strNm == ""){
						Swal.fire({
					    	  icon: 'error',
					    	  title: '매장명을 입력하세요.',
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						/* alert("선택한 매장명이 없습니다.") */
						return;	
					}
					/* else if(strNm == $("#strNm").val()){
						alert("지정한 매장명이 같습니다.")
						return;	
					} */
					var strAddr = $("#strAddr").val();
					if(strAddr == ""){
						Swal.fire({
					    	  icon: 'error',
					    	  title: '선택한 주소가 없습니다.',
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						/* alert("선택한 주소가 없습니다.") */
						return;	
					}
					var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}");
					var res = patt.test( $("#strCallNum").val());
			
					if( !patt.test( $("#strCallNum").val()) ){
						Swal.fire({
					    	  icon: 'error',
					    	  title: '전화번호를 확인해 주세요.',
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
					    /* alert("'-'을 작성하여 전화번호를 정확히 입력하여 주십시오."); */
					    return false;
					}
					/* if(strCallNum = "#strCallNum"){
						alert("선택한 전화번호는 있는 전화번호입니다.")
						return;	
					} */
					var strOpnTm = $("#strOpnTm").val();
					var strClsTm = $("#strClsTm").val();
					if(strOpnTm >= strClsTm){
						Swal.fire({
					    	  icon: 'error',
					    	  title: '오픈시간과 클로즈시간을 확인하세요.',
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						/* alert("선택한 오픈 시간이 클로즈 시간보다 느립니다.") */
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
								Swal.fire({
							    	  icon: 'success',
							    	  title: '수정되었습니다.',
							    	  showConfirmButton: true,
							    	  confirmButtonColor: '#3085d6'
								}).then((result)=>{
									if(result.isConfirmed){
										location.reload(); // 새로고침
									}
								});
				            	/* alert("수정되었습니다."); */
							}
							else{
								Swal.fire({
							    	  icon: 'error',
							    	  title: response.message,
							    	  showConfirmButton: false,
							    	  timer: 2500
								});
								/* alert(response.errorCode + " / " + response.message); */
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
<style> 
.select-align-center {
	text-align-last: center;
	width: auto;
	border: none;
    background-color: #0000;
    font-weight: bold;
}
.half-left {
	width: 100%;
	display: inline-block;
	
}
 .half-right {
	width: 40%; 	
	display: inline-block;
	
}
</style>	
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold"> 매장관리 > 매장 상세조회</span>
		</div>
		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 40px; margin: 20px; ">
			<h5 class="fs-5 fw-bold" style="padding:10px">매장 정보</h5>
			<form id="strdetailmst_form">
				<div class="flex">
					<div class="half-left">
						<input type="hidden" id="isModify" value="false" />
						<div style="display: inline-block; width: 45%;">
							<div class="input-group inline">
								<span class="input-group-text">가맹점주ID</span>
								<input class="form-control" type="text" id="mbrId" name="mbrId" maxlength="20" value="${strVO.mbrId}"  />
							</div>
						    <div class="input-group inline">
						        <span class="input-group-text">연락처</span>
						        <input class="form-control" type="tel" name="strCallNum" id="strCallNum" title="전화번호를 입력하세요." placeholder="00*-000*-000*" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" value="${strVO.strCallNum}">
						    </div>
					
							<div class="input-group inline">
								<span class="input-group-text">오픈시간</span>
								<input class="form-control" type="time" id="strOpnTm" name="strOpnTm" value="${strVO.strOpnTm}"/>
							</div>
							<div class="input-group inline">
								<span class="input-group-text">종료시간</span>
								<input class="form-control" type="time" id="strClsTm" name="strClsTm" value="${strVO.strClsTm}"/>
							</div>
							
						</div>
						<div style="display: inline-block; width: 45%;">
							<div class="input-group inline">
								<span class="input-group-text ">등록자</span>
								<input class="form-control readonly" type="text" id="strRgstr" name="strRgstr" maxlength="20" readonly value="${strVO.strRgstr}" />
							</div>
							<div class="input-group inline">
								<span class="input-group-text">등록일</span>
								<input class="form-control readonly" type="text" id="strRgstDt" name="strRgstDt" readonly value="${strVO.strRgstDt}" />
							</div>
							<div class="input-group inline">
								<span class="input-group-text">수정자</span>
								<input class="form-control readonly" type="text" id="mdfyr" name="mdfyr" maxlength="20" readonly value="${MbrVO.mbrId}"/>
							</div>
							<div class="input-group inline">
								<span class="input-group-text">수정일</span>
								<input class="form-control readonly" type="text" id="mdfyDt" name="mdfyDt" readonly value="${strVO.mdfyDt}" />
							</div>
							


						</div>
					</div>
					<div class="half-right">
						<div class="input-group inline">
							<span class="input-group-text">매장ID</span>
							<input class="form-control readonly" type="text" id="strId" name="strId" readonly value="${strVO.strId}" />
						</div>
						<div class="input-group inline">
							<span class="input-group-text">매장명</span>
							<input class="form-control " type="text" id="strNm" name="strNm" maxlength="1000" value="${strVO.strNm}" />
						</div>	
						<div class="input-group inline">
							<span class="input-group-text">지역</span>
							<select class="form-select " id="strLctn" name="strLctn" >
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
							</div>	
						<div class="input-group inline">
							<span class="input-group-text">도시</span>
							<select class="form-select " id="strCty" name="strCty" >
								<option value="" >도시명</option>
								<c:choose>
									<c:when test="${not empty ctyList}" >
										<c:forEach items="${ctyList}"
													var="cty" >
											<option value="${cty.ctyId}" ${cty.ctyId eq	 strVO.strCty ? 'selected' : ''}>${cty.ctyNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</div>
						<div class="input-group inline">
							<span class="input-group-text">매장주소</span>
							<input class="form-control " type="text" id="strAddr" name="strAddr" maxlength="200" value="${strVO.strAddr}"/>
						</div>
						<div style="float: right; margin-top: 12px;">
							<div style="display:inline-block; margin-right: 10px;">
								<label class="form-check-label">사용여부</label>
								<input class="form-check-input" type="checkbox" id="useYn" name="useYn" ${strVO.useYn == "Y" ? 'checked' : ''} value="Y"/>
							</div>
							<button id="save_btn" class="btn btn-outline-primary btn-default">매장 수정</button>
						</div>
				
						
		
					</div>
				</div>
			</form>
		</div>
	<div class="table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
		<!-- 관리자 리스트 -->
		<div style="margin: 13px;">총 ${mbrList.size()}명</div>
		<table class="table caption-top table-hover" style="text-align: center;">
			<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;"> 
				<tr>
					<th>ID</th>
					<th>이름</th>
					<th>이메일</th>
					<th>매장명</th>
					<th>회원등급</th>
					<th>가입일</th>
					<th>최근 로그인 날짜</th>
					<th>최근 로그인 IP</th>
					<th>로그인 제한</th>
					
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty mbrList}">
						<c:forEach items="${mbrList}" var="mbr" varStatus="index">
							<tr data-mbrId="${mbr.mbrId}" 
								data-mbrNm="${mbr.mbrNm }" 
								data-strId="${mbr.strId }" 
								data-mbrEml="${mbr.mbrEml }" 
								data-mbrLvl="${mbr.mbrLvl }" 
								data-mbrLvlNm ="${mbr.cmmnCdVO.cdNm}"
								data-mbrRgstrDt="${mbr.mbrRgstrDt }" 
								data-useYn="${mbr.useYn}" 
								data-mbrRcntLgnDt="${mbr.mbrRcntLgnDt }" 
								data-mbrRcntLgnIp="${mbr.mbrRcntLgnIp}" 
								data-mbrLgnFlCnt="${mbr.mbrLgnFlCnt }" 
								data-mbrLgnBlckYn="${mbr.mbrLgnBlckYn}" 
								data-mbrLstLgnFlDt="${mbr.mbrLstLgnFlDt }" 
								data-mbrPwdChngDt="${mbr.mbrPwdChngDt }" 
								data-mbrLeavDt="${mbr.mbrLeavDt}"
								data-delYn="${mbr.delYn}"
								>

								<td>${mbr.mbrId}</td>
								<td>
									<a href="${context}/mbr/detail/${mbr.mbrId}">${mbr.mbrNm}</a>
								</td>
								<td>${mbr.mbrEml}</td>
								<td>${mbr.strVO.strNm}</td>
								<td>${mbr.cmmnCdVO.cdNm}</td>
								<td>${mbr.mbrRgstrDt}</td>
								<td>${mbr.mbrRcntLgnDt}</td>
								<td>${mbr.mbrRcntLgnIp}</td>
								<td>${mbr.mbrLgnBlckYn}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="10" class="no-items">등록된 관리자가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>		
	</div>

	

<jsp:include page="../include/closeBody.jsp" />
</html>
