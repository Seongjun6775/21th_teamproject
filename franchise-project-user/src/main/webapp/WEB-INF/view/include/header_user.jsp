<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />

<meta charset="UTF-8">
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

a {
    text-decoration: none;
    color: #000000a6;
}
ul{
   list-style:none;
   padding-left:0px;
   color: #000000a6;
}
   
li{
   list-style:none;
   padding-left:0px;
   color: #000000a6; 
}
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
.dropdown-menu {
   --bs-dropdown-link-active-color: #ffbe2e;
    --bs-dropdown-link-active-bg: #0000;
}
.nav-item .nav-link:hover{
  border-bottom: solid #ffbe2e 1px;
  background-color:#0000!important;
  color: #ffbe2e
}
.nav-item .nav-link-right{
font-size: 22px; FONT-WEIGHT: 550;  margin:10px; margin-top: 45px; color: #fff; padding: 10px 25px; border-radius: 25px;

}
.qna-btn{
font-size: 25px; FONT-WEIGHT: 550;  margin:10px; color: #fff; padding: 10px 25px; border-radius: 25px;
background-color: #ffbe2e; text-align: center;
}
/* .nav-item .nav-link-right:hover{
  background-color:#0000!important;
  --bs-btn-hover-bg: #6528e0;
} */ 

.collapse > ul > li > a:focus {
background-color:#0000!important;
}
ul.dropdown-menu > li:focus{
   background-color:#0000!important;
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
 /* 스르륵 */
 
 * {padding:0;margin:0;}
body {background:#fff;}
header {width:100%;background:#f5f5f5;position:relative;z-index:10;}
.header-list {width:1200px;margin:0 auto;font-size:0;padding:15px 0;}
.header-list > li {font-size:20px;display:inline-block;vertical-align:middle;}
.header-list > li:nth-child(1) {font-size:20px;width:200px;}
.header-list > li:nth-child(2) {width:calc(100% - 250px);}
.header-list > li:nth-child(3) {width:50px;}
.header-list > li > div {width:auto;}

.menu-ul {font-size:0;}
.menu-ul > li {font-size:20px;display:inline-block;vertical-align:middle;}
.menu-ul > li > a {display:block;width:auto;padding:15px;}

input[id="menuicon"] {display:none;}
input[id="menuicon"] + label {display:block;position:relative;width:100%;height:40px;cursor:pointer;}
input[id="menuicon"] + label span {display:block;position:absolute;width:100%;height:3px;border-radius:30px;background:#666;transition:all .35s;}
input[id="menuicon"] + label span:nth-child(1) {top:10%;}
input[id="menuicon"] + label span:nth-child(2) {top:50%;transform:translateY(-50%);} /*     ϰ            ִ  style top:calc(50% - 2.5px); margin-top:-2.5px;*/
input[id="menuicon"] + label span:nth-child(3) {bottom:10%;}
input[id="menuicon"]:checked + label {z-index:2;}
input[id="menuicon"]:checked + label span:nth-child(1) {top:50%;transform:translateY(-50%) rotate(45deg);}
input[id="menuicon"]:checked + label span:nth-child(2) {opacity:0;}
input[id="menuicon"]:checked + label span:nth-child(3) {bottom:50%;transform:translateY(50%) rotate(-45deg);}
div[class="sidebar"] {width:100%;height:0px;background:#ffffff;position:fixed;top:130px;left:0;z-index:1;transition:all .35s;overflow:hidden;}
input[id="menuicon"]:checked + label + div {height: 220px;}

.sitemap-ul {font-size:0;width:1200px;margin:15px auto;text-align:center;}
.sitemap-ul > li {font-size:20px;display:inline-block;vertical-align:top;width:20%;}
      input.img-button {
        background: url( "${context}/img/cat.jpg" ) no-repeat;
        border: none;
        width: 32px;
        height: 32px;
        cursor: pointer;
      }
      
li.dropdown > ul > li > a  {
    font-weight: 600;
    font-size: 18px;
}
.dropdown-menu{
   --bs-dropdown-min-width: 12rem;
}
.btm_image{
    font-size: 20px;
    FONT-WEIGHT: 550;
    margin: 5px;
    color: #fff;
    padding: 5px 15px;
    border-radius: 25px;
}
</style>
<jsp:include page="./joinModal.jsp" />
  <nav class="navbar navbar-expand-lg shadow-sm border-bottom sticky-sm-top bg-white" style=" height: 130px; padding: 0 40px; ">
    <div class="container-fluid ">
      <a  href="${context}/"><img src = "${context}/img/붕어빵라이언누끼.png"  width="100" height="100"/></a>
      <a class="navbar-brand" href="${context}/" style="font-size: 25px; FONT-WEIGHT: 550; padding: 25px 25px 25px 0px;">프랜차이즈   </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent" >
           <ul class="navbar-nav me-auto mb-2 mb-lg-0">
             <li class="nav-item dropdown">
               <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">
                 메뉴
               </a>
               <ul class="dropdown-menu">
                 <li><a class="dropdown-item" href="${context}/prdt/list2">전체보기</a></li>
   <%--               <c:choose> --%>
   <%--             <c:when test="${not empty srtList}"> --%>
   <%--                <c:forEach items="${srtList}" --%>
   <%--                         var="srt"> --%>
   <%--                   <li><a class="dropdown-item" href="${context}/prdt/list2?prdtSrt=${srt.cdId}"> --%>
   <%--                      ${srt.cdNm} --%>
   <!--                   </a></li> -->
   <%--                </c:forEach> --%>
   <%--             </c:when> --%>
   <%--          </c:choose> --%>
               <li><a class="dropdown-item" href="${context}/prdt/list2?prdtSrt=004-01">메인메뉴</a></li>
               <li><a class="dropdown-item" href="${context}/prdt/list2?prdtSrt=004-02">사이드메뉴</a></li>
               <li><a class="dropdown-item" href="${context}/prdt/list2?prdtSrt=004-03">음료</a></li>
   
   <!--               <li><a class="dropdown-item" href="#">전체보기</a></li> -->
   <!--               <li><a class="dropdown-item" href="#">메인메뉴</a></li> -->
               </ul>
             </li>
             <li class="nav-item dropdown">
               <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">
                 매장
               </a>
               <ul class="dropdown-menu">
                 <li><a class="dropdown-item" href="${context}/str/customer">매장찾기</a></li>
               </ul>
             </li>
             <li class="nav-item dropdown">
               <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">
                 이벤트
               </a>
               <ul class="dropdown-menu">
                 <li><a class="dropdown-item" href="${context}/evnt/ongoingList">이벤트목록</a></li>
               </ul>
             </li>
             <li class="nav-item dropdown">
               <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 25px; FONT-WEIGHT: 550;  padding:25px; padding-top: 45px; HEIGHT: 130PX;">
                 리뷰
               </a>
               <ul class="dropdown-menu">
                  <li class="dropdown-item">
                     <c:choose>
                     <c:when test ="${sessionScope.__MBR__.mbrLvl eq '001-04'}">
                        <a href="${context}/mbr/rv/list">리뷰</a>
                     </c:when>
                     <c:otherwise>
                        <a href="${context}/user/rv/list">리뷰</a>
                     </c:otherwise>
                  </c:choose>
               </li>
               </ul>
             </li>

           </ul>
           <div style="margin-right:20px;">
           <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
               <a class="nav-link-right" style=" background-color: #d72300;" href="${context}/prdt/list2" >주문하기</a>
            </li>
            <li class="nav-item">
               <a class="nav-link-right" style=" background-color: #502416;" href="${context}/hr/hrindex" >채용 문의</a>
            </li>
            <li class="nav-item">
                  <a class="nav-link-right" style="background-color: #ffbe2e;" href="${context}/hlpdsk/list_user">고객센터</a>
            </li>
           </ul>
           </div>
           <div style=" width: 40px;">
            <input type="checkbox" id="menuicon">
            <label for="menuicon">
               <span></span>
               <span></span>
               <span></span>
            </label>
            <div class="sidebar">
               <ul class="sitemap-ul">
                  <li><a href="${context}/prdt/list2" class="fs-4 fw-bold">메뉴</a>
                     <ul>
                        <li><a href="${context}/prdt/list2?prdtSrt=004-01" class="fs-6 fw-bold">메인메뉴</a></li>
                        <li><a href="${context}/prdt/list2?prdtSrt=004-02" class="fs-6 fw-bold">사이드메뉴</a></li>
                        <li><a href="${context}/prdt/list2?prdtSrt=004-03" class="fs-6 fw-bold">음료</a></li>
                     </ul>
                  </li>
                  <li><a href="#" class="fs-4 fw-bold">매장</a>
                     <ul>
                        <li><a href="#" class="fs-6 fw-bold">매장찾기 </a></li>
                     </ul>
                  </li>
                  <li><a href="#" class="fs-4 fw-bold">이벤트</a>
                     <ul>
                        <li><a href="${context}/evnt/ongoingList" class="fs-6 fw-bold">이벤트</a></li>
                     </ul>
                  </li>
                  
                  <li class="fs-4 fw-bold">리뷰
                     <ul>
                        <li class="fs-6 fw-bold">
                              <c:choose>
                              <c:when test ="${sessionScope.__MBR__.mbrLvl eq '001-04'}">
                                 <a href="${context}/mbr/rv/list">리뷰</a>
                              </c:when>
                              <c:otherwise>
                                 <a href="${context}/user/rv/list">리뷰</a>
                              </c:otherwise>
                           </c:choose>
                        </li>
                     </ul>
                  </li>
               </ul>
            </div>         
         </div>
         <div class="dropdown text-end" style="margin-left: 20px;">
          <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
            <img  src="${context}/img/logout.png" width="50" height="50">
          </a> 
          <c:if test="${not empty sessionScope.__MBR__ }">
          	<small class="fw-semibold" style="position: fixed; right: 62px;">${sessionScope.__MBR__.mbrNm}님</small>
          </c:if>
          <ul class="dropdown-menu text-small profile" style="position: absolute;inset: 0px 0px auto auto;margin: 0px;transform: translate(10px, 70px);">
            <c:if test="${not empty sessionScope.__MBR__ }">
            	<li><a class="dropdown-item" href="#">${sessionScope.__MBR__.mbrNm}</a></li>
	            <li><a class="dropdown-item" href="${context}/mbr/pwdCheck">프로필</a></li>
            	<li><a class="dropdown-item" href="${context}/odrlst/list" >주문목록</a></li>
	            <li><hr class="dropdown-divider"></li>
            </c:if>
            <li style="text-align: center;">	
				<c:choose>
					<c:when test="${not empty sessionScope.__MBR__ }">
					    <a href="${context}/mbr/logout" class="btm_image" id="img_btn_logout" style=" background-color: #d72300;">로그아웃</a> 
					</c:when>
					<c:otherwise>
					    <button class="btm_image" id="img_btn" data-bs-toggle="modal" data-bs-target="#loginModal" style=" background-color: #ffbe2e;;" >로그인</button>  
					</c:otherwise>
				</c:choose>
            </li>
          </ul>
        </div>
        
<%--            <div style="padding: 5px; margin:20px;">
              <c:choose>
                 <c:when test="${not empty sessionScope.__MBR__ }">
                     <a href="${context}/mbr/logout" class="btm_image" id="img_btn_logout" style=" background-color: #d72300;">로그아웃</a> 
                 </c:when>
                 <c:otherwise>
                     <button class="btm_image" id="img_btn" data-bs-toggle="modal" data-bs-target="#loginModal" style=" background-color: #ffbe2e;;" >로그인</button>  
                 </c:otherwise>
              </c:choose>
           </div> --%>
        </div>
    </div>
  </nav>