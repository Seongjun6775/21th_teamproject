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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script type="text/javascript">
	$().ready(function() {
		$(".table_grid > table > tbody > tr").click(function(){
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
				
				$.get("${context}/api/str/changecty", {"lctId": strLctn}, function(response){})
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
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">매장 > 매장조회</span>
	    </div>
	    
	    <!-- searchbar -->
		<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
		  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
		  <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="margin: 15px;">
		    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
		  </svg>	
		    <select id="search-select" class="form-select input-text" style="margin-right: 10px; width: 30%;" aria-label="Default select example">
				<option value="">검색 조건</option>
				<option value="strNm"${searchIdx eq 'strNm' ?  'selected': ''}>매장명</option>
				<option value="mbrId"${searchIdx eq 'mbrId' ?  'selected': ''}>점주ID</option>
		    </select>
		    <input class="form-control me-2" type="text" id="search-keyword" value="${keyword}" placeholder="Search" aria-label="Search">
		    <button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px;">Search</button>
		</div>
		<!-- /searchbar -->	
		<div class="table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
		<div style="margin: 13px;">총${strList.size() > 0 ? strList.get(0).totalCount : 0}건</div>	
			<table class="table caption-top table-hover" style="text-align: center;">
				<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
					<tr>
						<th scope="col" style="border-radius: 6px 0 0 0; padding: 20px 20px 8px 20px;"><input type="checkbox" id="all_check" /></th>
						<th scope="col" style="width:250px; padding: 20px 20px 8px 20px;">매장명</th>
						<th scope="col" style="padding: 20px 20px 8px 20px; width: 150px">
							<select class="form-select" name="selectFilter" 
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
						<th scope="col" style="padding: 20px 20px 8px 20px; width: 150px">
							<select class="form-select" name="selectFilter"
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
						<th scope="col" style="padding: 20px 20px 8px 20px;">매장주소</th>
						<th scope="col" style="padding: 20px 20px 8px 20px;">전화번호</th>
						<th scope="col" style="padding: 20px 20px 8px 20px;">점주ID</th>
						<th scope="col" style=" width:120px;border-radius: 0 6px 0 0; padding: 20px 20px 8px 20px;">상세조회</th>
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
				<nav aria-label="Page navigation example">
					<ul class="pagination" style="text-align: center;">
						<c:set value="${strList.size() > 0 ? strList.get(0).lastPage : 0}" var="lastPage"/>
						<c:set value="${strList.size() > 0 ? strList.get(0).lastGroup : 0}" var="lastGroup"/>
						
						<fmt:parseNumber var="nowGroup" value="${Math.floor(strVO.pageNo / 10)}" integerOnly="true"/>
						<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
						<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
						<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo"/>
					
						
						<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo"/>
						<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo"/>
					
						<c:if test="${nowGroup > 0}">
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartpageNo})">이전</a></li>
						</c:if>
						
						<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
							<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq strVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
						</c:forEach>
					
						<c:if test=" ${lastGroup > nowGroup}">
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
		<div class="col-2 admin_detail_table_grid bg-white rounded shadow-sm" style="padding: 30px; width: 1613px; margin:20px; height: auto;">
				<div class="grid-detail">
				<h5 style="padding:10px">매장 정보</h5>
				<form id="strdetailmst_form" class="needs-validation">
					<input type="hidden" id="isModify" value="false" />
					<div class="row g-3 " style="display: inline-block; width: 50%;">
						<div class="input-group col-12">
							<span class="input-group-text">매장 ID</span>
							<input type="text" id="strId" name="strId" readonly value="${strVO.strId}" class="form-control readonly"  />
						</div>
						
						<div class="input-group inline">
							<span class="input-group-text">매장명</span>
							<input type="text" id="strNm" name="strNm" maxlength="1000" value="${strVO.strNm}" class="form-control"/>
						</div>
						<div class="input-group inline">
							<span class="input-group-text">지역명</span>
							<select class="form-select" name="strLctn" id="strLctn">
								<option value="">지역명</option>
								<c:choose>
									<c:when test="${not empty lctList}">
										<c:forEach items="${lctList}" var="lct">
											<option value="${lct.lctId}" ${strVO.strLctn eq lct.lctId ? 'selected' : ''}>${lct.lctNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</div>
						<div class="input-group inline">
							<span class="input-group-text">도시명</span>
							<select class="form-select" name="strCty" id="strCty">
								<option value="">도시명</option>
								<c:choose>
									<c:when test="${not empty ctyList}">
										<c:forEach items="${ctyChangedList != null ? ctyChangedList : ctyList}" var="cty">
											<option value="${cty.ctyId}" ${strVO.strCty eq cty.ctyId ? 'selected' : ''}>${cty.ctyNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</div>
		
						<div class="input-group inline" >
							<span class="input-group-text">매장주소</span>
							<input class="form-control" type="text" id="strAddr" name="strAddr" maxlength="200" value="${strVO.strAddr}"/>
						</div>
					    <div class="input-group inline">
					        <span class="input-group-text">전화번호</span>
					        <input class="form-control" type="tel" name="strCallNum" id="strCallNum" title="전화번호를 입력하세요." placeholder="00*-000*-000*" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" value="${strVO.strCallNum}">
					    </div>	
					
						<div class="input-group inline">
							<span class="input-group-text">점주ID</span>
							<input class="form-control"  type="text" id="mbrId" name="mbrId" maxlength="20" value="${strVO.mbrId}"/>
						</div>
						</div>
						
						<div class="row g-3 half-right" style="display: inline-block; width: 30%; margin-left: 30px;">
						<div class="input-group inline">
							<span class="input-group-text">오픈시간</span>
							<input class="form-control"  type="time" id="strOpnTm" name="strOpnTm" value="09:00:00"/>
						</div>
						<div class="input-group inline">
							<span class="input-group-text">종료시간</span>
							<input class="form-control"  type="time" id="strClsTm" name="strClsTm" value="18:00:00"/>
						</div>
						<div class="input-group inline">
							<span class="input-group-text">등록자</span>
							<input class="form-control readonly"  type="text" id="strRgstr" name="strRgstr" maxlength="20" readonly value="${mbrVO.mbrId}"  />
						</div>
						<div class="input-group inline">
							<span class="input-group-text">등록일</span>
							<input class="form-control readonly"  type="text" id="strRgstDt" name="strRgstDt" readonly value="${strVO.strRgstDt}"/>
						</div>
						<div class="input-group inline">
							<span class="input-group-text">수정자</span>
							<input class="form-control readonly"  type="text" id="mdfyr" name="mdfyr" maxlength="20" readonly value="${mbrVO.mbrId}" />
						</div>
						<div class="input-group inline">
							<span class="input-group-text">수정일</span>
							<input class="form-control readonly"  type="text" id="mdfyDt" name="mdfyDt" readonly value="${strVO.mdfyDt}" 	/>
						</div>
						<div class="inline">
							<label class="form-check-label">사용여부</label>
							<input class="form-check-input" type="checkbox" id="useYn" name="useYn" ${strVO.useYn == "Y" ? 'checked' : ''} value="Y"/>
						</div>
						<div style="float:right; display: flex; flex-direction: row-reverse;">
							<button id="new_btn" class="btn btn-outline-primary" style="margin-right: 10px;">신규</button>
							<button id="save_btn" class="btn btn-outline-success">등록</button>
						</div>
					</div>
				</form>
			</div>
		</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
