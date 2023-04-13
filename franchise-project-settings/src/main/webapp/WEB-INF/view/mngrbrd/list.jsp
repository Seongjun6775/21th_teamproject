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
	
	<h1>게시판</h1>
    
		<div class="search-group">
	   		<select id="type">
		         <option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : ''}>제목+내용</option>
		         <option value="T" ${pageMaker.cri.type eq 'T' ? "selected" : ''}>제목</option>
		         <option value="C" ${pageMaker.cri.type eq 'C' ? "selected" : ''}>내용</option>
		         <option value="W" ${pageMaker.cri.type eq 'W' ? "selected" : ''}>작성자</option>
		         <option value="TWC" ${pageMaker.cri.type eq 'TWC' ? "selected" : ''}>전체</option>
		     </select>
	     	<label for="search-keyword">검색</label>
			<input type="text" id="search-keyword" class="search-input" value="${mngrBrdVO.mngrBrdTtl}"/>
			<button class="btn-search" id="search-btn">검색</button>
    	</div>
	<div class= "grid">
		<div class="grid-count align-right">
			총 ${mngrBrdList.size()}건
		</div>
	
		<table>
			<thead>
				<tr>
					<th><input type = "checkbox" id ="all_check"/></th>
					<th>글번호</th>
					<th>카테고리</th>					
					<th>제목</th>
					<th>조회수</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정자</th>
					<th>수정일</th>
					<th>게시여부</th>
						
				</tr>
			</thead>
			<tbody>
				<c:choose>					
					<c:when test="${not empty mngrBrdList}">
						<c:forEach items="${mngrBrdList}" var="mngrBrd">
							<tr data-mngrid = "${mngrBrd.mngrId}"
								data-rdcnt = "${mngrBrd.rdCnt}"
								data-mngrbrdwrtdt = "${mngrBrd.mngrBrdWrtDt}"
								data-mdfyr = "${mngrBrd.mdfyr}"
								data-mdfydt = "${mngrBrd.mdfyDt}"
								data-useyn = "${mngrBrd.useYn}">
								<td>
									<input type ="checkbox" class="check_idx" value="${mngrBrd.mngrBrdId}">
								</td>
								<td>${mngrBrd.mngrBrdId} </td>
								<td>${mngrBrd.ntcYn eq 'Y' ? '공지' : '게시판'}</td>
								
								<td>
									<a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}">
										${mngrBrd.mngrBrdTtl} 
									</a></td>
								<td>${mngrBrd.rdCnt}</td>
								<td>${mngrBrd.mngrId}</td>
								<td>${mngrBrd.mngrBrdWrtDt}</td>
								<td>${mngrBrd.mdfyr}</td>
								<td>${mngrBrd.mdfyDt}</td>
								<td>${mngrBrd.useYn}</td>		
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="10" class="no-items">
							
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div>
			<button id="delete_btn" >삭제</button>
			<button><a href="${pageContext.request.contextPath}/mngrbrd/write"> 게시글 작성</a></button>
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









</body>
</html>