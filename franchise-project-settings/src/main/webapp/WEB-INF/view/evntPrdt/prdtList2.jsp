<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 상품 설정</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

//input 가격 입력의 최대길이를 제한하기 위한 기능
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
}

// 특수문자 모두 제거    
function chkChar(obj){
    var RegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;	//정규식 구문
    if (RegExp.test(obj.value)) {
      obj.value = obj.value.replace(RegExp , '');
    }
}

$().ready(function() {
	
	var ajaxUtil = new AjaxUtil();
	
	$("#search-keyword-prdtSrt").val("${prdtVO.prdtSrt}");
	
	
	
	
	//체크박스기능
	$("#all-check").click(function() {
		$(".check_idx").prop("checked", $("#all-check").prop("checked"));
	});
	$("#all-check").change(function(){
		$(".check-idx").prop("checked", $(this).prop("checked"));
	});
	$(".check-idx").change(function(){
		var count = $(".check-idx").length;
		var checkCount = $(".check-idx:checked").length;
		
		$("#all-check").prop("checked", count == checkCount);
	});
	
	
	// 체크 버튼 클릭 시 체크된 리스트 뜸
// 	$("#btn-revomeEvntPrdt").click(function() {
// 		var checkLen = $(".check-idx:checked").length;
		
// 		if(checkLen == 0){
// 			alert("체크한 대상이 없습니다.");
// 			return;
// 		}
		
// 		var form = $("<form></form>")
// 		$(".check-idx:checked").each(function(){
// 			console.log($(this).val());
// 			form.append("<input type='hidden' name='evntPrdtIdList' value='"+$(this).val() + "'>'")
// 		});
		
// 		$.post("${context}/api/evntPrdt/delete", form.serialize(), function(response){
// 			if(response.status == "200 OK"){
// 				location.reload(); //새로고침
// 				alert("이벤트 상품 등록이 해제되었습니다.")
// 			}
// 			else{
// 				alert(response.errorCode + " / " + response.message);
// 			}
// 		})
		
		
	// 검색 기능 : 셀렉트박스 변경시
	$("select[name=selectFilter]").on("change", function(event) {
		movePage(0);
		});	
				

	// 1. 등록 버튼을 누르면 수행할 내용
	$("#btn-create").click(function() {
		$.post(
		// 1. 호출할 주소
		"${context}/api/evntPrdt/create",

		// 2. 파라미터
		{
			evntId : "${evntId}",
			evntPrdtId : $("#evntPrdtId").val(),
			prdtId : $("#prdtId").val(),
			prdtNm : $("#prdtNm").val(),
			prdtPrc : $("#prdtPrc").val(),
			evntPrdtChngPrc : $("#evntPrdtChngPrc").val()
		},

		// 3. 결과 처리
		function(response) {
			if (response.status == "200 OK") {
				alert(response.message);
				//location.reload(); // 새로고침
			} else {
				alert(response.errorCode + " / " + response.message);
			}
		});
	});

	//'돌아가기'버튼 누르면 뒤로 돌아가기
	$("#btn-cancle").click(function() {
		window.close();
	});

	// 창 닫기
	$("#btn-close").click(function() {
		window.close();
	});
		
});

function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	
	var queryString = "prdtSrt=" + srt;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/evntPrdt/prdtList2?" + queryString; // URL 요청
} 
			
</script>

</head>
<body>
		<div class="main-layout">
		<div>
			<h1>이벤트상품 리스트 목록 조회</h1>
			<div>총 ${evntList.size() > 0 ? evntList.get(0).totalCount : 0}건</div>
		</div>
		<div class="content">
			<div class="sort-group">
				<table>
					<thead>
						<tr>
						   <th><input type="checkbox" id="all-check" /></th>
							<th style="width: 100px">이벤트 상품 ID</th>
							<th style="width: 200px">이벤트 ID</th>
							<th style="width: 200px">상품 ID</th>
							<th style="width: 200px">
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
							<th style="width: 200px">상품 가격</th>
							<th style="width: 200px">변경 가격</th>
							<th style="width: 200px">최종 이벤트 가격</th>
							<th style="width: 80px">사용유무</th>
							<th style="width: 80px">삭제여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty prdtList}">
								<c:forEach items="${prdtList}" var="prdt">
									<tr>
									 <td class="firstcell">
									    <input type="checkbox" class="check-idx" value="${prdt.prdtId}"/></td>
										<td>${prdt.prdtId}</td>
										<td> </td>
										<td>${prdt.prdtId}</td>
										<td>${prdt.prdtNm}</td>
										<td>${prdt.prdtPrc}</td>
										<td> <input type="text" class="selectFilter" id="search-keyword-changPrice" 
								           	placeholder="변경할 가격 입력" onkeyup="chkChar(this)" value=""></td>
										<td></td>
										<td>${prdt.useYn}</td>
										<td>${prdt.delYn}</td>
									
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9">등록된 이벤트 대상 품목 정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				
				
				
				
				
						<div class="pagenate">
					<ul>
						<c:set value="${prdtList.size() > 0 ? prdtList.get(0).lastPage : 0}" var="lastPage" />
						  <c:set value="${prdtList.size() > 0 ? prdtList.get(0).lastGroup : 0}" var="lastGroup" />

						<fmt:parseNumber var="nowGroup" value="${Math.floor(prdtVO.pageNo /10)}" integerOnly="true" />
						<c:set value="${nowGroup*10}" var="groupStartPageNo" />
						<c:set value="${nowGroup*10+ 10}" var="groupEndPageNo" />
						<c:set value="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo -1}" var="groupEndPageNo" />

						<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
						<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
						<c:if test="${nowGroup > 0}">
							<li><a href="javascript:movePage(0)">처음</a></li>
							<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
						</c:if>

						<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
							<li><a class="${pageNo eq prdtVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
						</c:forEach>
						<c:if test="${lastGroup > nowGroup}">
							<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li><a href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</div>	
			</div>
			<button id="btn-close" class="btn-primary">닫기</button>
			<button id="btn-revomeEvntPrdt" class="btn-primary">상품 삭제</button>
			<button id="btn-listEvntPrdt" class="btn-primary">확인용도</button>

		</div>
	</div>
</body>
</html>