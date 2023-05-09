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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<script type="text/javascript">
$(document).ready(function() {
	
	if ("${mbrVO.mbrLvl}" != "001-04") {
		Swal.fire({
		  	  icon: 'error',
		  	  title: '이용자 로그인 후<br>주문하실 수 있습니다.',
		  	  showConfirmButton: true,
		  	  confirmButtonColor: '#3085d6'
			}).then((result)=>{
				if(result.isConfirmed){
					location.href = "${context}/index";
				}
			});
	}
	
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
		
		$.post("${context}/api/strprdt/list2/lct", {lctId: lct}, function(data) {
				for (var i = 0; i < data.length; i++) {
				    var ctyId = data[i].ctyId;
				    var ctyNm = data[i].ctyNm;
				    
				    var tr = $("<tr data-ctyid='" + ctyId + "'></tr>");
				    var td = $("<td></td>");
				    td.addClass("ellipsis");
				    var a = $("<a href='#'>" + ctyNm + "</a>");
				    td.append(a);
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
		
		$.post("${context}/api/strprdt/list2/cty", {ctyId: ctyId}, function(data) {
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
<body class="scroll">

	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">붕어빵 파는곳</div>
		<div class="overlay absolute"></div>
	</div>


	<div id="menu" class="flex-column">
	
		<div id="menuCategory" class="flex">
			<div id="menuTitle">주문할 매장을 선택합니다</div>
		</div>
		
		
		<div id="selectStr" class="flex">
			<div class="overflow lctTable inline-block">
				<table id="lctTable"
						class="table table-hover">
					<thead class="">
						<tr>
							<th style="border-radius: 0">지역</th>
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
						class="table table-hover">
					<thead class="">
						<tr>
							<th style="border-radius: 0">도시</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			<div class="overflow strTable inline-block">
				<table id="strTable"
						class="table table-hover">
					<thead class="">
						<tr>
							<th style="border-radius: 0">매장 이름</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		
		
	</div>
	
	
	<jsp:include page="../include/footer_user.jsp" />
	
	
</body>
</html>