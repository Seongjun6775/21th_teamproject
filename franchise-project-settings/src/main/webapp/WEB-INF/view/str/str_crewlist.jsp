<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">매장관리 > 직원 목록</div>
			
			<!-- 조회영역 -->
			<div class="grid">
				<div class="grid-count align-right">총 ${mbrList.size()}명</div>
					<table>
						<thead>
							<tr>
								<th>ID</th>
								<th>이름</th>
								<th>이메일</th>
								<th>매장명</th>
								<th>회원등급</th>
								<th>가입일</th>
								<th>최근 로그인 날짜</th>
								<th>최근 로그인 IP</th>
								<th>로그인 제한</th>
								
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty mbrList}">
									<c:forEach items="${mbrList}" var="mbr" varStatus="index">
										<tr data-mbrId="${mbr.mbrId}" 
											data-mbrNm="${mbr.mbrNm }" 
											data-strId="${mbr.strId }" 
											data-mbrEml="${mbr.mbrEml }" 
											data-mbrLvl="${mbr.mbrLvl }" 
											data-mbrLvlNm ="${mbr.cmmnCdVO.cdNm}"
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

											<td>${mbr.mbrId}</td>
											<td>
												<a href="${context}/mbr/detail/${mbr.mbrId}">${mbr.mbrNm}</a>
											</td>
											<td>${mbr.mbrEml}</td>
											<td>${mbr.strVO.strNm}</td>
											<td>${mbr.cmmnCdVO.cdNm}</td>
											<td>${mbr.mbrRgstrDt}</td>
											<td>${mbr.mbrRcntLgnDt}</td>
											<td>${mbr.mbrRcntLgnIp}</td>
											<td>${mbr.mbrLgnBlckYn}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="10" class="no-items">등록된 관리자가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>