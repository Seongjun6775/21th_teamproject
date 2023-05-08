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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
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
  width: 350px; 
  height: 140px; 
  border: 1px solid #fff;
  background: #fff;
  text-align: center;
  line-height: 140px;
  margin: 0;
  margin-right: 20px;
  font-size: 20px;
  FONT-WEIGHT: 600;
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
 .flex-center{
     display: flex;
    justify-content: center;
 }
 
 .shop_categorylist > li{
    float: left;
    font-size: 1.125rem;
    line-height: 110%;
    border-left: 1px solid #ededed;
    border-right: 1px solid #ededed;
 }
 
 .map_btn{
 font-size: 25px;
    FONT-WEIGHT: 550;
    margin: 10px;
    color: #fff;
    padding: 10px 25px;
    border-radius: 35px;
    background-color:#d72300;
    }
</style>
</head>
<body style="background-color:#f2ebe6; overflow: auto;">
	<jsp:include page="./include/header_user.jsp" />
	<div style="background-color:#f7f7f7; margin: 0 230px;">
		<div>
			<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
				<div class="carousel-inner" style=" width: 100%; height:1050px; ">
					<div class="carousel-item active">
						<img src="${context}/img/붕어빵이벤트2.jpg" class="d-block w-100" alt="고양이1" >
					</div>
					<div class="carousel-item">
						<img src="${context}/img/cat.jpg" class="d-block w-100" alt="고양이2">
					</div>
					<div class="carousel-item">
						<img src="${context}/img/와플.png" class="d-block w-100" alt="고양이3">
					</div>
					<div class="carousel-item">
						<img src="${context}/img/cat4.jpg" class="d-block w-100" alt="고양이4">
					</div>
				</div>
<%-- 				<div style="display: flex; justify-content: center;">
					<div style="position: absolute; bottom: 0; display:inline-block; z-index: 1; margin-bottom: 270px;">
						<a href="${context}/prdt/list2" style="font-size: 20px; FONT-WEIGHT: 600;"><button class="main-order-box">주문</button></a>
						<a href="${context}/prdt/list2" style="font-size: 20px; FONT-WEIGHT: 600;"><button class="main-order-box">메뉴 더보기</button></a>
					</div>
				</div> --%>
					<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
			</div>
			<div style="padding: 30px; background: #444;">
				<div class="container-fluid"style="display: flex;">
				<svg  style="display:inline-block" xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-arrow-right-circle" viewBox="0 0 16 16">
					<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z" style="color: #fff;"/>
				</svg>
				<a href="#" style="margin-left: 20px ; font-size: 25px; FONT-WEIGHT: 550; display:inline-block; color: #fff;">로그인하고 더 많은 해택을 즐겨보세요!</a>
				</div>
<!-- 				<div style="margin: 30px;">
					<div class="roundbox"><a class="dropdown-item" href="#" style="font-size: 20px; FONT-WEIGHT: 600;">로그인/회원가입</a></div>
					<div class="roundbox"><a class="dropdown-item" href="#" style="font-size: 20px; FONT-WEIGHT: 600;">비회원 주문조회</a></div>
				</div> -->
			</div>
		</div>
		<iframe width="100%" height="600" src="https://www.youtube.com/embed/y___01py2wk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
		<div style=" position: relative; padding:50px 100px; background-color: #fff; height: 810px;" >
			<div style="position: absolute; top: 25%; left: 30%;">
				<h2 class="flex-center fs-1 fw-bold" style="FONT-WEIGHT:800">매장찾기</h2>
				<p class="flex-center fw-bold" >고객님 주변에 있는 뿡어빵을 찾아보세요!</p>
	<!-- 			<div class="flex-center" style="margin:20px">
					<button class="map_btn flex-center">매장찾기</button> 
				</div> -->
				<ul class="shop_categorylist flex-center">
					<li>
						<img src="${context}/img/map3.gif" width="150" height="100" > 
						<div class="fw-bolder flex-center flex-center">미리 주문하고 <br>픽업가능한
						</div> 
						<div class="fw-bold text-danger fs-5 flex-center m-10"  >오더</div>
					</li>
					<li> 
						<img src="${context}/img/map4.gif" width="150" height="100" >
						<div class="fw-bolder flex-center">차안에서 빠르게 <br>이용할 수 있는
						</div>
						<div class="fw-bold text-danger fs-5 flex-center m-10 " >드라이브 스루</div>
					</li>
					<li>
						<img src="${context}/img/map1.gif" width="150" height="100" >
						<div class="fw-bolder flex-center">24시간 언제든 <br>함께할 수 있는</div>
						<div class="fw-bold text-danger fs-5 flex-center m-10">24시간</div>
					</li>
					<li>
						<img src="${context}/img/map5.gif" width="150" height="100">
						<div class="fw-bolder flex-center">내 차와 함께 <br>올 수 있는</div>
						<div class="fw-bold text-danger fs-5 flex-center m-10 " >주차공간</div>
					</li>
				</ul>
			</div>
		</div>
		
		<div style="height: 300px;">
			<h1>이벤트 한눈에 보기 </h1>
			
		</div>
			<div style="height: 402px;">
			<a href="${context}/hr/hrindex"><img src="${context}/img/채용문의.png" width="50%" height="300"></a> 
			
			
		</div>
	 </div>
<jsp:include page="./include/footer_user.jsp" />
</body>
</html>
