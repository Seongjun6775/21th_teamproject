<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		$(".qna-btn").click(function() {
			if ("${sessionScope.__MBR__.mbrId}" == "") {
				Swal.fire({
				     title: '로그인 필요',
				     text: "로그인이 필요합니다.\n로그인 하시겠습니까?",
				     icon: 'warning',
				     showCancelButton: true,
				     confirmButtonColor: '#3085d6',
				     cancelButtonColor: '#d33',
				     cancelButtonText: '취소',
				     confirmButtonText: '로그인'
				   }).then((result) => {
				      if(result.isConfirmed){
				         $("#img_btn").click();
				      }else{
				         $("#btn-modal-close").click();
				      }
				});
			}
			else {
				location.href="${context}/hlpdsk/list"; 
			}
		});
		
		
		$(".que").click(function() {
			   $(this).next(".anw").stop().slideToggle(300);
			  $(this).toggleClass('on').siblings().removeClass('on');
			/*   $(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기 */
			});
	    $("#search-btn").click(function(){
	        movePage(0);
	     });
		
	});
	function movePage(pageNo){

		var queryString = "pageNo=" + pageNo;
		
		location.href = "${context}/hlpdsk/list?" + queryString;
		
	}

</script>
 <style>
*{
  box-sizing: border-box; 
}
  
.que:first-child{
    border-top: 2px solid black;
  }

  
.que{
  position: relative;
  padding: 17px 0;
  cursor: pointer;
  font-size: 14px;
  border-bottom: 1px solid #dddddd;
  
}
  
.que::before{
  display: inline-block;
  content: 'Q';
  font-size: 14px;
  color: #ffbe2e;
  margin: 0 5px;
}

.que.on>span{
  font-weight: bold;
  color: #ffbe2e;
}
  
.anw {
  display: none;
  overflow: hidden;
  font-size: 14px;
  background-color: #f4f4f2;
  padding: 30px;
}
  
.anw::before {
  display: inline-block;
  content: 'A';
  font-size: 14px;
  font-weight: bold;
  color: #666;
  margin: 0 5px;
}

.arrow-wrap {
  position: absolute;
  top:50%; right: 10px;
  transform: translate(0, -50%);
}

.que .arrow-top {
  display: none;
}
.que .arrow-bottom {
  display: block;
}
.que.on .arrow-bottom {
  display: none;
}
.que.on .arrow-top {
  display: block; 
}
</style>
</head> 
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">고객센터</div>
		<div class="overlay absolute"></div>
	</div>
		<div id="menu" class="flex-column" style=" margin-bottom: 0;">
			<div class="bg-white " style="padding: 100px; height:auto;">
				<div  style="position: relative">
					<h1 style="font-weight: 700; margin-bottom: 1rem;">자주 묻는 질문</h1>
					<div style="position: absolute;right: 0;top: 0;margin: 8px;">
						<a href="javascript:void(0);" class="qna-btn fw-bold" style="margin:0px"> 내 질문/문의 </a> 					
					</div>
				</div>
				
				<div id="Accordion_wrap" style="margin-bottom: 20px; border-bottom: 1px solid black;">
				     <div class="que">
				     	<span>현금영수증 발행이 가능하나요?</span>
				     	<div class="arrow-wrap">
				    		<span class="arrow-top">↑</span>
				     		<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>결제시 현금영수증을 선택하여 발행 여부를 선택하실 수 있습니다. </span>
				     </div>
				     <div class="que">
				     	<span>주문 가능한 최소 금액이 있나요?</span>				       
				     	<div class="arrow-wrap">
				     		<span class="arrow-top">↑</span>
				     		<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>예, 최소 주문 금액제도에 따라 지역별, 매장별로 상이 할 수 있습니다.</span>
				     </div>
				     <div class="que">
				     	<span>가격은 어떻게 확인이 가능한가요?</span>
				     	<div class="arrow-wrap">
				     	<span class="arrow-top">↑</span>
				     	<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>제품 주문 시에 가격을 확인할 수 있으며, 매장 가격 정책에 따라 매장 가격과 배달 시 가격은 다르게 책정되어 있습니다.</span>
				     </div>
				     <div class="que">
				     	<span>대량주문에 대한 제한이 있는지요?</span>
				     	<div class="arrow-wrap">
				     	<span class="arrow-top">↑</span>
				     	<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>대량주문의 경우 매장 상황을 파악한 후 콜센터에서 확인전화를 드리며 확인 전화가 완료되어야 주문이 접수됩니다. 원재료 및 제품의 생산시간을 고려하여 가능 여부를 안내해드립니다.</span>
				     </div>
				     <div class="que">
				     	<span>주문을 변경,취소하고 싶은데 가능하나요?</span>
				     	<div class="arrow-wrap">
				     	<span class="arrow-top">↑</span>
				     	<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>완료된 주문의 취소, 변경을 원하시는 경우 1599-1599로 연락 후 가능 여부를 확인받으실 수 있습니다</span>
				     </div>
				     
				     
				     
				     <div class="que">
				     	<span>채용문의는 어디서 하면 되나요??</span>
				     	<div class="arrow-wrap">
				     	<span class="arrow-top">↑</span>
				     	<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>채용 문의는 로그인 후 상단의 있는 채용 문의를 통해 채용 지원을 할 수 있습니다.</span>
				     </div>
				     <div class="que">
				     	<span>대량주문에 대한 제한이 있는지요?</span>
				     	<div class="arrow-wrap">
				     	<span class="arrow-top">↑</span>
				     	<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>대량주문의 경우 매장 상황을 파악한 후 주문이 접수됩니다. <br>원재료 및 제품의 생산시간을 고려하여 가능 여부를 안내해드립니다.</span>
				     </div>
				     <div class="que">
				     	<span>미리 주문 예약이 가능한가요?</span>
				     	<div class="arrow-wrap">
				     	<span class="arrow-top">↑</span>
				     	<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>예약주문은 해당 매장과 상의 후 예약 가능합니다.</span>
				     </div>
				     <div class="que">
				     	<span>주문 가능한 최소 금액이 있나요?</span>
				     	<div class="arrow-wrap">
				     	<span class="arrow-top">↑</span>
				     	<span class="arrow-bottom">↓</span>
				     	</div>
				     </div>
				     <div class="anw">
				     	<span>예, 저희는 최소 주문 금액제도에 따라 지역별, 매장별로 상이 할 수 있습니다.</span>
				     </div>
				</div>
				<div class="qna_box row" >	 
					
				</div>
			</div> 		
		</div>
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>