<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	$().ready(function(){
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
		
		
		$("#cancel_btn").click(function(){
			window.close();
		})
		
		$("#regist_btn").click(function(){
			
			var checkbox = $(".check_idx:checked");
			if(checkbox.length ==0){
				alert("하나의 공지글을 선택하세요.");
				return;
			}
			
			checkbox.each(function(){
				var each = $(this).closest("tr").data();
				opener.addGnrFn(each);
				
			})
		})
	})

</script>
</head>
<body>
	<div class="search-popup content">
		<h1>장르검색</h1>
		<form>
			<div class="search-group">
				<label for="">장르명</label>
				<input type="text" name="gnrNm" class="grow-1 mr-10" value="${gnrNm}"/>
				<button class="btn-search" id="search-btn-">검색</button>	
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">
				총 ${gnrList.size() > 0 ? gnrList.size() : 0}건
			</div>
			
			<table>
				<thead>
					<tr>
					<th>
						<input type="checkbox" id="all_check" />
					</th>
					<th>장르명</th>
					<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty gnrList}">
							<c:forEach items="${gnrList}" var="gnr">
								<tr data-gnrid="${gnr.gnrId}"
									data-gnrNm="${gnr.gnrNm}">
									<td>
										<input type ="checkbox" 
											   class="check_idx" 
											   value="${gnr.gnrId}">
									</td>
									<td>${gnr.gnrNm}</td>
									<td>${gnr.crtDt}</td>
								</tr>
								
							
							</c:forEach>
						</c:when>
						
						<c:otherwise>
							<tr>
								<td colspan="3">검색된 장르가 없습니다.</td>
							
							</tr>
							
							
						</c:otherwise>
					</c:choose>
				
				</tbody>
			
			</table>
		
		</div>
		
		<div class="align-right">
			<button id="cancel_btn" class="btn-delete">취소</button>
			<button id="regist_btn" class="btn-primary">등록</button>
		</div>
	</div>
</body>
</html>