<%@page import="com.ktds.fr.mbr.vo.MbrVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$().ready(function() {
	$("li.nav-item").children("a").mouseover(function(){
		$(this).closest(".nav").find(".nav-item.active").removeClass("active");
		$(this).closest("li.nav-item").addClass("active");
		$("div.header").mouseleave(function(){
			$(this).find(".active").removeClass("active");
		}); 
		
		$(".sub-item").mouseenter(function(){
			$(this).addClass("active");
		});
	});
}); 

</script>
<!-- header -->
  <header class="p-3 mb-4">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start" style=" height: 30px; padding:10px 30px 0px 0px; margin: 0px;">
        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
        </ul>
        <div style="margin-right:10px;">
        	<div class="fw-bold fs-5">${sessionScope.__MBR__.mbrNm}님 </div> 
        	<small style="float: right;">${sessionScope.__MBR__.mbrLvl eq '001-01' ? '본사' 
        	: sessionScope.__MBR__.mbrLvl eq '001-02' ? '가맹점주'
        	: sessionScope.__MBR__.mbrLvl eq '001-03' ? '점원'
        	: '이용자'} </small> 
        </div>
        
        <div class="dropdown text-end">
          <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
          </a> 
          <ul class="dropdown-menu text-small">
            <li><a class="dropdown-item" href="#">${sessionScope.__MBR__.mbrNm}</a></li>
           <!--  <li><a class="dropdown-item" href="#">Settings</a></li> -->
            <li><a class="dropdown-item" href="${context}/mbr/pwdCheck">Profile</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="${context}/logout">Sign out</a></li>
          </ul>
        </div>
      </div>
  </header>
  <!-- /header -->


