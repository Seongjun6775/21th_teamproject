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
<jsp:include page="../include/stylescript.jsp"/>
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
		var url;
		$(".open-layer").click(function(event) {
			var mbrId = $(this).attr('val');
			$("#layer_popup").css({
			    "padding": "5px",
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF",
				"position": "absolute",
				"border": "solid 1px #222",
				"z-index": "10px"
			}).show();
			if (mbrId == '${sessionScope.__MBR__.mbrId}') {
				url = "cannot"
			} else {
				url = "${context}/nt/ntcreate/" + mbrId
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
			console.log(searchIdx);
			console.log(searchKeyword);
			
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
		var hlpDskPrcsYn = $("#search-keyword-hlpDskPrcsYn").val();
		
			var queryString = "searchIdx=" + searchIdx;
			queryString += "&searchKeyword=" + searchKeyword
			queryString += "&pageNo=" + pageNo;
			queryString += "&hlpDskPrcsYn=" + hlpDskPrcsYn;
			
			location.href = "${context}/hlpdsk/list?" + queryString;
		
	}

</script>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">고객센터</span>
	    </div>

		<!-- searchbar -->
		<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
		  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
		  <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="margin: 15px;">
		    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
		  </svg>
		    <select id="search-select" class="form-select" style="margin-right: 10px; width: 30%;" aria-label="Default select example">
				<option value="hlpDskTtl"${searchIdx eq 'hlpDskTtl' ?  'selected': ''}>제목</option>
				<option value="hlpDskCntnt"${searchIdx eq 'hlpDskCntnt' ?  'selected': ''}>본문</option>
				<option value="Wrtr"${searchIdx eq 'Wrtr' ?  'selected': ''}>작성자</option>
		    </select>
		    <input class="form-control me-2" type="text" id="search-keyword" value="${searchKeyword}" placeholder="Search" aria-label="Search">
		    <button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px; min-width:80px;">검색</button>
		</div>
		<!-- /searchbar -->	
		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<div style="margin: 13px;">총 ${hlpDskList.size() > 0 ? hlpDskList.get(0).totalCount : 0}건</div>
			<table class="table caption-top table-hover" style="text-align: center;">
				<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;"> 
					<tr>
						<th>글번호</th>
						<th>문의/건의</th>	
						<th style="">
							<select class="select-align-center" name="selectFilter"
									id="search-keyword-hlpDskPrcsYn">
								<option value="">답변상태</option>
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
									<td style="width: 100px;">No.${hlpDsk.hlpDskWrtId.substring(12,17).replaceFirst("^0+(?!$)", "")}</td>    
									<td style="width: 130px;">${hlpDsk.hlpDskSbjct}</td>
									<td style="width: 130px;">${hlpDsk.hlpDskPrcsYn eq 'N' ? '답변대기중' : '답변완료'}</td>
									<td>
										<a href="${context}/hlpdsk/${hlpDsk.hlpDskWrtId}" class="brdid">
											${hlpDsk.hlpDskTtl}  
										</a>
									</td>
									<td style="width: 180px;" class="ellipsis" onclick="event.cancelBubble=true">${hlpDsk.mbrVO.mbrNm}
									<span>(<a class="open-layer" style="text-decoration: none;" href="javascript:void(0);" val="${hlpDsk.mbrId}">${hlpDsk.mbrId eq null ? '<i class="bx bx-error-alt" ></i>ID없음' : hlpDsk.mbrId}</a>)</span></td>
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
				<ul class="pagination" style="text-align: center;">
					<c:set value = "${hlpDskList.size() > 0 ? hlpDskList.get(0).lastPage : 0}" var="lastPage"/>
					<c:set value = "${hlpDskList.size() > 0 ? hlpDskList.get(0).lastGroup : 0}" var="lastGroup"/>
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(hlpDskVO.pageNo /10)}" integerOnly="true" />
					<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
					<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
					<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo-1}" var="groupEndPageNo" />
					
					<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
					<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
					<c:if test="${nowGroup > 0}">
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
					</c:if>
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
						<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq hlpDskVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
			
					<c:if test="${lastGroup > nowGroup}">
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>			
		</div> 		
<jsp:include page="../include/closeBody.jsp" />
	<div class="layer_popup" id="layer_popup" style="display: none;">
		<div class="popup_box">
			<div class="popup_content">
				<a class="send-memo-btn" href="javascript:void(0);">
				<i class='bx bx-mail-send' ></i>
				쪽지 보내기</a>
			</div>
			<div>
				<a class="close-memo-btn" href="javascript:void(0);">
				<i class='bx bx-x'></i>
				닫기</a>
			</div>
		</div>
	</div>
</html>