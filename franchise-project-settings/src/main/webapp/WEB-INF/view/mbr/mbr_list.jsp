<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$("#search-btn").click(function(){
			movePage(0);
		});
		$("#mbrLvl").val("${mbrVO.mbrLvl}");
		$("#search-keyword-delYn").prop("checked", $("#search-keyword-delYn").val() == 'Y');
		$("#search-keyword-mbrNm").keydown(function(key){
			if (key.keyCode == 13) {
	        	$("#search-btn").click();
	        }
		});
		$("#search-clear-btn").click(function(){
			$("#search-keyword-mbrNm").val("");search-clear-btn
			$("#mbrLvl").val("");
			$("#search-keyword-delYn").prop("checked", false);
			$("#search-keyword-startdt").val("");
			$("#search-keyword-enddt").val("");
		});
	});
	
	function movePage(pageNo){
		var mbrLvl = $("#mbrLvl option:selected").val();
		var mbrNm = $("#search-keyword-mbrNm").val();
		var startDt = $("#search-keyword-startdt").val();
		var endDt = $("#search-keyword-enddt").val();
		var delYn = $("#search-keyword-delYn").val();
		
		var intStartDt = parseInt(startDt.split("-").join(""));
		var intEndDt = parseInt(endDt.split("-").join(""));
		
		if(intStartDt > intEndDt){
			alert("시작 일자를 확인해 주세요");
			return;
		}
		var queryString = "mbrLvl=" + mbrLvl;
		queryString += "&mbrNm=" + mbrNm;
		queryString += "&startDt=" + startDt;
		queryString += "&endDt=" + endDt;
		queryString += "&delYn=" + delYn;
		queryString += "&pageNo=" + pageNo;
		
		location.href="${context}/mbr/list?" + queryString;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">회원관리 > 회원 목록</div>
				<!-- 검색영역 -->
				<div class="search-row-group">
					<div class="search-group">
						<label for="search-keyword-mbrNm" >이름</label>
						<input type="text" id="search-keyword-mbrNm" class="search-input" value="${mbrVO.mbrNm}"/>
						<select id="mbrLvl" name="mbrLvl">
							<option value="">멤버등급</option>
							<c:choose>
									<c:when test="${not empty srtList}">
										<c:forEach items="${srtList}" var="srt">
											<option value="${srt.cdId}">${srt.cdNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
						</select>
						<select id="search-keyword-delYn" name="delYn">
								<option value="">탈퇴유무</option>
								<option value="Y" ${MbrVO.delYn eq 'Y' ? 'selected' : ''}>Y</option>
								<option value="N" ${MbrVO.delYn eq 'N' ? 'selected' : ''}>N</option>
						</select>
						<%-- <label for="search-keyword-delYn" >탈퇴여부</label>
						<input type="checkbox" id="search-keyword-delYn" class="search-input" style="flex-grow: 0.1;" value="${mbrVO.delYn eq 'Y' ? 'Y' : 'N'}"/> --%>
						<label for="search-keyword-startdt" >조회기간</label>
						<input type="date" id="search-keyword-startdt" class="search-input" value="${mbrVO.startDt}"/>
						<input type="date" id="search-keyword-enddt" class="search-input" value="${mbrVO.endDt}"/>
						
						<button class="btn-search" id="search-btn">검색</button>
						<button class="btn-search-clear" id="search-clear-btn">초기화</button>
					</div>
				</div>	
				<!-- 조회영역 -->
				<div class="grid">
					<div class="grid-count align-right">총 ${mbrList.size() > 0 ? mbrList.get(0).totalCount : 0 }건</div>
					<table>
						<thead>
							<tr>
								<th>순번</th>
								<th>ID</th>
								<th>이름</th>
								<th>이메일</th>
								<th>회원등급</th>
								<th>가입일</th>
								<th>최근 로그인 날짜</th>
								<th>최근 로그인 IP</th>
								<th>로그인 제한</th>
								<th>탈퇴</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty mbrList}">
									<c:forEach items="${mbrList}" var="mbr" varStatus="index">
										<tr data-mbrId="${mbr.mbrId}" 
											data-mbrNm="${mbr.mbrNm }" 
											data-mbrEml="${mbr.mbrEml }" 
											data-mbrLvl="${mbr.mbrLvl }" 
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
											<td>${index.index+1}</td>
											<td>${mbr.mbrId}</td>
											<td>${mbr.mbrNm}</td>
											<td>${mbr.mbrEml}</td>
											<td>${mbr.mbrLvl}</td>
											<td>${mbr.mbrRgstrDt}</td>
											<td>${mbr.mbrRcntLgnDt}</td>
											<td>${mbr.mbrRcntLgnIp}</td>
											<td>${mbr.mbrLgnBlckYn}</td>
											<td>${mbr.delYn}</td>
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
					
						<div class="pagenate">
							<ul>
								<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastPage : 0}" var="lastPage"/>
								<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastGroup : 0}" var="lastGroup"/>
								
								<!-- Math.floor(mbrVO.pageNo / 10) -->
								<fmt:parseNumber var="nowGroup" value="${Math.floor(mbrVO.pageNo / 10)}" integerOnly = "true"/>
								<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
								<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
								<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1 }" var="groupEndPageNo"/>
								<%-- <c:set value="${groupEndPageNo > lastPage ? (lastPage-1 < 0 ? lastPage : lastPage -1 ) : groupEndPageNo - 1}" var="groupEndPageNo"/> --%>
								
								<c:set value="${(nowGroup - 1 ) * 10}" var="prevGroupStartPageNo"/>
								<c:set value="${(nowGroup + 1 ) * 10}" var="nextGroupStartPageNo"/>
								 
								<%-- lastPage: ${lastPage }
								lastGroup: ${lastGroup }
								nowGroup: ${nowGroup }
								groupStartPageNo:${groupStartPageNo }
								groupEndPageNo:${groupEndPageNo}
								prevGroupStartPageNo: ${prevGroupStartPageNo }
								nextGroupStartPageNo: ${nextGroupStartPageNo } --%>
								
								<c:if test="${nowGroup > 0}">
									<li><a href="javascript:movePage(0)">처음</a></li>
									<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
								</c:if>
								
								<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
									<li><a class="${pageNo eq mbrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
								</c:forEach>
								
								<c:if test="${lastGroup >nowGroup}">
									<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
									<li><a href="javascript:movePage(${lastPage})">끝</a></li>
								</c:if>
							</ul>
						</div>
					
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
