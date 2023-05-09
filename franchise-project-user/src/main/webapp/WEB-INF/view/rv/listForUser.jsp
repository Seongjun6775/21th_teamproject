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
<%-- <link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}"> --%>
<jsp:include page="../include/stylescript.jsp" />

<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

	$().ready(function() {
		
		var url;
		var mbrId;
		$(".open-layer").click(function(event) {
			// event.preventDefault();
			mbrId = $(this).text();
			$("#layer_popup").css({
				"padding": "5px",
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF",
				"position": "absolute",
				"border": "solid 1px #222",
				"z-index": "10px"
			}).show();
			if (url == '${sessionScope.__MBR__.mbrId}') {
				url = "cannot"
			} else {
				url = "${context}/nt/ntcreate/" + mbrId
			}
		});
		
		$(".search-rv-btn").click(function() {
			if (mbrId) {
				$("input[name=searchWrap]").val(mbrId)
				$("#search_option").val("mbrId").prop("selected", true);
				$("#search_btn").click();
			}
		});
		$(".send-memo-btn").click(function() {
			if (url !== "cannot") {
				location.href = url;
			} else {
				alert("본인에게 쪽지를 보낼 수 없습니다.");
			}
		});
		$('body').on('click', function(event) {
			if (!$(event.target).closest('#layer_popup').length) {
				$('#layer_popup').hide();
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
			location.href = "${context}/mbr/rv/create";
		});			
		$("#search_btn").click(function(){			
			movePage(0);
		});		 
		$(".rvRow td").not(".firstcell, .ellipsis").click(function() {
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
 <style>
*{
  box-sizing: border-box; 
}
  
.que:first-child{
    border-top: 2px solid black;
  }

  
.que{
  position: relative;
  padding: 17px 0;
  cursor: pointer;
  font-size: 14px;
  border-bottom: 1px solid #dddddd;
  
}
  
.que::before{
  display: inline-block;
  content: 'Q';
  font-size: 14px;
  color: #ffbe2e;
  margin: 0 5px;
}

.que.on>span{
  font-weight: bold;
  color: #ffbe2e;
}
  
.anw {
  display: none;
  overflow: hidden;
  font-size: 14px;
  background-color: #f4f4f2;
  padding: 30px;
}
  
.anw::before {
  display: inline-block;
  content: 'A';
  font-size: 14px;
  font-weight: bold;
  color: #666;
  margin: 0 5px;
}

.arrow-wrap {
  position: absolute;
  top:50%; right: 10px;
  transform: translate(0, -50%);
}

.que .arrow-top {
  display: none;
}
.que .arrow-bottom {
  display: block;
}
.que.on .arrow-bottom {
  display: none;
}
.que.on .arrow-top {
  display: block; 
}
</style>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">리뷰</div>
		<div class="overlay absolute"></div>
	</div>				
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
								<td class="ellipsis"
									onclick="event.cancelBubble=true">
									<a class="open-layer" href="javascript:void(0);" val="${rv.mbrId}">
										${rv.mbrId eq null ? '<i class="bx bx-error-alt" ></i>ID없음' : rv.mbrId}</a></td>																			
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
<jsp:include page="../include/footer_user.jsp" />
	<div class="layer_popup" id="layer_popup" style="display: none;">
		<div class="popup_box">
			<div class="popup_content">
				<a class="send-memo-btn" href="javascript:void(0);">
					<i class='bx bx-mail-send' ></i>쪽지 보내기</a>
			</div>
			<div>
				<a class="search-rv-btn" href="javascript:void(0);">
					<i class='bx bx-search-alt-2'></i>작성 리뷰 보기</a>
			</div>
			<div>
				<a class="close-memo-btn" href="javascript:void(0);">
					<i class='bx bx-x'></i>닫기</a>
			</div>
		</div>
	</div>	
</body>
</html>