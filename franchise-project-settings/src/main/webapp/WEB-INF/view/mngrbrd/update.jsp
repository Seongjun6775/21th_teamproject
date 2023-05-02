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
<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		$("#list_btn").click(function() {
			location.href="${context}/mngrbrd/list";
		});
		
		$("#fix_btn").click(function(){
			//수정
			var mngrId = $(this).val(); 
			console.log(mngrId);
			$.post("${context}/api/mngrbrd/update/${mngrBrd.mngrBrdId}",$("#create_form").serialize()
					,function(response){
				if(response.status =="200 OK"){
					var url= '${context}/mngrbrd/${mngrBrd.mngrBrdId}'
					//console.log(url);
					location.replace(url);
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}	
			});
	    
		});

		
	
	});
</script>


</head>
<jsp:include page="../include/openBody.jsp" />	
			<div class="bg-white rounded shadow-sm  " style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">	
				<span class="fs-5 fw-bold">관리자게시판 > 상세페이지 > 수정</span>
				<div style="position: absolute;right: 0;top: 0; margin: 20px;">
					 <button id="list_btn" class="btn btn-secondary" >목록</button>
				</div>
		    </div>	
			<div class="bg-white rounded shadow-sm" style="padding: 40px 18px 23px 35px; overflow: auto;  margin:20px;">
				<div class="fs-3 fw-bolder" style="margin-left: 10px;">수정하기</div>
				<form id="create_form" >
						<div class="header-option-right">
							<div class="create-group form-check-label" style="display: inline-block;">		
								게시여부<input type="checkbox" id="useYn" name="useYn"  value="Y" ${mngrBrd.useYn =='Y' ? 'checked' : ''}/>
							</div>
							<div class="create-group form-check-label" style="display: inline-block;">
								공지여부<input type="checkbox" id="ntcYn" name="ntcYn" value="Y" ${mngrBrd.ntcYn =='Y' ? 'checked' : ''} />
							</div>
						</div>	
					<div class="create-group">
						<label for="mngrBrdTtl" class="label"  style="margin: 5px;">제목</label> 
						<input type="text" id="mngrBrdTtl" name="mngrBrdTtl" class="form-control" placeholder="제목을 입력해주세요." value="${mngrBrd.mngrBrdTtl} " />
					</div>
							
					 
					<input type="hidden" id="mngrId" name="mngrId" value="${mngrBrd.mngrId}" />
								
					
					<div class="create-group">
						<label for="mngrBrdCntnt" class="label"  style="margin: 5px;">본문</label> 
						<textarea  id="mngrBrdCntnt" name="mngrBrdCntnt" class="form-control" placeholder="내용을 입력해주세요." style ="resize:none;" >${mngrBrd.mngrBrdCntnt}</textarea>
					</div>
					

				</form>
			
			
				
				<div style="padding: 10px;text-align: right;"> 
					<button id="fix_btn" class="btn btn-primary">수정</button>
					<a href="${context}/mngrbrd/${mngrBrd.mngrBrdId}" class="btn btn-danger" style="text-decoration: none;">취소</a>		
				</div> 					
			</div>
<jsp:include page="../include/closeBody.jsp" />
</html>