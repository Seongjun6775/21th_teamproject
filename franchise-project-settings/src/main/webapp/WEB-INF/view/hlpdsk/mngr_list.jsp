<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<c:set var="now" value="<%=new java.util.Date()%>" /><!-- 현재시간 -->
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
				form.append("<input type='hidden' name='hlpDskWrtId' value='" + $(this).val() + "'>")
			});

			$.post("${context}/api/hlpdsk/delete",form.serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
	    $("#search-btn").click(function(){
	    	var searchIdx = $("#search-select").val();	
			var searchKeyword = $("#search-keyword").val();
	        movePage(0);
	     });
	    
	    $("select[name=selectFilter]").on("change", function(evetn) {
			movePage(0);
		});
		
	}); 
	function movePage(pageNo){
		//전송.
		//입력 값.	 
		var searchIdx = $("#search-select").val();	
		var searchKeyword = $("#search-keyword").val();
		var delYn = $("#search-keyword-delYn").val();
		
			var queryString = "searchIdx=" + searchIdx;
			queryString += "&searchKeyword=" + searchKeyword
			queryString += "&pageNo=" + pageNo;
			queryString += "&delYn=" + delYn;
			
			location.href = "${context}/hlpdsk/list?" + queryString;
		
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
					<h3 class="list-title">고객센터</h3> 
				</div> 
				
			
			
				<div class="board_box row">	
					<div class=" col-sm-3 col-xs-4"> 
						<select id="search-select" class="input-text" style="width: 100%;">
							<option value="hlpDskTtl"${searchIdx eq 'hlpDskTtl' ?  'selected': ''}>제목</option>
							<option value="hlpDskCntnt"${searchIdx eq 'hlpDskCntnt' ?  'selected': ''}>본문</option>
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
				<div class= "grid">
				
					<table>
						<thead>
							<tr>
								<th>글번호</th>
								<th>문의/건의</th>	
								<th>답변상태
									<select class="selectFilter" name="selectFilter"
											id="search-keyword-delYn">
										<option value="">--</option>
										<option value="Y">답변완료</option>
										<option value="N">답변대기중</option>
									</select>
								</th>			
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>			 		
								<c:when test="${not empty hlpDskList}">
									<c:forEach items="${hlpDskList}" var="hlpDsk" >
										<tr data-hlpdskwrtid = "${hlpDsk.hlpDskWrtId}"
											data-hlpdsksbjct = "${hlpDsk.hlpDskSbjct}"
											data-hlpdskprcsyn = "${hlpDsk.hlpDskPrcsYn}"
											data-hlpdskttl = "${hlpDsk.hlpDskTtl}"
											data-mbrnm = "${mbrVO.mbrNm}"
											data-hlpdskwrtdt = "${hlpDsk.hlpDskWrtDt}">
											<td>${hlpDsk.hlpDskWrtId.substring(12,17).replaceFirst("^0+(?!$)", "")}</td>    
											<td>${hlpDsk.hlpDskSbjct}</td>
											<td>${hlpDsk.hlpDskPrcsYn eq 'N' ? '답변대기중' : '답변완료'}</td>
											<td>
												<a href="${context}/hlpdsk/${hlpDsk.hlpDskWrtId}" style="text-decoration: none;">
													${hlpDsk.hlpDskTtl}  
												</a>
											</td>
											<td>${hlpDsk.mbrVO.mbrNm}</td>
											<td>${hlpDsk.hlpDskWrtDt}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="no-items">
											등록한 글이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				
					 <div class="pagenate">
						<ul>
							<c:set value = "${hlpDskList.size() > 0 ? hlpDskList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${hlpDskList.size() > 0 ? hlpDskList.get(0).lastPage : 0}" var="lastGroup"/>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(hlpDskVO.pageNo /10)}" integerOnly="true" />
							<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
							<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo-1}" var="groupEndPageNo" />
							
							<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
							<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo})")>이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
								<li><a class="${pageNo eq hlpDskVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
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