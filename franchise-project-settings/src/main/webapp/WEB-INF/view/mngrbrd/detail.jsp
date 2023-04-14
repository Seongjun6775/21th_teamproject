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
	});
</script>
</head>
<body>
	<div class="main-layout">
		<div>
		<!-- 상세화면 헤더 -->
			<div class="header-option-bar">
				<div class="header-option-right">
					<div class="article-action">			
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