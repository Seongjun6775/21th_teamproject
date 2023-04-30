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
<link rel="stylesheet2" href="${context}/css/brd_common.css?p=${date}"/>
<script type="text/javascript" src="${context}/bs/assets/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
        $().ready(function(){
            $('.nav-item').mouseenter(function(){
                $(this).find('.dropdown-menu').show();
            }).mouseleave(function(){
                $(this).find('.dropdown-menu').hide();
            })
        });
		
	}); 
</script>
<style>
.nav-scroller .nav {
  display: flex;
  flex-wrap: nowrap;
  padding-bottom: 1rem;
  margin-top: -1px;
  overflow-x: auto;
  text-align: center;
  white-space: nowrap;
  -webkit-overflow-scrolling: touch;
}

.btn-bd-primary {
  --bd-violet-bg: #712cf9;
  --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

  --bs-btn-font-weight: 600;
  --bs-btn-color: var(--bs-white);
  --bs-btn-bg: var(--bd-violet-bg);
  --bs-btn-border-color: var(--bd-violet-bg);
  --bs-btn-hover-color: var(--bs-white);
  --bs-btn-hover-bg: #6528e0;
  --bs-btn-hover-border-color: #6528e0;
  --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
  --bs-btn-active-color: var(--bs-btn-hover-color);
  --bs-btn-active-bg: #5a23c8;
  --bs-btn-active-border-color: #5a23c8;
}
.bd-mode-toggle {
  z-index: 1500;
}

.nav-item .nav-link:hover{
  border-bottom: solid #dd4848 1px;
}
.roundbox {
  border-radius: 15px;
  display: inline-block;
  width: 240px;
  height: 80px;
  overflow: visible;
  border: 1px solid #fff;
  background: #fff;
  text-align: center;
  line-height: 80px;
  margin: 0px 20px 0px 0px;
  font-size: 20px; FONT-WEIGHT: 600;
}

.main-order-box{
  border-radius: 15px;
  display: inline-block;
  width: 550px;
  height: 240px;
  border: 1px solid #fff;
  background: #fff;
  text-align: center;
  line-height: 240px;
  margin: 0;
  margin-right: 20px;
  font-size: 20px; FONT-WEIGHT: 600;
}
.footer{
  width: 100%;
  max-width: 1920px;
  min-width: 1440px;
  height: 240px;
  background: #444;
  margin: 0 auto;
}

.ft_info {
  float: right;
}

.footer .ft_info .menu li {
display: inline-block;
}

.footer .ft_info .menu li a {
font-family: 'Noto Sans KR';
font-weight: 200;
font-size: 18px;
color: #aaa;
text-decoration: none;
 }
</style>


	<main>
  <nav class="navbar navbar-expand-lg  border-bottom sticky-sm-top bg-white" style=" height: 130px; padding: 0 40px; ">
    <div class="container-fluid ">
      <img src = "${context}/img/cat.jpg"  width="40"; height="32";/>
      <a class="navbar-brand" href="#" style="font-size: 25px; FONT-WEIGHT: 550; padding: 25px 25px 25px 0px;">프렌차이즈</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent" >
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item dropdown">
            <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550; padding:25px; padding-top: 45px; HEIGHT: 130PX;">
              회원
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">회원</a></li>
              <li><a class="dropdown-item" href="#">회원관리</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">주문관리</a></li>
              <li><a class="dropdown-item" href="#">채용관리</a></li>
              <li><a class="dropdown-item" href="#">쪽지관리</a></li>
              
            </ul>
          </li> 
          <li class="nav-item dropdown">
            <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">
              메뉴
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">메뉴관리</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">이벤트관리</a></li>
              <li><a class="dropdown-item" href="#">리뷰관리</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">
              매장
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">매장찾기</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">이벤트관리</a></li>
              <li><a class="dropdown-item" href="#">리뷰관리</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">
              게시판
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">관리자게시판</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">댓글관리</a></li>
            </ul>
            
          </li>


          <li class="nav-item"  >
            <a class="nav-link disabled" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">채용</a>
          </li>
        </ul>
        <form class="d-flex" role="search">
          <input class="form-control me-3" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
        <div style="padding: 5px;">
          <button type="button" class="btn btn-primary position-relative">
            Profile
              <span class="visually-hidden">New alerts</span>
          </button>
        </div>
      </div>
    </div>
  </nav>