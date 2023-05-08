<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/> 
<%-- <link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/> --%>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />	
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {	
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked",$(this).prop("checked"));
		});
			
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount =$(".check_idx:checked").length;
			console.log(count,checkCount)
			$("#all_check").prop("checked",count==checkCount);
		});
		
		$("#delete_btn").click(function(){
			var checkLen= $(".check_idx:checked").length;
			if(checkLen ==0){
				Swal.fire({
			    	  icon: 'error',
			    	  title: '삭제할 댓글이 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("삭제할 댓글이 없습니다."); */
				return;
			} 
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			var form =$("<form></form>")	
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='rplId' value='" + $(this).val() + "'>")
			});
			
			$.post("${context}/api/rpl/delete",form.serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else {
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + "/" + response.message); */
				}
			});
		});
		
		$("#search-btn").click(function(){
			//전송.
			//입력 값.	
			var rplCntnt = $("#search-keyword").val();
			//URL 요청
			location.href = "${context}/rpl/list?rplCntnt=" +rplCntnt;
		});
		
	    $("#search-btn").click(function(){
	    	
	        movePage(0);
	     });
	    
	    $("select[name=selectFilter]").on("change", function(evetn) {
			movePage(0);
		});
	}); 

	function movePage(pageNo){
		
		var searchIdx = $("#search-select").val();	
		var searchKeyword = $("#search-keyword").val();
		var delYn = $("#search-keyword-delYn").val();
		
		var queryString = "searchIdx=" + searchIdx;
		queryString += "&searchKeyword=" + searchKeyword
		queryString += "&pageNo=" + pageNo; 
		queryString += "&delYn=" + delYn
	
		location.href = "${context}/rpl/list?" + queryString;
	}
	
	
</script>
<style> 
.select-align-center {
	text-align-last: center;
	width: auto;
	border: none;
    background-color: #0000;
    font-weight: bold;
}
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
} 
</style>
</head>
<jsp:include page="../include/openBody.jsp" />

				<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
					<span class="fs-5 fw-bold">관리자게시판 > 댓글 리스트</span>
	    		</div>
				<!-- searchbar -->
				<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
					<!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
					<svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="margin: 15px;">
					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg>
					<select id="search-select" class="form-select" style="margin-right: 10px; width: 30%;" aria-label="Default select example">
						<option value="rplCntnt"${searchIdx eq 'mngrBrdTtl' ?  'selected': ''}>댓글</option>
						<option value="Wrtr"${searchIdx eq 'Wrtr' ?  'selected': ''}>작성자</option>
						<option value="mngrBrdTtl"${searchIdx eq 'mngrBrdTtl' ?  'selected': ''}>게시글</option>
					</select>
					<input class="form-control me-2" type="text" id="search-keyword" value="${rplVO.rplCntnt}" placeholder="Search" aria-label="Search">
					<button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px; min-width:80px;">검색</button>
				</div>
				<!-- /searchbar -->	
	
				<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
					<div style="margin: 13px;">총 ${rplList.size() > 0 ? rplList.get(0).totalCount : 0}건</div>
					<table class="table caption-top table-hover" style="text-align: center;table-layout: fixed; ">
						<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
							<tr>		
								<th scope="col" style="border-radius:6px 0  0 0; padding: 20px 20px 8px 20px;"><input type = "checkbox" id ="all_check"/></th>
								<th scope="col" style="padding: 20px 20px 8px 20px;">글번호  </th>	
								<th scope="col" style="padding: 20px 20px 8px 20px;">게시글</th>				
								<th scope="col" style="padding: 20px 20px 8px 20px;">댓글내용</th> 
								<th scope="col" style="padding: 20px 20px 8px 20px;">작성자</th>
								<th scope="col" style="padding: 20px 20px 8px 20px;">작성일</th>
								<th scope="col" style="padding: 20px 20px 8px 20px; ">수정일</th>
								<th scope="col" style="border-radius: 0 6px 0 0; width: 160px;" >
									<select class=" select-align-center" name="selectFilter"
											id="search-keyword-delYn">
										<option value="">삭제여부</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>			 		
								<c:when test="${not empty rplList}">
									<c:forEach items="${rplList}" var="rpl" >
										<tr data-rplid = "${rpl.rplId}"
											data-rplcntnt = "${rpl.rplCntnt}"
											data-mbrid = "${rpl.mbrId}"
											data-rplwrtdt = "${rpl.rplWrtDt}"
											data-mdfydt = "${rpl.mdfyDt}"
											data-altclid = "${rpl.altclId}"
											data-useyn = "${rpl.useYn}"
											data-delyn = "${rpl.delYn}">
											<td style="width: 20px;">
												<input type ="checkbox" class="check_idx" value="${rpl.rplId}">
											</td>
											<td style="width: 160px;">${rpl.rplId} </td>
											<td class="ellipsis" style="width: 200px; "> 
												<a href="${context}/mngrbrd/${rpl.altclId}" class="brdid">
												${rpl.mngrbrdVO.mngrBrdTtl}</a>
											</td>
											<td class="ellipsis">${rpl.rplCntnt} </td>
											<td style="width: 110px;">${rpl.mbrVO.mbrNm} </td>
											<td style="width: 180px;">${rpl.rplWrtDt} </td>
											<td style="width: 180px;">${rpl.mdfyDt} </td>
											<td style="width: 40px;">${rpl.delYn} </td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="9" class="no-items">
											검색 결과가 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div style="position: relative;">
						<div class="pagenate">
							<ul class="pagination" style="text-align: center;">
								<c:set value = "${rplList.size() > 0 ? rplList.get(0).lastPage : 0}" var="lastPage"/>
								<c:set value = "${rplList.size() > 0 ? rplList.get(0).lastGroup : 0}" var="lastGroup"/>
								
								<fmt:parseNumber var="nowGroup" value="${Math.floor(rplVO.pageNo /10)}" integerOnly="true" />
								<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
								<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
								<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo}" var="groupEndPageNo" />
								
								<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
								<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
								<c:if test="${nowGroup > 0}">
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
								</c:if>
	
								<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
									<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq rplVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
								</c:forEach> 
								
								<c:if test="${lastGroup > nowGroup}">
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
								</c:if>
							</ul>
						</div>
						<div style="position: absolute;right: 0;top: 0;">
	           				<button id="delete_btn" class="btn btn-outline-danger btn-default">삭제</button> 
	          			</div>	
					</div>		
				</div>		
<jsp:include page="../include/closeBody.jsp" />
</html>