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
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$(".odrlst_table_grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			if (data.odrlstid != null && (data.odrlstid) != "") {
				location.href="${context}/odrdtl/list/" + data.odrlstid;
			}
		});
		
	/*
	
	
	
	
		일괄 삭제 기능입니다. 현재 사용되지 않습니다.
	
	
	
	
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#check_del_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			
			if (checkLen == 0) {
				alert("선택하신 주문서가 없습니다.")
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			var form = $("<form></form>");
			$(".check_idx:checked").each(function() {
				form.append("<input type='hidden' name='odrLstId' value ='" + $(this).val() +"'>")
			});
			
			$.post("${context}/api/odrlst/delete", form.serialize(), function(response) {});
			location.reload();
			
		});
	*/
		
		$(".delete_btn").click(function(){
			
			if (!confirm("해당 주문서를 삭제하시겠습니까?")) {
				return;
			}
			var odrLstId = $(this).val();
			$.post("${context}/api/odrlst/delete/" + odrLstId, function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.message + "\n매장 직원에게 문의하세요.");
				}
			})
			
		});
		
		
		
	});
	
	function movePage(pageNo) {
		location.href = "${context}/odrlst/mbrodrlst?pageNo=" + pageNo;
	}
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
		<span class="fs-5 fw-bold">주문목록</span>
	</div>
			<div>총 ${myOdrLst.size() > 0 ? myOdrLst.get(0).totalCount : 0}건</div>
			<!-- <button id="check_del_btn" class="btn btn-danger btn-sm">일괄삭제</button> -->
			<div class="odrlst_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<table class="table table-striped">
					<thead>
						<tr>
							<!-- <th><input type="checkbox" id="all_check"/></th> -->
							<th>주문 번호</th>
							<th>주문 일자</th>
							<th>주문 매장</th>
							<th>주문 상태</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty myOdrLst}">
								<c:forEach items="${myOdrLst}" var="odrLst">
									<tr data-odrlstid="${odrLst.odrLstId}"
										data-mbrid="${odrLst.mbrId}"
										data-odrlstodrprcs="${odrLst.odrLstOdrPrcs}"
										data-odrlstrgstdt="${odrLst.odrLstRgstDt}"
										data-odrlstrgstr="${odrLst.odrLstRgstr}"
										data-mdfydt="${odrLst.mdfyDt}"
										data-mdfyr="${odrLst.mdfyr}"
										data-useyn="${odrLst.useYn}"
										data-delyn="${odrLst.delYn}">
										<!-- <td onclick="event.cancelBubble=true"><input type="checkbox" class="check_idx" value="${odrLst.odrLstId}" /></td> -->
										<td>${odrLst.odrLstId}</td>
										<td>${odrLst.odrLstRgstDt}</td>
										<td>${odrLst.strVO.strNm}</td>
										<td>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-01'}">주문대기</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-02'}">주문접수</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-03'}">주문처리</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-04'}">주문완료</c:if>
											<c:if test="${odrLst.odrLstOdrPrcs eq '003-05'}">주문취소</c:if>
										</td>
										<td onclick="event.cancelBubble=true"><button type="button" class="btn btn-danger btn-sm delete_btn"
													 value="${odrLst.odrLstId}">삭제</button></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="5">주문 내역이 없습니다.</td>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="pagenate">
				<ul style="list-style: none;">
					<c:set value="${myOdrLst.size() >0 ? myOdrLst.get(0).lastPage : 0}" var="lastPage" />
					<c:set value="${myOdrLst.size() >0 ? myOdrLst.get(0).lastGroup : 0}" var="lastGroup" />
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(odrLstVO.pageNo / 10)}" integerOnly="true" />
					<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
					<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
					<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
					
					<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
					<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
					
					
					<c:if test="${nowGroup > 0}">
						<li><a href="javascript:movePage(0)">처음</a></li>
						<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
					</c:if>
				
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li><a class="${pageNo eq odrLstVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
					
					<c:if test="${lastGroup > nowGroup}">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>
			<jsp:include page="../include/footer.jsp" />
<jsp:include page="../include/closeBody.jsp" />
</html>
