<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" href="../../css/evntCommon.css"> -->
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<meta charset="UTF-8">
<title>이벤트 상품 목록 조회</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
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
		$("#btn-revomeEvntPrdt").click(function() {
			var checkLen = $(".check-idx:checked").length;
			
			if(checkLen == 0){
				alert("체크한 대상이 없습니다.");
				return;
			}
			
			var form = $("<form></form>")
			$(".check-idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='evntPrdtIdList' value='"+$(this).val() + "'>'")
			});
			
			$.post("${context}/api/evntPrdt/delete", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
					alert("이벤트 상품 등록이 해제되었습니다.")
				}
				else{
					alert(response.errorCode + " / " + response.message);
				}
			})
			
		});	
		
		
		// 창 닫기
		$("#btn-close").click(function() {
			window.close();
		});
		
		//★☆확인용도(나중에 삭제할것)
		$("#btn-listEvntPrdt").click(function() {
			var pop = window.open("${context}/evntPrdt/prdtList2", "resPopup", "width=1200, height=600, scrollbars=yes, resizable=yes");
			pop.focus();
		});
		
		
	});
	
	function movePage(pageNum){
		location.href = "${context}/evntPrdt/list/${evntId}?pageNum=" + (pageNum);	
	}
	
</script>


</head>
<body>
	<div style="padding: 23px 18px 23px 18px;">	
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin-bottom:20px;" >
	        <span class="fs-5 fw-bold"> 이벤트상품 리스트 목록 조회</span>
      	</div>
		<div class="content">
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding:30px 30px 55px 30px;">
				<div style="display: inline-block; margin-bottom: 5px;">총 ${evntPrdtList.size()}건</div>
				<table class="table caption-top table-hover" style="text-align: center;">
					<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
						<tr>
						   <th style="width: 50px; text-align: center;"><input type="checkbox" id="all-check" /></th>
							<th style="width: 100px">이벤트 상품 ID</th>
							<th style="width: 200px">이벤트 ID</th>
							<th style="width: 200px">상품 ID</th>
							<th style="width: 200px">상품 이름</th>
							<th style="width: 200px">상품 가격</th>
							<th style="width: 200px">변경 후 가격</th>
<!-- 							<th style="width: 80px">사용유무</th> -->
<!-- 							<th style="width: 80px">삭제여부</th> -->
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty evntPrdtList}">
								<c:forEach items="${evntPrdtList}" var="evntPrdt">
									<tr>
									 <td class="firstcell">
									    <input type="checkbox" class="check-idx" value="${evntPrdt.evntPrdtId}"/></td>
										<td>${evntPrdt.evntPrdtId}</td>
										<td>${evntPrdt.evntId}</td>
										<td>${evntPrdt.prdtId}</td>
										<td>${evntPrdt.prdtNm}</td>
										<td><fmt:formatNumber>${evntPrdt.prdtPrc}</fmt:formatNumber>원</td>
										<td><fmt:formatNumber>${evntPrdt.evntPrdtChngPrc}</fmt:formatNumber>원</td>
<%-- 										<td>${evntPrdt.useYn}</td> --%>
<%-- 										<td>${evntPrdt.delYn}</td> --%>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6">등록된 이벤트 대상 품목 정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div style="position: relative;">
					<div class="pagenate">
						<ul class="pagination" style="text-align: center;">
							<c:set value="${evntPrdtList.size() > 0 ? evntPrdtList.get(0).lastPage : 0}" var="lastPage" />
							  <c:set value="${evntPrdtList.size() > 0 ? evntPrdtList.get(0).lastGroup : 0}" var="lastGroup" />
	
							<fmt:parseNumber var="nowGroup" value="${Math.floor(evntPrdtVO.pageNo /10)}" integerOnly="true" />
							<c:set value="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value="${nowGroup*10+ 10}" var="groupEndPageNo" />
							<c:set value="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo -1}" var="groupEndPageNo" />
	
							<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
							<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							<c:if test="${nowGroup > 0}">
								<li class="page-item"><a class="page-link text-secondary"href="javascript:movePage(0)">처음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
	
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
								<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq evntPrdtVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							<c:if test="${lastGroup > nowGroup}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div>
					<div style="position: absolute;right: 0;top: 0;">
						<button id="btn-close" class="btn btn-secondary" >닫기</button>
						<button id="btn-revomeEvntPrdt" class="btn btn-danger">상품 삭제</button>
						<%--<button id="btn-listEvntPrdt" class="btn-primary">확인용도</button>--%>
					</div>	
				</div>
			
			</div>
		</div>
	</div>
</body>
</html>