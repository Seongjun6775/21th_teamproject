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
		
		// 수신인, 발신인 검색 기능입니다
		$("#search_btn").click(function() {
			movePage(0);
		});
	});
	
	function movePage(pageNo) {
		
		var keyword = $("#search-keyword").val();
		
		if ($(".search_idx").val() == "ntTtl") {
			var ntTtl = keyword;
			location.href="${context}/nt/mngrlist?ntTtl=" + ntTtl + "&?pageNo=" + pageNo;
			$(".search_idx").val("ntTtl");
			$("#search-keyword").val(keyword);
		}
		else if ($(".search_idx").val() == "sndrId") {
			var sndrId = keyword;
			location.href="${context}/nt/mngrlist?sndrId=" + sndrId + "&?pageNo=" + pageNo;
			$(".search_idx").val("sndrId");
			$("#search-keyword").val(keyword);
		}
		else {
			var rcvrId = keyword;
			location.href="${context}/nt/mngrlist?rcvrId=" + rcvrId + "&?pageNo=" + pageNo;
			$(".search_idx").val("rcvrId");
			$("#search-keyword").val(keyword);
		}
	}
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<h3>중간관리자 상세조회 페이지</h3>
			<div>
				<div>총 ${myNtList.size() > 0 ? myNtList.size() : 0}건</div>
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
							<th>확인 일자</th>
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
									    data-ntrddt="${nt.ntRdDt}">
										<td><input type="checkbox" class="check_idx" value="${nt.ntId}"/></td>
										<td>${nt.ntId}</td>
										<td><a href="${context}/nt/mngrdetail/${nt.ntId}">${nt.ntTtl}</a></td>
										<td>${nt.sndrId}</td>
										<td>${nt.rcvrId}</td>
										<td>${nt.ntRdDt}</td>
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
					<select class="search_idx">
						<option value="ntTtl">제목</option>
						<option value="sndrId">발신인</option>
						<option value="rcvrId">수신인</option>
					</select>
					<input type="text" id="search-keyword" />
					<button id="search_btn">검색</button>
				<jsp:include page="../include/footer.jsp" />
			</div>
		</div>
	</div>
</body>
</html>
