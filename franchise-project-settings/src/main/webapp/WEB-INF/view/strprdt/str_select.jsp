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
<link rel="stylesheet" href="${context}/css/strprdt_common.css?p=${date}" />
<script type="text/javascript">
$(document).ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	$(document).on('click', 'a[href="#"]', function(e) {
		  e.preventDefault();
		});
// 	$('a[href="#"]').click(function(ignore) {
//         ignore.preventDefault();
//     });
	
	
	$("tbody").children("tr").click(function() {
		var lct = $(this).data().lctid;
		$(this).closest("tbody").find(".on").removeClass("on");
		$(this).addClass("on");
		
		$("#ctyTable").children("tbody").empty();
		$("#strTable").children("tbody").empty();
		
		$.post("${context}/api/strprdt/list2/lct",
			{lctId: lct},
			function(data) {
				for (var i = 0; i < data.length; i++) {
				    var ctyId = data[i].ctyId;
				    var ctyNm = data[i].ctyNm;
				    
				    var tr = $("<tr data-ctyid='" + ctyId + "'></tr>");
				    var td = "<td><a href='#'>" + ctyNm + "</a></td>"
				    
				    $("#ctyTable").children("tbody").append(tr);
				    tr.append(td);
				    
				    tr.click(function() {
				    	$(this).closest("tbody").find(".on").removeClass("on");
						$(this).addClass("on");
				    	var ctyId = $(this).data().ctyid;
				    	strCall(ctyId);
				    });
				}
			});
		
		
		
	});
	
	function strCall(ctyId) {
		$("#strTable").children("tbody").empty();
		if (!ctyId)	return;
		
		$.post("${context}/api/strprdt/list2/cty",
		        {ctyId: ctyId},
		        function(data) {
		        	for (var i = 0; i < data.length; i++) {
					    var strId = data[i].strId;
					    var strNm = data[i].strNm;
					    
					    var tr = $("<tr data-strid='" + strId + "'></tr>'");
					    var td = "<td><a href='${context}/strprdt/"+strId+"'>" + strNm + "</a></td>"
					    
					    $("#strTable").children("tbody").append(tr);
					    tr.append(td);
					    
					    tr.click(function() {
					    	location.href="${context}/strprdt/"+strId
					    });
		        }
	        })
	}
	
	
	
})
</script>
</head>
<body>


	<div class="headline relative">
		상단 헤드라인임 //////// <a href="${context}/prdt/list">관리자 메뉴로 돌아가깅</a>
		<br><a href="javascript:window.history.back();">뒤로가기</a>
	</div>
	
	<div class="overflow lctTable inline-block">
		<table id="lctTable"
				class="">
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
	</div>
	<div class="overflow ctyTable inline-block">
		<table id="ctyTable"
				class="">
			<thead>
				<tr>
					<th>도시</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
	<div class="overflow strTable inline-block">
		<table id="strTable"
				class="">
			<thead>
				<tr>
					<th>매장이름일까</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
	
		
</body>
</html>