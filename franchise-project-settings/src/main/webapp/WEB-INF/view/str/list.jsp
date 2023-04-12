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

		}
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
							<th>매장번호</th>
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
								<tr data-gnrid="${str.strId}" 
								data-gnrnm="${str.strNm}" 
								data-crtr="${str.strAddr}" 
								data-crtdt="${str.strCallNum}" 
								data-mdfyr="${str.strOpnTm}" 
								data-mdfydt="${str.strClsTm}" 
								data-useyn="${str.useYn}" >
								<td>
									<input type="checkbox" class="check_idx" value="${gnr.gnrId}"/>
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

</body>
</html>