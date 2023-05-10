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
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<jsp:include page="../include/stylescript.jsp"/>

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		$("#list_btn").click(function() {
			location.href="${context}/mngrbrd/list";
		});
		
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
				htmls += '<textarea class="rpltextarea form-control" style="resize:none; width:40%;" placeholder="댓글을 입력하시오." name="rplCntnt" id="'+ rplId+'">';
				htmls += replace.text();
				htmls += '</textarea>';
				htmls += '<button class="rpl_update_y" style="height: 80px;width: 50px; margin-left: 5px;" value ="'+rplId+'">수정</button>'
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.message); */
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + "/" + response.message); */
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.errorCode + "/" + response.message); */
				}
			})
		});
		
		$(".black-rpl-btn").click(function(){
			
			var div = $(this).closest("div.rplbtn")
			console.log(div);
			console.log($('.create_rpl_form').length);			
			
			if($('.create_rpl_form').length == 0 ){ 
				var reRplForm = $("<form class='create_rpl_form rpl_box rounded shadow-sm' style='padding: 10px; background-color: #e0e0e0; margin-top: 10px;'>" 
								+ "<input type='hidden' class='altclId' name='altclId' value='${mngrBrd.mngrBrdId}'' />" 
								+ "<input type='hidden' class='rplPrntRpl form-control'name='rplPrntRpl' value='"+ $(this).data('value')+"'/></form>");
				var input = $("<textarea name='rplCntnt' class='rplCntnt form-control' style='resize:none; margin-top: 10px;' placeholder='댓글을 입력하시오.'></textarea>"
							+ "<div style='margin-top: 10px; display: flex;justify-content: center;'><button class='btn btn-primary new_btn' style='background-color: #1e51a2; padding:7px 10px 7px 10px;'>댓글등록</button></div>");
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
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.message); */
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
		
		
		$("#new_btn").click(function(){
			$.post("${context}/api/mngrbrd/rpl/create", $("#create_form").serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else if (response.status =="400"){
					//파라미터를 전달하지 않은 경우
					console.log(response.message);
					Swal.fire({
				    	  icon: 'error',
				    	  title: response.message,
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert(response.message); */
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
		/* var simplemde = new SimpleMDE({ element: $("#cntnt")[0],
										initialPreviewMode: true,
		});
		var mdString = "${mngrBrd.mngrBrdCntnt}";
		console.log(marked.parse(mdString)); */
		
		
		var url;
		$(".open-layer").click(function(event) {
			var mbrId = $(this).attr('val');
			$("#layer_popup").css({
				"padding": "5px",
				"top": event.pageY,
				"left": event.pageX,
				"backgroundColor": "#FFF",
				"position": "absolute",
				"border": "solid 1px #222",
				"z-index": "10px"
			}).show();
			if (mbrId == '${sessionScope.__MBR__.mbrId}') {
				url = "cannot"
			} else {
				url = "${context}/nt/ntcreate/" + mbrId
			}
		});
		
		$(".send-memo-btn").click(function() {
			if (url !== "cannot") {
				location.href = url;
			} else {
				Swal.fire({
			    	  icon: 'error',
			    	  title: '자신에게는 쪽지를<br>보낼 수 없습니다.',
			    	  showConfirmButton: true,
			    	  confirmButtonColor: '#3085d6'
				});
			}
		});
		$('body').on('click', function(event) {
			if (!$(event.target).closest('#layer_popup').length) {
				$('#layer_popup').hide();
			}
		});
		$(".close-memo-btn").click(function() {
			url = undefined;
			$("#layer_popup").hide();
		});
		
	});
</script>
<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
} 

</style>
</head>
<jsp:include page="../include/openBody.jsp" />
			<div class="bg-white rounded shadow-sm  " style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">	
				<span class="fs-5 fw-bold">관리자게시판 > 상세페이지</span>
				<div style="position: absolute;right: 0;top: 0; margin: 20px;">
					 <button id="list_btn" class="btn btn-secondary" >목록</button>
				</div>
		    </div>
		    <div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
				<!-- 상세화면 헤더 -->
	
				<div style="text-align: right;">
					<div class="article-action">			
						<c:if test="${mbrVO.mbrId eq mngrBrd.mngrId}">	
							<a href="${context}/mngrbrd/update/${mngrBrd.mngrBrdId}"  class="btn btn-default btn-outline-primary" style="text-decoration: none;">수정하기</a>
						</c:if>
						<c:if test="${mbr.mbrLvl eq '001-01' || mbrVO.mbrId eq mngrBrd.mngrId}">
							<button id="delete_btn" class="btn btn-default btn-outline-danger">삭제</button> 
						</c:if>		
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
								        <div class="etc-data ellipsis"  onclick="event.cancelBubble=true">
								        	<a class="open-layer" href="javascript:void(0);" val="${mngrBrd.mbrVO.mbrId}">${mngrBrd.mbrVO.mbrNm}</a>
								        </div>	
								    </div> 
								</div>
					        </div>	
					    </div>
					</header>
					</div>
					<article class="detailview-article">												
					    <textarea style="width: 100%; overflow-x: auto; overflow-y: hidden; border: none; resize:none;     background-color: #fff;" 
					    		class="contentsDiv"
					    		disabled>${mngrBrd.mngrBrdCntnt}</textarea>
					    <div class="pop-lay-col2"> 
					        <!-- Comment -->
				            <div>           
					            <div>
					            	<div class="rplBox">
										<form id="create_form" >
											<input type="hidden" id="altclId" name="altclId" value="${mngrBrd.mngrBrdId}" />
											
											<input type="hidden" name="rplPrntRpl" value="" />
											
											<div style="margin-top: 10px; display: flex;"> 
												<textarea class="rpltextarea form-control" style="resize:none; " placeholder="댓글을 입력하시오." name="rplCntnt" id="rplCntnt"></textarea>
											</div>
										</form>
										<div style="display: flex;justify-content: center; margin: 10px; ">
											<button id="new_btn" class="btn-primary btn" style="background-color: #1e51a2; padding: 7px 10px 7px 10px;">댓글등록</button>		
										</div>
									</div>
										<c:choose>
											<c:when test="${not empty mngrBrd.rplList && not empty mngrBrd.rplList.get(0).rplId}" >
												<div class="rplBox">
													<ul class="rpl-box">							 
														<c:forEach items="${mngrBrd.rplList}" var="rpl" varStatus="index"> 
															<div class="rplymember rounded shadow-sm" style="border: 1px solid #e0e0e0; padding: 10px; margin-left: ${rpl.depth*50}px">
															<c:if test="${sessionScope.__MBR__.mbrLvl eq '001-01'}">
																<input type="hidden" id="rplId" name="rplId" value="${rpl.rplId}" />	
																<input type="hidden" id="altclId" name="altclId" value="${mbrVO.mbrNm}" />												
																<li class="rpl-one fw-normal" style="float: right;"><small>${rpl.rplWrtDt eq rpl.mdfyDt ? rpl.rplWrtDt : rpl.mdfyDt}
																${rpl.rplWrtDt eq rpl.mdfyDt ? '' : '(수정됨)'}</small></li>								 	
																<li class="rpl-one fw-bolder ellipsis" style="margin: 10px 0;" onclick="event.cancelBubble=true">
																	<a class="open-layer" href="javascript:void(0);" val="${rpl.mbrVO.mbrId}">${rpl.mbrVO.mbrNm}</a>
																</li>
																<li class="replace" id="cntnt" style="${rpl.delYn eq 'Y' ? 'color: #f00' : ''}; margin: 10px;"> ${rpl.rplCntnt } ${rpl.delYn eq 'Y' ? '[이미 삭제된 댓글입니다.]<br>' : ''}</li>
																<div class="rplbtn">
																	<button data-value="${rpl.rplId}" class="black-rpl-btn">댓글달기</button>
																	<c:if test="${mbrVO.mbrId eq rpl.mbrId  && rpl.delYn eq 'N'}">	
																		<button value="${rpl.rplId}" class="blue-rpl-btn">수정 </button>
																	</c:if>						
																	<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrId eq rpl.mbrId}">
																		<button value="${rpl.rplId}" class="red-rpl-btn">삭제</button>		
																	</c:if>	
																</div>	
															
															</c:if>	
															<c:if test="${sessionScope.__MBR__.mbrLvl eq '001-02'}">
																<input type="hidden" id="rplId" name="rplId" value="${rpl.rplId}" />	
																<input type="hidden" id="altclId" name="altclId" value="${mbrVO.mbrNm}" />												
																<li class="rpl-one fw-normal" style="float: right;">${rpl.rplWrtDt eq rpl.mdfyDt ? rpl.rplWrtDt : rpl.mdfyDt}
																${rpl.rplWrtDt eq rpl.mdfyDt ? '' : '(수정됨)'}</li>								 	
																<li class="rpl-one fw-bolder ellipsis" style="margin: 10px 0;" onclick="event.cancelBubble=true">
																	<a class="open-layer" href="javascript:void(0);" val="${rpl.mbrVO.mbrId}">${rpl.mbrVO.mbrNm}</a>
																</li>
																<li class="replace" id="cntnt" style="${rpl.delYn eq 'Y' ? 'color: #f00' : ''};">${rpl.delYn eq 'Y' ? '이미 삭제된 댓글입니다. ' : rpl.rplCntnt}</li>
																<div class="rplbtn">
																	<button data-value="${rpl.rplId}" class="black-rpl-btn">댓글달기</button> 
																	<c:if test="${mbrVO.mbrId eq rpl.mbrId}">	
																		<button value="${rpl.rplId}" class="blue-rpl-btn">수</button>
																	</c:if>						
																	<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrId eq rpl.mbrId}">
																		<button value="${rpl.rplId}" class="red-rpl-btn">삭제</button>		
																	</c:if>	
																</div>
															</c:if>
															</div>
														</c:forEach>								
													</ul>
												</div>	
											</c:when>
											<c:otherwise>
								                <table  style="margin:20px; ">
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
			
	<!-- layer-popup -->
		<div class="layer_popup" id="layer_popup" style="display: none;">
			<div class="popup_box">
				<div class="popup_content">
					<a class="send-memo-btn" href="javascript:void(0);">
						<i class='bx bx-mail-send' ></i>쪽지 보내기</a>
				</div>
				<div>
					<a class="close-memo-btn" href="javascript:void(0);">
						<i class='bx bx-x'></i>닫기</a>
				</div>
			</div>
		</div>
			
<jsp:include page="../include/closeBody.jsp" />
</html>