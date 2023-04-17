<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/rv_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#new_btn").click(function() {
			location.href = "${context}/rv/create";
		});
		$("#all_check").click(function() {
			$(".check_idx").prop("checked", $("#all_check").prop("checked"));
		});
		$("#all_check").change(function(){
			$(".check-idx").prop("checked", $(this).prop("checked"));
		});
		$(".check-idx").change(function(){
			var count = $(".check-idx").length;
			var checkCount = $(".check-idx:checked").length;
			
			$("#all_check").prop("checked", count == checkCount);
		});
		$("#delete_all_btn").click(function(){
			var checkLen = $(".check-idx:checked").length;
			
			if(checkLen == 0){
				alert("삭제할 리뷰가 없습니다.");
				return;
			}
			
			var form = $("<form></form>")
			$(".check-idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='rvIdList' value='"+$(this).val() + "'>'")
			});
			$.post("${context}/api/rv/delete", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + " / " + response.message);
				}
			})
		});	
		$("#search_btn").click(function(){
			
			movePage(0);
		});
	});
		function movePage(pageNo){
			//전송.
			//입력 값:
			var mbrId = $("#search-keyword-mbrId").val();
			var rvTtl = $("#search-keyword-rvTtl").val();
			var rvCntnt = $("search-keyword-rvCntnt").val();
			
			var queryString = "?pageNo=" + pageNo;
			queryString += "&mbrId=" + mbrId;
			queryString += "&rvTtl=" + rvTtl;
			queryString += "&rvCntnt=" + rvCntnt;
			//URL요청
			location.href="${context}/rv/list/?" + queryString;
			
		}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">리뷰 > 리뷰목록</div>
			
			<h1>리뷰 목록</h1>
			<div>총 ${rvList.size()}건</div>
			
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>리뷰ID</th>
						<th>회원ID</th>
						<th>주문상세ID</th>
						<th>제목</th>
						<th>좋아요/싫어요</th>
						<th>등록일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty rvList}">
							<c:forEach items="${rvList}"
									   var="rv">
								<tr>
									<td>
										<input type="checkbox" 
											   class="check-idx" 
											   value="${rv.rvId}"/>
									</td>
									<td><a href="${context}/rv/detail/${rv.rvId}" >${rv.rvId}]</a></td>
									<td>${rv.mbrId}</td>
									<td>${rv.odrDtlId}</td>					
									<td>${rv.rvTtl}</td>					
									<td>${rv.rvLkDslk}</td>					
									<td>${rv.rvRgstDt}</td>					
									<td>${rv.mdfyDt}</td>									
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<td colspan="8" class="no-item">
								등록된 리뷰가 없습니다.
							</td>
						</c:otherwise>
					</c:choose>			
				</tbody>
			</table>	
			
			<div class="align-right mt-10">
				<button id="delete_all_btn" class="btn-delete">삭제</button>
			</div>
			
			<div class="pagenate">
				<ul>
					<c:set value = "${rvList.size() > 0 ? rvList.get(0).lastPage : 0}" var="lastPage"/>
					<c:set value = "${rvList.size() > 0 ? rvList.get(0).lastGroup : 0}" var="lastGroup"/>
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(gnrVO.pageNo / 10)}" integerOnly = "true"/>
					<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
					<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
					<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo"/>
					
					<c:set value="${(nowGroup - 1 ) * 10}" var="prevGroupStartPageNo"/>
					<c:set value="${(nowGroup + 1 ) * 10}" var="nextGroupStartPageNo"/>
					
					<%-- lastPage: ${lastPage }
					lastGroup: ${lastGroup }
					nowGroup: ${nowGroup }
					groupStartPageNo:${groupStartPageNo }
					groupEndPageNo:${groupEndPageNo}
					prevGroupStartPageNo: ${prevGroupStartPageNo }
					nextGroupStartPageNo: ${nextGroupStartPageNo } --%>
					
					<c:if test = "${nowGroup > 0}">
						<li><a href="javascript:movePage(0)">처음</a></li>
						<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
					</c:if>
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li><a class="${pageNo eq gnrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
					
					<c:if test = "${lastGroup >nowGroup }">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>				
			
			<form action="rvList" method="post">
				<div class="search-wrap">
				<select name="search_option">
					<option value="${rv.rvTtl}">제목</option>					
					<option value="${rv.rvCntnt}">내용</option>					
					<option value="${rv.mbrId}">작성자</option>									
				</select>
				<input type="text" placeholder="검색어를 입력하세요">
				<button id="search_btn" class="btn-search">검색</button>
				</div>
			</form>
			
			<div class="align-right">				
				<button id="new_btn" class="btn-primary">등록</button>
			</div>
			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>