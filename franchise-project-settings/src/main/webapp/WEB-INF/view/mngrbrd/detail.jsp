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
		
		$(".blue-rpl-btn").click(function(){

			var rplId = $(this).val(); 
			
			console.log(rplId);
			console.log($('.update_rpl_form').length);
			
			var div = $(this).closest("div.rplbtn")
			console.log(div);
			
			if($('.update_rpl_form').length == 0 ){
				var rplymbr = div.closest('.rplymember');
				var replace = rplymbr.find(".replace");
				var rplId = rplymbr.children('#rplId').val();
				
				var htmls = "";
				htmls += '<form class="update_rpl_form" >';
				htmls += '<div style="margin-top: 10px; display: flex;">';
				htmls += '<textarea class="rpltextarea" placeholder="댓글을 입력하시오." name="rplCntnt" id="'+ rplId+'">';
				htmls += replace.text();
				htmls += '</textarea>';
				htmls += '<button class="rpl_update_y" value ="'+rplId+'">수정</button>'
/* 				htmls += '<button class="rpl_update_n" value ="'+rplId+'">취소</button>' */
				htmls += '</div>';
				htmls += '</form>'
				//replace.replaceWith(htmls);
					replace.after($(htmls));
					replace.hide();
					$(htmls).focus();
			} 
			else{  
				var rplymbr = div.closest('.rplymember');
				var replace = rplymbr.find(".replace");
				var rplId = rplymbr.children('#'+rplId).val();
				var rplCntnt = rplymbr.children('#cntnt').text();
				replace.show();
				$('.update_rpl_form').remove();
			}
			
		});
		$("div.rplymember").on("click",".rpl_update_y",function(){
			var rplId = $(this).val();
			var div = $(this).closest("div.rplymember");
			$.post("${context}/api/mngrbrd/rpl/update/"+ rplId, $(".update_rpl_form").serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else if (response.status =="400"){
					//파라미터를 전달하지 않은 경우
					alert(response.message);
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		/* $("div.rplymember").on("click",".rpl_update_n",function(){
			alert("!");
			var rplymbr = div.closest('.rplymember');
			var replace = rplymbr.find(".replace");
			var rplCntnt = rplymbr.children('#cntnt').text();
			replace.show();
			$('.update_rpl_form').remove();
		}); */
		
		
		$("#delete_btn").click(function(){
			console.log("${mngrBrd.mngrBrdId}");
			var mngrBrdId = ("${mngrBrd.mngrBrdId}");
			
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
		
		$(".red-rpl-btn").click(function(){ 
			var rplId = $(this).val(); 
			console.log(rplId);
			
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			} 
			$.get("${context}/api/mngrbrd/rpl/delete/"+ rplId, function(response){
				if(response.status =="200 OK"){
					location.reload();
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
		
		$(".black-rpl-btn").click(function(){
			
			var div = $(this).closest("div.rplbtn")
			console.log(div);
			console.log($('.create_rpl_form').length);			
			
			if($('.create_rpl_form').length == 0 ){
				var reRplForm = $("<form class='create_rpl_form' >" + "<input type='hidden' class='altclId' name='altclId' value='${mngrBrd.mngrBrdId}'' />"
						+ "<input type='hidden' class='rplPrntRpl' name='rplPrntRpl' value='"+ $(this).data('value')+"'/> </form>");
				var input = $("<textarea name='rplCntnt' class='rplCntnt'></textarea>"
							+ "<button class='blue-btn new_btn' >등록</button>");
				reRplForm.append(input);
				div.after(reRplForm);
			}	
			else{
				$('.create_rpl_form').remove();
			}
		
			
		});
		
		$("div.rplBox").on("click",".new_btn",function(){
			$.post("${context}/api/mngrbrd/rpl/create", $(".create_rpl_form").serialize(),function(response){
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
		
		
		$("#new_btn").click(function(){
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
	<jsp:include page="../include/header.jsp" />
		<div>
		<jsp:include page="../include/sidemenu.jsp" />
		<jsp:include page="../include/content.jsp" />
			<div>
			<!-- 상세화면 헤더 -->
				<div class="header-option-bar">
					<div class="header-option-right">
						<div class="article-action">			
							<c:if test="${mbr.mbrLvl eq '001-01' || mbrVO.mbrId eq mngrBrd.mngrId}">
								<button id="delete_btn" class="red-btn">삭제</button> 
							</c:if>		
							<c:if test="${mbrVO.mbrId eq mngrBrd.mngrId}">	
								<a href="${context}/mngrbrd/update/${mngrBrd.mngrBrdId}"  class="btn-m" style="text-decoration: none;">수정하기</a>
							</c:if>
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
							        <div class="etc-dt">등록일</div> 
							        <div class="etc-data">
							            ${mngrBrd.mngrBrdWrtDt}${mngrBrd.mngrBrdWrtDt eq mngrBrd.mdfyDt ? '':'(수정됨)'}   
							        </div>
							        <div class="etc-user">작성자 </div>
							        <div class="etc-data">${mngrBrd.mbrVO.mbrNm}</div>	
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
			            <div>           
				            <div>
				            	<div class="rplBox">
									<form id="create_form" >
										<input type="hidden" id="altclId" name="altclId" value="${mngrBrd.mngrBrdId}" />
										
										<input type="hidden" name="rplPrntRpl" value="" />
										
										<div style="margin-top: 10px; display: flex;"> 
											<label for="rplCntnt" style="margin: 10px;">댓글쓰기</label> 
											<textarea class="rpltextarea" placeholder="댓글을 입력하시오." name="rplCntnt" id="rplCntnt"></textarea>
										</div>
									</form>
									<div class="rplbtn">	
										<button id="new_btn" class="blue-btn" >등록</button>		
									</div>
								</div>
									<c:choose>
										<c:when test="${not empty mngrBrd.rplList && not empty mngrBrd.rplList.get(0).rplId}" >
											<div class="rplBox">
												<ul class="rpl-box">							
													<c:forEach items="${mngrBrd.rplList}" var="rpl" varStatus="index"> 
														<div class="rplymember" style="border: 1px solid #e0e0e0; padding: 5px; margin-left: ${rpl.depth*50}px">
															<input type="hidden" id="rplId" name="rplId" value="${rpl.rplId}" />	
															<input type="hidden" id="altclId" name="altclId" value="${mbrVO.mbrNm}" />												
															<li class="rpl-one" style="margin-top: 10px;">${rpl.mbrVO.mbrNm}</li>
															<li class="rpl-one">${rpl.rplWrtDt eq rpl.mdfyDt ? rpl.rplWrtDt : rpl.mdfyDt}
															${rpl.rplWrtDt eq rpl.mdfyDt ? '' : '(수정됨)'}</li>
																							
															<li class="replace" id="cntnt" >${rpl.rplCntnt}</li>
															<div class="rplbtn">
																<button data-value="${rpl.rplId}" class="black-rpl-btn">댓글달기</button>
																<c:if test="${mbrVO.mbrId eq rpl.mbrId}">	
																	<button value="${rpl.rplId}" class="blue-rpl-btn">수정</button>
																</c:if>	
																<c:if test="${mbr.mbrLvl eq '001-01' || mbrVO.mbrId eq rpl.mbrId}">
																	<button value="${rpl.rplId}" class="red-rpl-btn">삭제</button>		
																</c:if>	
															</div>
														</div>
													</c:forEach>								
												</ul>
											</div>	
										</c:when>
										<c:otherwise>
							                <table  style="margin-left:20px; ">
							                    <tbody>
						                    		<tr>
						                    		 	<td>등록된 댓글이 없습니다.</td>
						                    		</tr> 
							                	</tbody>
							            	</table>
										</c:otherwise>
									</c:choose>
				        	</div>
				        </div>
				        <!-- //Comment -->
				    </div>
				</article>
			</div>	
		</div>	
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>
</html>