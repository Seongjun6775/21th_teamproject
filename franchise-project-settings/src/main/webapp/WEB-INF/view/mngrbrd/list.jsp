<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<c:set var="now" value="<%=new java.util.Date()%>" /><!-- 현재시간 -->
<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today" /><!-- 현재시간을 숫자로 -->
<fmt:parseNumber value="${mngrBrd.mngrBrdWrtDt.time / (1000*60*60*24)}" integerOnly="true" var="chgDttm" /><!-- 게시글 작성날짜를 숫자로 -->
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
		var url;
		$(".open-layer").click(function(event) {

			var mbrId = $(this).text();  
			$("#layer_popup").css({
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF",
				"position": "absolute",
				"border": "solid 1px #222",
				"z-index": "10px"
			}).show();
			
			url = "${context}/nt/ntcreate/" + mbrId
		});
		
		$(".send-memo-btn").click(function() {
			if (url) {
				location.href = url;
			}
		});
		
		$(".close-memo-btn").click(function() {
			url = undefined;
			$("#layer_popup").hide();
		});
		
		$(".grid > table > tbody > tr").click(function(){ 
			var data =$(this).data();
/* 			alert(data);
			var grdmbr = div.closet('.brdid');
			console.log(grdmbr);
			var brdid = 
			$("#mngrBrdId").val(data.mngrbrdid);
			alert("!!"); */
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
		
	    $("#search-btn").click(function(){
	        movePage(0);
	     });
		
	}); 

	function movePage(pageNo){
		//전송.
		//입력 값.	 
		var searchIdx = $("#search-select").val();	
		var searchKeyword = $("#search-keyword").val();
		
			var queryString = "searchIdx=" + searchIdx;
			queryString += "&searchKeyword=" + searchKeyword
			queryString += "&pageNo=" + pageNo;


			location.href = "${context}/mngrbrd/list?" + queryString;
		
	}

</script>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div>
			<div style="display: block; padding: 20px;">
				<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
					<span class="fs-5 fw-bold"> 게시판 > 관리자게시판</span>
			    </div>	
				
			    <div class="board_box row">	
					<div class=" col-sm-3 col-xs-4"> 
						<select id="search-select" class="input-text" style="width: 100%;">
							<option value="mngrBrdTtl"${searchIdx eq 'mngrBrdTtl' ?  'selected': ''}>제목</option>
							<option value="mngrBrdCntnt"${searchIdx eq 'mngrBrdCntnt' ?  'selected': ''}>본문</option>
							<option value="Wrtr"${searchIdx eq 'Wrtr' ?  'selected': ''}>작성자</option>
						</select> 
					</div>
					<div class=" col-sm-6 col-xs-8">
						<input name="keyword" type="text" class="input-text" placeholder="검색어를 입력해주세요" id="search-keyword"  style="width: 100%;" value="${searchKeyword}" >
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
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty noticeList}">
									<c:forEach items="${noticeList}" var="mngrBrd" >
										<tr data-mngrid = "${mngrBrd.mngrId}"
											data-mngrbrdwrtdt = "${mngrBrd.mngrBrdWrtDt}"
											data-useyn = "${mngrBrd.useYn}" style="${mngrBrd.ntcYn eq 'Y' ? 'background-color: #ffffaa7a' : ''}">
											
											<c:if test="${mbrVO.mbrLvl eq '001-01'}">
												<td style="width: 20px;"> 
													<input type ="checkbox" class="check_idx" value="${mngrBrd.mngrBrdId}">
												</td>
											</c:if>	
											<td style="width: 100px;">No.${mngrBrd.mngrBrdId.substring(12,17).replaceFirst("^0+(?!$)", "")} </td>
											<td style="width: 130px;">
											${mngrBrd.ntcYn eq 'Y' ? '공지' : '커뮤니티'}</td>
											
											<td>
												<a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}" class="brdid">
													${mngrBrd.mngrBrdTtl}  
												</a>[${mngrBrd.rplList.size()}] 
											</td>
											<td style="width: 180px;">${mngrBrd.mbrVO.mbrNm}
											<span>(<a class="open-layer" style="text-decoration: none;" href="javascript:void(0);">${mngrBrd.mbrVO.mbrId}</a>)</span></td>
											<td style="width: 200px;">${mngrBrd.mngrBrdWrtDt}</td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
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
											<td style="width: 100px;">No.${mngrBrd.mngrBrdId.substring(12,17).replaceFirst("^0+(?!$)", "")} </td>
											<td style="width: 130px;">
											${mngrBrd.ntcYn eq 'Y' ? '공지' : '커뮤니티'}</td>
											
											<td>
												<a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}" class="brdid">
													${mngrBrd.mngrBrdTtl}  
												</a>[${mngrBrd.rplList.size()}] 
											</td>
											<td style="width: 180px;" >${mngrBrd.mbrVO.mbrNm}
											<span>(<a class="open-layer" style="text-decoration: none;" href="javascript:void(0);">${mngrBrd.mbrVO.mbrId}</a>)</span></td>
											<td style="width: 200px;">${mngrBrd.mngrBrdWrtDt}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="8" class="no-items">
											동록된 글이 없습니다.
										</td> 
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				
					 <div class="pagenate">
						<ul>
							<c:set value = "${mngrBrdList.size() > 0 ? mngrBrdList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${mngrBrdList.size() > 0 ? mngrBrdList.get(0).lastGroup : 0}" var="lastGroup"/>
							
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

							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
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
		
<jsp:include page="../include/closeBody.jsp" />
<div class="layer_popup" id="layer_popup" style="display: none;">
	<div class="popup_box">
		<div class="popup_content">
			<a class="send-memo-btn" href="javascript:void(0);">쪽지 보내기</a>
		</div>
		<div>
			<a class="close-memo-btn" href="javascript:void(0);">닫기</a>
		</div>
	</div>
</div>
</html>