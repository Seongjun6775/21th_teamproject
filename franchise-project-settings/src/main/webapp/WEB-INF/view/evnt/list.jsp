<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.ktds.fr.mbr.vo.MbrVO"%>
<%@page import="java.util.Random"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<% MbrVO mbrVO = (MbrVO) session.getAttribute("__MBR__"); %>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<%-- <link rel="stylesheet" href="../css/evntCommon.css?p=${date}" /> --%>
<meta charset="UTF-8">
<title>이벤트 목록 조회</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
			$("#all-check").click(function() {
						$(".check_idx").prop("checked",
								$("#all-check").prop("checked"));
					});
			$("#all-check").change(function() {
						$(".check-idx").prop("checked",
								$(this).prop("checked"));
					});
			$(".check-idx").change(function() {
								var count = $(".check-idx").length;
								var checkCount = $(".check-idx:checked").length;
								$("#all-check").prop("checked",
										count == checkCount);
							});
			//이벤트 리스트 조회(검색)
			$("#btn-init").click(function() {
				document.getElementById("evntTtl").value = "";
				document.getElementById("evntCntnt").value = "";
				document.getElementById("evntStrtDt").value = "";
				document.getElementById("evntEndDt").value = "";
				document.getElementById("useYn").value = "ALL";
			});
			//이벤트 등록(생성)          
			$("#btn-create").click(function() {
				location.href = "${context}/evnt/create";
			});
			// 이전 페이지        
			$("#btn-prevPage").click(function() {
								// 			alert("totalCount : " + Number(document.getElementById("totalCount").value) 
								// 					+ ", lastPage : " + Number(document.getElementById("lastPage").value)
								// 					+ ", lastGroup : " + Number(document.getElementById("lastGroup").value));
								const pageNum = Number(document
										.getElementById("pageNo").value) - 1;
								if (pageNum < 0) {
									alert("첫 페이지 입니다.");
									return;
								} else {
									location.href = "${context}/evnt/list?pageNo="
											+ pageNum;
								}
							});
			// 다음 페이지
			$("#btn-nextPage").click(function() {
								const pageNum = Number(document.getElementById("pageNo").value) + 1;
								if (pageNum >= Number(document.getElementById("lastPage").value)) {
									alert("마지막 페이지 입니다.");
									return;
								} else {
									location.href = "${context}/evnt/list?pageNo="
											+ pageNum;
								}
							});
			//'우리매장 참여이벤트' 버튼 클릭 시 팝업창으로 리스트 뜸
			$("#btn-ourStrEvnt").click(function() {
								var pop = window.open("${context}/evntStr/ourList","resPopup","width=1700, height=800, scrollbars=yes, resizable=yes");
								pop.focus();
							});
			// 체크 버튼 클릭 시 체크된 리스트 뜸
			$("#btn-checkEvnts").click(function() {
								var checkLen = $(".check-idx:checked").length;
								if (checkLen == 0) {
									alert("체크한 대상이 없습니다.");
									return;
								}
								var form = $("<form></form>");
								$(".check-idx:checked").each(function() {
												console.log($(this).val());
												form.append("<input type='hidden' name='evntIdList' value='"
																	+ $(this).val()
																	+ "'>'")
								});
							});
			
			//이용자 페이지로 이동하기       
			$("#btn-ongoingList").click(function() {
				location.href = "${context}/evnt/ongoingList";
			});
		});
	
	function movePage(pageNum) {
		location.href = "${context}/evnt/list?pageNo=" + (pageNum);
	}
	
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">이벤트 > 이벤트 조회</span>
	    </div>
	    
				
			<div class="content">
				
				<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px; display: flex;justify-content: center;">
					<div>
						<form action="${context}/evnt/list" method="post">
							<table style="width: 100%;">
								<tr>
									<td>이벤트 제목</td>
									<td><input  class="form-control me-2" id="evntTtl" type="text" name="evntTtl"
										value="${evntTtl}" style="width: 90%;" /></td>
									<td>이벤트 내용</td>
									<td><input class="form-control me-2" id="evntCntnt" type="text" name="evntCntnt"
										value="${evntCntnt}" style="width: 90%;" /></td>
									<td >이벤트 사용유무</td>
									<td>
										<select id="useYn" class="form-select" name="useYn" >
											<option value="ALL">전체</option>
											<option value="Y" ${useYn eq 'Y' ? 'selected' : ''}>Y</option>
											<option value="N" ${useYn eq 'N' ? 'selected' : ''}>N</option>
										</select>
									</td>

								</tr>
								<tr>
									<td>이벤트 시작일자</td>
									<td><input id="evntStrtDt" type="date" name="evntStrtDt" class="form-control " style="margin-right: 10px;"
										value="${evntStrtDt}" style="width: 90%;" /></td>
									<td>이벤트 종료일자</td>
									<td><input id="evntEndDt" type="date" name="evntEndDt" class="form-control " style="margin-right: 10px; "
										value="${evntEndDt}" style="width: 90%;" /></td>
									<td>
										<button type="submit" class="btn btn-outline-success" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px; min-width:80px;"id="search-btn">검색</button>
									</td>	
									<td>
									
										<button id="btn-init" type="submit" style="background-color: #fff;">
											<img  src="${context}/img/reset2.png" width="28"; height="28"></button>
									</td>
																	
								</tr>
							</table>
										    	

							<!-- 페이지 네이션을 위한 Hidden 데이터 -->
<%-- 							<input id="viewCnt" name="viewCnt" value="${viewCnt}" type="hidden" /> --%>
<%-- 						   <input id="pageCnt" name="pageCnt" value="${pageCnt}" type="hidden" />  --%>
<%-- 						   <input id="pageNo" name="pageNo" value="${pageNo}" type="hidden" />  --%>
<%-- 						   <input id="totalCount" name="totalCount" value="${totalCount}" type="hidden" />  --%>
<%-- 						   <input id="lastPage" name="lastPage" value="${lastPage}" type="hidden" />  --%>
<%-- 						   <input id="lastGroup" name="lastGroup" value="${lastGroup}" type="hidden" /> --%>

						</form>
					</div>

					<!--             </form> -->
				</div>
				<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
					<div style="margin: 13px;" >총 ${evntList.size() > 0 ? evntList.get(0).totalCount : 0}건</div>
					<table class="table caption-top table-hover" style="text-align: center;">
						<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
							<tr>
								<!--<th style="width: 50px"></th>-->
								<!-- <input type="checkbox" id="all-check"/> -->
								<th scope="col" style="border-radius: 6px 0 0 0; padding: 20px 20px 8px 20px;">이벤트 ID</th>
								<th scope="col" style="padding: 20px 20px 8px 20px;" >이벤트 제목</th>
								<th scope="col" style="padding: 20px 20px 8px 20px;" >이벤트 내용</th>
								<th scope="col" style="padding: 20px 20px 8px 20px;" >시작일</th>
								<th scope="col" style="padding: 20px 20px 8px 20px;" >종료일</th>
<!-- 							<th style="width: 100px">사진</th> -->
								<th  scope="col" style="border-radius: 0 6px 0 0; padding: 20px 20px 8px 20px;" >사용유무</th>

							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty evntList}">
									<c:forEach items="${evntList}" var="evnt">
										<tr>
										    <!-- <td class="firstcell" style="text-align:center;"> --> 
											<!-- <input type="checkbox" class="check-idx" value="${evnt.evntId}" /></td> -->

											<td style="text-align:center;">${evnt.evntId}</td>
											<td style="text-align:center;"><a href="${context}/evnt/detail/${evnt.evntId}">${evnt.evntTtl}</a></td>
											<td style="text-align:center;"><a href="${context}/evnt/detail/${evnt.evntId}">${evnt.evntCntnt}</a></td>
											<td style="text-align:center;">${evnt.evntStrtDt}</td>
											<td style="text-align:center;">${evnt.evntEndDt}</td>
<%-- 											<td>${evnt.orgnFlNm}</td> --%>
											<td style="text-align:center;">${evnt.useYn}</td>

										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6">등록된 이벤트가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="pagenate">
						<ul class="pagination" style="text-align: center;">
							<c:set value = "${evntList.size() > 0 ? evntList.get(0).lastPage : 0}" var="lastPage"/>
								<c:set value = "${evntList.size() > 0 ? evntList.get(0).lastGroup : 0}" var="lastGroup"/>
								
								<fmt:parseNumber var="nowGroup" value="${Math.floor(evntVO.pageNo /10)}" integerOnly="true" />
								<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
								<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
								<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo -1}" var="groupEndPageNo" />
								
								<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
								<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
								<c:if test="${nowGroup > 0}">
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
								</c:if>
								
								<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
									<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq evntVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
								</c:forEach>
								<c:if test="${lastGroup > nowGroup}">
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
									<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
								</c:if>
						</ul>
					</div>
					<div class="btn-group">
							<c:if test="${mbrVO.mbrLvl eq '001-02'}">
							<button type="submit" id="btn-ourStrEvnt" class="btn btn-secondary" style="border: solid 1px;">우리매장 참여중인 이벤트</button>
							</c:if>
			 			<%-- 	<button id="btn-checkEvnts" class="btn-primary">체크 이벤트..</button>--%>
							<button id="btn-ongoingList" class=" btn btn-secondary" style="border: solid 1px;">이용자 페이지로 이동</button>
						
					 </div>
				</div>
				<%-- 
			<div class="pagenation" style="text-align:center">
				<button id="btn-prevPage" class="btn-primary">[이전페이지]</button>
					<c:forEach begin="${pageNo+1}" end="${lastPage}" step="1" var="pageNo">
								[<a href="javascript:movePage(${pageNo})">${pageNo}</a>]
					</c:forEach>
				<button id="btn-nextPage" class="btn-primary">[다음페이지]</button>
			</div>
			 --%>
			</div>
<jsp:include page="../include/closeBody.jsp" />
</html>