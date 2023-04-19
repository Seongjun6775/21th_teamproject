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
		
	    $("#search-btn").click(function(){
	        movePage(0);
	     });
	    
		
		
	}); 

	function movePage(pageNo){
		//전송.
		//입력 값.	 
		var mngrBrdSel = $("#search-select").val();	
		if(mngrBrdSel== "value1"){
			var mngrBrd = $("#search-keyword").val();
			
			var queryString = "mngrBrdTtl=" + mngrBrd;
			queryString += "&pageNo=" + pageNo;
			//URL 요청 
			location.href = "${context}/mngrbrd/list?" + queryString;
		}
		
		else if(mngrBrdSel== "value2"){
			var mngrBrd = $("#search-keyword").val();
			
			var queryString = "mngrBrdTtl=";
			queryString = "&mngrBrdCntnt=" + mngrBrd;
			queryString += "&pageNo=" + pageNo;
			//URL 요청 
			location.href = "${context}/mngrbrd/list?" + queryString;
		}
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
					<h3 class="list-title"> 관리자 게시판</h3> 
				</div> 
		
			    <div class="board_box row">	
					<div class=" col-sm-3 col-xs-4">
						<select id="search-select" class="input-text" style="width: 100%;">
							<option id ="0" value="value1">제목</option>
							<option id ="1" value="value2">본문</option> 
						</select>
					</div>
					<div class=" col-sm-6 col-xs-8">
						<input name="keyword" type="text" class="input-text" placeholder="검색어를 입력해주세요" id="search-keyword"  style="width: 100%;" value="${mngrBrdVO.mngrBrdTtl}" >
					</div>
					<div class=" col-sm-3 col-xs-12">
						<a role="button" title="검색" id="search-btn" class="blue-btn" style="width:100%;">검색</a>
					</div>
				</div>
				
				<div class="list-brd-top"> 
					<div class="cnt">
			    		<span>총  게시물 ${mngrBrdList.size()} <strong id="articleTotalCount"></strong> 개</span>,
						<span class="division_line">페이지 <strong id="currentPageNo"></strong> / <span id="totalPageNo">${mngrBrdVO.pageNo+1}</span></span>
					</div>
					
			    	<div class="write">   
						<c:if test="${mbrVO.mbrLvl eq '001-01'}"> 
							<button id="delete_btn" class="red-btn">삭제</button> 
						</c:if>
						<a href="${context}/mngrbrd/write" class="btn-m" style="text-decoration: none;"> 게시글 작성</a>
					</div>
			    </div>
			
				<div class= "grid">
				
					<table>
						<thead>
							<tr>
								<c:if test="${mbrVO.mbrLvl eq '001-01'}">
									<th><input type = "checkbox" id ="all_check"/></th>
								</c:if>
								<th>글번호</th>
								<th>카테고리</th>					
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<c:if test="${mbrVO.mbrLvl eq '001-01'}">
									<th>게시여부</th>
								</c:if>	
							</tr>
						</thead>
						<tbody>
							<c:choose>			 		
								<c:when test="${not empty mngrBrdList}">
									<c:forEach items="${mngrBrdList}" var="mngrBrd" >
										<tr data-mngrid = "${mngrBrd.mngrId}"
											data-mngrbrdwrtdt = "${mngrBrd.mngrBrdWrtDt}"
											data-useyn = "${mngrBrd.useYn}" style="${mngrBrd.ntcYn eq 'Y' ? 'background-color: #ffffaa7a' : ''}">
											
											<c:if test="${mbrVO.mbrLvl eq '001-01'}">
												<td style="width: 20px;"> 
													<input type ="checkbox" class="check_idx" value="${mngrBrd.mngrBrdId}">
												</td>
											</c:if>	
											<td style="width: 160px;">${mngrBrd.mngrBrdId} </td>
											<td style="width: 90px;">
											${mngrBrd.ntcYn eq 'Y' ? '공지' : '커뮤니티'}</td>
											
											<td>
												<a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}" style="text-decoration: none;">
													${mngrBrd.mngrBrdTtl}  
												</a>[${mngrBrd.rplList.size()}] 
											</td>
											<td>${mngrBrd.mbrVO.mbrNm}</td>
											<td style="width: 160px;">${mngrBrd.mngrBrdWrtDt}</td>
											<c:if test="${mbrVO.mbrLvl eq '001-01'}">
												<td style="width: 70px;">
												${mngrBrd.useYn}</td>	
											</c:if>	
											
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
							<c:set value = "${mngrBrdList.size() > 0 ? mngrBrdList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${mngrBrdList.size() > 0 ? mngrBrdList.get(0).lastPage : 0}" var="lastGroup"/>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(MngrBrdVO.pageNo /10)}" integerOnly="true" />
							<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
							<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo}" var="groupEndPageNo" />
							
							<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
							<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo})")>이전</a></li>
							</c:if>

							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo-1}" step="1" var="pageNo">
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
		</div>
		<jsp:include page="../include/footer.jsp" />
	</div>
</div>
</body>
</html>