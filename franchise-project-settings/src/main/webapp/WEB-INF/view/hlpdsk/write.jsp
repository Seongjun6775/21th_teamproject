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
			location.href="${context}/hlpdsk/list";
		});
		$("#new_btn").click(function(){	
			$.post("${context}/api/hlpdsk/write", $("#create_form").serialize(),function(response){
				if(response.status =="200 OK"){
					var url= '${context}/hlpdsk/list'
					location.replace(url);	
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
<jsp:include page="../include/openBody.jsp" />
			<div class="bg-white rounded shadow-sm" style="position: relative; padding: 23px 18px 23px 18px; margin: 20px;">
		        <span class="fs-5 fw-bold">고객센터 > 문의/건의</span>
		        <div style="position: absolute;right: 0;top: 0; margin: 20px;">
				  <button id="list_btn" class="btn btn-secondary" >목록</button>
		        </div>
	      	</div>
			<!-- //상세화면 헤더 -->
			<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; overflow: auto;  margin:20px;">
				<h2 class="fw-bold" style="margin: 20px;">작성</h2>
				<div>
					<form id="create_form" >
							<div style="display: flex;flex-direction: row-reverse;"> 
								<select id="hlpDskSbjct" name="hlpDskSbjct" class="input-text form-select" style="width: 10%;">
									<option value="">선택</option>
									<option value="문의하기">문의하기</option>				
									<option value="건의하기">건의하기</option>
								</select> 
								<span style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">글 분류</span>
							</div>
						<div class="create-group"> 
							<input type="hidden" id="mbrId" name="mbrId" value="${mbrId}" />
						</div>	
						 
						<div class="create-group">
							<label for="mngrBrdTtl" class="label" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e;">제목</label> 
							<input type="text" id="mngrBrdTtl" name="hlpDskTtl" placeholder="제목을 입력해주세요." class="form-control"  value="" />
						</div>
						
						<div class="create-group">
							<label for="hlpDskCntnt" class="label" style="margin: 5px; padding-left: 8px; border-left: solid #ffbe2e; height: 47px;">본문</label> 
							<textarea  id="hlpDskCntnt" name="hlpDskCntnt" placeholder="내용을 입력해주세요." class="form-control"  style="resize: none;" >${hlpDsk.mngrBrdCntnt}</textarea>
						</div>
					<div style="padding: 10px;text-align: right;"> 
						<button id="new_btn" class="btn btn-primary">등록</button>
					</div> 					
					</form>	
				</div>
			</div>			
<jsp:include page="../include/closeBody.jsp" />
</html>