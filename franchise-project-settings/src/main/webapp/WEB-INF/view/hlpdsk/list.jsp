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
		
		console.log(${mbrVO.mbrId});

	    $("#search-btn").click(function(){
	        movePage(0);
	     });
		
	});
	function movePage(pageNo){

		var queryString = "pageNo=" + pageNo;
		
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
				
			    <div class="qna_box row" >	 
					<a href="${context}/hlpdsk/write" class="qna-btn" style="text-decoration: none; width:70%;"> 문의/건의 </a>
				</div>		
				<div class= "grid">
				
					<table>
						<thead>
							<tr>
								<th>글번호</th>
								<th>문의/건의</th>	
								<th>답변상태</th>			
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>			 		
								<c:when test="${not empty myHlpDskList}">
									<c:forEach items="${myHlpDskList}" var="hlpDsk" >
										<tr data-hlpdskwrtid = "${hlpDsk.hlpDskWrtId}"
											data-hlpdsksbjct = "${hlpDsk.hlpDskSbjct}"
											data-hlpdskprcsyn = "${hlpDsk.hlpDskPrcsYn}"
											data-hlpdskttl = "${hlpDsk.hlpDskTtl}"
											data-mbrnm = "${mbrVO.mbrNm}"
											data-mbrid = "${hlpDsk.mbrId}"
											data-hlpdskwrtdt = "${hlpDsk.hlpDskWrtDt}">
												<td style="width: 100px;">No.${hlpDsk.hlpDskWrtId.substring(12,17).replaceFirst("^0+(?!$)", "")}</td>
												<td style="width: 130px;">${hlpDsk.hlpDskSbjct}</td>
												<td style="width: 130px;">${hlpDsk.hlpDskPrcsYn eq 'N' ? '답변대기중' : '답변완료'}</td>
												<td>
													<a href="${context}/hlpdsk/${hlpDsk.hlpDskWrtId}" class="brdid">
														${hlpDsk.hlpDskTtl}  
													</a>
												</td>
												<td style="width: 180px;">${hlpDsk.mbrVO.mbrNm}</td>
												<td style="width: 200px;">${hlpDsk.hlpDskWrtDt}</td>				
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="no-items">
											등록된 글이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				
					 <div class="pagenate">
						<ul>
							<c:set value = "${myHlpDskList.size() > 0 ? myHlpDskList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${myHlpDskList.size() > 0 ? myHlpDskList.get(0).lastGroup : 0}" var="lastGroup"/>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(hlpDskVO.pageNo /10)}" integerOnly="true" />
							<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
							<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo -1}" var="groupEndPageNo" />
							
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