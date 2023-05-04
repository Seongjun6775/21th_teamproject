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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<body class="bg-dark bg-opacity-10 ">
<jsp:include page="../include/logo.jsp" />
	<main class="d-flex flex-nowrap ">	
		<div style="margin:0px; width: 100%; overflow: auto; display: flex; height: 100vh; flex-direction: column;">
			<!-- contents -->
		    <!-- 검색영역 -->
			<!-- searchbar -->
			<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
			  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
			  <i class="bi bi-search" style="margin: 15px;"></i>
			  <!-- <label for="search-keyword-mbrNm" >이름</label> -->
				<form style="display: flex; align-items: center;">
					<input type="text" name="strNm" class="form-control me-2" placeholder="매장명 검색" value="${strNm}"/>
					<input type="text" name="strAddr" class="form-control me-2" placeholder="매장주소 검색" value="${strAddr}"/>
					<!-- <button class="btn-search" id="search-btn">검색</button> -->
					<button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px;">Search</button>
				</form>
			</div>
      		<!-- /contents -->
	    	<div class="str_search_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; height: auto;">
				<div class="grid-count align-right">총 ${strList.size()}건</div>
				<table class="table  table-hover" style="text-align: center;">
					<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
						<tr>
							<th scope="col" class="col-1"  style="border-radius: 6px 0 0 0;">선택</th>
							<th scope="col" class="col-1">매장명</th>
							<th scope="col" class="col-1">매장주소</th>
							<th scope="col" class="col-1">가맹점주</th>
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
											<input type="checkbox" class="check-idx form-check-input" value="${str.strId}"/>
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
				<div class="align-right">
					<button id="cancel_btn" class="btn btn-outline-danger fire-btn" style="border: solid 2px; font-weight: 800;">취소</button>
					<button id="regist_btn" class="btn btn-outline-primary" style="border: solid 2px; font-weight: 800; margin-right: 15px;">등록</button>
				</div>
	    	</div>
      		<!-- /contents -->
		</div>
	</main>
</body>
</html>