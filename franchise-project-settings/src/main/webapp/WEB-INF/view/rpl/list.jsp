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
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
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
				alert("삭제할 댓글이 없습니다.");
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
					alert(response.errorCode + "/" + response.message);
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
</head>
<body>
<div class="main-layout">	
	<jsp:include page="../include/header.jsp" />	
	<div>
		<jsp:include page="../include/sidemenu.jsp" />
		<jsp:include page="../include/content.jsp" />
		<div>
			<div style="display: block; padding: 20px;">
				<div class="list-title">
					<h3 class="list-title"> 댓글 리스트</h3> 
				</div> 
		
			    <div class="board_box row">	
					<div class=" col-sm-3 col-xs-4">
						<select id="search-select" class="input-text" style="width: 100%;">
							<option value="rplCntnt"${searchIdx eq 'mngrBrdTtl' ?  'selected': ''}>댓글</option>
							<option value="Wrtr"${searchIdx eq 'Wrtr' ?  'selected': ''}>작성자</option>
							<option value="mngrBrdTtl"${searchIdx eq 'mngrBrdTtl' ?  'selected': ''}>게시글</option>
						</select> 
					</div>
					<div class=" col-sm-6 col-xs-8">
						<input name="keyword" type="text" class="input-text" placeholder="검색어를 입력해주세요" id="search-keyword"  style="width: 100%;" value="${rplVO.rplCntnt}" >
					</div>
					<div class=" col-sm-3 col-xs-12">
						<a role="button" title="검색" id="search-btn" class="blue-btn" style="width:100%;">검색</a>
					</div>
				</div>
				
				<div class="list-brd-top"> 
					<div class="cnt">
			    		<span>총 댓글 ${rplList.size()} <strong id="articleTotalCount"></strong> 개</span>,
						<span class="division_line">페이지 <strong id="currentPageNo"></strong> / <span id="totalPageNo">${rplVO.pageNo+1}</span></span>
					</div>
					
			    	<div class="write">   
						<button id="delete_btn" class="red-btn">삭제</button> 
					</div>
			    </div>
			
				<div class= "grid">
				
					<table>
						<thead>
							<tr>		
								<th><input type = "checkbox" id ="all_check"/></th>
								<th>글번호  </th>	
								<th>게시글</th>				
								<th>댓글내용</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
								<th>삭제여부
									<select class="selectFilter" name="selectFilter"
											id="search-keyword-delYn">
										<option value="">Y/N</option>
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
											<td style="width: 200px;"> 
												<a href="${context}/mngrbrd/${rpl.altclId}" class="brdid">
												${rpl.mngrbrdVO.mngrBrdTtl}</a>
											</td>
											<td>${rpl.rplCntnt} </td>
											<td style="width: 110px;">${rpl.mbrVO.mbrNm} </td>
											<td style="width: 180px;">${rpl.rplWrtDt} </td>
											<td style="width: 180px;">${rpl.mdfyDt} </td>
											<td style="width: 70px;">${rpl.delYn} </td>
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
				
					<div class="pagenate">
						<ul>
							<c:set value = "${rplList.size() > 0 ? rplList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${rplList.size() > 0 ? rplList.get(0).lastGroup : 0}" var="lastGroup"/>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(rplVO.pageNo /10)}" integerOnly="true" />
							<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
							<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo}" var="groupEndPageNo" />
							
							<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
							<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo})")>이전</a></li>
							</c:if>

							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
								<li><a class="${pageNo eq rplVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach> 
							
							<c:if test="${lastGroup > nowGroup}">
								<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li><a href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div>			
				</div>		
			</div>
		</div>
		<jsp:include page="../include/footer.jsp" />
	</div>
</div>
</body>
</html>