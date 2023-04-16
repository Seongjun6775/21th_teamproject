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
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		$("#delete_btn").click(function(){
			var mngrBrdId = $("#mngrBrdId").val();
			console.log(mngrBrdId);
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			} 
			$.get("${context}/api/mngrbrd/delete/"+ mngrBrdId, function(response){
				if(response.status =="200 OK"){
					var url= '${context}/mngrbrd/list'
					location.replace(url);
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
		
		$("#new_btn").click(function(){
			console.log("!!");
		
			$.post("${context}/api/mngrbrd/rpl/create", $("#create_form").serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else if (response.status =="400"){
					//파라미터를 전달하지 않은 경우
					console.log(response.message);
					alert(response.message);
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
		<div>
		<!-- 상세화면 헤더 -->
			<div class="header-option-bar">
				<div class="header-option-right">
					<div class="article-action">
						<button id="delete_btn" class="red-btn">삭제</button> 			
						<a href="${context}/mngrbrd/update/${mngrBrd.mngrBrdId}"  class="btn-m" style="text-decoration: none;">수정하기</a>
						<a href="${context}/mngrbrd/list" class="btn-m" style="text-decoration: none;">목록</a> 
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
			                    <p class="list-title">${mngrBrd.mngrBrdTtl}</p>
			            <!-- 추가 정보 -->
						<div class="etc">
						    <div class="etc-table">
						        <div class="etc-dt">등록일 </div> 
						        <div class="etc-data">
						            ${mngrBrd.mngrBrdWrtDt}    
						        </div>
						        <div class="etc-user">작성자 </div>
						        <div class="etc-data">${mngrBrd.mngrId}</div>	
						    </div> 
						</div>
			        </div>

			    </div>
			</header>
			</div>
			<article class="detailview-article">												
			    <div style="overflow-x:auto;overflow-y:hidden;" class="contentsDiv">
			        ${mngrBrd.mngrBrdCntnt}
			    </div>
			    <div class="pop-lay-col2">
			        <!-- Comment -->
		            <div id="rplBox" class="rplBox">
			            <div id="CommentListBox">			                
							<form id="create_form" >
								<input type="hidden" name="mngrBrdId" value="${mngrBrdVO.mngrBrdId}" />
								<input type="hidden" name="rplPrntRpl" value="0" />
								
								<div style="margin-top: 10px; display: flex;">
									<label for="rpl" style="margin: 10px;">댓글쓰기</label> 
									<textarea name="rpl" id="rpl"></textarea>
								</div>
							</form>
								<div style="padding: 10px;text-align: right;"> 
								<button id="new_btn" class="blue-btn">등록</button>
							</div> 	
							<ul>
								<c:forEach items="${topic.replyList}" var="reply">
									<li>${reply.reply}</li>
								</c:forEach>
							</ul>
							
							<hr/>
			                 
			                
			                <table  style="margin-left:20px;">
			                    <tbody>
				                    <tr>
				                        <td>등록된 댓글이 없습니다.</td>
				                    </tr>
			                	</tbody>
			            	</table>
			        	</div>
			        </div>
			        <!-- //Comment -->
			    </div>
			</article>
			<div>
				
			</div>
				
		</div>
			
		
		
		
		
	</div>


</body>
</html>