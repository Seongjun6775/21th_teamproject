<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		var url;
		$(".open-layer").click(function(event) {
			var mbrId = $(this).text();
			$("#layer_popup").css({
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF",
				"position": "absolute",
				"border": "solid 1px #222",
				"z-index": "10px"
			}).show();
			url = "${context}/nt/ntcreate/" + mbrId
		});
		
		$(".send-memo-btn").click(function() {
			if (url) {
				location.href = url;
			}
		});
		
		$(".close-memo-btn").click(function() {
			url = undefined;
			$("#layer_popup").hide();
		});
		
		$("#create-btn").click(function() {
			location.href="${context}/hr/hrcreate"
		});
		
		$(".hr_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.hrid != null && (data.hrid) != "") {
				location.href="${context}/hr/hrmstrdetail/" + data.hrid;
			}
		});
		$("#search_btn").click(function() {
			movePage(0);
		});
		$("#hrLvl, #hrStat, #delYn").change(function() {
			movePage(0);
		});
	});
	function movePage(pageNo) {
		
		var searchIdx = $("#search_idx").val();
		var keyword = $("#search-keyword").val();
		var hrLvl = $("#hrLvl").val();
		var hrStat = $("#hrStat").val();
		var delYn = $("#delYn").val();
		var startDt = $("#startDt").val();
		var endDt = $("#endDt").val();
		
		var intStartDt = parseInt(startDt.split("-").join(""));
		var intEndDt = parseInt(endDt.split("-").join(""));
		
		if(intStartDt > intEndDt) {
			alert("시작일자는 종료일자보다 늦을 수 없습니다!");
			return;
		}
		
		var queryString = "searchIdx=" + searchIdx;
		queryString += "&keyword=" + keyword;
		queryString += "&startDt=" + startDt;
		queryString += "&endDt=" + endDt;
		queryString += "&hrLvl=" + hrLvl;
		queryString += "&hrStat=" + hrStat;
		queryString += "&delYn=" + delYn;
		queryString += "&pageNo=" + pageNo;
		
		location.href = "${context}/hr/hrmstrlist?" + queryString;
	}
	
</script>

</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">회원 > 채용관리</span>
	    </div>
		<!-- searchbar -->
		<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
		  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
		  <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="margin: 15px;">
		    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
		  </svg>
		  <input class="form-control " style="margin-right: 10px; width: 30%;" type="date" id="startDt" name="startDt" value="${hrVO.startDt}">
		  <input class="form-control" style="margin-right: 40px; width: 30%;" type="date" id="endDt" name="endDt" value="${hrVO.endDt}">
		    <select id="search_idx" class="form-select" style="margin-right: 10px; width: 30%;" aria-label="Default select example">
				<option value="">검색 조건</option>
				<option value="hrTtl" ${searchIdx eq "hrTtl" ? 'selected' : '' }>제목</option>
				<option value="mbrId" ${searchIdx eq "mbrId" ? 'selected' : '' }>지원자</option>
		    </select>
		    <input class="form-control me-2" type="text" id="search-keyword" value="${keyword}" placeholder="Search" aria-label="Search">
		    <button id="search_btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px;">Search</button>
		</div>
		<!-- /searchbar -->	
		    
		<!-- contents -->
		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				
				<div style="margin: 13px;">총 ${hrList.size() > 0 ? hrList.get(0).totalCount : 0}건</div>
				<table class="table caption-top table-hover" style="text-align: center;">
					<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
						<tr>
							<th scope="col" style="border-radius: 6px 0 0 0; padding: 20px 20px 8px 20px;">작성자</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;" >
								<select id="hrLvl" class="form-select" aria-label="Default select example">
									<option value="">지원 직군</option>
									<option value="005-01" ${hrVO.hrLvl eq "005-01" ? 'selected' : '' }>점주</option>
									<option value="005-02" ${hrVO.hrLvl eq "005-02" ? 'selected' : '' }>사원</option>
								</select>
							</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">제목</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">등록일</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">승인 여부</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">
								<select id="hrStat" class="form-select" aria-label="Default select example">
									<option value="">채용 상태</option>
									<option value="002-01" ${hrVO.hrStat eq "002-01" ? 'selected' : '' }>접수</option>
									<option value="002-02" ${hrVO.hrStat eq "002-02" ? 'selected' : '' }>심사중</option>
									<option value="002-03" ${hrVO.hrStat eq "002-03" ? 'selected' : '' }>심사완료</option>
								</select>
							</th>
							<th scope="col" style="border-radius: 0 6px 0 0; padding: 20px 20px 8px 20px;" >
								<select id="delYn" class="form-select" aria-label="Default select example">
									<option value="">삭제 여부</option>
									<option value="Y" ${hrVO.delYn eq "Y" ? 'selected' : '' }>삭제됨</option>
									<option value="N" ${hrVO.delYn eq "N" ? 'selected' : '' }>삭제되지 않음</option>
								</select>
							</th>
						</tr>
					</thead> 
					<tbody>
						<c:choose>
							<c:when test="${not empty hrList}">
								<c:forEach items="${hrList}" var="hr">
									<tr data-hrid="${hr.hrId}"
									    data-mbrid="${hr.mbrId}"
									    data-mbrnm="${hr.mbrVO.mbrNm}"
									    data-hrlvl="${hr.hrLvl}"
									    data-hrttl="${hr.hrTtl}"
									    data-hrrgstdt="${hr.hrRgstDt}"
									    data-hrapryn="${hr.hrAprYn}"
									    data-hrstat="${hr.hrStat}"
									    data-delyn="${hr.delYn}"
									    style="${hr.ntcYn eq 'Y' ? 'font-weight: bold' : ''};">
									    <c:set var="checkYn" value="" />
									    <c:choose>
									    	<c:when test="${hr.delYn eq 'Y'}">
									    		<c:set var="checkYn" value="disabled" />
									    	</c:when>
									    	<c:when test="${hr.ntcYn eq 'Y'}">
									    		<c:set var="checkYn" value="disabled" />
									    	</c:when>
									    	<c:when test="${hr.orgnFlNm eq null}">
									    		<c:set var="checkYn" value="disabled" />
									    	</c:when>
									    </c:choose>
										<%-- <td><input type="checkbox" class="check_idx" value="${hr.hrId}" ${checkYn}/></td> --%>
										<td onclick="event.cancelBubble=true">
											<a class="open-layer" href="javascript:void(0);">${hr.mbrVO.mbrNm}</a>
										</td>
										<td>${hr.cdNm}</td> 
										<td><a href="${context}/hr/hrmstrdetail/${hr.hrId}">${hr.hrTtl}</a></td>
										<td>${hr.hrRgstDt}</td>
										<td>${hr.hrAprYn}</td>
										<c:choose>
											<c:when test="${hr.hrStat eq '002-01'}"><td>접수</td></c:when>
											<c:when test="${hr.hrStat eq '002-02'}"><td>심사중</td></c:when>
											<c:when test="${hr.hrStat eq '002-03'}"><td>심사완료</td></c:when>
											<c:otherwise><td></td></c:otherwise>
										</c:choose>
										<td>${hr.delYn eq 'Y' ? '삭제됨' : ''}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="7">등록된 지원서가 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div style="position: relative;">
					<div class="pagenate">
						<nav aria-label="Page navigation example">
							<ul class="pagination" style="text-align: center;">
								<c:set value="${hrList.size() >0 ? hrList.get(0).lastPage : 0}" var="lastPage" />
								<c:set value="${hrList.size() >0 ? hrList.get(0).lastGroup : 0}" var="lastGroup" />
								
								<fmt:parseNumber var="nowGroup" value="${Math.floor(hrVO.pageNo / 10)}" integerOnly="true" />
								<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
								<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
								<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
								
								<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
								<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
								
								
								<c:if test="${nowGroup > 0}">
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
								</c:if>
							
								
								<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
									<li class="page-item"><a class="${pageNo eq hrVO.pageNo ? 'on' : ''} page-link text-secondary" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
								</c:forEach>
								
								<c:if test="${lastGroup > nowGroup}">
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
								</c:if>
							</ul>
						</nav>
					</div>
					<div style="position: absolute;right: 0;top: 0;">
	           			<button id="create-btn" type="button" class="btn btn-secondary">작성</button>
	          		</div>
				</div>
		</div>
			
		<div class="layer_popup" id="layer_popup" style="display: none;">
		<div class="popup_box">
			<div class="popup_content">
				<a class="send-memo-btn" href="javascript:void(0);">쪽지 보내기</a>
			</div>
			<div>
				<a class="close-memo-btn" href="javascript:void(0);">닫기</a>
			</div>
		</div>
		</div>
<jsp:include page="../include/closeBody.jsp" />
</html>
