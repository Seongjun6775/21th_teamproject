<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		
		if (!("${ntVO.ntTtl}") == null) {
			$(".search_idx").val("ntTtl");
			$("#search-keyword").val("${ntVO.ntTtl}");
		}
		else if (!("${ntVO.sndrId}") == null) {
			$(".search_idx").val("sndrId");
			$("#search-keyword").val("${ntVO.sndrId}");
		}
		else if (!("${ntVO.rcvrId}") == null) {
			$(".search_idx").val("rcvrId");
			$("#search-keyword").val("${ntVO.rcvrId}");
		}
		
		
		
		$("#all_check").change(function() {
			$(".check_idx").not("[disabled=disabled]").prop("checked", $(this).prop("checked"));
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
		
		$("#crt_btn").click(function() {
			location.href = "${context}/nt/create";
		});
		
		// 수신인, 발신인 검색 기능입니다
		$("#search_btn").click(function() {
			
			var searchVal = $(".search_idx").val();
			var keyword = $("#search-keyword").val();
			
			console.log(searchVal);
			console.log(keyword);
			
			alert("!");
			
			movePage(0, searchVal, keyword);
		});
	});
	
	
	function movePage(pageNo, searchVal, keyword) {
		
		if (searchVal == "ntTtl") {
			location.href="${context}/nt/mstrlist?searchVal=" + searchVal + "&keyword=" + keyword + "&pageNo=" + pageNo;
		}
		else if (searchVal == "sndrId") {
			location.href="${context}/nt/mstrlist?searchVal=" + searchVal + "&keyword=" + keyword + "&pageNo=" + pageNo;
		}
		else {
			location.href="${context}/nt/mstrlist?searchVal=" + searchVal + "&keyword=" + keyword + "&pageNo=" + pageNo;
		}
	}
	
	function f_selectFilter() {
		var ntRdDt = ("#s_ntRdDt").val();
		var delYn = ("#s_delYn").val();
		
		
		
		
	}
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div>
				master 쪽지 페이지 테스트
			</div>
			<div>
				<div>총 ${allNtList.size() > 0 ? allNtList.size() : 0}건</div>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>쪽지 번호</th>
							<th>쪽지 제목</th>
							<th>발신인</th>
							<th>수신인</th>
							<th>쪽지 발송 일자</th>
							<th>
								<select id="s_ntRdDt" onchange="f_selectFilter">
									<option value="">쪽지 확인 일자</option>
									<option value="Y">수신</option>
									<option value="N">미수신</option>
								</select>
							</th>
							<th>
								<select id="s_delYn" onchange="f_selectFilter">
									<option value="">삭제 여부</option>
									<option value="Y">삭제됨</option>
									<option value="N">삭제되지 않음</option>
								</select>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty allNtList}">
								<c:forEach items="${allNtList}" var="nt">
									<tr data-ntid="${nt.ntId}"
									    data-ntttl="${nt.ntTtl}"
									    data-sndrid="${nt.sndrId}"
									    data-rcvrid="${nt.rcvrId}"
									    data-ntsndrdt="${nt.ntSndrDt}"
									    data-ntrddt="${nt.ntRdDt}"
									    data-delyn="${nt.delYn}">
										<td><input type="checkbox" class="check_idx" value="${nt.ntId}"
										            ${nt.delYn eq 'Y' ? 'disabled' : ''}/></td>
										<td>${nt.ntId}</td>
										<td><a href="${context}/nt/mstrdetail/${nt.ntId}">${nt.ntTtl}</a></td>
										<td>${nt.sndrId}</td>
										<td>${nt.rcvrId}</td>
										<td>${nt.ntSndrDt}</td>
										<td>${nt.ntRdDt}</td>
										<td>${nt.delYn eq 'Y' ? '삭제됨' : ''}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="8">쪽지 송수신 이력이 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="pagenate">
					<ul>
						<c:set value="${allNtList.size() >0 ? allNtList.get(0).lastPage : 0}" var="lastPage" />
						<c:set value="${allNtList.size() >0 ? allNtList.get(0).lastGroup : 0}" var="lastGroup" />
						
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
				<button id="crt_btn">작성</button>
				<button id="check_del_btn">일괄삭제</button>
				<select class="search_idx">
					<option value="">검색 조건</option>
					<option value="ntTtl" ${searchVal eq "ntTtl" ? 'selected' : '' }>제목</option>
					<option value="sndrId" ${searchVal eq "sndrId" ? 'selected' : '' }>발신인</option>
					<option value="rcvrId" ${searchVal eq "rcvrId" ? 'selected' : '' }>수신인</option>
				</select>
				<input type="text" id="search-keyword" value="${keyword}"/>
				<button id="search_btn">검색</button>
				<jsp:include page="../include/footer.jsp" />
			</div>
		</div>
	</div>
</body>
</html>
