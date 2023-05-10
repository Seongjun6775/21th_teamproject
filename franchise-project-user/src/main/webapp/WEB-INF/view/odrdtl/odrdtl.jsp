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
<link rel="stylesheet" href="${context}/css/odrdtl_odrdtl.css?p=${date}" />
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		var odrPrcs = "${odrPrcs.odrLstOdrPrcs}";
		
		if ("${odrPrcs.odrLstOdrPrcs}" == "003-01") {
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
					
					var price = 0;
					if ("${odrDtl.prdtVO.evntPrdtVO.evntId}" != "") {
						price = ${odrDtl.prdtVO.evntPrdtVO.evntPrdtChngPrc};
					}
					else {
						price = ${odrDtl.prdtVO.prdtPrc};
					}
					var totalPrice = num * price;
					$(".total-price").val(totalPrice);
				}
			});
		}
			
		$("#list_btn").click(function() {
			location.href = "${context}/odrdtl/list/${odrDtl.odrLstId}";
		});
		
		$("#modify_btn").click(function() {
			var cnt = $(".cnt").val();
			
			if (odrPrcs != "003-01") {
				if (odrPrcs == "003-05") {
					Swal.fire({
				    	  icon: 'warning',
				    	  title: '주문 취소된 상품입니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert("주문 취소된 상품입니다."); */
					return;
				}
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '이미 주문 처리된 상품입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 주문 처리된 상품입니다."); */
				return;
			}
			
			if (cnt == ${odrDtl.odrDtlPrdtCnt}) {
				if (!confirm("수량이 변경되지 않았습니다. 이대로 수정을 완료하시겠습니까?")) {
					return;
				}
			}
			if (!confirm("수량 변경을 완료하시겠습니까?")) {
				return;
			}
			
			var odrDtlPrc = 0;
			if ("${odrDtl.prdtVO.evntPrdtVO.evntId}" == "") {
				odrDtlPrc = ${odrDtl.prdtVO.prdtPrc};
			}
			else {
				odrDtlPrc = ${odrDtl.prdtVO.evntPrdtVO.evntPrdtChngPrc};
			}
			
			$.post("${context}/api/odrdtl/update/${odrDtl.odrDtlId}", {"odrDtlPrdtCnt": cnt, "odrDtlPrc": odrDtlPrc}, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/odrdtl/list/${odrDtl.odrLstId}";
				}
				else {
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
			});
			
		});
		
		
		
		$("#delete_btn").click(function(){
			
			if (odrPrcs != "003-01") {
				if (odrPrcs == "003-05") {
					Swal.fire({
				    	  icon: 'warning',
				    	  title: '주문 취소된 상품입니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert("주문 취소된 상품입니다."); */
					return;
				}
				Swal.fire({
			    	  icon: 'warning',
			    	  title: '이미 주문 처리된 상품입니다.',
			    	  showConfirmButton: false,
			    	  timer: 2500
				});
				/* alert("이미 주문 처리된 상품입니다."); */
				return;
			}
			
			if (!confirm("해당 물품을 삭제하시겠습니까?")) {
				return;
			}
			var odrDtlId = ("${odrDtl.odrDtlId}");
			$.post("${context}/api/odrdtl/delete/" + odrDtlId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/odrdtl/list/${odrDtl.odrLstId}";
				}
				else {
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + " / " + response.message); */
				}
			});
		});
		
	});
</script>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">주문 상세조회
			<div style="color: #ccc; padding-top: 10px;"></div>
		</div>
		<div class="overlay absolute"></div>
	</div>
			<div class="container bg-white rounded shadow-sm" style="padding: 50px; margin: 0 auto; ">
				<div class="row content text-center">
					<div class="col img-grid">
						<img src="${context}/prdt/img/${odrDtl.prdtVO.uuidFlNm}" alt="사진이 들어갈 예정입니다.">
					</div>
					<!-- 임시로 style을 넣어 두었습니다. css 작업을 하실 때 지워야 합니다. -->
					<div class="col text-grid">
						<div style="text-align: left; font-size: 20px;">상품명 : 
							<span style="text-align: left; font-size: 30px; font-weight: bold;">${odrDtl.prdtVO.prdtNm}</span>
							<c:if test="${not empty odrDtl.prdtVO.evntPrdtVO.evntId}">
								<span>이벤트중!!</span>
							</c:if>
						</div>
						<div style="text-align: left; font-size: 20px;">개당 가격 : 
							<c:choose>
								<c:when test="${not empty odrDtl.prdtVO.evntPrdtVO.evntId}">
									<span style="text-align: left; font-size: 30px; font-weight: bold;">
										<del><fmt:formatNumber>${odrDtl.prdtVO.prdtPrc}</fmt:formatNumber></del>
										<fmt:formatNumber>${odrDtl.prdtVO.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber>
									</span>원
								</c:when>
								<c:otherwise>
									<span style="text-align: left; font-size: 30px; font-weight: bold;">
										<fmt:formatNumber>${odrDtl.prdtVO.prdtPrc}</fmt:formatNumber>
									</span>원
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col updown" style="text-align: left; font-size: 20px; padding: 0px;">수량 :
								<button class="minus">-</button>
								<input type="text" class="cnt text-center" value="${odrDtl.odrDtlPrdtCnt}" readonly/>
								<button class="plus">+</button>
						</div>
						<div class="col price" style="text-align: left; font-size: 20px; padding: 0px;">합계 : 
							<c:choose>
								<c:when test="${not empty odrDtl.prdtVO.evntPrdtVO.evntId}">
									<input type="text" class="total-price" value="${odrDtl.prdtVO.evntPrdtVO.evntPrdtChngPrc * odrDtl.odrDtlPrdtCnt}" readonly>
								</c:when>
								<c:otherwise>
									<input type="text" class="total-price" value="${odrDtl.prdtVO.prdtPrc * odrDtl.odrDtlPrdtCnt}" readonly>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<button type="button" id="modify_btn"class="btn btn-success">수정</button>
				<button type="button" id="list_btn" class="btn btn-secondary">목록</button>
				<button type="button" id="delete_btn" class="btn btn-danger">삭제</button>
			</div>
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>
