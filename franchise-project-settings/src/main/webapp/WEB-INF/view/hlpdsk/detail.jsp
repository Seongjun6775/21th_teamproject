<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		$("#fix_btn").click(function(){
			//수정
			var mngrId = $(this).val(); 
			console.log(mngrId);
			$.post("${context}/api/hlpdsk/update/${hlpDsk.hlpDskWrtId}",$("#create_form").serialize()
					,function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}	
			});
	    
		}); 
	});
</script>
</head>
<body>
	<div class="main-layout" >
	<jsp:include page="../include/header.jsp" />
		<div>
		<jsp:include page="../include/sidemenu.jsp" />
		<jsp:include page="../include/content.jsp" />
			<div>
			<!-- 상세화면 헤더 -->
				<div class="header-option-bar">
					<div class="header-option-right">
						<div class="article-action">			
							<a href="${context}/hlpdsk/list" class="btn-m" style="text-decoration: none;">목록</a> 
						</div>
					</div>
				</div>
			</div>
			<!-- //상세화면 헤더 -->
			<div>
				<!-- 게시판 콘텐츠 -->		
				<div>
				<header class="detailview-header">
				    <div class="detailview-header-area">
				        <div class="detailview-header-left">
				                    <p class="list-title">${hlpDsk.hlpDskTtl}</p>
				            <!-- 추가 정보 -->
							<div class="etc">
							    <div class="etc-table">
							        <div class="etc-dt">등록일</div> 
							        <div class="etc-data">
							            ${hlpDsk.hlpDskWrtDt}  
							        </div>
							        <div class="etc-user">작성자 </div>
							        <div class="etc-data">${hlpDsk.mbrVO.mbrNm}</div>	
							    </div> 
							</div>
				        </div>	
				    </div>
				</header>
				</div>
				<article class="detailview-article">												
				    <div style="overflow-x:auto;overflow-y:hidden; border-bottom: solid 1px;" 
				    	class="contentsDiv">
				        ${hlpDsk.hlpDskCntnt}
				    </div>

				</article>
			</div>
			<c:if test="${hlpDsk.hlpDskPrcsYn eq 'Y'}">	
				<div 	>
					<!-- 게시판 콘텐츠 -->		
					<div class="qna-cntnt">
					<header class="detailview-header">
					    <div class="detailview-header-area">
					        <div class="detailview-header-left">
					        	<div class="qna-font">답변완료</div> 

					            <!-- 추가 정보 -->
								<div class="etc">
								    <div class="etc-table">
								        <div class="etc-dt">등록일</div> 
								        <div class="etc-data">
								            ${hlpDsk.hlpDskPrcsDt}  
								        </div>
								        <div class="etc-user">작성자 </div>
								        <div class="etc-data">${hlpDsk.mstrVO.mbrNm}</div>	
								    </div> 
								</div>
					        </div>	
					    </div>
					</header>
					<article class="detailview-article">												
					    <div style="overflow-x:auto;overflow-y:hidden;" class="contentsDiv">
					       ${hlpDsk.hlpOkCntnt}
					    </div>
					</article>
					</div>

				</div>
			</c:if>
			<c:if test="${hlpDsk.hlpDskPrcsYn eq 'N'&& sessionScope.__MBR__.mbrLvl eq '001-04'}">
				<div class="wait-box"  >
					답변대기중입니다.		
				</div>
			</c:if>
			<c:if test="${hlpDsk.hlpDskPrcsYn eq 'N' && sessionScope.__MBR__.mbrLvl ne '001-04'}">
				<form id="create_form" >
					<div class="qna_box row" style="background: #ffffff;" >	
						<button class="qna-btn" id="fix_btn" style="width:70%;">답변하기</button>
					</div>
					<input type="hidden" id="mstrId" name="mstrId" value="${sessionScope.__MBR__.mbrId}" />
					<div>
						<textarea id="hlpOkCntnt" name="hlpOkCntnt" placeholder="답변을 입력해주세요." class="qna-text"></textarea>
					</div>	
				</form>	
			</c:if>
			
			
		</div>	
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>
</html>