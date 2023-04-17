<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href="${context}/css/common.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
		
		$("#search-btn").click(function(){
			//전송.
			//입력 값.	
			var mngrBrdTtl = $("#search-keyword").val();
			//URL 요청 
			location.href = "${context}/mngrbrd/list?mngrBrdTtl=" +mngrBrdTtl;
		});
		
		
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
				alert("삭제할 글이 없습니다.");
				return;
			} 
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			var form =$("<form></form>")	
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='mngrBrdId' value='" + $(this).val() + "'>")
			});

			$.post("${context}/api/mngrbrd/delete",form.serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
	});
	
	function movePage(pageNo){
		//전송.
		//입력 값.	
		var mngrBrdTtl = $("#search-keyword").val();
		//URL 요청
		location.href = "${context}/mngrbrd/list?mngrBrdTtl=" +mngrBrdTtl +"&pageNo=" +pageNo;
	}
	

</script>
</head>
<body>
<div style="display: block; padding: 20px;">
	<div class="list-title">
	    <h3 class="list-title"> 관리자 게시판</h3>
	</div> 
    
    <div class="board_box row">	
		<div class=" col-sm-3 col-xs-4">
			<select id="keySelect" class="input-text" style="width: 100%;" onchange="javascript:changeSearchSelect(this);">
				<option value="subject">제목</option>
				<option value="summary">본문</option>			 
					<option value="user_name">작성자</option>			
			</select>
		</div>
		<div class=" col-sm-6 col-xs-8">
			<input name="keyword" type="text" class="input-text" placeholder="검색어를 입력해주세요" id="search-keyword"  style="width: 100%;" value="${mngrBrdVO.mngrBrdTtl}" >
		</div>
		<div class=" col-sm-3 col-xs-12">
			<a role="button" title="검색"  href="javascript:void(0);"  id="search-btn" class="blue-btn" style="width:100%;">검색</a>
		</div>
	</div>
	
	<div style="margin: 10px;"> 
		<span>총  게시물 ${mngrBrdList.size()} <strong id="articleTotalCount"></strong> 개</span>,
		<span class="division_line">페이지 <strong id="currentPageNo"></strong> / <span id="totalPageNo">${mngrBrdVO.pageNo+1}</span></span>
    </div>

	<div class= "grid">
	
		<table>
			<thead>
				<tr>
					<th><input type = "checkbox" id ="all_check"/></th>
					<th>글번호</th>
					<th>카테고리</th>					
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>게시여부</th>
						
				</tr>
			</thead>
			<tbody>
				<c:choose>					
					<c:when test="${not empty mngrBrdList}">
						<c:forEach items="${mngrBrdList}" var="mngrBrd">
							<tr data-mngrid = "${mngrBrd.mngrId}"
								data-mngrbrdwrtdt = "${mngrBrd.mngrBrdWrtDt}"
								data-useyn = "${mngrBrd.useYn}">
								<td style="width: 20px;"> 
									<input type ="checkbox" class="check_idx" value="${mngrBrd.mngrBrdId}">
								</td>
								<td style="width: 160px;">${mngrBrd.mngrBrdId} </td>
								<td style="width: 70px;">
								${mngrBrd.ntcYn eq 'Y' ? '공지' : '게시판'}</td>
								
								<td>
									<a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}" style="text-decoration: none;">
										${mngrBrd.mngrBrdTtl}  
									</a>[${mngrBrd.rplList.size()}] 
								</td>
								<td>${mngrBrd.mngrId}</td>
								<td style="width: 160px;">${mngrBrd.mngrBrdWrtDt}</td>
								<td style="width: 70px;">
								${mngrBrd.useYn}</td>		
								
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="9" class="no-items">
							
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div style="text-align: right; margin-top: 6px;"> 
			<button id="delete_btn" class="red-btn">삭제</button> 
			<a href="${pageContext.request.contextPath}/mngrbrd/write" class="btn-m" style="text-decoration: none;"> 게시글 작성</a>
		</div>
		

		
		<div class="pagenate">
			<ul>
				<c:set value = "${mngrBrdList.size() > 0 ? mngrBrdList.get(0).lastPage : 0}" var="lastPage"/>
				<c:set value = "${mngrBrdList.size() > 0 ? mngrBrdList.get(0).lastPage : 0}" var="lastGroup"/>
				
				<fmt:parseNumber var="nowGroup" value="${Math.floor(MngrBrdVO.pageNo /10)}" integerOnly="true" />
				<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
				<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
				<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo-1}" var="groupEndPageNo" />
				
				<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
				<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
				
		<%-- 		lastPage: ${lastPage} 
				lastGroup:${lastGroup}
				nowGroup:${nowGroup}
				groupStartPageNo:${groupStartPageNo}
				groupEndPageNo:${groupEndPageNo}
				prevGroupStartPageNo:${prevGroupStartPageNo}
				nextGroupStartPageNo: ${nextGroupStartPageNo} --%>
				
				<c:if test="${nowGroup > 0}">
					<li><a href="javascript:movePage(0)">처음</a></li>
					<li><a href="javascript:movePage(${prevGroupStartPageNo})")>이전</a></li>
				</c:if>
						
				<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
					<li><a class="${pageNo eq MngrBrdVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
				</c:forEach>
				
				<c:if test="${lastGroup > nowGroup}">
					<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
					<li><a href="javascript:movePage(${lastPage})">끝</a></li>
				</c:if>
			</ul>
		</div>			
	</div>
</div>
</body>
</html>