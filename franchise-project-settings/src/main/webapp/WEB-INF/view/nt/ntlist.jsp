<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/ntcommon.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#check_del_btn").click(function() {
			console.log($(this).val());
			var checkLen = $(".check_idx:checked").length;
			
			if (checkLen == 0) {
				alert("선택한 쪽지가 없습니다.");
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='ntId' value='" + $(this).val() + "'>")
			});
			
			$.post("${context}/api/nt/delete", form.serialize(), function(response) {});
			location.reload();
		});
		
		$(".nt_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.ntid != null && data.ntid != "") {
				location.href="${context}/nt/ntdetail/" + data.ntid;
			}
		});
		
		// 수신인, 발신인 검색 기능입니다
		$("#search_btn").click(function() {
			movePage(0);
		});
	});
	
	function movePage(pageNo) {
		
		var keyword = $("#search-keyword").val();

		var searchVal = $(".search_idx").val();
		var keyword = $("#search-keyword").val();
		var startDt = $("#startDt").val();
		var endDt = $("#endDt").val();
		
		var intStartDt = parseInt(startDt.split("-").join(""));
		var intEndDt = parseInt(endDt.split("-").join(""));
		
		if(intStartDt > intEndDt) {
			alert("시작일자는 종료일자보다 늦을 수 없습니다!");
			return;
		}
		
		var queryString = "searchVal=" + searchVal;
		queryString += "&keyword=" + keyword;
		queryString += "&startDt=" + startDt;
		queryString += "&endDt=" + endDt;
		queryString += "&pageNo=" + pageNo;
		
		// URL 요청
		location.href = "${context}/nt/ntlist?" + queryString;
	}
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<h3>회원 쪽지 상세조회 페이지</h3>
			<div>
				<div>총 ${myNtList.size() > 0 ? myNtList.size() : 0}건</div> 
			</div>
			<div>
				<label for="startDt">검색 시작일</label>
				<input type="date" id="startDt" name="startDt" value="${ntVO.startDt}" />
				<label for="endDt">검색 종료일</label>
				<input type="date" id="endDt" name="endDt" value="${ntVO.endDt}" />
				<select class="search_idx">
					<option value="ntTtl" ${searchVal eq "ntTtl" ? 'selected' : '' }>제목</option>
					<option value="sndrId" ${searchVal eq "sndrId" ? 'selected' : '' }>발신인</option>
				</select>
				<input type="text" id="search-keyword" value="${keyword}"/>
				<button id="search_btn">검색</button>
			</div>
			<div class="nt_table_grid">
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>쪽지 제목</th>
							<th>발신인</th>
							<th>수신인</th>
							<th>쪽지 발송 일자</th>
							<th>쪽지 수신 여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty myNtList}">
								<c:forEach items="${myNtList}" var="nt">
									<tr data-ntid="${nt.ntId}"
									    data-ntttl="${nt.ntTtl}"
									    data-sndrid="${nt.sndrId}"
									    data-rcvrid="${nt.rcvrId}"
									    data-ntsndrdt="${nt.ntSndrDt}"
									    data-ntrddt="${nt.ntRdDt}">
										<td><input type="checkbox" class="check_idx" value="${nt.ntId}"/></td>
										<td><a href="${context}/nt/ntdetail/${nt.ntId}">${nt.ntTtl}</a></td>
										<td>${nt.sndrId}</td>
										<td>${nt.rcvrId}</td>
										<td>${nt.ntSndrDt}</td>
										<td>${nt.ntRdDt ne null ? '수신' : '미수신'}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="6">쪽지 송수신 이력이 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="pagenate">
					<ul>
						<c:set value="${myNtList.size() >0 ? myNtList.get(0).lastPage : 0}" var="lastPage" />
						<c:set value="${myNtList.size() >0 ? myNtList.get(0).lastGroup : 0}" var="lastGroup" />
						
						<fmt:parseNumber var="nowGroup" value="${Math.floor(ntVO.pageNo / 10)}" integerOnly="true" />
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
							<li><a class="${pageNo eq ntVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
						</c:forEach>
						
						<c:if test="${lastGroup > nowGroup}">
							<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li><a href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</div>
				<div>
					<button id="check_del_btn">일괄삭제</button>
				</div>
				<div>
				<jsp:include page="../include/footer.jsp" />
			</div>
		</div>
	</div>
</body>
</html>
