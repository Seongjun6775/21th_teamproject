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
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">

	$().ready(function() {
		
		var url;
		$(".open-layer").click(function(event) {
			// event.preventDefault();
			var mbrId = $(this).text();
			$("#layer_popup").css({
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF",
				"position": "absolute",
				"border": "solid 1px #222",
				"z-index": "10px"
			}).show();
			
			url = mbrId
		});
		
		$(".send-memo-btn").click(function() {
			if (url) {
				$("input[name=searchWrap]").val(url)
				$("#search_option").val("mbrId").prop("selected", true);
				$("#search_btn").click();
			}
		});
		
		$(".close-memo-btn").click(function() {
			url = undefined;
			$("#layer_popup").hide();
		});
		
		$("input[name=searchWrap]").val("${searchRvVO.search}");
		$("#search_option").val("${searchRvVO.type}");
		
		$("#search-keyword").keyup(function(event) {
			if(event.keyCode == 13) {
				$("#search_btn").click();
			}
		});
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
			if(confirm("정말 삭제하시겠습니까?")) {
				var form = $("<form></form>")
				$(".check-idx:checked").each(function(){
					var myMbrId = "${mbrVO.mbrId}";
					var myMbrLvl = "${mbrVO.mbrLvl}";
					var mbrId = $(this).closest("tr").find(".open-layer").text();
					if (myMbrLvl == "001-04" && myMbrId != mbrId) {
						alert("자신의 리뷰만 삭제 가능합니다.");
						return;		
					}
					console.log($(this).val());
					form.append("<input type='hidden' name='rvIdList' value='"+$(this).val() + "'>'");
				});
				$.post("${context}/api/rv/delete", form.serialize(), function(response){
					if(response.status == "200 OK"){
						location.reload(); //새로고침
						alert("리뷰가 삭제되었습니다.")
					}
					else{
						alert(response.errorCode + "권한이 없습니다." + response.message);
					}
				})
			}
		});	
		
		$("#search_btn").click(function(){			
			movePage(0);
		});		 
		$(".rvRow td").not(".firstcell, .mbrId").click(function() {
			var rvid = $(this).closest(".rvRow").data("rvid")
			location.href="${context}/rv/detail/" + rvid;
		})
	});
		function movePage(pageNo){
			//전송.
			//입력 값:
			 var id = $("input[name=searchWrap]").val();
			 var selec = $("#search_option").val();
			
			var queryString = "?pageNo=" + pageNo;
			queryString += "&type="+selec + "&search=" + id;
			
			//URL요청
			location.href="${context}/rv/list" + queryString;
			
		}
</script>
<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
}
</style>
</head>
<body>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">리뷰 > 리뷰목록</span>
	    </div>		
		
		<!-- searchbar -->
		<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
		  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
		  <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="margin: 15px;">
		    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
		  </svg>
		    <select id="search_option" name="searchOption" class="form-select " style="margin-right: 10px; width: 30%;" aria-label="Default select example">
				<option value="">검색 조건</option>
				<option value="strNm" >매장명</option>
				<option value="mbrId" >회원ID</option>
		    </select>
		    <input class="form-control me-2" type="text" name="searchWrap" id="search-keyword" placeholder="Search" aria-label="Search">
		    <button id="search_btn" class="btn btn-outline-success enterkey" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px; min-width:80px;">검색</button>
		</div>
		<!-- /searchbar -->	

		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<div style="margin: 13px; display:inline-block">총 ${rvList[0].totalCount}건</div>	
		<table class="table caption-top table-hover" style="text-align: center;">
			<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
				<tr>
					<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-04'}">
					<th scope="col" style="padding: 20px 20px 8px 20px;"><input type="checkbox" id="all_check" /></th>
					</c:if>
					<th scope="col" style="padding: 20px 20px 8px 20px;">주문서ID</th>
					<th scope="col" style="padding: 20px 20px 8px 20px;">매장명</th>
					<th scope="col" style="padding: 20px 20px 8px 20px;">제목</th>
					<th scope="col" style="padding: 20px 20px 8px 20px;">회원ID</th>						
					<th scope="col" style="padding: 20px 20px 8px 20px;">좋아요/싫어요</th>
					<th scope="col" style="padding: 20px 20px 8px 20px;">등록일</th>
					<th scope="col" style="padding: 20px 20px 8px 20px;">수정일</th> 
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty rvList}">
						<c:forEach items="${rvList}"
								   var="rv">
							<tr class="rvRow" data-rvid="${rv.rvId}" style="cursor:pointer;">
								<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-04'}">
								<td class="firstcell">
									<input type="checkbox" 
										   class="check-idx" 
										   value="${rv.rvId}" style="width:13px;"/>
								</td>
								</c:if>
								<td>${rv.odrLstId}</td>
								<td>${rv.strVO.strNm}</td>
								<td>${rv.rvTtl}</td>
								<td class="mbrId" onclick="event.cancelBubble=true"><a class="open-layer" href="javascript:void(0);">${rv.mbrId}</a></td>																			
								<td>${rv.rvLkDslk eq 'T' ? '좋아요' : '싫어요'}</td>					
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
		<div style="position: relative;">
			<div class="pagenate">
				<ul class="pagination" style="text-align: center;">
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
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
					</c:if>
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq gnrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
					
					<c:if test = "${lastGroup >nowGroup }">
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>
			<div style="position: absolute;right: 0;top: 0;">	
				<c:if test="${mbrVO.mbrLvl eq '001-04'}">		
					<button id="new_btn" class="btn btn-outline-success btn-default">등록</button>
				</c:if>
				<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-04'}">
					<button id="delete_all_btn" class="btn btn-outline-danger btn-default" >삭제</button>
				</c:if>
			</div>
		</div>	
	</div>
<jsp:include page="../include/closeBody.jsp" />
	<div class="layer_popup" id="layer_popup" style="display: none;">
		<div class="popup_box">
			<div class="popup_content">
				<a class="send-memo-btn" href="javascript:void(0);">작성 리뷰 보기</a>
			</div>
			<div>
				<a class="close-memo-btn" href="javascript:void(0);">닫기</a>
			</div>
		</div>
	</div>	
</html>