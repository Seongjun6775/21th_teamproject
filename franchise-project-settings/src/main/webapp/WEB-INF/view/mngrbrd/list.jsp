<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked",$(this).prop("checked"));
		});
		
			
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount =$(".check_idx:checked").length;
			console.log(count,checkCount)
			$("#all_check").prop("checked",count==checkCount);
		});
		$("#delete_btn").click(function(){
			var checkLen= $(".check_idx:checked").length;
			if(checkLen ==0){
				alert("삭제할 글이 없습니다.");
				return;
			}
			
			var form =$("<form></form>")	
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='mngrBrdId' value='" + $(this).val() + "'>")
			});

			$.post("${context}/api/mngrbrd/delete",form.serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		
	
		
	});
</script>
</head>
<body>
	<h1>게시판</h1>
	
	<!-- 한 칸에 한 정보만 -> table / 한 칸에 여러 정보 -> ul -->
	<div>총 ${mngrBrdList.size()}건</div>
	<div>
		<table>
			<thead>
				<tr>
					<th><input type = "checkbox" id ="all_check"/></th>
					<th>글번호</th>
					<th>카테고리</th>					
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정자</th>
					<th>수정일</th>
					<th>게시여부</th>
						
				</tr>
			</thead>
			<tbody>
				<c:choose>					
					<c:when test="${not empty mngrBrdList}">
						<c:forEach items="${mngrBrdList}" var="mngrBrd">
							<tr data-mngrid = "${mngrBrd.mngrId}"
								data-mngrbrdwrtdt = "${mngrBrd.mngrBrdWrtDt}"
								data-mdfyr = "${mngrBrd.mdfyr}"
								data-mdfydt = "${mngrBrd.mdfyDt}"
								data-useyn = "${mngrBrd.useYn}">
								<td>
									<input type ="checkbox" class="check_idx" value="${mngrBrd.mngrBrdId}">
								</td>
								<td>${mngrBrd.mngrBrdId} </td>
								<td>${mngrBrd.ntcYn eq 'Y' ? '공지' : '게시판'}</td>
								
								<td>
									<a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}">
										${mngrBrd.mngrBrdTtl} 
									</a>
								<td>${mngrBrd.mngrId}</td>
								<td>${mngrBrd.mngrBrdWrtDt}</td>
								<td>${mngrBrd.mdfyr}</td>
								<td>${mngrBrd.mdfyDt}</td>
								<td>${mngrBrd.useYn}</td>		
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="9">
							
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div>
			<button id="delete_btn" class="btn-delete">삭제</button>
		</div>

	
		
		
	</div>
	
	
	
	
	
	
	<div>
		<button><a href="${pageContext.request.contextPath}/mngrbrd/write"> 게시글 작성</a></button>
	</div>


</body>
</html>