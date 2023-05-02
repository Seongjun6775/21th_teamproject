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
<jsp:include page="./include/stylescript.jsp" /> 
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
* {padding:0;margin:0;}
body {background:#fff;}
header {width:100%;background:#f5f5f5;position:relative;z-index:10;}
.header-list {width:1200px;margin:0 auto;font-size:0;padding:15px 0;}
.header-list > li {font-size:12px;display:inline-block;vertical-align:middle;}
.header-list > li:nth-child(1) {font-size:20px;width:200px;}
.header-list > li:nth-child(2) {width:calc(100% - 250px);}
.header-list > li:nth-child(3) {width:50px;}
.header-list > li > div {width:auto;}

.menu-ul {font-size:0;}
.menu-ul > li {font-size:12px;display:inline-block;vertical-align:middle;}
.menu-ul > li > a {display:block;width:auto;padding:15px;}

input[id="menuicon"] {display:none;}
input[id="menuicon"] + label {display:block;position:relative;width:100%;height:40px;cursor:pointer;}
input[id="menuicon"] + label span {display:block;position:absolute;width:100%;height:3px;border-radius:30px;background:#666;transition:all .35s;}
input[id="menuicon"] + label span:nth-child(1) {top:10%;}
input[id="menuicon"] + label span:nth-child(2) {top:50%;transform:translateY(-50%);} /* ����ϰ� ����� �� �ִ� style top:calc(50% - 2.5px); margin-top:-2.5px;*/
input[id="menuicon"] + label span:nth-child(3) {bottom:10%;}
input[id="menuicon"]:checked + label {z-index:2;}
input[id="menuicon"]:checked + label span:nth-child(1) {top:50%;transform:translateY(-50%) rotate(45deg);}
input[id="menuicon"]:checked + label span:nth-child(2) {opacity:0;}
input[id="menuicon"]:checked + label span:nth-child(3) {bottom:50%;transform:translateY(50%) rotate(-45deg);}
div[class="sidebar"] {width:100%;height:0px;background:#aaa;position:fixed;top:76px;left:0;z-index:1;transition:all .35s;overflow:hidden;}
input[id="menuicon"]:checked + label + div {height:300px;}

.sitemap-ul {font-size:0;width:1200px;margin:15px auto;text-align:center;}
.sitemap-ul > li {font-size:12px;display:inline-block;vertical-align:top;width:20%;}

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
</head>
<body>
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
  <div style="background-color:#f7f7f7;">
    <div>
      <div>
        <div> 
          <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner" style=" width: auto; height: auto; ">
              <div class="carousel-item active">
                <img src="${context}/img/cat.jpg" class="d-block w-100" alt="고양이1" >
              </div>
              <div class="carousel-item">
                <img src="${context}/img/cat2.jpg" class="d-block w-100" alt="고양이2">
              </div>
              <div class="carousel-item">
                <img src="${context}/img/cat3.jpg" class="d-block w-100" alt="고양이3">
              </div>
              <div class="carousel-item">
                <img src="${context}/img/cat4.jpg" class="d-block w-100" alt="고양이4">
              </div>
            </div>
            <div style="display: flex; justify-content: center;">
              <div style="position: absolute; bottom: 0; display:inline-block; z-index: 1; margin-bottom: 270px;">
                <div class="main-order-box"><a class="dropdown-item" href="#" style="font-size: 20px; FONT-WEIGHT: 600;">포장주문</a></div>
                <div class="main-order-box"><a class="dropdown-item" href="#" style="font-size: 20px; FONT-WEIGHT: 600;">마이오더</a></div>
              </div>
            </div>
          </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>

          <div style="padding: 20px;">
            <div class="container-fluid">
              <h2 style="margin-top: 10px;"><img src = "${context}/img/화살표.png" width="40"; height="32"; style="border-radius: 100%; margin-bottom: 10px;"/>로그인하고 더 많은 해택을 즐겨보세요!</h2>
            </div>
            <div style="margin: 30px;">
              <div class="roundbox"><a class="dropdown-item" href="#" style="font-size: 20px; FONT-WEIGHT: 600;">로그인/회원가입</a></div>
              <div class="roundbox"><a class="dropdown-item" href="#" style="font-size: 20px; FONT-WEIGHT: 600;">비회원 주문조회</a></div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
  <div style="height: 300px;">
    <h1>컨텐츠~~~~</h1>
  </div>
  <div>
      <div class = "footer">
        <div style="padding: 45px 40px 0px 40px;">
          <div style="display: inline-block;"><h3>프렌차이즈logo</h3></div>
          <div class="ft_info">
            <ul class="menu">
              <li><a href="#" class="item">이용약관</a></li>
              <li><a href="#" class="privacy">개인정보처리방침</a></li>
              <li><a href="#" target="_blank" class="notice">공지사항</a></li>
              <li><a href="#" target="_blank" class="item">창업안내</a></li>
              <li><a class="item" style="cursor: unset;">대표번호 1588-1588(운영시간 09:00 ~ 18:00)</a></li>
            </ul>



            <div style="margin-left: 40px;"> 서울시 서초구 방배역 KTDSuniversity 4, 2층<br> 사업자등록번호 120-81-63948<span class="vbar"></span>
              통신판매업신고번호 제2018-서울영등포-1220호<br> 한국피자헛유한회사 대표이사 : 김성준<span class="vbar"></span>
              개인정보 보호책임자 : 이진영 
            </div>
            <div style="margin-left: 40px;"> Copyright © BY PIZZA HUT KOREA LTD. ALL RIGHT RESERVED 
            </div>
          </div>   
        </div>
      </div>
  </div>
  

  

  
</main>
</body>
</html>
