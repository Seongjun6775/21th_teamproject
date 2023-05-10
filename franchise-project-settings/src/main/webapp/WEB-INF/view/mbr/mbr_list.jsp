<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">
	$().ready(function(){
		$("#search-btn").click(function(){
			movePage(0);
		});
		$("#mbrLvl").val("${mbrVO.mbrLvl}");
		$("#search-keyword-delYn").prop("checked", $("#search-keyword-delYn").val() == 'Y');
		$("#search-keyword-mbrNm").keydown(function(key){
			if (key.keyCode == 13) {
	        	$("#search-btn").click();
	        }
		});
		$("#search-clear-btn").click(function(){
			$("#search-keyword-mbrNm").val("");search-clear-btn
			$("#mbrLvl").val("");
			$("#search-keyword-delYn").prop("checked", false);
			$("#search-keyword-startdt").val("");
			$("#search-keyword-enddt").val("");
		});
		$("#mbrLvl, #search-keyword-delYn, #listSize").change(function(){
			movePage(0);
		});
		
		// layer-popup (이름 클릭 시 쪽지보내기 창 띄우기)
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
				Swal.fire({
			    	  icon: 'error',
			    	  title: '자신에게는 쪽지를<br>보낼 수 없습니다.',
			    	  showConfirmButton: true,
			    	  confirmButtonColor: '#3085d6'
				});
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
	});
	
	function movePage(pageNo){
		var mbrLvl = $("#mbrLvl option:selected").val();
		var mbrNm = $("#search-keyword-mbrNm").val();
		var startDt = $("#search-keyword-startdt").val();
		var endDt = $("#search-keyword-enddt").val();
		var delYn = $("#search-keyword-delYn").val();
		var viewCnt = parseInt($("#listSize option:selected").val());
		
		var intStartDt = parseInt(startDt.split("-").join(""));
		var intEndDt = parseInt(endDt.split("-").join(""));
		
		if(intStartDt > intEndDt){
			Swal.fire({
		    	  icon: 'warning',
		    	  title: '시작 일자를 확인해 주세요.',
		    	  showConfirmButton: false,
		    	  timer: 2500
	    	});
			/* alert("시작 일자를 확인해 주세요");*/
			return;
		}
		var queryString = "mbrLvl=" + mbrLvl;
		queryString += "&mbrNm=" + mbrNm;
		queryString += "&startDt=" + startDt;
		queryString += "&endDt=" + endDt;
		queryString += "&delYn=" + delYn;
		queryString += "&viewCnt=" + viewCnt;
		queryString += "&pageNo=" + pageNo;
		
		location.href="${context}/mbr/list?" + queryString;
	}
</script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<jsp:include page="../include/openBody.jsp" />
			<!-- contents -->
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">회원 > 회원목록</span>
		    </div>
				<!-- 검색영역 -->
				<!-- searchbar -->
				<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
				  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
				  <i class="bi bi-search" style="margin: 15px;"></i>
				  <!-- <label for="search-keyword-mbrNm" >이름</label> -->
						
						<input type="date" style ="margin-right: 10px;"id="search-keyword-startdt" class="form-control" value="${mbrVO.startDt}"/>
						<input type="date" style ="margin-right: 10px;" id="search-keyword-enddt" class="form-control" value="${mbrVO.endDt}"/>
						<input type="text" id="search-keyword-mbrNm" class="form-control me-2" placeholder="이름 검색" value="${mbrVO.mbrNm}"/>
						
						<button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px; min-width:80px;">검색</button>
				</div>
				<!-- 조회영역 -->
				<div class="admin_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; height: auto;">
					<div style="margin: 13px;">
						총 ${mbrList.size() > 0 ? mbrList.get(0).totalCount : 0 }건 / 게시물 개수
						<select id="listSize" name="viewCnt" class="select-align-center">
							<option value="10" ${mbrVO.viewCnt eq 10 ? 'selected' : ''}>10개</option>
							<option value="30" ${mbrVO.viewCnt eq 30 ? 'selected' : ''}>30개</option>
							<option value="50" ${mbrVO.viewCnt eq 50 ? 'selected' : ''}>50개</option>
							<option value="100" ${mbrVO.viewCnt eq 100 ? 'selected' : ''}>100개</option>
						</select>
					</div>
					<table class="table caption-top table-hover" style="text-align: center;">
						<thead class="table-secondary " style="border-bottom: 2px solid #adb5bd;" >
							<tr>
								<th scope="col" class="col-1"  style="border-radius: 6px 0 0 0;">ID</th>
								<th scope="col" class="col-1">이름</th>
								<th scope="col" class="col-1">이메일</th>
								<th scope="col" class="col-1">
									<select id="mbrLvl" name="mbrLvl" class="select-align-center" aria-label="Default select example">
										<option value="">멤버등급</option>
										<c:choose>
												<c:when test="${not empty srtList}">
													<c:forEach items="${srtList}" var="srt">
														<option value="${srt.cdId}">${srt.cdNm}</option>
													</c:forEach>
												</c:when>
											</c:choose>
									</select>
								</th>
								<th scope="col" class="col-1">가입일</th>
								<th scope="col" class="col-1">최근 로그인</th>
								<th scope="col" class="col-1">최근 로그인 IP</th>
								<th scope="col" class="col-1">로그인 제한</th>
								<th scope="col" class="col-1"  style="border-radius:0 6px 0 0;"> 
									<select id="search-keyword-delYn" name="delYn" class="select-align-center" aria-label="Default select example">
											<option value="">탈퇴유무</option>
											<option value="Y" ${MbrVO.delYn eq 'Y' ? 'selected' : ''}>Y</option>
											<option value="N" ${MbrVO.delYn eq 'N' ? 'selected' : ''}>N</option>
									</select>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty mbrList}">
									<c:forEach items="${mbrList}" var="mbr">
										<tr data-mbrId="${mbr.mbrId}" 
											data-mbrNm="${mbr.mbrNm }" 
											data-mbrEml="${mbr.mbrEml }" 
											data-mbrLvl="${mbr.mbrLvl }" 
											data-mbrRgstrDt="${mbr.mbrRgstrDt }" 
											data-useYn="${mbr.useYn}" 
											data-mbrRcntLgnDt="${mbr.mbrRcntLgnDt }" 
											data-mbrRcntLgnIp="${mbr.mbrRcntLgnIp}" 
											data-mbrLgnFlCnt="${mbr.mbrLgnFlCnt }" 
											data-mbrLgnBlckYn="${mbr.mbrLgnBlckYn}" 
											data-mbrLstLgnFlDt="${mbr.mbrLstLgnFlDt }" 
											data-mbrPwdChngDt="${mbr.mbrPwdChngDt }" 
											data-mbrLeavDt="${mbr.mbrLeavDt}"
											data-delYn="${mbr.delYn}"
											>
											<%-- <td>${fn:substring(mbr.mbrId, 0, fn:length(mbr.mbrId)-3)}***</td> --%>
											<td>${mbr.mbrId}</td>
											<td class="ellipsis"
											onclick="event.cancelBubble=true">
											<a class="open-layer" href="javascript:void(0);" 
												val="${mbr.mbrId}">
												${mbr.mbrNm eq null ? '<i class="bx bx-error-alt" ></i>ID없음' : mbr.mbrNm}</a>
											</td>
											<td>${mbr.mbrEml}</td>
											<td>${mbr.mbrLvl}</td>
											<td>${mbr.mbrRgstrDt}</td>
											<td>${mbr.mbrRcntLgnDt}</td>
											<td>${mbr.mbrRcntLgnIp}</td>
											<td>${mbr.mbrLgnBlckYn}</td>
											<td>${mbr.delYn}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="9" class="no-items">등록된 관리자가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
						<div class="pagenate">
							<nav aria-label="Page navigation example">
								<ul class="pagination" style="text-align: center;">
									<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastPage : 0}" var="lastPage"/>
									<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastGroup : 0}" var="lastGroup"/>
									
									<!-- Math.floor(mbrVO.pageNo / 10) -->
									<fmt:parseNumber var="nowGroup" value="${Math.floor(mbrVO.pageNo / 10)}" integerOnly = "true"/>
									<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
									<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
									<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1 }" var="groupEndPageNo"/>
									
									<c:set value="${(nowGroup - 1 ) * 10}" var="prevGroupStartPageNo"/>
									<c:set value="${(nowGroup + 1 ) * 10}" var="nextGroupStartPageNo"/>
	
									<c:if test="${nowGroup > 0}">
										<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
										<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
									</c:if>
									
									<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
										<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq mbrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
									</c:forEach>
									
									<c:if test="${lastGroup >nowGroup}">
										<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
										<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
									</c:if>
								</ul>
							</nav>
						</div>
				</div>
      		<!-- /contents -->
      		
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
      		
      		
<jsp:include page="../include/closeBody.jsp" />
<body>
	
</body>
</html>
