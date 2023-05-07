<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<!-- <link rel="stylesheet" href="../css/evntCommon.css"> -->
<meta charset="UTF-8">
<title>우리매장 이벤트리스트 목록 조회</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
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
		// 창 닫기
		$("#btn-close").click(function() {
			window.close();
		});

		// 체크 버튼 클릭 시 체크된 리스트 뜸
		$("#btn-exitEvnts").click(function() {
			var checkLen = $(".check-idx:checked").length;
			
			if(checkLen == 0){
				alert("체크한 대상이 없습니다.");
				return;
			}
			
			var form = $("<form></form>")
			$(".check-idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='evntStrIdList' value='"+$(this).val() + "'>'")
			});
			
			$.post("${context}/api/evntStr/delete", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
					alert("이벤트 참여가 해제되었습니다.")
				}
				else{
					alert(response.errorCode + " / " + response.message);
				}
			})
			
		});	
		
	});
	
	function movePage(pageNum){
		location.href = "${context}/evntStr/ourList/${evntStrId}?pageNum=" + (pageNum);		
	}
	
</script>
<style>
.btn{
	border: solid 2px;
    font-weight: 800;
}
  
</style>
</head>
<body class="bg-dark bg-opacity-10 ">
	<div style="padding: 23px 18px 23px 18px;">
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin-bottom:20px;" >
	        <span class="fs-5 fw-bold"> 우리매장 이벤트리스트 목록 조회</span>
      	</div>
		<div class="content">
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding:30px 30px 55px 30px;">
			<div style="display: inline-block; margin:13px;">총 ${evntStrList.size()}건</div>
				<table class="table caption-top table-hover" style="text-align: center;">
					<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
						<tr>
							<th><input type="checkbox" id="all-check" /></th>
							<th>이벤트 참여번호</th>
							<th style="width: 200px">이벤트 ID</th>
							<th style="width: 200px">이벤트 제목</th>
							<th style="width: 200px">이벤트 내용</th>
							<th style="width: 200px">시작일</th>
							<th style="width: 200px">종료일</th>
							<th style="width: 200px">이벤트 참여매장 ID</th>
							<th style="width: 200px">이벤트 참여매장명</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty evntStrList}">
								<c:forEach items="${evntStrList}" var="evntStr">
									<tr>
										<td class="firstcell">
										<input type="checkbox" class="check-idx" value="${evntStr.evntStrId}" /></td>
										<td>${evntStr.evntStrId}</td>
										<td>${evntStr.evntId}</td>
										<td>${evntStr.evntTtl}</td>
										<td>${evntStr.evntCntnt}</td>
										<td>${evntStr.evntStrtDt}</td>
										<td>${evntStr.evntEndDt}</td>
										<td>${evntStr.strId}</td>
										<td>${evntStr.strNm}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9">등록된 이벤트 참여매장 정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div style="position: relative;"> 
					<div class="pagenate">
						<ul class="pagination" style="text-align: center;">
							<c:set value="${evntStrList.size() > 0 ? evntStrList.get(0).lastPage : 0}" var="lastPage" />
							  <c:set value="${evntStrList.size() > 0 ? evntStrList.get(0).lastGroup : 0}" var="lastGroup" />
	
							<fmt:parseNumber var="nowGroup" value="${Math.floor(evntStrVO.pageNo /10)}" integerOnly="true" />
							<c:set value="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value="${nowGroup*10+ 10}" var="groupEndPageNo" />
							<c:set value="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo -1}" var="groupEndPageNo" />
	
							<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
							<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							<c:if test="${nowGroup > 0}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
	
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
								<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq evntStrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							<c:if test="${lastGroup > nowGroup}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div>
					<div style="position: absolute;right: 0;top: 0;">
						<button id="btn-exitEvnts" class=" btn btn-outline-danger">이벤트 참여해제</button>
						<button id="btn-close" class="btn btn-outline-secondary ">닫기</button>
					</div>	
				</div>
			</div>
		</div>
	</div>
</body>
</html>