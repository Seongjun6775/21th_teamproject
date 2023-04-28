<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>"></c:set>
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
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}

	// 특수문자 모두 제거    
	function chkChar(obj) {
		var RegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; //정규식 구문
		if (RegExp.test(obj.value)) {
			obj.value = obj.value.replace(RegExp, '');
		}
	}

	$().ready(function() {

		var ajaxUtil = new AjaxUtil();

		$("#search-keyword-prdtSrt").val("${prdtVO.prdtSrt}");

		//체크박스기능
		$("#all-check").click(function() {
			$(".check_idx").prop("checked", $("#all-check").prop("checked"));
		});
		$("#all-check").change(function() {
			$(".check-idx").prop("checked", $(this).prop("checked"));
		});
		$(".check-idx").change(function() {
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

		
		 $("#btn-create-evntPrdt").click(function() {
				var checkLen = $(".check-idx:checked").length;
				if (checkLen == 0) {
					alert("선택된 항목이 없습니다.");
					return;
				}
				if (!confirm("체크한 항목이 일괄 등록됩니다.")) {
					return;
				}
				
				var form = $("<form></form>")
				
				$(".check-idx:checked").each(function() {
					var chgPrice = $(this).closest("tr").find("input[type=text]").val();
					chgPrice = chgPrice.replaceAll(",","");
//    				var evntId = $(this).();
					console.log(chgPrice);
// 					console.log($(this).val());
 					form.append("<input type='hiedden' name='prdtId' value='" + $(this).val() + "'>");
 					form.append("<input type='hiedden' name='evntPrdtChngPrc' value='" + chgPrice + "'>");
//					console.log(document.getElementById("search-keyword-changePrice"));
//					console.log(document.getElementById("search-keyword-changePrice").value);
				});
 					form.append("<input type='hiedden' name='evntId' value='${evntId}'>");
							
				$.post("${context}/api/evntPrdt/createCheckedEvntPrdtList", form.serialize(), function(response) {
					if (response.status == "200 OK") {
						location.reload(); //새로고침
					}
					else {
						alert(response.errorCode + " / " + response.message);
					}
				});
			})
	});

	function movePage(pageNo) {
		var srt = $("#search-keyword-prdtSrt").val();

		var queryString = "prdtSrt=" + srt;
		queryString += "&prdtPageNo=" + pageNo;

		location.href = "${context}/evntPrdt/prdtList2/${evntId}?" + queryString; // URL 요청
	}
	
	 function inputNumberFormat(obj) {
	     obj.value = comma(uncomma(obj.value));
	 }

	 function comma(str) {
	     str = String(str);
	     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	 }

	 function uncomma(str) {
	     str = String(str);
	     return str.replace(/[^\d]+/g, '');
	 }
</script>

</head>
<body>
	<div class="main-layout">
		<div>
			<h1>이벤트상품 리스트 목록 조회</h1>
			<div>총 ${prdtList.size()}건</div>
			<div>
				이벤트 ID : <input type="text" id="evntPrdtId" style="width: 300px;"
					readonly="readonly" placeholder="이벤트ID는 입력할 수 없습니다."
					value="${evntId}" />
			</div>
		</div>
		<div class="content">
			<div class="grid">
				<table>
					<thead>
						<tr>
							<th style="width: 50px; text-align: center;"><input type="checkbox" id="all-check" /></th>
							<th style="width: 200px; text-align: center;">상품 ID</th>
							<th style="width: 200px; text-align: center;"><select class="selectFilter"
								name="selectFilter" id="search-keyword-prdtSrt">
									<option value="">분류</option>
									<c:choose>
										<c:when test="${not empty srtList}">
											<c:forEach items="${srtList}" var="srt">
												<option value="${srt.cdId}">${srt.cdNm}</option>
											</c:forEach>
										</c:when>
									</c:choose>
							</select></th>
							<th style="width: 200px; text-align: center;">상품 가격</th>
							<th style="width: 200px; text-align: center;">변경 가격</th>
<!-- 							<th style="width: 80px; text-align: center;">사용유무</th> -->
<!-- 							<th style="width: 80px; text-align: center;">삭제여부</th> -->
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty prdtList}">
								<c:forEach items="${prdtList}" var="prdt">
									<tr>
										<td class="firstcell" style="text-align: center;"><input type="checkbox"
											class="check-idx" value="${prdt.prdtId}" /></td>
										<td style="text-align: center;">${prdt.prdtId}</td>
										<td style="text-align: center;">${prdt.prdtNm}</td>
										<td style="text-align: center;"><fmt:formatNumber>${prdt.prdtPrc}</fmt:formatNumber></td>
										<td style="text-align: center;"><input type="text" 
											id="search-keyword-changePrice" placeholder="변경할 가격 입력"
											onkeyup="inputNumberFormat(this)" value=""></td>
<%-- 										<td style="text-align: center;">${prdt.useYn}</td> --%>
<%-- 										<td style="text-align: center;">${prdt.delYn}</td> --%>

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
			</div>
			<button id="btn-create-evntPrdt" class="btn-primary">일괄 등록</button>
			<button id="btn-close" class="btn-primary">닫기</button>
			<!-- 			<button id="btn-revomeEvntPrdt" class="btn-primary">상품 삭제</button> -->
			<!-- 			<button id="btn-listEvntPrdt" class="btn-primary">확인용도</button> -->

		</div>
	</div>
</body>
</html>