<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<script type="text/javascript">
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	$('a[href="#"]').click(function(ignore) {
		ignore.preventDefault();
	});
	$('div[class="itemList"]').click(function() {
		location.href = "${context}/prdt/list2/"+$(this).data("prdtid");
	});

	
	var srt = "${prdtVO.prdtSrt}"
	$("div[id=menuCategory] a").each(function() {
		if ($(this).attr("value") == srt) {
			$(this).addClass("menuOn");
		}
	})
	
	
	$("div[id=menuCategory] a").click(function() {
		var srt = $(this).attr("value");
		var queryString = "prdtSrt=" + srt;
		location.href = "${context}/prdt/list2?" + queryString;
	});
	
	
// 	$(".prdt1").click(function() {
// 		var data = $(this).data();
// 		location.href="${context}/prdt/list2/"+data.prdtid
// 	})
	
	
	


	$('.nav-item').mouseenter(function(){
	    $(this).find('.dropdown-menu').show();
	}).mouseleave(function(){
	    $(this).find('.dropdown-menu').hide();
	})
		
	
	
});


function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	var prdtNm= $("#search-keyword-prdtNm").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	
	var queryString = "prdtSrt=" + srt;
	queryString += "&prdtNm=" + prdtNm;
	queryString += "&useYn=" + useYn;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/prdt/list2?" + queryString; // URL 요청
} 

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
 
 
a[role=button]:hover {
	background-color: white;
}
a[role=button]:focus {
	background-color: white;
}


</style>
</head>
<body class="scroll">

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

<!-- 	<div class="headline relative"> -->
<%-- 		상단 헤드라인임 //////// <a href="${context}/prdt/list">관리자 메뉴로 돌아가깅</a> --%>
<%-- 		<br><a href="${context}/strprdt/list2">주문가볼까</a> --%>
		
<!-- 	</div> -->


	<div class="visualArea flex relative">
		<div class="content-setting title">붕어빵 파는곳</div>
		<div class="overlay absolute"></div>
	</div>
	
	
	
	<div id="menu" class="flex-column">
		<div id="menuCategory" class="flex">
			<a href="#" value="" class="menu">
				전체메뉴
			</a>
			<c:choose>
				<c:when test="${not empty srtList}">
					<c:forEach items="${srtList}"
								var="srt">
						<a href="#"  class="menu"
							value="${srt.cdId}" >
							${srt.cdNm}
						</a>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
		
	
		<div id="itemList" class="flow-wrap">
			<c:choose>
				<c:when test="${not empty prdtList}">
					<c:forEach items="${prdtList}"
								var="prdt">
						<div class="itemList" data-prdtid="${prdt.prdtId}">
							<div class="prdt card shadow" style="padding: 24px; border-radius: 24px;">
								<div class="img-box" style="width: 100%">
									<c:choose>
										<c:when test="${empty prdt.uuidFlNm}">
											<img src="${context}/img/default_photo.jpg">
										</c:when>
										<c:otherwise>
											<img src="${context}/prdt/img/${prdt.uuidFlNm}/">
										</c:otherwise>
									</c:choose>	
								</div>
								<div class="prdt3">
									<div class="discount">
										<c:choose>
											<c:when test="${not empty prdt.evntVO.evntId}">
												<span>이벤트 진행중 <i class='bx bxs-discount bx-tada bx-rotate-180' ></i></span>
											</c:when>
										</c:choose>
									</div>
									<div class="name ellipsis">${prdt.prdtNm}</div>
									<div class="price"><fmt:formatNumber>${prdt.prdtPrc}</fmt:formatNumber><span>원</span></div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
	
	</div>
	
	
	


</body>
</html>