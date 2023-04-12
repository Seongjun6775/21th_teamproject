<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript" src="${context}/js/AjaxUtil.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
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
			var keyword = $("#search-keyword").val();
			
			if ($(".search_idx").val() == "ntTtl") {
				var ntTtl = keyword;
				location.href="${context}/nt/mstrlist?ntTtl=" + keyword;
			}
			else if ($(".search_idx").val() == "sndrId") {
				var sndrId = keyword;
				location.href="${context}/nt/mstrlist?sndrId=" + keyword;
			}
			else {
				var rcvrId = keyword;
				location.href="${context}/nt/mstrlist?rcvrId=" + keyword;
			}
			
			
		})
			

		
	});
</script>
</head>
<body>
	<div class="nt_header">
		<div>
			master 쪽지 페이지 테스트
		</div>
		<div>
			총 ${allNtList.size() > 0 ? allNtList.size() : 0}건
		</div>
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
					<th>삭제 여부</th>
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
							    data-ntrddt="${nt.ntRdDt}"
							    data-delyn="${nt.delYn}">
								<td><input type="checkbox" class="check_idx" value="${nt.ntId}"
								            ${nt.delYn eq 'Y' ? 'disabled' : ''}/></td>
								<td>${nt.ntId}</td>
								<td><a href="${context}/nt/mstrdetail/${nt.ntId}">${nt.ntTtl}</a></td>
								<td>${nt.sndrId}</td>
								<td>${nt.rcvrId}</td>
								<td>${nt.ntRdDt}</td>
								<td>${nt.delYn eq 'Y' ? '삭제됨' : ''}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<td colspan="7">쪽지 송수신 이력이 없습니다.</td>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<div>
		<button id="crt_btn">작성</button>
		<button id="check_del_btn">일괄삭제</button>
		<select class="search_idx">
			<option value="ntTtl">제목</option>
			<option value="sndrId">발신인</option>
			<option value="rcvrId">수신인</option>
		</select>
		<input type="text" id="search-keyword" />
		<button id="search_btn">검색</button>
	</div>
	
</body>
</html>