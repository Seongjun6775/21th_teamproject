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
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		$("#list_btn").click(function() {
			location.href="${context}/hlpdsk/list";
		});
		
		$("#delete_btn").click(function(){
			console.log("${hlpDsk.hlpDskWrtId}");
			var hlpDskWrtId = ("${hlpDsk.hlpDskWrtId}"); 
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			} 
			$.get("${context}/api/hlpdsk/delete/"+ hlpDskWrtId, function(response){
				if(response.status =="200 OK"){
					var url= '${context}/hlpdsk/list'
					location.replace(url); 
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + "/" + response.message); */
				}	
			});
	    
		}); 
	});
</script>
<style>
.qna-btn{
    font-size: 25px;
    FONT-WEIGHT: 550;
    margin: 10px;
    color: #fff;
    padding: 10px 25px;
    border-radius: 25px;
    background-color: #ffbe2e;
    text-align: center;
}
</style>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

		<div class="visualArea flex relative">
			<div class="content-setting title">고객센터</div>
			<div class="overlay absolute"></div>
		</div>
		<div id="menu" class="flex-column rounded" style="background-color:#adb5bd36;"> 
		<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
	        <span class="fs-5 fw-bold"> 고객센터 > 문의/건의</span>
	        <div style="position: absolute;right: 0;top: 0; margin: 20px;">
			  <button id="list_btn" class="btn btn-secondary" >목록</button>
	        </div>
	    </div>
		<div>
			<!-- 게시판 콘텐츠 -->		
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<header class="detailview-header">
			    <div class="detailview-header-area">
			    	<div style="float:right;">
			    		<c:if test="${mbrVO.mbrLvl eq '001-01'}"> 
							<button id="delete_btn"class="btn btn-outline-danger btn-default">삭제</button> 
						</c:if>
			    	</div>
			        <div class="detailview-header-left" style="background-color: #fff;">
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
			
			<article class="detailview-article">											
			    <textarea style="width: 100%; overflow-x: auto; overflow-y: hidden; border: none; resize:none;     background-color: #fff;" 
				    		class="contentsDiv"
				    		disabled>${hlpDsk.hlpDskCntnt}</textarea>
			</article>
			</div>
		</div>
		<c:if test="${hlpDsk.hlpDskPrcsYn eq 'Y'}">	
			<div 	>
				<!-- 게시판 콘텐츠 -->		
				<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
				<header class="detailview-header">
				    <div class="detailview-header-area">
				        <div class="detailview-header-left" style="background-color: #fff;">
				        	<div class="list-title">답변완료</div> 
	
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
			<div class="bg-white rounded shadow-sm fs-6" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
				답변대기중입니다.		
			</div>
		</c:if>
		<c:if test="${hlpDsk.hlpDskPrcsYn eq 'N' && sessionScope.__MBR__.mbrLvl ne '001-04'}">
			<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<form id="create_form" >
					<div class="qna_box row rounded" style="background: #adb5bd8a;padding:20px;" >
						<button class="qna-btn" id="fix_btn" style="width:70%;">답변하기</button>
					
					<input type="hidden" id="mstrId" name="mstrId" value="${sessionScope.__MBR__.mbrId}" />
					<div>
						<textarea id="hlpOkCntnt" name="hlpOkCntnt" placeholder="답변을 입력해주세요." class="qna-text form-control"></textarea>
					</div>
					</div>	
				</form>	
			</div>
		</c:if>
	</div>
<jsp:include page="../include/footer_user.jsp" />
</html>