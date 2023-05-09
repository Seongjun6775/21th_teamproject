<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		var url;
		$(".open-layer").click(function(event) {
			if ("${mbrVO.mbrLvl}" == "001-02") {
				var mbrId = $(this).text();
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
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#check_del_btn").click(function() {
			console.log($(this).val());
			var checkLen = $(".check_idx:checked").length;
			
			if (checkLen == 0) {
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '선택한 쪽지가 없습니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("선택한 쪽지가 없습니다."); */
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='ntId' value='" + $(this).val() + "'>")
			});
			
			$.post("${context}/api/nt/delete", form.serialize(), function(response) {});
			location.reload();
		});
		
		$("#crt_btn").click(function() {
			location.href = "${context}/nt/ntcreate";
		});
		
		$(".nt_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.ntid != null && data.ntid != "") {
				location.href="${context}/nt/ntmngrdetail/" + data.ntid;
			}
		});
		
		// 수신인, 발신인 검색 기능입니다
		$("#search_btn").click(function() {
			movePage(0);
		});
	});
	
	function movePage(pageNo) {
		
		var keyword = $("#search-keyword").val();

		var searchVal = $("#search_idx").val();
		var keyword = $("#search-keyword").val();
		var startDt = $("#startDt").val();
		var endDt = $("#endDt").val();
		
		var intStartDt = parseInt(startDt.split("-").join(""));
		var intEndDt = parseInt(endDt.split("-").join(""));
		
		if(intStartDt > intEndDt) {
			Swal.fire({
		    	  icon: 'error',
		    	  title: '시작일자는 종료일자보다 늦을 수 없습니다.',
		    	  showConfirmButton: false,
		    	  timer: 2500
			});
			/* alert("시작일자는 종료일자보다 늦을 수 없습니다!"); */
			return;
		}
		
		var queryString = "searchVal=" + searchVal;
		queryString += "&keyword=" + keyword;
		queryString += "&startDt=" + startDt;
		queryString += "&endDt=" + endDt;
		queryString += "&pageNo=" + pageNo;
		
		// URL 요청
		location.href = "${context}/nt/ntmngrlist?" + queryString;
	}
	
</script>
<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
} 
</style>
</head>
<jsp:include page="../include/openBody.jsp" />

		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">쪽지 > 쪽지 관리</span>
	    </div>
			<div>
				<!-- searchbar -->
				<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
					<svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="margin: 15px;">
						<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg>
					<input class="form-control " style="margin-right: 10px; width: 30%;" type="date" id="startDt" name="startDt" value="${ntVO.startDt}" />
					<input class="form-control" style="margin-right: 40px; width: 30%;" type="date" id="endDt" name="endDt" value="${ntVO.endDt}" />
					<select id="search_idx"  class="form-select" style="margin-right: 10px; width: 30%;" aria-label="Default select example">
						<option value="ntTtl" ${searchVal eq "ntTtl" ? 'selected' : '' }>제목</option>
						<option value="sndrId" ${searchVal eq "sndrId" ? 'selected' : '' }>발신인</option>
					</select>
					<input class="form-control me-2" type="text" id="search-keyword" value="${keyword}"/>
					<button id="search_btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px;">Search</button>
				</div>
				<!-- /searchbar -->
			</div>
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<div>총 ${myNtList.size() > 0 ? myNtList.size() : 0}건</div>
				<table class="table caption-top table-hover" style="text-align: center;">
					<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
						<tr>
							<th scope="col" style="border-radius: 6px 0 0 0; padding: 20px 20px 8px 20px;"><input type="checkbox" id="all_check"/></th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">쪽지 제목</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">발신인</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">수신인</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">쪽지 발송 일자</th>
							<th scope="col" style="padding: 20px 20px 8px 20px;">쪽지 수신 여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty myNtList}">
								<c:forEach items="${myNtList}" var="nt">
									<tr data-ntid="${nt.ntId}"
									    data-ntttl="${nt.ntTtl}"
									    data-sndrid="${nt.sndrId}"
									    data-rcvrid="${nt.rcvrId}"
									    data-ntsndrdt="${nt.ntSndrDt}"
									    data-ntrddt="${nt.ntRdDt}">
										<td onclick="event.cancelBubble=true"><input type="checkbox" class="check_idx" value="${nt.ntId}"/></td>
										<td><a href="${context}/nt/ntmngrdetail/${nt.ntId}">${nt.ntTtl}</a></td>
										<td class="ellipsis" onclick="event.cancelBubble=true"><a class="open-layer" href="javascript:void(0);" val="${nt.sndrId}">${nt.sndrId}</a></td>
										<td class="ellipsis" onclick="event.cancelBubble=true"><a class="open-layer" href="javascript:void(0);" val="${nt.rcvrId}">${nt.rcvrId}</a></td>
										<td>${nt.ntSndrDt}</td>
										<td>${nt.ntRdDt ne null ? '수신' : '미수신'}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="6">쪽지 송수신 이력이 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			<div style="position: relative;">
				<div class="pagenate">
						<ul class="pagination" style="text-align: center;">
							<c:set value="${myNtList.size() >0 ? myNtList.get(0).lastPage : 0}" var="lastPage" />
							<c:set value="${myNtList.size() >0 ? myNtList.get(0).lastGroup : 0}" var="lastGroup" />
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(ntVO.pageNo / 10)}" integerOnly="true" />
							<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
							<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
							
							<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
							<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							
							
							<c:if test="${nowGroup > 0}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
								<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq ntVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div>
					<div style=" right: 0;top: 0; position: absolute;">
						<button id="check_del_btn" class="btn btn-outline-danger btn-default ">일괄삭제</button>
						<button id="crt_btn" class="btn btn-outline-secondary btn-default"
								 style="display: ${mbrVO.mbrLvl eq '001-03' ? 'none' : ''}">작성</button>
					</div>
				</div>
			</div>
			
			
	<div class="layer_popup" id="layer_popup" style="display: none;">
		<div class="popup_box">
			<div class="popup_content">
				<a class="send-memo-btn" href="javascript:void(0);">
					<i class='bx bx-mail-send' ></i>쪽지 보내기
				</a>
			</div>
			<div>
				<a class="close-memo-btn" href="javascript:void(0);">
					<i class='bx bx-x'></i>닫기
				</a>
			</div>
		</div>
	</div>
<jsp:include page="../include/closeBody.jsp" />
	
	
</html>
