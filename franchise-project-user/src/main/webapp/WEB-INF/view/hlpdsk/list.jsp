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
table > thead > tr > th:last-child {
    border-radius:0;
}
table > thead > tr > th:first-child{
    border-radius:0;
}
    
</style>
</head> 
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">고객센터</div>
		<div class="overlay absolute"></div>
	</div>
		<div id="menu" class="flex-column" style="margin-bottom: 500px;"> 
			<div class="bg-white " style="padding: 100px; height:1000px;">
				<h1 style="font-weight: 700; margin-bottom: 1rem;">자주 묻는 질문</h1>
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
					<a href="${context}/hlpdsk/write" class="qna-btn fw-bold"> 문의/건의 </a>
				</div>
				<c:if test= "${not empty sessionScope.__MBR__}">	
				<div class="rounded" style="border: solid 2px #e0e0e0;">
					<table class="table caption-top table-hover" style="text-align: center;">
						<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
							<tr>
							<!-- 	<th >글번호</th> -->
								<th>문의/건의</th>	 
								<th>답변상태</th>			
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>			 		
								<c:when test="${not empty myHlpDskList}">
									<c:forEach items="${myHlpDskList}" var="hlpDsk" >
										<tr data-hlpdskwrtid = "${hlpDsk.hlpDskWrtId}"
											data-hlpdsksbjct = "${hlpDsk.hlpDskSbjct}"
											data-hlpdskprcsyn = "${hlpDsk.hlpDskPrcsYn}"
											data-hlpdskttl = "${hlpDsk.hlpDskTtl}"
											data-mbrnm = "${mbrVO.mbrNm}"
											data-mbrid = "${hlpDsk.mbrId}"
											data-hlpdskwrtdt = "${hlpDsk.hlpDskWrtDt}">
							<%-- 					<td style="width: 100px;">No.${hlpDsk.hlpDskWrtId.substring(12,17).replaceFirst("^0+(?!$)", "")}</td> --%>
												<td style="width: 130px;">${hlpDsk.hlpDskSbjct}</td>
												<td style="width: 130px;">${hlpDsk.hlpDskPrcsYn eq 'N' ? '답변대기중' : '답변완료'}</td>
												<td>
													<a href="${context}/hlpdsk/${hlpDsk.hlpDskWrtId}" class="brdid">
														${hlpDsk.hlpDskTtl}  
													</a>
												</td>
												<td style="width: 180px;">${hlpDsk.mbrVO.mbrNm}</td>
												<td style="width: 200px;">${hlpDsk.hlpDskWrtDt}</td>				
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="no-items">
											등록된 글이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				
					 <div class="pagenate">
						<ul class="pagination" style="text-align: center;">
							<c:set value = "${myHlpDskList.size() > 0 ? myHlpDskList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${myHlpDskList.size() > 0 ? myHlpDskList.get(0).lastGroup : 0}" var="lastGroup"/>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(hlpDskVO.pageNo /10)}" integerOnly="true" />
							<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value ="${nowGroup*10+ 10}" var="groupEndPageNo" />
							<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo -1}" var="groupEndPageNo" />
							
							<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
							<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							<c:if test="${nowGroup > 0}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})")>이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo < 0 ? 0 : groupEndPageNo}" step="1" var="pageNo">
								<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq hlpDskVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							<c:if test="${lastGroup > nowGroup}">
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div> 
				</div>	
				</c:if>		
			</div> 		
		</div>
	<jsp:include page="../include/footer_user.jsp" />
</body>
</html>