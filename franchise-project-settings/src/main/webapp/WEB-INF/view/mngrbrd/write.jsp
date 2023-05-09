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
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		/* var simplemde = new SimpleMDE({ element: $("#mngrBrdCntnt")[0],
										status: true,
										spellChecker: false,
										hideIcons: ["link", "image"]});
		
		$("#list_btn").click(function() {
			location.href="${context}/mngrbrd/list";
		}); */
		
		$("#new_btn").click(function(){	
			/* $("#mngrBrdCntnt").val(simplemde.value()); */
			$.post("${context}/api/mngrbrd/write", $("#create_form").serialize(),function(response){
				if(response.status =="200 OK"){
					
					var url= '${context}/mngrbrd/list'
						//console.log(url);
						location.replace(url);
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
		
	});
</script>
<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
} 
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
</head>
<jsp:include page="../include/openBody.jsp" />
			<div class="bg-white rounded shadow-sm  " style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">	
				<span class="fs-5 fw-bold">관리자게시판 > 작성</span>
				<div style="position: absolute;right: 0;top: 0; margin: 20px;">
					 <button id="list_btn" class="btn btn-secondary" >목록</button>
				</div>
		    </div>

			<div class="bg-white rounded shadow-sm" style="padding: 40px 18px 23px 35px; margin:20px;">
				<!-- <h2 class="fw-bold" style="margin: 20px;">작성</h2> -->
				<div>
					<form id="create_form" >
						<div class="header-option-right">
							<div class="create-group form-check-label" style="display: inline-block;">		
								게시여부<input type="checkbox" id="useYn" name="useYn"  value="Y" ${mngrBrd.useYn =='Y' ? 'checked' : ''}/>
							</div>
							<c:if test="${sessionScope.__MBR__.mbrLvl eq '001-01'}">
								<div class="create-group form-check-label" style="display: inline-block;">
									공지여부<input type="checkbox" id="ntcYn" name="ntcYn" value="Y" ${mngrBrd.ntcYn =='Y' ? 'checked' : ''} />
								</div>
							</c:if>
						</div>	
						
						<div class="create-group" style="flex-direction: column;">
							<label for="mngrBrdTtl" class="label" style="margin-left: 12px; padding-left: 8px; border-left: solid #ffbe2e;">제목</label> 
							<input type="text" id="mngrBrdTtl" class="form-control" name="mngrBrdTtl" placeholder="제목을 입력해주세요." value="${mngrBrd.mngrBrdTtl}" />
						</div>
								
						<div  class="create-group"> 
							<input type="hidden" id="mngrId" name="mngrId" value="${mngrBrd.mngrId}" />
						</div>			
						
						<div class="create-group" style="flex-direction: column;">
							<label for="mngrBrdCntnt" class="label" style=" margin-left: 12px; padding-left: 8px; border-left: solid #ffbe2e; height: 47px;">본문</label> 
							<textarea id="mngrBrdCntnt" name="mngrBrdCntnt"  placeholder="내용을 입력해주세요." class="form-control" style="resize:none;">${mngrBrd.mngrBrdCntnt}</textarea>
						</div>
					</form>	
					<div style="padding: 10px;text-align: right;"> 
						<button id="new_btn" class="btn btn-outline-primary btn-default">등록</button>
					</div> 					
				</div>
			</div>			
<jsp:include page="../include/closeBody.jsp" />
</html>