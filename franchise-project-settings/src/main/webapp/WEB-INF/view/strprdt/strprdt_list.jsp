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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	$("#search-keyword-str").val("${strPrdtVO.strId}");
	$("#search-keyword-prdt").val("${strPrdtVO.prdtId}");
	$("#search-keyword-useYn").val("${strPrdtVO.useYn}");
	$("#search-keyword-prdtSrt").val("${strPrdtVO.cmmnCdVO.cdId}")
	var evntYn = ""
	 if (${strPrdtVO.evntVO.evntId != ""} && ${not empty strPrdtVO.evntVO.evntId} ) {
		 evntYn = "${strPrdtVO.evntVO.evntId}"
	 }
	 $("#search-keyword-evntYn").val(evntYn);
	

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
			Swal.fire({
		    	  icon: 'error',
		    	  title: '선택된 항목이 없습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("선택된 항목이 없습니다."); */
			return;
		}
		if ($("select-useYn").val() == "") {
			Swal.fire({
		    	  icon: 'error',
		    	  title: '사용유무가 선택되지 않았습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("사용유무가 선택되지 않았습니다."); */
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
				Swal.fire({
			    	  icon: 'error',
			    	  title: response.message,
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert(response.errorCode + " / " + response.message); */
			}
		});
	})
	
	
	$("#btn-missingCheck").click(function() {
		$.post("${context}/api/strprdt/listCheck", null, function(response) {
			if (response.status == "200 OK") {
				Swal.fire({
			    	  icon: 'success',
			    	  title: response.message,
			    	  showConfirmButton: true,
			    	  confirmButtonColor: '#3085d6'
				}).then((result)=>{
					if(result.isConfirmed){
						location.reload(); //새로고침
					}
				});
				/* alert(response.message) */
			}
			else {
				Swal.fire({
			    	  icon: 'error',
			    	  title: response.message,
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert(response.errorCode + " / " + response.message); */
			}
		});
	});
	
	
	// 검색 기능 : 셀렉트박스 변경시
	$("select[name=selectFilter]").on("change", function(event) {
		movePage(0);
	});
	
	
	$("#btn-search-reset").click(function() {
		location.href = "${context}/strprdt/list";
	});
	
	var url;
	$(".open-layer").click(function(event) {
		var mbrId = $(this).attr('val');
		$("#layer_popup").css({
		    "padding": "5px",
			"top": event.pageY,
			"left": event.pageX,
			"backgroundColor": "#FFF",
			"position": "absolute",
			"border": "solid 1px #222",
			"z-index": "10px"
		}).show();
		if (mbrId == '${sessionScope.__MBR__.mbrId}') {
			url = "cannot"
		} else {
			url = "${context}/nt/ntcreate/" + mbrId
		}
	});
	$(".send-memo-btn").click(function() {
		if (url !== "cannot") {
			location.href = url;
		} else {
			alert("본인에게 쪽지를 보낼 수 없습니다.");
		}
	});
	$('body').on('click', function(event) {
		if (!$(event.target).closest('#layer_popup').length) {
			$('#layer_popup').hide();
		}
	});
	$(".close-memo-btn").click(function() {
		url = undefined;
		$("#layer_popup").hide();
	});
	
	
});


function movePage(pageNo) {
	var str = $("#search-keyword-str").val(); 
	var prdt = $("#search-keyword-prdt").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	var srt = $("#search-keyword-prdtSrt").val(); 
	if (srt == "" || srt == null) {
		srt = '%' // cmmnCdVO의 cdId검색은 공백이 되면 왜 에러가 나는것일까?
	}
	var evntYn= $("#search-keyword-evntYn").val(); 
	if (evntYn == "" || srt == null) {
		evntYn = '%'
	}
	
	var queryString = "strPrdtPageNo=" + pageNo;
	queryString += "&strId=" + str;
	queryString += "&prdtId=" + prdt;
	queryString += "&useYn=" + useYn;
	queryString += "&evntVO.evntId=" + evntYn;
	queryString += "&cmmnCdVO.cdId=" + srt; // vo안에 vo에 멤버변수로 전달할 때
	
	location.href = "${context}/strprdt/list?" + queryString; // URL 요청
} 
</script>
</head>
<body>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">메뉴 > 매장별 메뉴관리</span>
	</div>
	<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
 		<div style="margin: 13px;">총 ${strPrdtList.size() > 0 ? strPrdtList.get(0).totalCount : 0}건</div> 
		<table class="table caption-top table-hover" style="text-align: center;">
			<thead class="table-secondary">
				<tr>
					<th scope="col"><input type="checkbox" id="all-check"/></th>

					<c:if test="${mbrVO.mbrLvl eq '001-01'}">
						<th scope="col">
							<select name="selectFilter"
									id="search-keyword-str"
									class="select-align-center" 
									style="width:220px;">
								<option value="">매장명</option>
								<c:choose>
									<c:when test="${not empty strList}">
										<c:forEach items="${strList}"
													var="str">
											<option value="${str.strId}">${str.strNm} (${str.strId})</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</th>
					</c:if>
					
					<th scope="col">
						<select class="select-align-center" name="selectFilter"
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
					<th scope="col">
						<select class="select-align-center" name="selectFilter"
								id="search-keyword-prdt">
							<option value="">메뉴 이름</option>
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
					<th scope="col">
						<select class="select-align-center" name="selectFilter"
								id="search-keyword-evntYn">
							<option value="">이벤트</option>
							<option value="Y">진행중</option>
							<option value="N">-</option>
						</select>
					</th>
					<th scope="col">수정자</th>
					<th scope="col">수정일</th>
					<th scope="col">
					<select class="select-align-center" name="selectFilter"
							id="search-keyword-useYn">
						<option value="">사용유무</option>
						<option value="Y">사용</option>
						<option value="N">미사용</option>
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
								
								<c:if test="${mbrVO.mbrLvl eq '001-01'}">
									<td>${strPrdt.strVO.strNm}</td>
								</c:if>
								
								<td>${strPrdt.cmmnCdVO.cdNm}</td>
								<td>${strPrdt.prdtVO.prdtNm}</td>
								<td>${empty strPrdt.evntVO.evntId ? "-" : "진행중"}</td>
								<td class="ellipsis"
									onclick="event.cancelBubble=true">
									<a class="open-layer" href="javascript:void(0);" 
												val="${strPrdt.mdfyrMbrVO.mbrId}">
												${strPrdt.mdfyr eq null ? '<i class="bx bx-error-alt" ></i>ID없음' : strPrdt.mdfyr}(${strPrdt.mdfyrMbrVO.mbrNm})</a>
								</td>
								<td>${strPrdt.mdfyDt}</td>
								<td>${strPrdt.useYn eq 'Y' ? '사용' : '미사용'}</td>
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
		<%-- 		총 ${strPrdtList.size() > 0 ? strPrdtList.get(0).totalCount : 0}건
				총 ${strPrdtList.size() > 0 ? strPrdtList.size() : 0}건 --%>
			<c:if test="${mbrVO.mbrLvl eq '001-01'}">
				<button id="btn-missingCheck" class="btn btn-outline-success btn-default" style="vertical-align: top;">누락체크</button>
			</c:if>	
			</div> 
			
			<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-02'}">
				<div class="align-right absolute white-space-nowrap" style="right: 0px;" >
					<select class="form-select"
							id="select-useYn">
						<option value="">사용유무</option>
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
					<button id="btn-update-all" 
							class="btn btn-outline-primary btn-default" 
							style="vertical-align: top;">일괄수정</button>
					<button class="btn btn-outline-success btn-default" 
							id="btn-search-reset">검색초기화</button>		
				</div>
			</c:if>
			
			<div class="pagenate">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<c:set value="${strPrdtList.size() > 0 ? strPrdtList.get(0).lastPage : 0}" var="lastPage"></c:set>
						<c:set value="${strPrdtList.size() > 0 ? strPrdtList.get(0).lastGroup : 0}" var="lastGroup"></c:set>
						
						<fmt:parseNumber var="nowGroup" value="${Math.floor(strPrdtVO.strPrdtPageNo / strPrdtVO.strPrdtPageCnt)}" integerOnly="true" />
						<c:set value="${nowGroup * strPrdtVO.strPrdtPageCnt}" var="groupStartPageNo"></c:set>
						<c:set value="${groupStartPageNo + strPrdtVO.strPrdtPageCnt}" var="groupEndPageNo"></c:set>
						<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1}" var="groupEndPageNo"></c:set>
						
						<c:set value="${(nowGroup - 1) * strPrdtVO.strPrdtPageCnt}" var="prevGroupStartPageNo"></c:set>
						<c:set value="${(nowGroup + 1) * strPrdtVO.strPrdtPageCnt}" var="nextGroupStartPageNo"></c:set>
						
						 
						<c:if test="${nowGroup > 0}">
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo+strPrdtVO.strPrdtPageCnt-1})">이전</a></li>
						</c:if>
						
						<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1"	var="strPrdtPageNo">
							<li class="page-item"><a class="page-link text-secondary" class="${strPrdtPageNo eq strPrdtVO.strPrdtPageNo ? 'on' : ''}"  href="javascript:movePage(${strPrdtPageNo})">${strPrdtPageNo+1}</a></li>
						</c:forEach>
						
						<c:if test="${lastGroup > nowGroup}">
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
		
<!-- 		<div class="align-right grid-btns"> -->
<%-- 			<a href="${context}/prdt/list"><button class="btn btn-secondary">메뉴리스트</button></a> --%>
<!-- 		</div> -->

	<div class="layer_popup" id="layer_popup" style="display: none;">
		<div class="popup_box">
			<div class="popup_content">
				<a class="send-memo-btn" href="javascript:void(0);">
				<i class='bx bx-mail-send' ></i>
				쪽지 보내기</a>
			</div>
			<div>
				<a class="close-memo-btn" href="javascript:void(0);">
				<i class='bx bx-x'></i>
				닫기</a>
			</div>
		</div>
	</div>
		

	</div>
<jsp:include page="../include/closeBody.jsp" />
</html>