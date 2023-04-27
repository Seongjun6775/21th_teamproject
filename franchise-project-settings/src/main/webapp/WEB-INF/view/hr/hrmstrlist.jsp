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
<link rel="stylesheet" href="${context}/css/hr_mstr.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		var url;
		$(".open-layer").click(function(event) {
			var mbrId = $(this).text();
			$("#layer_popup").css({
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF" 
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
		
		$(".create_btn").click(function() {
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
<style>
   .bd-placeholder-img {
     font-size: 1.125rem;
     text-anchor: middle;
     -webkit-user-select: none;
     -moz-user-select: none; 
     user-select: none;
   }

   @media (min-width: 768px) {
     .bd-placeholder-img-lg {
       font-size: 3.5rem;
     }
   }

   .b-example-divider {
     width: 100%;
     height: 3rem;
     background-color: rgba(0, 0, 0, .1);
     border: solid rgba(0, 0, 0, .15);
     border-width: 1px 0;
     box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
   }

   .b-example-vr {
     flex-shrink: 0;
     width: 1.5rem;
     height: 100vh;
   }

   .bi {
     vertical-align: -.125em;
     fill: currentColor;
   }

   .nav-scroller {
     position: relative;
     z-index: 2;
     height: 2.75rem;
     overflow-y: hidden;
   }

   .nav-scroller .nav {
     display: flex;
     flex-wrap: nowrap;
     padding-bottom: 1rem;
     margin-top: -1px;
     overflow-x: auto;
     text-align: center;
     white-space: nowrap;
     -webkit-overflow-scrolling: touch;
   }

   .btn-bd-primary {
     --bd-violet-bg: #712cf9;
     --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

     --bs-btn-font-weight: 600;
     --bs-btn-color: var(--bs-white);
     --bs-btn-bg: var(--bd-violet-bg);
     --bs-btn-border-color: var(--bd-violet-bg);
     --bs-btn-hover-color: var(--bs-white);
     --bs-btn-hover-bg: #6528e0;
     --bs-btn-hover-border-color: #6528e0;
     --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
     --bs-btn-active-color: var(--bs-btn-hover-color);
     --bs-btn-active-bg: #5a23c8;
     --bs-btn-active-border-color: #5a23c8;
   }
   .bd-mode-toggle {
     z-index: 1500;
   }

   .btn-toggle:hover{
     background-color: var(--bs-tertiary-color) !important;
   }

   .btn-toggle:focus{
     background-color: var(--bs-tertiary-color) !important;
   }

   .collapse > ul > li:hover{
     background-color: var(--bs-tertiary-color) !important;
   }
   .collapse > ul > li:focus{
     background-color: var(--bs-tertiary-color) !important;
   }
   .collapse > ul > li > a:hover {
     background-color: #fff0 !important;
   }
   .collapse > ul > li > a:focus {
     background-color: #fff0 !important;
   }
   
   .pagenate{
     display: flex;
     margin-top: 10px;
     justify-content: center;
     align-items: center;
   }
 </style>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<div class="content inline">
			<h3>master 채용 페이지 테스트</h3>
			<div>
				<div>총 ${hrList.size() > 0 ? hrList.get(0).totalCount : 0}건</div>
				<!-- <button id="check_download_btn">전체 다운로드</button> -->
				<div>
					<label for="startDt">검색 시작일</label>
					<input type="date" id="startDt" name="startDt" value="${hrVO.startDt}" />
					<label for="endDt">검색 종료일</label>
					<input type="date" id="endDt" name="endDt" value="${hrVO.endDt}" />
					<select id="search_idx">
						<option value="">검색 조건</option>
						<option value="hrTtl" ${searchIdx eq "hrTtl" ? 'selected' : '' }>제목</option>
						<option value="mbrId" ${searchIdx eq "mbrId" ? 'selected' : '' }>지원자</option>
					</select>
				<input type="text" id="search-keyword" value="${keyword}"/>
				<button id="search_btn">검색</button>
				</div>
			</div>
			<div class="hr_table_grid">
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<!-- <th><input type="checkbox" id="all_check"/></th> -->
							<th>지원자 ID</th>
							<th>
								<select id="hrLvl">
									<option value="">지원 직군</option>
									<option value="005-01" ${hrVO.hrLvl eq "005-01" ? 'selected' : '' }>점주</option>
									<option value="005-02" ${hrVO.hrLvl eq "005-02" ? 'selected' : '' }>사원</option>
								</select>
							</th>
							<th>제목</th>
							<th>등록일</th>
							<th>승인 여부</th>
							<th>
								<select id="hrStat">
									<option value="">채용 상태</option>
									<option value="002-01" ${hrVO.hrStat eq "002-01" ? 'selected' : '' }>접수</option>
									<option value="002-02" ${hrVO.hrStat eq "002-02" ? 'selected' : '' }>심사중</option>
									<option value="002-03" ${hrVO.hrStat eq "002-03" ? 'selected' : '' }>심사완료</option>
								</select>
							</th>
							<th>
								<select id="delYn">
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
									    data-hrlvl="${hr.hrLvl}"
									    data-hrttl="${hr.hrTtl}"
									    data-hrrgstdt="${hr.hrRgstDt}"
									    data-hrapryn="${hr.hrAprYn}"
									    data-hrstat="${hr.hrStat}"
									    data-delyn="${hr.delYn}">
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
										<td onclick="event.cancelBubble=true"><a class="open-layer" href="javascript:void(0);">${hr.mbrId}</a>
											
										</td>
										<td>${hr.cdNm}</td>
										<td><a href="${context}/hr/hrmstrdetail/${hr.hrId}">${hr.hrTtl}</a></td>
										<td>${hr.hrRgstDt}</td>
										<td>${hr.hrAprYn}</td>
										<td>${hr.hrStat}</td>
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
			</div>
			<div class="pagenate">
				<ul>
					<c:set value="${hrList.size() >0 ? hrList.get(0).lastPage : 0}" var="lastPage" />
					<c:set value="${hrList.size() >0 ? hrList.get(0).lastGroup : 0}" var="lastGroup" />
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(hrVO.pageNo / 10)}" integerOnly="true" />
					<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
					<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
					<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
					
					<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
					<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
					
					
					<c:if test="${nowGroup > 0}">
						<li><a href="javascript:movePage(0)">처음</a></li>
						<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
					</c:if>
				
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li><a class="${pageNo eq hrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
					
					<c:if test="${lastGroup > nowGroup}">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>
			<div>
				<button class="create_btn">작성</button>
			</div>
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
</body>
</html>
