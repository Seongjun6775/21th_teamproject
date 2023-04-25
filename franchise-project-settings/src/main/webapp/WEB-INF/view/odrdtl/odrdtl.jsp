<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<link rel="stylesheet" href="${context}/css/odrdtl_odrdtl.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$(".updown button").click(function(e) {
			e.preventDefault();
			var count = $(this).closest(".updown").find(".cnt");
			var now = parseInt(count.val());
			var min = 1;
			var max = 999;
			var num = now;
			
			if($(this).hasClass("minus")){
				var type="m";
			} else {
				var type="p"
			}
			
			if (type == "m") {
				if (now > min) {
					num = now - 1;
				}
			} else {
				if (now < max) {
					num = now + 1;
				}
			}
			
			if (num != now) {
				count.val(num);
				
				var price = num * ${odrDtl.prdtVO.prdtPrc};
				$(".total-price").val(price);
			}
		});
		
		$("#list_btn").click(function() {
			location.href = "${context}/odrdtl/list/${odrDtl.odrLstId}";
		});
		
		
		
		$("#delete_btn").click(function(){
			
			if (!confirm("해당 물품을 삭제하시겠습니까?")) {
				return;
			}
			var odrDtlId = ("${odrDtl.odrDtlId}");
			$.post("${context}/api/odrdtl/delete/" + odrDtlId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/odrdtl/list/${odrDtl.odrLstId}";
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			
			<div class="container text-center">
				<div class="row content">
					<div class="col img-grid">
						<img src="" alt="사진이 들어갈 예정입니다.">
					</div>
					<div class="col text-grid">
						<div>${odrDtl.prdtVO.prdtNm}</div>
						<div>${odrDtl.prdtVO.prdtPrc}원</div>
						<div class="col updown">
							<button class="minus">-</button>
							<input type="text" class="cnt text-center" value="${odrDtl.odrDtlPrdtCnt}" readonly/>
							<button class="plus">+</button>
						</div>
						<div class="col price">
							<input type="text" class="total-price" value="${odrDtl.odrDtlPrdtCnt * odrDtl.prdtVO.prdtPrc}" readonly>
						</div>
					</div>
				</div>
			</div>
			
			<button type="button" id="modify_btn"class="btn btn-success">수정</button>
			<button type="button" id="list_btn" class="btn btn-secondary">목록</button>
			<button type="button" id="delete_btn" class="btn btn-danger">삭제</button>
			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
