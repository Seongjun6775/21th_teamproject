<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장별 메뉴 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	$("#search-keyword-prdt").val("${strPrdtVO.prdtId}");
	$("#search-keyword-useYn").val("${strPrdtVO.useYn}");
	$("#search-keyword-prdtSrt").val("${strPrdtVO.cmmnCdVO.cdId}")
	

	$("#all-check").change(function(){
		$(".check-idx").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx:checked").length;
	});
	$(".check-idx").change(function(){
		var count = $(".check-idx").length;
		var checkCount = $(".check-idx:checked").length;
		$("#all-check").prop("checked", count == checkCount);
		console.log($(this).val())
	});
	
	
	$("#btn-update-all").click(function() {
		var checkLen = $(".check-idx:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if ($("select-useYn").val() == "") {
			alert("사용유무가 선택되지 않았습니다.");
		}
		if (!confirm("체크한 항목이 일괄 수정됩니다.")) {
			return;
		}
		
		var form = $("<form></form>")
		
		$(".check-idx:checked").each(function() {
			console.log($(this).val());
			form.append("<input type='hiedden' name='strPrdtIdList' value='" + $(this).val() + "'>");
		});
			form.append("<input type='hiedden' name='useYn' value='" + $("#select-useYn").val() + "'>");
		
		$.post("${context}/api/strprdt/update", form.serialize(), function(response) {
			if (response.status == "200 OK") {
				location.reload(); //새로고침
			}
			else {
				alert(response.errorCode + " / " + response.message);
			}
		});
	})
	
	
	// 검색 기능 : 셀렉트박스 변경시
	$("select[name=selectFilter]").on("change", function(event) {
		movePage(0);
	});
	
	
	$("#btn-search-reset").click(function() {
		location.href = "${context}/strprdt/list";
	})
	
	
})


function movePage(pageNo) {
	var prdt = $("#search-keyword-prdt").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	var srt = $("#search-keyword-prdtSrt").val(); 
	if (srt == "" || srt == null) {
		srt = '%' // cmmnCdVO의 cdId검색은 공백이 되면 왜 에러가 나는것일까?
	}
	
	var queryString = "strPrdtPageNo=" + pageNo;
	queryString += "&prdtId=" + prdt;
	queryString += "&useYn=" + useYn;
	queryString += "&cmmnCdVO.cdId=" + srt; // vo안에 vo에 멤버변수로 전달할 때
	
	location.href = "${context}/strprdt/list?" + queryString; // URL 요청
} 
</script>
</head>
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div>
			<jsp:include page="../include/sidemenu.jsp"></jsp:include>
			<jsp:include page="../include/content.jsp"></jsp:include>
			<div class="grid">
				<div class="space-between mb-10">
					
					
				</div>
				
				<br>id ${strVO.strId}
				<br>이름 ${strVO.strNm}
				<br>주소 ${strVO.strLctn} - ${strVO.strCty} - ${strVO.strAddr}
				<br>전화번호 ${strVO.strCallNum}
				<br>매니저Id ${strPrdtList[0].strMbrVO.mbrId}
				<br>매니저이름 ${strPrdtList[0].strMbrVO.mbrNm}
				<br>운영시간 ${strVO.strOpnTm} ~ ${strVO.strClsTm}
				
				<table id="dataTable"
						class="mb-10">
					<thead>
						<tr>
							<th><input type="checkbox" id="all-check"/></th>
							<th>
								<select class="selectFilter" name="selectFilter"
									id="search-keyword-prdtSrt">
									<option value="">분류</option>
									<c:choose>
										<c:when test="${not empty srtList}">
											<c:forEach items="${srtList}"
														var="srt">
												<option value="${srt.cdId}">${srt.cdNm}</option>
											</c:forEach>
										</c:when>
									</c:choose>
								</select>
							</th>
							<th>
								<select class="selectFilter" name="selectFilter"
										id="search-keyword-prdt">
									<option value="">상품</option>
									<c:choose>
										<c:when test="${not empty prdtList}">
											<c:forEach items="${prdtList}"
														var="prdt">
												<option value="${prdt.prdtId}">${prdt.prdtNm} (${prdt.prdtId})</option>
											</c:forEach>
										</c:when>
									</c:choose>
								</select>
							</th>
							<th>수정자</th>
							<th>수정일</th>
							<th>
							<select class="selectFilter" name="selectFilter"
									id="search-keyword-useYn">
								<option value="">사용유무</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty strPrdtList}">
								<c:forEach items="${strPrdtList}"
											var="strPrdt"
											varStatus="index">
									<tr data-strPrdtId="${strPrdt.strPrdtId}" 
										> 
										<td class="align-center">
											<input type="checkbox" class="check-idx" value="${strPrdt.strPrdtId}" />
										</td>
										<td>${strPrdt.cmmnCdVO.cdNm}</td>
										<td>${strPrdt.prdtVO.prdtNm}</td>
										<td>${strPrdt.mdfyr}(${strPrdt.mdfyrMbrVO.mbrNm})</td>
										<td>${strPrdt.mdfyDt}</td>
										<td>${strPrdt.useYn}</td>
									</tr>
								</c:forEach>	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" class="no-items">
										등록된 항목이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<div class="relative">
					<div class="align-left absolute fontsize14">
						<!-- 페이지네이션용  -->
						총 ${strPrdtList.size() > 0 ? strPrdtList.get(0).totalCount : 0}건
						<%-- 총 ${strPrdtList.size() > 0 ? strPrdtList.size() : 0}건 --%>
					</div>
					<div class="align-right absolute " style="right: 0px;" >
						<button class="btn-primary" 
								id="btn-search-reset">검색초기화</button>
					</div>
					
					<div class="pagenate">
						<ul>
							<c:set value="${strPrdtList.size() > 0 ? strPrdtList.get(0).lastPage : 0}" var="lastPage"></c:set>
							<c:set value="${strPrdtList.size() > 0 ? strPrdtList.get(0).lastGroup : 0}" var="lastGroup"></c:set>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(strPrdtVO.strPrdtPageNo / strPrdtVO.strPrdtPageCnt)}" integerOnly="true" />
							<c:set value="${nowGroup * strPrdtVO.strPrdtPageCnt}" var="groupStartPageNo"></c:set>
							<c:set value="${groupStartPageNo + strPrdtVO.strPrdtPageCnt}" var="groupEndPageNo"></c:set>
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1}" var="groupEndPageNo"></c:set>
							
							<c:set value="${(nowGroup - 1) * strPrdtVO.strPrdtPageCnt}" var="prevGroupStartPageNo"></c:set>
							<c:set value="${(nowGroup + 1) * strPrdtVO.strPrdtPageCnt}" var="nextGroupStartPageNo"></c:set>
							
							 
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo+strPrdtVO.strPrdtPageCnt-1})">이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1"	var="strPrdtPageNo">
								<li><a class="${strPrdtPageNo eq strPrdtVO.strPrdtPageNo ? 'on' : ''}"  href="javascript:movePage(${strPrdtPageNo})">${strPrdtPageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li><a href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div>
				</div>
				
				<div class="align-right grid-btns">
					<a href="${context}/prdt/list">메뉴리스트</a>
				</div>
				
			</div>
			
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>
	
</body>
</html>