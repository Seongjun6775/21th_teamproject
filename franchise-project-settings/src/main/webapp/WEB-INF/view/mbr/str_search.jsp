<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".check-idx").change(function(){
			var count = $(".check-idx").length;
			var checkCount = $(".check-idx:checked").length;
			if($(this).prop("checked")){
				$(".check-idx").prop("checked", false);
				$(this).prop("checked", true);
			}
		});
		$("#cancel_btn").click(function(){
			window.close();
		});
		$("#regist_btn").click(function(){
			var checkbox = $(".check-idx:checked");
			if(checkbox.length == 0 ){
				alert("매장을 선택하세요.");
			}
			var checkedStr = checkbox.closest("tr").data();
			opener.addStrFn(checkedStr);
			window.close();
		});
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>매장 검색</h1>
		<form>
			<div class="search-group">
				<label for="strNm">매장명</label>
				<input type="text" name="strNm" class="grow-1 mr-10" value ="${strNm}">
				<label for="strAddr">매장주소</label>
				<input type="text" name="strAddr" class="grow-1 mr-10" value ="${strAddr}">
				<button class="btn-search" id="search-btn">검색</button>
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">총 ${strList.size()}건</div>
			<table>
				<thead>
					<tr>
						<th>선택</th>
						<th>매장명</th>
						<th>매장주소</th>
						<th>점주</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test ="${not empty strList }">
							<c:forEach items="${strList}" var="str">
								<tr data-strid="${str.strId}"
									data-strnm="${str.strNm}"
									data-straddr="${str.strAddr}"
									data-mbrid="${str.mbrId}"
								>
									<td>
										<input type="checkbox" class="check-idx" value="${str.strId}"/>
									</td>
									<td>${str.strNm}</td>
									<td>${str.strAddr}</td>
									<td>${empty str.mbrId ? '없음' : str.mbrId}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">검색된 매장이 없습니다.</td>
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