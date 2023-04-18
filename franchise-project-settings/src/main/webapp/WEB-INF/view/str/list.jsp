<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
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
					location.reload(); // 새로고침
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
				/* if(strNm == $("#strNm").val()){
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
					alert("'-'을 기입하지 않았거나, 전화번호가 일치하지 않습니다. 전화번호를 정확히 입력하여 주십시오.");
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
				$.post("${context}/api/str/create", $("#strdetailmst_form").serialize(), function(response) {
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
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
		
			<div class="path"> 매장 관리</div>
				<div class="search-group">
					<label for="search-keyword">매장명</label>
					<input type="text" id="search-keyword" class="search-input" value=""/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
				
			<h1>매장 전체 조회</h1>
			
			<div class="grid">
				
					<div class="grid-count align-right">
					 	총${strList.size() > 0 ? strList.get(0).totalCount : 0}건
					</div>
				
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>매장ID</th>
						<th>매장명</th>
						<th>매장주소</th>
						<th>전화번호</th>
						<th>관리자ID</th>
						<!-- <th>오픈시간</th>
						<th>종료시간</th>
						<th>사용여부</th> -->
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty strList}">
							<c:forEach items="${strList}"
									var="str">
							<tr data-strid="${str.strId}" 
							data-strnm="${str.strNm}" 
							data-straddr="${str.strAddr}" 
							data-strcallnum="${str.strCallNum}" 
							data-mbrid="${str.mbrId}" 
							data-stropntm="${str.strOpnTm}" 
							data-strclstm="${str.strClsTm}" 
							data-useyn="${str.useYn}" >
							<td>
								<input type="checkbox" class="check_idx" value="${str.strId}"/>
							</td>
								<td><a href="${context}/str/strdetailmst/${str.strId}">${str.strId}</a></td>
								<td>${str.strNm}</td>
								<td>${str.strAddr}</td>
								<td>${str.strCallNum}</td>
								<td>${str.mbrId}</td>
								<%-- <td>${str.strOpnTm}</td>
								<td>${str.strClsTm}</td>
								<td>${str.useYn}</td> --%>
							</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="9" class="no-items">
									등록된 매장이 없습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="pagenate">
				<ul>
					<c:set value="${strList.size() > 0 ? strList.get(0).lastPage : 0}" var="lastPage"/>
					<c:set value="${strList.size() > 0 ? strList.get(0).lastGroup : 0}" var="lastGroup"/>
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(strVO.pageNo / 10)}" integerOnly="true"/>
					<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
					<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
					<c:set value="${groupEndPageNo > lastPage ? lastPage -1 : groupEndPageNo-1}" var="groupEndPageNo"/>
				
					
					<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo"/>
					<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo"/>
				
					<c:if test="${nowGroup > 0}">
						<li><a href="javascript:movePage(0)">처음</a></li>
						<li><a href="javascript:movePage(${prevGroupStartpageNo})">이전</a></li>
					</c:if>
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li><a class="${pageNo eq strVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
				
					<c:if test=" ${lastGroup > nowGroup}">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>
			<div class="grid-strdetailmst">
				<form id="strdetailmst_form">
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="strId" style="width:180px">매장 ID</label>
						<input type="text" id="strId" name="strId" readonly value=""/>
					</div>
					<div class="input-group inline">
						<label for="strNm" style="width:180px">매장명</label>
						<input type="text" id="strNm" name="strNm" maxlength="1000" value="${strVO.strNm}"/>
					</div>
					<div class="input-group inline">
						<label for="strAddr" style="width:180px">매장주소</label>
						<input type="text" id="strAddr" name="strAddr" maxlength="200" value="${strVO.strAddr}"/>
						<select name="strAddr" id="strAddr">
						<option>지역 선택</option>
							<option value="서울" ${strVO.strAddr eq '서울' ? 'selected' : ''}>서울</option>
							<option value="부산">부산</option>
							<option value="강원">강원</option>
							<option value="경기">경기</option>
							<option value="인천">인천</option>
							<option value="대구">대구</option>
						</select>
					</div>
					
				    <div class="input-group inline">
				        <label for="strCallNum" style="width:180px">전화번호</label>
				        <input type="tel" name="strCallNum" id="strCallNum" title="전화번호를 입력하세요." placeholder="00*-000*-000*" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" value="${strVO.strCallNum}">
				    </div>	
				
					<div class="input-group inline">
						<label for="mbrId" style="width:180px">관리자ID</label>
						<input type="text" id="mbrId" name="mbrId" maxlength="20" value="${strVO.mbrId}"/>
					</div>
					<div class="input-group inline">
						<label for="strOpnTm" style="width:180px">오픈시간</label>
						<input type="time" id="strOpnTm" name="strOpnTm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strClsTm" style="width:180px">종료시간</label>
						<input type="time" id="strClsTm" name="strClsTm" value=""/>
					</div>
					
					<div class="input-group inline">
						<label for="useYn" style="width:180px">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" value="Y"/>
					</div>
				</form>
			</div>
		</div>
			<div class="align-right">
				<button id="new_btn" class="btn-primary">신규</button>
				<button id="save_btn" class="btn-primary">등록</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
