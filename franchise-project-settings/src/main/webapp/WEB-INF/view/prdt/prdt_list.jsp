<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="randomValue" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<script type="text/javascript">

// input 가격 입력의 최대길이를 제한하기 위한 기능
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
  }

// 천단위 구분기호를 위해 갖고왔는데 미사용중임, 동작어려움 ㅠ
function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	var table = document.getElementById("dataTable");
	var rowCount = table.rows.length;
	console.log(rowCount);
	// 가격 천단위 구분기호를 찍고싶다
	// 테이블로우에 for문으로 반복한다???
	// function priceToString 참고 및 사용
	
	
	
	$(".grid > table > tbody > tr").click(function() {
		var data = $(this).data();
		console.log(data)
		console.log($("#isModify").val());
		
		$("#isModify").val("true"); // true:수정/false:신규
		
		$("#prdtId").val(data.prdtid);
		$("#prdtSrt").val(data.prdtsrt);
		$("#prdtNm").val(data.prdtnm);
		$("#prdtPrc").val(data.prdtprc);
		$("#prdtRgstr").val(data.prdtrgstr+"("+data.prdtrgstrnm+")");
		$("#prdtRgstDt").val(data.prdtrgstdt);
		$("#mdfyr").val(data.mdfyr+"("+data.mdfyrnm+")");
		$("#mdfyDt").val(data.mdfydt);
		$("#mdfyDt").val(data.mdfydt);
		$("#prdtCntnt").val(data.prdtcntnt);
		$("#prdtCntnt").val(data.prdtcntnt);
		
		$("#useYn").prop("checked", data.useyn == "Y");
	})
	
	$("#all-check").change(function(){
		$(".check-idx").prop("checked",$(this).prop("checked"));
	})
	$(".check-idx").change(function(){
		var count = $(".check-idx").length;
		var checkCount = $(".check-idx:checked").length;
		console.log(count +"/"+ checkCount)
		$("#all-check").prop("checked", count == checkCount);
	})
	
	
	$("#btn-new").click(function() {
		$("#isModify").val("false"); // true:수정/false:신규
		
		$("#prdtId").val("");
		$("#prdtSrt").val("none");
		$("#prdtNm").val("");
		$("#prdtPrc").val("");
		$("#prdtRgstr").val("");
		$("#prdtRgstDt").val("");
		$("#mdfyr").val("");
		$("#mdfyDt").val("");
		$("#mdfyDt").val("");
		$("#prdtCntnt").val("");
		$("#prdtCntnt").val("");
		
		$("#prdtIMG").attr("src", "${context}/img/default_photo.jpg");
		$("#useYn").prop("checked", false);
	})
	
	
	$("#btn-new").click(function() {
		
	})
	
	
	
	$("#prdtFileId").change(function() {
		var file = $(this)[0].files;
		console.log(file);
		
		if(file.length > 0) {
			var fileReader = new FileReader();
			fileReader.onload = function(data) {
				// FileReader 객체가 로드 됐을 떄,
				console.log(data);
				$("#prdtIMG").attr("src", data.target.result);
			}
			fileReader.readAsDataURL(file[0]);
			$("#isDeleteIMG").val("Y");
			
		} else {
			// 기본 이미지로 변경
			$("#prdtFileId").val("");
			$("#prdtIMG").attr("src", "${context}/img/default_photo.jpg")
			$("#isDeleteIMG").val("Y");
		}
	});
	$("#del-img").click(function(event) {
		event.preventDefault();
		$("#prdtFileId").val("");
		$("#isDeleteIMG").val("Y");
		$("#prdtIMG").attr("src", "${context}/img/default_photo.jpg")
	});
	
	
	
	$("#btn-save").click(function() {
		console.log("세이브버튼임")
		if ($("#isModify").val() == "false") {
			ajaxUtil.upload("#form-detail", "${context}/api/prdt/create", function(response) {
				if (response.status == "200 OK") {
					console.log("메뉴 생성 성공")
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			}, {"prdtIMG":"uploadFile"})
		} else {
			ajaxUtil.upload("#form-detail", "${context}/api/prdt/update", function(response) {
				if (response.status == "200 OK") {
					console.log("메뉴 수정 성공")
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			}, {"prdtIMG":"uploadFile"})
		}
		
	})
	
	
	
	$("#prdtIMG").click(function() {
		console.log("a");
		$("#prdtFileId").click();
	});
	
	// 이미지등록 라벨 클릭 시 이벤트제거
	$("label").click(function(event) {
		event.preventDefault();
	});
	
	
	
})
</script>
</head>
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div>
			<jsp:include page="../include/sidemenu.jsp"></jsp:include>
			<jsp:include page="../include/content.jsp"></jsp:include>
			
			<div class="grid">
				<div class="grid-count align-right">
					<!-- 페이지네이션용  -->
					<%-- 총 ${prdtList.size() > 0 ? prdtList.get(0).totalCount : 0}건 --%>
					총 ${prdtList.size() > 0 ? prdtList.size() : 0}건
				</div>
				<table id="dataTable">
					<thead>
						<tr>
							<th><input type="checkbox" id="all-check"/></th>
							<th>ID</th>
							<th>분류</th>
							<th>이름</th>
							<th>가격</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>수정자</th>
							<th>수정일</th>
							<th>사용유무</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty prdtList}">
								<c:forEach items="${prdtList}"
											var="prdt"
											varStatus="index">
									<tr data-prdtid="${prdt.prdtId}" 
										data-prdtnm="${prdt.prdtNm}" 
										data-prdtprc="${prdt.prdtPrc}" 
										data-prdtcntnt="${prdt.prdtCntnt}" 
										data-prdtfileId="${prdt.prdtFileId}" 
										data-prdtsrt="${prdt.prdtSrt}" 
										data-prdtsrtnm="${prdt.cmmnCdVO.cdNm}" 
										data-prdtrgstr="${prdt.prdtRgstr}" 
										data-prdtrgstDt="${prdt.prdtRgstDt}" 
										data-mdfyr="${prdt.mdfyr}" 
										data-mdfydt="${prdt.mdfyDt}"
										data-useyn="${prdt.useYn}"
										data-prdtrgstrnm="${prdt.prdtRgstrMbrVO.mbrNm}"
										data-mdfyrnm="${prdt.mdfyrMbrVO.mbrNm}"> 
										<td class="align-center">
											<input type="checkbox" class="check-idx" value="${prdt.prdtId}" />
										</td>
										<td>${prdt.prdtId}
											<c:choose>
												<c:when test="${prdt.prdtFileId eq 'sample_file_name'}"><span class="memo">(사진없음)</span>
												</c:when>
											</c:choose>
										</td>
										<td>${prdt.cmmnCdVO.cdNm}</td>
										<td>${prdt.prdtNm}</td>
										<td class="money">${prdt.prdtPrc}</td>
										<td>${prdt.prdtRgstr}(${prdt.prdtRgstrMbrVO.mbrNm})</td>
										<td>${prdt.prdtRgstDt}</td>
										<td>${prdt.mdfyr}(${prdt.mdfyrMbrVO.mbrNm})</td>
										<td>${prdt.mdfyDt}</td>
										<td>${prdt.useYn}</td>
									</tr>
								</c:forEach>	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" class="no-items">
										등록된 항목이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<div class="grid-detail">
					<form id="form-detail">
						<!-- 
						isModify == true -> 수정(update)
						isModify == false -> 등록(insert)
						 -->
						<input type="hidden" id="isModify" value="false" />
						
						<div class="grid-left mr-10">
							<div class="inline-flex">
								<div class="input-group" style="position:relative;">
									<label for="prdtFileId">사진</label>
									<input type="file" id="prdtFileId"  name="prdtFileId" value=""/>
									<img src="${context}/img/default_photo.jpg" id="prdtIMG" class="img">
									<button id="del-img" style="position: absolute; right:10px; bottom:10px;">X</button>
									<input type="hidden" id="isDeleteIMG" name="isDeleteIMG" value="N">
								</div>	
							</div>
						</div>
						<div class="grid-right">
							<div class="input-group inline">
								<label for="prdtId">ID</label>
								<input type="text" id="prdtId" class="readonly" name="prdtId" readonly placeholder="ID는 자동생성됩니다" value=""/>
							</div>
							<div class="input-group inline">
								<label for="prdtSrt">분류</label>
								<select id="prdtSrt" name="prdtSrt">
									<option value="none">선택</option>
									<option value="분류-가">기역</option>
									<option value="분류-나">니은</option>
									<option value="분류-다">디귿</option>
									<option value="분류-라">리을</option>
								</select>
							</div>
							<div class="input-group inline">
								<label for="prdtNm">이름</label>
								<input type="text" id="prdtNm"  name="prdtNm"  value=""/>
							</div>
							<div class="input-group inline">
								<label for="prdtPrc">가격</label>
								<input type="number" id="prdtPrc"  name="prdtPrc" 
										min="0" max="9999999" maxlength="7" 
										oninput="maxLengthCheck(this)" value="0"/>
							</div>
							<div class="input-group inline">
								<label for="useYn">사용여부</label>
								<input type="checkbox" id="useYn" name="useYn" value="Y"/>
							</div>
							<div class="input-group inline">
								<label for="prdtRgstr" >등록자</label>
								<input type="text" id="prdtRgstr" disabled value=""/>
							</div>
							<div class="input-group inline">
								<label for="prdtRgstDt" >등록일</label>
								<input type="text" id="prdtRgstDt" disabled value=""/>
							</div>
							<div class="input-group inline">
								<label for="mdfyr">수정자</label>
								<input type="text" id="mdfyr" disabled value=""/>
							</div>
							<div class="input-group inline">
								<label for="mdfyDt">수정일</label>
								<input type="text" id="mdfyDt" disabled value=""/>
							</div>
							<div class="input-group inline">
								<label for="prdtCntnt">내용</label>
								<input type="text" id="prdtCntnt" placeholder="내용이 비었습니다" value=""/>
							</div>
						</div>
						
						
						
						
					</form>
					
				</div>
				<div class="align-right grid-btns">
					<button id="btn-new" class="btn-primary">신규</button>
					<button id="btn-save" class="btn-primary">저장</button>
					<button id="btn-delete" class="btn-primary btn-delete">삭제</button>
				</div>
				
			</div>
			
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>
	
</body>
</html>