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
<link rel="stylesheet" href="${context}/css/rv_common.css?p=${date}" />
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
		
		$(".enterkey").keyup(function(event) {
			if(event.keyCode == 13) {
				$("#search_btn").click();
			}
		});
		$("#new_btn").click(function() {
			var session = "${mbr}";
			console.log(session);
			if (session == "" || session.length == 0) {
				if(confirm("로그인이 필요합니다. \n로그인 하시겠습니까?")){
					location.href = "${context}/user/join";
					return;
				}else{
					return; 
				}
			}
			location.href = "${context}/mbr/rv/create";
		});
		$("#search_btn").click(function(){			
			movePage(0);
		});		 
		$(".rvRow td").not(".mbrId").click(function() {
			var rvid = $(this).closest(".rvRow").data("rvid")
			location.href="${context}/user/rv/detail/" + rvid;
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
			location.href="${context}/user/rv/list" + queryString;
			
		}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/rvMgmtSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">리뷰 > 리뷰목록</div>
			
			
			<div class="container">
			    <header class="d-flex justify-content-center py-3">
			      <ul class="nav nav-pills">
			        <li class="nav-item"><h3>리뷰 목록</h3></li>
			      </ul>
			    </header>
			</div>
			<div class="search-row-group">
				<div class="search-group">
					<select id="search_option" name="searchOption">					
						<option value="strNm">매장명</option>					
						<option value="mbrId">회원ID</option>									
					</select>
					<input type="text" name="searchWrap" class="enterkey" placeholder="검색어를 입력하세요">						
					<button id="search_btn" class="btn-search">검색</button>				
				</div>
			</div>
			<div>총 ${rvList[0].totalCount}건</div>
			
			<table>
				<thead>
					<tr>
						<th>주문서ID</th>
						<th>매장명</th>
						<th>제목</th>
						<th>회원ID</th>						
						<th>좋아요/싫어요</th>
						<th>등록일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty rvList}">
							<c:forEach items="${rvList}"
									   var="rv">
								<tr class="rvRow" data-rvid="${rv.rvId}" style="cursor:pointer;"> 
									<td>${rv.odrLstId}</td>
									<td>${rv.strVO.strNm}</td>
									<td>${rv.rvTtl}</td>
									<td class="mbrId" onclick="event.cancelBubble=true"><a class="open-layer" href="javascript:void(0);">${rv.mbrId}</a></td>																			
									<td>${rv.rvLkDslk}</td>					
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
			<div class="align-right">				
				<button id="new_btn" class="btn-primary">등록</button>
			</div>			
			<div class="pagenate">
				<ul>
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
						<li><a href="javascript:movePage(0)">처음</a></li>
						<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
					</c:if>
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li><a class="${pageNo eq gnrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
					
					<c:if test = "${lastGroup >nowGroup }">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>				
						
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
	
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
	
</body>
</html>