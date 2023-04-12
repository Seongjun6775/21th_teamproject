<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function() {

		});
	</script>
</head>

<body>
	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="all_check" /></th>
				<th>순번</th>
				<th>매장ID</th>
				<th>매장명</th>
				<th>매장주소</th>
				<th>전화번호</th>
				<th>오픈시간</th>
				<th>종료시간</th>
				<th>사용여부</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty strList}">
					<c:forEach items="${strList}"
							var="str">
					<tr data-strid="${str.strId}" 
					data-strnm="${str.strNm}" 
					data-straddr="${str.strAddr}" 
					data-strcallnum="${str.strCallNum}" 
					data-stropntm="${str.strOpnTm}" 
					data-strclstm="${str.strClsTm}" 
					data-useyn="${str.useYn}" >
					<td>
						<input type="checkbox" class="check_idx" value="${str.strId}"/>
					</td>
						<td>순번</td>
						<td>${str.strId}</td>
						<td>${str.strNm}</td>
						<td>${str.strAddr}</td>
						<td>${str.strCallNum}</td>
						<td>${str.strOpnTm}</td>
						<td>${str.strClsTm}</td>
						<td>${str.useYn}</td>
					</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9" class="no-items">
							등록된 매장이 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
				<div class="pagenate">
					<ul>
						<c:set value="${gnrList.size() > 0 ? gnrList.get(0).lastPage : 0}" var="lastPage"/>
						<c:set value="${gnrList.size() > 0 ? gnrList.get(0).lastGroup : 0}" var="lastGroup"/>
						
						<fmt:parseNumber var="nowGroup" value="${Math.floor(gnrVO.pageNo / 10)}" integerOnly="true"/>
						<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
						<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
						<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo"/>
					
						
						<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo"/>
						<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo"/>
					
						<c:if test="${nowGroup > 0}">
							<li><a href="javascript:movePage(0)">처음</a></li>
							<li><a href="javascript:movePage(${prevGroupStartpageNo})">이전</a></li>
						</c:if>
						
						<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
							<li><a class="${pageNo eq gnrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
						</c:forEach>
					
						<c:if test=" ${lastGroup > nowGroup}">
							<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li><a href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</div>
			<div class="grid-detail">
				<form id="detail_form">
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="strId" style="width:180px">매장 ID</label>
						<input type="text" id="strId" name="strId" readonly value=""/>
					</div>
					<div class="input-group inline">
						<label for="strNm" style="width:180px">매장명</label>
						<input type="text" id="strNm" name="strNm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strAddr" style="width:180px">매장주소</label>
						<input type="text" id="strAddr" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strCallNum" style="width:180px">전화번호</label>
						<input type="text" id="strCallNum" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strOpnTm" style="width:180px">오픈시간</label>
						<input type="text" id="strOpnTm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strClsTm" style="width:180px">종료시간</label>
						<input type="text" id="strClsTm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="useYn" style="width:180px">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" value="Y"/>
					</div>
				</form>
			</div>
			<div class="align-right">
				<button id="new_btn" class="btn-primary">신규</button>
				<button id="save_btn" class="btn-primary">저장</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
			</div>
			
			
</body>
</html>