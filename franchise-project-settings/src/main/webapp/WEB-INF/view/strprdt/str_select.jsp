<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 - 매장 선택</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	
})
</script>
</head>
<body>


	<div class="headline relative">
		상단 헤드라인임 //////// <a href="${context}/prdt/list">관리자 메뉴로 돌아가깅</a>
		<br><a href="javascript:window.history.back();">뒤로가기</a>
	</div>
	
					
	<table id="dataTable1"
			class="mb-10">
		<thead>
			<tr>
				<th>지역</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty lctList}">
					<c:forEach items="${lctList}"
								var="lct">
						<tr data-lctid="${lct.lctId}">
							<td><a href="#">${lct.lctNm}</a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="1" class="no-items">
							조회된 항목이 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<table id="dataTable2"
			class="mb-10">
		<thead>
			<tr>
				<th>도시</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty ctyList}">
					<c:forEach items="${ctyList}"
								var="cty">
						<tr data-strid="${cty.ctyId}">
							<td><a href="#">${cty.ctyNm}</a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="1" class="no-items">
							조회된 항목이 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<table id="dataTable3"
			class="mb-10">
		<thead>
			<tr>
				<th>매장이름일까</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty strList}">
					<c:forEach items="${strList}"
								var="str">
						<tr data-strid="${str.strId}">
							<td><a href="#">${str.strNm}</a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="1" class="no-items">
							조회된 항목이 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
	<div class="relative">
		<div class="align-right absolute " style="right: 0px;" >
			<button class="btn-primary" 
					id="btn-search-reset">검색초기화</button>
			<select class="selectFilter"
					id="select-useYn">
				<option value="">사용유무</option>
				<option value="Y">Y</option>
				<option value="N">N</option>
			</select>
			<button id="btn-update-all" 
					class="btn-primary btn-delete" 
					style="vertical-align: top;">일괄수정</button>
		</div>
		
	</div>
	
	<div class="align-right grid-btns">
		<a href="${context}/prdt/list">메뉴리스트</a>
	</div>
	
</body>
</html>