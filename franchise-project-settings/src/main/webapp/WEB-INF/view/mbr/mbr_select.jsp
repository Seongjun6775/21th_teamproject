<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		/* $("#search-btn").click(function(){
			movePage(0);
		}); */
	});
	function movePage(pageNo){
		var mbrId = $("#mbrId").val();
		var startDt = $("#search-keyword-startdt").val();
		var endDt = $("#search-keyword-enddt").val();
		
		var intStartDt = parseInt(startDt.split("-").join(""));
		var intEndDt = parseInt(endDt.split("-").join(""));
		
		if(intStartDt > intEndDt){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '시작 일자를 확인해 주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			return;
		}
		
		var queryString ="mbrId=" + mbrId;
		queryString += "&startDt=" + startDt;
		queryString += "&endDt=" + endDt;
/* 		queryString += "&viewCnt=" + viewCnt; */
		queryString += "&pageNo=" + pageNo;
		
		location.href="${context}/mbr/select?" + queryString;
	}
</script>
</head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<body class="bg-dark bg-opacity-10 ">
<jsp:include page="../include/logo.jsp" />
	<main class="d-flex flex-nowrap ">	
		<div style="margin:0px; width: 100%; overflow: auto; display: flex; height: 100vh; flex-direction: column;">
			<!-- contents -->
		    <!-- 검색영역 -->
			<!-- searchbar -->
			<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
			  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
			  <i class="bi bi-search" style="margin: 15px;"></i>
			  <!-- <label for="search-keyword-mbrNm" >이름</label> -->
				<form style="display: flex; align-items: center;">
					<input type="date" style ="margin-right: 10px;"id="search-keyword-startdt" name="startDt" class="form-control" value="${lgnHistVO.startDt}"/>
					<input type="date" style ="margin-right: 10px;" id="search-keyword-enddt" name="endDt" class="form-control" value="${lgnHistVO.endDt}"/>
					<input type="hidden" class="form-control" name="mbrId" value="${lgnHistVO.mbrId}" />
					<!-- <button class="btn-search" id="search-btn">검색</button> -->
					<button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px;">Search</button>
				</form>
			</div>
			<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
				<div class="input-group">
					<span class="input-group-text">&nbsp;ID&nbsp;&nbsp;</span>
					<input type="text" class="form-control" id="mbrId" readonly value="${lgnHistVO.mbrId}" />
				</div>
				<div class="input-group">
					<span class="input-group-text">이름</span>
					<input type="text" class="form-control" readonly value="${histList[0].mbrVO.mbrNm}" />
				</div>
				<div class="input-group">
					<span class="input-group-text">등급</span>
					<input type="text" class="form-control" readonly value="${histList[0].cdNm}" />
				</div>
			</div>
      		<!-- /contents -->
	    	<div class="str_search_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; height: auto;">
				<div class="grid-count align-right">총 ${histList.size() > 0 ? histList.get(0).totalCount : 0 }건</div>
				<table class="table  table-hover" style="text-align: center;">
					<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
						<tr>
							<!-- <th scope="col" class="">회원아이디</th>
							<th scope="col" class="">회원이름</th>
							<th scope="col" class="">등급</th> -->
							<th scope="col" class="">로그</th>
							<th scope="col" class="">접속아이피</th>
							<th scope="col" class="">접속날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test ="${not empty histList }">
								<c:forEach items="${histList}" var="hist">
									<tr data-mbrid="${hist.mbrId}"
										data-mbrnm="${hist.mbrVO.mbrNm}"
										data-mbrlvl="${hist.mbrVO.mbrLvl}"
										data-cdnm="${hist.cdNm}"
										data-lgnactn="${hist.lgnHistActn}"
										data-lgnip="${hist.lgnHistIp}"
										data-lgndt="${hist.lgnHistDt}"
									>

										<%-- <td>${hist.mbrId}</td>
										<td>${hist.mbrVO.mbrNm}</td>
										<td>${hist.cdNm}</td> --%>
										<td>${hist.lgnHistActn eq 'login' ? '로그인' : '로그아웃'}</td>
										<td>${hist.lgnHistIp}</td>
										<td>${hist.lgnHistDt}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="3">검색된 회원 이력이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>				
				</table>
				<%-- <div class="pagenate">
					<nav aria-label="Page navigation example">
						<ul class="pagination" style="text-align: center;">
							<c:set value = "${histList.size() > 0 ? histList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${histList.size() > 0 ? histList.get(0).lastGroup : 0}" var="lastGroup"/>
							
							<!-- Math.floor(mbrVO.pageNo / 10) -->
							<fmt:parseNumber var="nowGroup" value="${Math.floor(mbrVO.pageNo / 10)}" integerOnly = "true"/>
							<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
							<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1 }" var="groupEndPageNo"/>
							
							<c:set value="${(nowGroup - 1 ) * 10}" var="prevGroupStartPageNo"/>
							<c:set value="${(nowGroup + 1 ) * 10}" var="nextGroupStartPageNo"/>

							<c:if test="${nowGroup > 0}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
								<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq lgnHistVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup >nowGroup}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</nav>
				</div> --%>
	    	</div>
      		<!-- /contents -->
		</div>
	</main>
</body>
</html>