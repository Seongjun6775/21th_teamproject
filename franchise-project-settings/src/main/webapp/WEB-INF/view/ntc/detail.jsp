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
<link rel="stylesheet" href="${context}/css/ntc_common.css?p={date}" />
<script type="text/javascript">
	$().ready(function(){
		
		$(".grid > table > tbody > tr").click(function(){
			$("#isModify").val("true"); //수정모드
			 
			var data =$(this).data(); 
			$("#ntcId").val(data.ntcid);
			$("#mbrId").val(data.mbrid);
			$("#ntcRgstDt").val(data.ntcrgstdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			$("#ntcTtl").val(data.ntcttl);
			$("#ntcCntnt").val(data.ntccntnt);
			$("#ntcPrrt").val(data.ntcP-prrt);
			$("#ntcInqAth").val(data.ntcinqath);
			$("#useYn").prop("checked",data.useyn =="Y");
		});

		$("#new_btn").click(function(){
			$("#isModify").val("false"); //등록모드
			$("#mbrId").val("");
			$("#ntcRgstDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val("");
			$("#ntcTtl").val("");
			$("#ntcCntnt").val("");
			$("#ntcPrrt").val("");
			$("#ntcInqAth").val("");
			$("#useYn").prop("checked",false);
		});
		
		
		$("#delete_btn").click(function(){
			var ntcId = $("#ntcId").val();
			if(ntcId==""){
				alert("선택된 공지가 없습니다.");
				return;
			}
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			$.get("${context}/api/ntc/delete/" +ntcId, function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
		
		
		
		
		$("#save_btn").click(function(){
			//console.log($("#mbrNm").val())
			if( $("#isModify").val() =="false"){
	
				
				//신규등록
				$.post("${context}/api/ntc/create",{ntcTtl: $("#ntcTtl").val(),
													ntcCntnt: $("#ntcCntnt").val()
													useYn: $("#useYn:checked").val()} ,function(response){
					if(response.status =="200 OK"){
						location.reload(); //새로고침	
					}
					else {
						alert(response.errorCode + "/" + response.message);
					}
				});
		    }
			else{ 
				//수정
				$.post("${context}/api/ntc/update",{ntcTtl: $("#ntcTtl").val(),
													ntcCntnt : $("#ntcCntnt").val()
													useYn: $("#useYn:checked").val()} ,function(response){
					if(response.status =="200 OK"){
						location.reload(); //새로고침	
					}
					else {
						alert(response.errorCode + "/" + response.message);
					}	
				});
			}

		});
		
		
		$("#search-btn").click(function(){
			//전송.
			//입력 값.	
			var ntcId = $("#search-keyword").val();
			//URL 요청
			location.href = "${context}/ntc/list";
		});
		
		
	 /* 	$("#all_check").click(function() {
			movePage(0);	
		});  */
	 	
		$("#all_check").change(function() {
			//console.log($(this.prop("checked"));
			$(".check_idx").prop("checked",$(this).prop("checked"));
		});
			
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount =$(".check_idx:checked").length;
			console.log(count,checkCount)
			$("#all_check").prop("checked",count==checkCount);
		});
		
		$("#delete_all_btn").click(function(){
			var checkLen= $(".check_idx:checked").length;
			if(checkLen ==0){
				alert("삭제할 장르가 없습니다.");
				return;
			}
			
			var form =$("<form></form>")	
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='ntcId' value='" + $(this).val() + "'>")
			});

			$.post("${context}/api/ntc/delete",form.serialize(),function(response){
				if(response.status =="200 OK"){
					location.reload(); //새로고침	
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
	});
		
	function movePage(pageNo){
		//전송.w
		//입력 값
		//URL 요청
		location.href = "${context}/ntc/list";
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/content.jsp"/>
			   
				<div class="path"> 공지게시판 </div>
				<div class="search-group">
					<label for="search-keyword">공지ID</label>
					<input type="text" id="search-keyword" class="search-input" value="${ntcVO.ntcId}"/>
					
					<button class="btn-search" id="search-btn">검색</button>
				</div>
				
				
				<div class="grid">
					<div class="grid-count align-right">
						
					</div>
					<table>
						<thead>
							<tr>
								<th><input type = "checkbox" id ="all_check"/></th>
								<th>공지ID</th>
								<th>회원ID</th>
								<th>등록일</th>
								<th>수정자</th>
								<th>수정일</th>
								<th>제목</th>
								<th>내용</th>
								<th>우선순위</th>
								<th>조회권한</th>
								<th>삭제여부</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty ntcList}">
									<c:forEach items="${ntcList}"
											   var="ntc" >
										<tr data-ntcid="${ntc.ntcId}"
											data-mbrid="${ntc.mbrId}" 
											data-ntcrgstdt="${ntc.ntcRgstDt}"
											data-mdfyr="${ntc.mdfyr}"
											data-mdfydt="${ntc.mdfyDt}"
										    data-ntcTtl="${ntc.ntcTtl}" 
										    data-ntccntnt="${ntc.ntcCntnt}"
										    data-ntcprrt="${ntc.ntcPrrt}"
										    data-ntcinqath="${ntc.ntcInqAth}"
										    data-useyn="${ntc.useYn}" 
										    data-delyn="${ntc.delYn}"
										    >
											<td>
												<input type ="checkbox" class="check_idx" value="${ntc.ntcId}">
											</td>
											<td>${ntc.ntcId}</td>
											<td>${ntc.mbrId}</td>
											<td>${ntc.ntcRgstDt}</td>
											<td>${ntc.mdfyr}</td>
											<td>${ntc.mdfyDt}</td>
											<td>${ntc.ntcTtl}</td>
											<td>${ntc.ntcCntnt}</td>
											<td>${ntc.ntcPrrt}</td>
											<td>${ntc.ntcInqAth}</td>
											<td>${ntc.useYn}</td>
											<td>${ntc.delYn}</td>
											
										</tr>
										<tr>
								
											
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="9" class="no-items">
										등록자 관리자가 없습니다.
										</td>
									
									</tr>
								</c:otherwise>
							</c:choose>
						
						</tbody>
					</table>
					<div class="align-right mt-10">
						<button id="delete_all_btn" class="btn-delete">삭제</button>
					</div>
					<div class="pagenate">
						<ul>
							<c:set value = "${ntcList.size() > 0 ? ntcList.get(0).lastPage : 0}" var="lastPage"/>
							<c:set value = "${ntcList.size() > 0 ? ntcList.get(0).lastPage : 0}" var="lastGroup"/>
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(ntcVo.pageNo /10)}" integerOnly="true" />
							<c:set value ="${nowGroup*10}" var="groupStartPageNo" />
							<c:set value ="${groupStartPageNo+ 10}" var="groupEndPageNo" />
							<c:set value ="${groupEndPageNo > lastPage ? lastPage :groupEndPageNo-1}" var="groupEndPageNo" />
							
							<c:set value ="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />  
							<c:set value ="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							
				
				
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
									
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
								<li><a class="${pageNo eq ntcVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li><a href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
						</ul>
					</div>
					
				</div>
				
				<div class="grid-detail" >
					<form id="detail_form" >
						<!-- 
						isModify ==true => 수정(update)
						isModify == false => 등록(insert)
						 -->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="ntcId" style=" width:180px;">공지ID</label><input type="text" id="ntcId" name="ntcId" readonly value=""/>
						</div>	
						
						<div class="input-group inline">
							<label for="mbrId" style=" width:180px;">회원ID</label><input type="text" id="mbrId"  name="mbrId" value=""/>
						</div>	
						
						<div class="input-group inline">
							<label for="ntcRgstDt" style=" width:180px;">사용여부</label><input type="checkbox" id="ntcRgstDt" name="ntcRgstDt" value="Y"/>
						</div>	
						
						<div class="input-group inline">
							<label for="ntcTtl" style=" width:180px;">등록자</label><input type="text" id="crtr" disabled value=""/>
						</div>
						
						<div class="input-group inline">
							<label for="crtDt" style=" width:180px;">등록일 </label><input type="text" id="crtDt"  disabled value=""/>
						</div>
						
						<div class="input-group inline">
							<label for="mdfyr" style=" width:180px;">수정자</label><input type="text" id="mdfyr" disabled value=""/>
						</div>
						
						<div class="input-group inline">
							<label for="mdfyDt" style=" width:180px;">수정일</label><input type="text" id="mdfyDt" disabled value=""/>
						</div>
						
							
					</form>
					
					
				</div>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">신규</button>
					<button id="save_btn" class="btn-primary">저장</button>
					<button id="delete_btn" class="btn-delete">삭제</button>
				</div>
				
				
				
				
				
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>