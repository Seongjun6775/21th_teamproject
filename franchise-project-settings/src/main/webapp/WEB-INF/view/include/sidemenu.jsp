<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<script type="text/javascript">
	$().ready(function(){
		var path = location.pathname;
		path=path.slice(path.indexOf("/", 1));
		$("a[data-href$='"+path+"']").closest("li.mb-1").find("button").click();
	});
</script>
 <!-- sidebar -->
 
  <div class="flex-shrink-0 p-3 bg-dark bg-opacity-75" style="width: 230px; position: fixed;top: 0;bottom: 0; overflow: auto; 
  		border-right: ${sessionScope.__MBR__.mbrLvl eq '001-01' ? 'solid 20px'
  		  : sessionScope.__MBR__.mbrLvl eq '001-02' ? ' solid 20px #ffbe2e'
  		  : ''};">

    <a href="${context}/index" class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
      <img src="${context}/img/붕어빵.png" width="30" height="24" class="rounded" style="margin: 8px;"/>
      <span class="text-light fs-5 fw-semibold">프렌차이즈</span> 
    </a>
    <ul class="list-unstyled ps-0">
      <c:if test="${sessionScope.__MBR__.mbrLvl eq '001-01'}">
	      <li class="mb-1">
	        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="false">
	          회원
	        </button>
	        <div class="collapse " id="home-collapse">
	          <ul class="text-light btn-toggle-nav list-unstyled fw-normal pb-1 small">
	            <li class="rounded"><a data-href="${context}/mbr/list" href="${context}/mbr/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">회원조회</a></li>
	            <li class="rounded"><a data-href="${context}/mbr/admin/list" href="${context}/mbr/admin/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">관리자조회</a></li>
	            <li class="rounded"><a data-href="${context}/hr/list,${context}/hr/hrmstrlist" href="${context}/hr/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">채용관리</a></li>
	          </ul>
	        </div>
	      </li>
	      <li class="border-top my-3"></li>
      </c:if>
      <c:if test="${sessionScope.__MBR__.mbrLvl eq '001-01'}">
	      <li class="mb-1">
	        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#prdt-collapse" aria-expanded="false">
	          메뉴
	        </button>
	        <div class="collapse " id="prdt-collapse">
	          <ul class="text-light btn-toggle-nav list-unstyled fw-normal pb-1 small">
	            <li class="rounded"><a data-href="${context}/prdt/list" href="${context}/prdt/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">메뉴관리</a></li>
	            <li class="rounded"><a data-href="${context}/strprdt/list" href="${context}/strprdt/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">매장별 메뉴관리</a></li>
	          </ul>
	        </div>
	      </li>
      </c:if>
      
      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
          매장
        </button>
        <div class="collapse" id="dashboard-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
          	<c:choose>
				<c:when test ="${sessionScope.__MBR__.mbrLvl eq '001-01'}">
					<li class="rounded"><a data-href="${context}/str/list" href="${context}/str/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">전국 매장 조회</a></li>
				</c:when >
				<c:otherwise>
					<li class="rounded"><a data-href="${context}/str/list, ${context}/str/strdetailmgn, ${context}/str/customer" href="${context}/str/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">매장 조회</a></li>
					<li class="rounded"><a data-href="${context}/strprdt/list" href="${context}/strprdt/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">메뉴관리</a></li>
		            <li class="rounded"><a data-href="${context}/str/odrlst" href="${context}/str/odrlst" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">주문관리</a></li>
				</c:otherwise>
			</c:choose>
            <li class="rounded"><a data-href="${context}/str/completeOdr" href="${context}/str/completeOdr" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">처리주문조회</a></li>
              <li class="rounded"><a data-href="${context}/payment" href="${context}/payment/monthly" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">매출관리</a></li>
<%--               <li class="rounded"><a data-href="${context}/payment" href="${context}/payment" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">매출관리</a></li> --%>
            <li class="rounded"><a data-href="${context}/paymentStr" href="${context}/paymentStr" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">지역별 매출관리</a></li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#order1-collapse" aria-expanded="false">
          이벤트
        </button>
        <div class="collapse" id="order1-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
	        <li class="rounded"><a data-href="${context}/evnt/list" href="${context}/evnt/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">이벤트 조회</a></li>
	        <c:if test="${sessionScope.__MBR__.mbrLvl == '001-01' || sessionScope.__MBR__.mbrLvl == '001-01'}">		
	        	<li class="rounded"><a data-href="${context}/evnt/create" href="${context}/evnt/create" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">이벤트 등록</a></li>
          	</c:if>
          </ul>
        </div>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#order2-collapse" aria-expanded="false">
          리뷰
        </button>
        <div class="collapse" id="order2-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
	      	<c:choose>	
				<c:when test="${sessionScope.__MBR__.mbrLvl == '001-01' || sessionScope.__MBR__.mbrLvl == '001-04'}">						
					<li class="rounded"><a data-href="${context}/rv/list" href="${context}/rv/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">리뷰관리</a></li>
			</c:when>
			</c:choose>	
			<c:choose>
				<c:when test="${sessionScope.__MBR__.mbrLvl == '001-02' || sessionScope.__MBR__.mbrLvl == '001-03'}">
					<li class="rounded"><a data-href="${context}/rv/list/store" href="${context}/rv/list/store" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">내 매장 리뷰</a></li>
				</c:when>
			</c:choose>
          </ul>
        </div>
      </li>
	   <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#order3-collapse" aria-expanded="false">
          게시판
        </button>
        <div class="collapse" id="order3-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
	        <li class="rounded"><a data-href="${context}/mngrbrd/list" href="${context}/mngrbrd/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">관리자게시판</a></li>
	        <c:if test="${sessionScope.__MBR__.mbrLvl eq '001-01'}">
            	<li class="rounded"><a data-href="${context}/rpl/list" href="${context}/rpl/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">댓글관리</a></li>
            </c:if>
          </ul>
        </div>
      </li>


      <li class="mb-1">
        <button class="text-light btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#order4-collapse" aria-expanded="false">
          쪽지
        </button>
        <div class="collapse" id="order4-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
	        <li class="rounded"><a data-href="${context}/nt/list, ${context}/nt/ntmstrlist" href="${context}/nt/list" class="text-light link-body-emphasis d-inline-flex text-decoration-none rounded">쪽지관리</a></li>
          </ul>
        </div>
      </li>
      <c:if test="${sessionScope.__MBR__.mbrLvl == '001-01' || sessionScope.__MBR__.mbrLvl == '001-01'}">		
	      <li class="border-top my-3"></li>	
	      <li class="mb-1">
		      <a href="${context}/hlpdsk/list">
		      <button class="text-light btn d-inline-flex align-items-center rounded border-0 collapsed"
		       style="--bs-btn-font-weight: 700;" data-bs-toggle="collapse" aria-expanded="false">
		          고객센터
		       </button></a>
	       </li> 
       </c:if>
<%--       <li class="text-light btn d-inline-flex align-items-center rounded border-0 collapsed" style="position: fixed; bottom: 0; left: 60px; right: 0;"> 
      	<a href="${context}/index_user" class="text-light link-dark d-inline-flex text-decoration-none rounded">소비자화면</a></li> --%>
    </ul>
  </div>
  <!-- /sidebar -->
