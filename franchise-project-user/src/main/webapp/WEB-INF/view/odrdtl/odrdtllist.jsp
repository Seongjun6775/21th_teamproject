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
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$(document).ready(function() {
			  $(".plus").on("click", function() {
			    var $cnt = $(this).siblings(".cnt");
			    var num = parseInt($cnt.val()) + 1;
			    var price = num * $(this).closest(".updown").siblings(".price").data("price");
			    $cnt.val(num);
			    $(this).closest(".updown").siblings(".price").children("span").text(price);
			  });

			  $(".minus").on("click", function() {
			    var $cnt = $(this).siblings(".cnt");
			    var num = parseInt($cnt.val()) - 1;
			    if (num < 1) {
			      num = 1;
			    }
			    var price = num * $(this).closest(".updown").siblings(".price").data("price");
			    $cnt.val(num);
			    $(this).closest(".updown").siblings(".price").children("span").text(price);
			  });
		});
		/* $(".updown button").click(function(e) {
			e.preventDefault();
			var $count = $(this).closest(".updown").find(".cnt");
			var now = parseInt($count.val());
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
				$count.val(num);
				
				var price = num * $(".price").data("price");
				$("#price").text(price);
			}
		}); */
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			
			<h2>구매 예정 물품 조회 페이지</h2>
			<div>총 ${odrDtlList.size() > 0 ? odrDtlList.get(0).totalCount : 0}건</div>
			<div class="odrdtl_table_grid">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>사진</th>
							<th>정보</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty odrDtlList}">
								<c:forEach items="${odrDtlList}" var="odr">
									<tr data-odrDtlId="${odr.odrDtlId}"
										data-odrLstId="${odr.odrLstId}"
										data-odrDtlPrdtId="${odr.odrDtlPrdtId}"
										data-odrDtlPrdtCnt="${odr.odrDtlPrdtCnt}"
										data-odrDtlStrId="${odr.odrDtlStrId}"
										data-useYn="${odr.useYn}"
										data-delYn="${odr.delYn}"
										data-mbrId="${odr.mbrId}"
										data-prdtNm="${odr.prdtVO.prdtNm}"
										data-prdtPrc="${odr.prdtVO.prdtPrc}"
										data-strNm="${odr.strVO.strNm}"
										data-strCallNum="${odr.strVO.strCallNum}">
										<td>
											
										</td>
										<td>
											<div class="container text-center">
											  <div class="row">
											    <div class="col">
											      상품명 : <span>${odr.prdtVO.prdtNm}</span>
											    </div>
											    <div class="col updown">
											    	<button class="minus">-</button>
											    	<input type="text" class="cnt" value="${odr.odrDtlPrdtCnt}" readonly/>
											    	<button class="plus">+</button>
											    </div>
											  </div>
											  <div class="row">
											    <div class="col price" data-price="${odr.prdtVO.prdtPrc}">
											      가격 : <span id="price">${odr.odrDtlPrdtCnt * odr.prdtVO.prdtPrc}</span>
											    </div>
											    <div class="col">
											      매장명 : <span>${odr.strVO.strNm}</span>
											    </div>
											  </div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="9">주문 내역이 없습니다.</td>
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
