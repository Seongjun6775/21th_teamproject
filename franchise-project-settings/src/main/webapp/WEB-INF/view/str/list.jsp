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
			$("#strLctn").val(data.strlctn);
			$("#strCty").val(data.strcty);
			$("#strAddr").val(data.straddr);
			$("#strCallNum").val(data.strcallnum);
			$("#mbrId").val(data.mbrid + "(" + data.mbrnm + ")");
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
			$("#strRgstr").val("${mbrVO.mbrId}");
			$("#strRgstDt").val("");
			$("#mdfyr").val("${mbrVO.mbrId}");
			$("#mdfyDt").val("");
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
			
			$("#index_btn").click(function(){
				location.href= "${context}/index";
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
			
			$("#search-keyword-strLctn").change(function(){
				movePage(0);
			});
			$("#search-keyword-strCty").change(function(){
				movePage(0);
			});
			
			$("#strLctn").change(function() {
				
				var strLctn = $("#strLctn").val();
				
				console.log(strLctn);
				console.log(strLctn);
				console.log(strLctn);
				console.log(strLctn);
				
				$.get("${context}/api/str/changecty", {"lctId": strLctn}, function(response){
					
				})
			});
			
		});
		function movePage(pageNo){
		//전송
		//입력 값.
		var searchIdx = $("#search-select").val();
		var keyword = $("#search-keyword").val();
		var strLctn = $("#search-keyword-strLctn").val();
		var strCty = $("#search-keyword-strCty").val();
		
		var queryString = "searchIdx=" + searchIdx;
		queryString += "&keyword=" + keyword;
		queryString += "&strLctn=" +strLctn;
		queryString += "&strCty=" +strCty;
		queryString += "&pageNo=" +pageNo;
		
		
		//url요청
		location.href = "${context}/str/list?" + queryString;
		}
		</script>
</head>

<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
		
			<div class="path"> 매장 관리
				<div class="search-group" >	
					<div class=" col-sm-3 col-xs-4">
						<select id="search-select" class="input-text" style="width: 97%;" >
							<option value="strNm"${searchIdx eq 'strNm' ?  'selected': ''}>매장명</option>
							<option value="mbrId"${searchIdx eq 'mbrId' ?  'selected': ''}>점주ID</option>
						</select> 
					</div>  
						<input name="keyword" type="text" class="input-text" placeholder="검색어를 입력해주세요" id="search-keyword"  style="width: 95%; height: 25px;" value="${keyword}" >
						<button class="btn-search" id="search-btn" style="width: 42px;">검색</button>
				</div>
				
				<!-- <div class="search-group">
					<label for="search-keyword">매장명</label>
					<input type="text" id="search-keyword" class="search-input" value="" />
					<button class="btn-search" id="search-btn">검색</button>
					<label for="search-keyword">관리자ID 조회</label>
					<input type="text" id="search-keyword-mbrId" class="search-input" value=""/>
					<button class="btn-search" id="search-btn">검색</button>
				</div> -->
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
						<th>매장명</th>
						<th>
							<select class="selectFilter" name="selectFilter"
										id="search-keyword-strLctn">
								<option value="">지역명</option>
								<c:choose>
									<c:when test="${not empty lctList}">
										<c:forEach items="${lctList}"
													var="lct"> 
											<option value="${lct.lctId}" ${strVO.strLctn eq lct.lctId ? 'selected' : ''}>${lct.lctNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</th>
						<th>
							<select class="selectFilter" name="selectFilter"
										id="search-keyword-strCty">
								<option value="">도시명</option>
								<c:choose>
									<c:when test="${not empty ctyList}">
										<c:forEach items="${ctyList}"
													var="cty" >
											<option value="${cty.ctyId}" ${strVO.strCty eq cty.ctyId ? 'selected' : ''}>${cty.ctyNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</th>
						<th>매장주소</th>
						<th>전화번호</th>
						<th>점주ID</th>
						<th>상세조회</th>
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
							data-strlctn="${str.lctCdVO.lctId}" 
							data-strcty="${str.ctyCdVO.ctyId}" 
							data-straddr="${str.strAddr}" 
							data-strcallnum="${str.strCallNum}" 
							data-mbrid="${str.mbrId}" 
							data-mbrnm="${str.mbrVO.mbrNm}" 
							data-stropntm="${str.strOpnTm}" 
							data-strclstm="${str.strClsTm}" 
							data-strrgstr="${str.strRgstr}" 
							data-strrgstdt="${str.strRgstDt}" 
							data-mdfyr="${str.mdfyr}" 
							data-mdfydt="${str.mdfyDt}" 
							data-useyn="${str.useYn}" >
							<td>
								<input type="checkbox" class="check_idx" value="${str.strId}"/>
							</td>
								<td>${str.strNm}</td>
								<td>${str.lctCdVO.lctNm}</td>
								<td>${str.ctyCdVO.ctyNm}</td>
								<td>${str.strAddr}</td>
								<td>${str.strCallNum}</td>
								<td>
								  <c:choose>
								    <c:when test="${empty str.mbrId}">
								      점주ID가 없습니다.
								    </c:when>
								    <c:otherwise>
								      ${str.mbrId} (${str.mbrVO.mbrNm})
								    </c:otherwise>
								  </c:choose>
								</td>
								<td style="width: 70px;">
									<a href="${context}/str/strdetailmst/${str.strId}">
									<input type="button" value="이동"/>
									</a>
								</td>
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
					<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo"/>
				
					
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
			<div class="grid-strdetailmst" style="margin-top: 10px;">
				<form id="strdetailmst_form">
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="strId" style="width:180px">매장 ID</label>
						<input type="text" id="strId" name="strId" readonly value="${strVO.strId}"  style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="strNm" style="width:180px">매장명</label>
						<input type="text" id="strNm" name="strNm" maxlength="1000" value="${strVO.strNm}"/>
					</div>
					<div class="input-group inline">
						<%-- 
						<select id="search-keyword-strLctn" name="strLctn">
							<option value="">지역</option>
							<c:choose>
								<c:when test="${not empty lctList}">
									<c:forEach items="${lctList}"
												var="lct"> 
										<option value="${lct.lctId}" ${strVO.strLctn eq lct.lctId ? 'selected' : ''}>${lct.lctNm}</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
						<label for="strCty" style="width:60px">도시</label>
						<select id="search-keyword-strCty" name="strCty">
							<option value="">도시명</option>
							<c:choose>
								<c:when test="${not empty ctyList}">
									<c:forEach items="${ctyList}"
												var="cty" >
										<option value="${cty.ctyId}" ${strVO.strCty eq cty.ctyId ? 'selected' : ''}>${cty.ctyNm}</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select> --%>
						<label for="strLctn" style="width:60px">지역</label>
						<select class="selectFilter" name="strLctn"
								id="strLctn">
						<option value="">지역명</option>
							<c:choose>
								<c:when test="${not empty lctList}">
									<c:forEach items="${lctList}"
												var="lct"> 
										<option value="${lct.lctId}" ${strVO.strLctn eq lct.lctId ? 'selected' : ''}>${lct.lctNm}</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
						<label for="strCty" style="width:60px">도시</label>
						<select class="selectFilter" name="strCty"
								id="strCty">
						<option value="">도시명</option>
							<c:choose>
								<c:when test="${not empty ctyList}">
									<c:forEach items="${ctyChangedList ne null ? ctyChangedList : ctyList}"
												var="cty" >
										<option value="${cty.ctyId}" ${strVO.strCty eq cty.ctyId ? 'selected' : ''}>${cty.ctyNm}</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
						
					</div>
					<div class="input-group inline">
						<label for="strAddr" style="width:60px">매장주소</label>
						<input type="text" id="strAddr" name="strAddr" maxlength="200" value="${strVO.strAddr}"/>
					</div>
				    <div class="input-group inline">
				        <label for="strCallNum" style="width:180px;">전화번호</label>
				        <input type="tel" name="strCallNum" id="strCallNum" title="전화번호를 입력하세요." placeholder="00*-000*-000*" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" value="${strVO.strCallNum}">
				    </div>	
				
					<div class="input-group inline">
						<label for="mbrId" style="width:180px">점주ID</label>
						<%-- <select id="mbrId" name="mbrId">
							<option value="">점주ID명</option>
							<c:choose>
								<c:when test="${not empty mbrList}">
									<c:forEach items="${mbrList}"
												var="mbr" >
										<option value="${mbr.mbrId}">${mbr.mbrId}</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select> --%>
						<input type="text" id="mbrId" name="mbrId" maxlength="20" value="${strVO.mbrId}"/>
					</div>
					<div class="input-group inline">
						<label for="strOpnTm" style="width:180px">오픈시간</label>
						<input type="time" id="strOpnTm" name="strOpnTm" value="09:00:00"/>
					</div>
					<div class="input-group inline">
						<label for="strClsTm" style="width:180px">종료시간</label>
						<input type="time" id="strClsTm" name="strClsTm" value="18:00:00"/>
					</div>
					<div class="input-group inline">
						<label for="strRgstr" style="width:180px">등록자</label>
						<input type="text" id="strRgstr" name="strRgstr" maxlength="20" readonly value="${mbrVO.mbrId}"  style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="strRgstDt" style="width:180px">등록일</label>
						<input type="text" id="strRgstDt" name="strRgstDt" readonly value="${strVO.strRgstDt}"  style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="mdfyr" style="width:180px">수정자</label>
						<input type="text" id="mdfyr" name="mdfyr" maxlength="20" readonly value="${mbrVO.mbrId}"  style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="mdfyDt" style="width:180px">수정일</label>
						<input type="text" id="mdfyDt" name="mdfyDt" readonly value="${strVO.mdfyDt}"  style="background-color:orange"/>
					</div>
					<div class="input-group inline">
						<label for="useYn" style="width:180px">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" ${strVO.useYn == "Y" ? 'checked' : ''} value="Y"/>
					</div>
				</form>
			</div>
		</div>
			<div class="align-right">
				<button id="new_btn" class="btn-primary">신규</button>
				<button id="save_btn" class="btn-primary">등록</button>
				<button id="index_btn" class="btn-index">처음 페이지로 돌아가기</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
