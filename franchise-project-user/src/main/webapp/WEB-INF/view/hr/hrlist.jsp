<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		if ("${sessionScope.__MBR__.mbrId}" == "") {
			Swal.fire({
			     title: '로그인 필요',
			     text: "로그인이 필요합니다.\n로그인 하시겠습니까?",
			     icon: 'warning',
			     showCancelButton: true,
			     confirmButtonColor: '#3085d6',
			     cancelButtonColor: '#d33',
			     cancelButtonText: '취소',
			     confirmButtonText: '로그인'
			   }).then((result) => {
			      if(result.isConfirmed){
			         $("#img_btn").click();
			      }else{
			         $("#btn-modal-close").click();
			      }
			});
		}
		
		$("#create-btn").click(function() {
			location.href="${context}/hr/hrcreate"
		});
		
		$("#hr_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.hrid != null && (data.hrid) != "") {
				location.href="${context}/hr/hrdetail/" + data.hrid;
			}
		});
		
	});
	
	function movePage(pageNo) {
		location.href = "${context}/hr/hrlist?pageNo=" + pageNo;
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
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">인재채용
			<div style="color: #ccc; padding-top: 10px;"></div>
		</div>
		<div class="overlay absolute"></div>
	</div>
	<div style="background-color: #ccc; height: 250px; display: flex;align-items: center;">
		<p style="margin: 0 auto; color: #fff; font-weight: bold; font-size: 20px;">변화를 만나는 곳, 변화를 만드는 곳.<br>프랜차이즈의 최신 채용정보를 확인하세요. </p>
	</div>
	
			<div id="hr_table_grid" class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:80px; height: 1200px;">
				<table class="table caption-top table-hover" style="text-align: center;">
				  <thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
				    <tr>
				      <th scope="col" style="border-radius: 6px 0 0 0; padding: 20px 20px 8px 20px;">채용 번호</th>
					  <th scope="col" style="padding: 20px 20px 8px 20px;">작성자 ID</th>
					  <th scope="col" style="padding: 20px 20px 8px 20px;">제목</th>
					  <th scope="col" style="padding: 20px 20px 8px 20px;">등록일</th>
					  <th scope="col" style="border-radius: 0 6px 0 0; padding: 20px 20px 8px 20px;">채용 상태</th>
				    </tr>
				  </thead>
				  <tbody>
				    <c:choose>
						<c:when test="${not empty myHrList}">
							<c:forEach items="${myHrList}" var="hr">
								<tr data-hrid="${hr.hrId}"
								    data-mbrid="${hr.mbrId}"
								    data-mbrnm="${hr.mbrVO.mbrNm}"
								    data-hrttl="${hr.hrTtl}"
								    data-hrrgstdt="${hr.hrRgstDt}"
								    data-hrapryn="${hr.hrAprYn}"
								    data-hrstat="${hr.hrStat}"
								    data-delyn="${hr.delYn}"
								    style="${hr.ntcYn eq 'Y' ? 'font-weight: bold' : ''};">
									<td>${hr.hrId}</td>
									<td>${hr.mbrId}</td>
									<td><a href="${context}/hr/hrdetail/${hr.hrId}">${hr.hrTtl}</a></td>
									<td>${hr.hrRgstDt}</td>
									<td>
										<c:choose>
											<c:when test="${hr.ntcYn eq 'Y'}"></c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${hr.hrStat eq '002-01'}">접수</c:when>
													<c:when test="${hr.hrStat eq '002-02'}">심사중</c:when>
													<c:when test="${hr.hrStat eq '002-03'}">심사완료</c:when>
													<c:otherwise><td></td></c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<td colspan="5">등록된 지원서가 없습니다.</td>
						</c:otherwise>
					</c:choose>
				  </tbody>
				</table>
				<div style="position: relative;">
					<div class="pagenate">
						<nav aria-label="Page navigation example">
							<ul class="pagination" style="text-align: center;">
								<c:set value="${myHrList.size() >0 ? myHrList.get(0).lastPage : 0}" var="lastPage" />
								<c:set value="${myHrList.size() >0 ? myHrList.get(0).lastGroup : 0}" var="lastGroup" />
								
							<fmt:parseNumber var="nowGroup" value="${Math.floor(hrVO.pageNo / 10)}" integerOnly="true" />
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
								<li class="page-item"><a class="${pageNo eq hrVO.pageNo ? 'on' : ''} page-link text-secondary" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</nav>
				</div>
				<div style="position: absolute; top:0; right:0;">
	       			<button id="create-btn" type="button" class="btn btn-outline-secondary btn-default">채용 지원 작성</button>
	       		</div> 
			</div>
		</div>
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>
