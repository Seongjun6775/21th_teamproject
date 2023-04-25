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
<%
MbrVO mbrVO = (MbrVO) session.getAttribute("__MBR__");
%>
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="../css/evntCommon.css?p=${date}">
<meta charset="UTF-8">
<title>이벤트 목록 조회</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(
			function() {

				//이벤트 리스트 조회(검색)
				$("#btn-init").click(function() {
					document.getElementById("evntTtl").value = "";
					document.getElementById("evntCntnt").value = "";
					document.getElementById("evntStrtDt").value = "";
					document.getElementById("evntEndDt").value = "";
				});

				// 이전 페이지        
				$("#btn-prevPage").click(
						function() {
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
				$("#btn-nextPage").click(
						function() {
							const pageNum = Number(document
									.getElementById("pageNo").value) + 1;
							if (pageNum >= Number(document
									.getElementById("lastPage").value)) {
								alert("마지막 페이지 입니다.");
								return;
							} else {
								location.href = "${context}/evnt/list?pageNo="
										+ pageNum;
							}
						});

				//종료 이벤트 확인          
				$("#btn-pastEvnt").click(function() {
					location.href = "${context}/evnt/pastEvntList";
				});

				//미래 이벤트 확인
				$("#btn-planEvnt").click(function() {
					location.href = "${context}/evnt/planEvntList";
				});

				$("#picture").click(function() {
					var data = $(this).data();
					location.href = "${context}/evnt/detail/" + data.evntid;
				})

			});

	function movePage(pageNum) {
		location.href = "${context}/evnt/list?pageNo=" + (pageNum);
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/evntSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div>
				<h1>이벤트 리스트 목록 조회</h1>
				<div>총 ${evntList.size() > 0 ? evntList.get(0).totalCount : 0}건</div>
			</div>
			<div class="content">
				<div class="search-group">
					<div>
						<form action="${context}/evnt/list" method="post">
							<table style="width: 100%;">
								<tr>
									<td>이벤트 제목</td>
									<td><input id="evntTtl" type="text" name="evntTtl"
										value="${evntTtl}" style="width: 90%;" /></td>
									<td>이벤트 내용</td>
									<td><input id="evntCntnt" type="text" name="evntCntnt"
										value="${evntCntnt}" style="width: 90%;" /></td>

								</tr>
								<tr>
									<td>이벤트 시작일자</td>
									<td><input id="evntStrtDt" type="date" name="evntStrtDt"
										value="${evntStrtDt}" style="width: 90%;" /></td>
									<td>이벤트 종료일자</td>
									<td><input id="evntEndDt" type="date" name="evntEndDt"
										value="${evntEndDt}" style="width: 90%;" /></td>

									<td colspan="2"><button type="submit" class="btn-search"
											id="search-btn">검색</button></td>
								</tr>
							</table>

							<div>
								<button id="btn-pastEvnt" class="btn-primary">종료 이벤트</button>
							</div>
							<br>
							<div>
								<button id="btn-planEvnt" class="btn-primary">예정된 이벤트</button>
							</div>


							<!-- 페이지 네이션을 위한 Hidden 데이터 -->
							<input id="viewCnt" name="viewCnt" value="${viewCnt}"
								type="hidden" /> <input id="pageCnt" name="pageCnt"
								value="${pageCnt}" type="hidden" /> <input id="pageNo"
								name="pageNo" value="${pageNo}" type="hidden" /> <input
								id="totalCount" name="totalCount" value="${totalCount}"
								type="hidden" /> <input id="lastPage" name="lastPage"
								value="${lastPage}" type="hidden" /> <input id="lastGroup"
								name="lastGroup" value="${lastGroup}" type="hidden" />

						</form>
					</div>
					<button id="btn-init" class="btn-primary">초기화</button>

					<button id="btn-create" class="btn-primary">등록</button>

					<!--             </form> -->
				</div>
				<div class="grid">
					<c:choose>
						<c:when test="${not empty evntList}">
							<c:forEach items="${evntList}" var="evnt">
								<div class="evnt" id="${evnt.evntId}">
									<div class="img-box">
										<c:choose>
											<c:when test="${empty evnt.uuidFlNm}">
												<img src="${context}/img/default_photo.jpg">

											</c:when>
											<c:otherwise>
												<a href="${context}/evnt/detail/${evnt.evntId}" > 
												<img src="${context}/evnt/img/${evnt.uuidFlNm}/">
												</a>
											</c:otherwise>
										</c:choose>
										<div class="evntPhoto">
											<div class="evntTtl">${evnt.evntTtl}</div>
											<div class="startDate">${evnt.evntStrtDt}</div>
											~
											<div class="endDate">${evnt.evntEndDt}</div>
										</div>
										<%-- <tr>
											<td>${evnt.evntId}</td>
											<td><a href="${context}/evnt/detail/${evnt.evntId}">${evnt.evntTtl}</a></td>
											<td>${evnt.evntCntnt}</td>
											<td>${evnt.evntStrtDt}</td>
											<td>${evnt.evntEndDt}</td>
											<td>${evnt.orgnFlNm}</td>
										</tr> --%>
									</div>
								</div>
							</c:forEach>

						</c:when>

						<c:otherwise>

							<tr>

								<td colspan="8">등록된 이벤트가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>


				</div>

				<div class="pagenate">
					<ul>
						<c:set
							value="${evntList.size() > 0 ? evntList.get(0).lastPage : 0}"
							var="lastPage"></c:set>
						<c:set
							value="${evntList.size() > 0 ? evntList.get(0).lastGroup : 0}"
							var="lastGroup"></c:set>

						<fmt:parseNumber var="nowGroup"
							value="${Math.floor(evntVO.pageNo / pageCnt)}" integerOnly="true" />
						<c:set value="${nowGroup * pageCnt}" var="groupStartPageNo"></c:set>
						<c:set value="${groupStartPageNo + pageCnt}" var="groupEndPageNo"></c:set>
						<c:set
							value="${groupEndPageNo > lastPage ? lastPage -1 : groupEndPageNo - 1}"
							var="groupEndPageNo"></c:set>
						<c:set value="${groupEndPageNo < 0 ? 0 : groupEndPageNo}"
							var="groupEndPageNo"></c:set>

						<c:set value="${(nowGroup - 1) * pageCnt}"
							var="prevGroupStartPageNo"></c:set>
						<c:set value="${(nowGroup + 1) * pageCnt}"
							var="nextGroupStartPageNo"></c:set>


						<c:if test="${nowGroup > 0}">
							<li><a href="javascript:movePage(0)">처음</a></li>
							<li><a
								href="javascript:movePage(${prevGroupStartPageNo+pageCnt-1})">이전</a></li>
						</c:if>

						<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}"
							step="1" var="pageNo">
							<li><a class="${pageNo eq evntVO.pageNo ? 'on' : ''}"
								href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
						</c:forEach>

						<c:if test="${lastGroup > nowGroup}">
							<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li><a href="javascript:movePage(${lastPage}-1)">끝</a></li>
						</c:if>
					</ul>
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
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>