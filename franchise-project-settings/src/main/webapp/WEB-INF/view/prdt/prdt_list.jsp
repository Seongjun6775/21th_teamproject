<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<c:set var="date" value="<%= new Random().nextInt() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 관리</title>
<jsp:include page="../include/stylescript.jsp"></jsp:include>
<link rel="stylesheet" href="${context}/css/prdt_common.css?p=${date}" />
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
	
	
	 $("#search-keyword-prdtSrt").val("${prdtVO.prdtSrt}");
	
	
	var table = document.getElementById("dataTable");
	var rowCount = table.rows.length;
	console.log(rowCount);
	// 가격 천단위 구분기호를 찍고싶다
	// 테이블로우에 for문으로 반복한다???
	// function priceToString 참고 및 사용
	
	
	
	$(".grid > table > tbody > tr").click(function() {
		var data = $(this).data();
		console.log(data)
		
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
		
		$("#useYn").prop("checked", data.useyn == "Y");
		
		var prdtFileId = data.prdtfileid;
		if (prdtFileId==""){
			prdtFileId= "FuckingErrorFileNameIsNull";
		}
		$("#prdtImg").attr("src", "${context}/prdt/img/" + prdtFileId + "/");
		
		
	});
	
	$("#all-check").change(function(){
		$(".check-idx").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx:checked").length;
		chkCount(checkLen);
	})
	$(".check-idx").change(function(){
		var count = $(".check-idx").length;
		var checkCount = $(".check-idx:checked").length;
		$("#all-check").prop("checked", count == checkCount);
		
	});
	
	
	$("#btn-new").click(function() {
		$("#isModify").val("false"); // true:수정/false:신규
		
		$("#prdtId").val("");
		$("#prdtSrt").val("");
		$("#prdtNm").val("");
		$("#prdtPrc").val("0");
		$("#prdtRgstr").val("");
		$("#prdtRgstDt").val("");
		$("#mdfyr").val("");
		$("#mdfyDt").val("");
		$("#mdfyDt").val("");
		$("#prdtCntnt").val("");
		$("#prdtCntnt").val("");
		
		$("#prdtImg").attr("src", "${context}/img/default_photo.jpg");
		$("#useYn").prop("checked", false);
	});
	
	
	
	$("#prdtFileId").change(function() {
		var file = $(this)[0].files;
		console.log(file);
		
		if(file.length > 0) {
			var fileReader = new FileReader();
			fileReader.onload = function(data) {
				// FileReader 객체가 로드 됐을 떄,
				console.log(data);
				$("#prdtImg").attr("src", data.target.result);
			}
			fileReader.readAsDataURL(file[0]);
			$("#isDeleteImg").val("Y");
			
		} else {
			// 기본 이미지로 변경
			$("#prdtFileId").val("");
			$("#prdtImg").attr("src", "${context}/img/default_photo.jpg")
			$("#isDeleteImg").val("Y");
		}
	});
	$("#del-img").click(function(event) {
		event.preventDefault();
		$("#prdtFileId").val("");
		$("#isDeleteImg").val("Y");
		$("#prdtImg").attr("src", "${context}/img/default_photo.jpg")
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
			}, {"prdtFileId":"uploadFile"})
		} else {
			ajaxUtil.upload("#form-detail", "${context}/api/prdt/update", function(response) {
				if (response.status == "200 OK") {
					console.log("메뉴 수정 성공")
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			}, {"prdtFileId":"uploadFile"})
		}
		
	});
	
	
	$("#btn-delete").click(function() {
		var prdtId = $("#prdtId").val();
		var prdtNm = $("#prdtNm").val();
		if (prdtId == "") {
			alert("선택된 항목이 없습니다.")
			return;
		}
		if (!confirm("ID    : " + prdtId + "\n이름 : " + prdtNm + "\n정말 삭제하시겠습니까?")) {
			return;
		}
		$.get("${context}/api/prdt/delete/" + prdtId, function(response) {
			location.reload(); //새로고침
		})
	});
	
	$("#btn-delete-all").click(function() {
		var checkLen = $(".check-idx:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if (!confirm("체크한 항목이 일괄 삭제됩니다.\n정말 삭제하시겠습니까?")) {
			return;
		}
		
		var form = $("<form></form>")
		
		$(".check-idx:checked").each(function() {
			console.log($(this).val());
			form.append("<input type='hiedden' name='prdtId' value='" + $(this).val() + "'>");
		});
		
		$.post("${context}/api/prdt/delete", form.serialize(), function(response) {
			if (response.status == "200 OK") {
				location.reload(); //새로고침
			}
			else {
				alert(response.errorCode + " / " + response.message);
			}
		});
	})
	
	// 체크박스가 되었다면 일괄삭제버튼 나타내기
	$("input:checkbox").click(function() {
		var checkLen = $(".check-idx:checked").length;
		chkCount(checkLen);
	})
		
	
	
	
	
	
	// 가격 빈값 -> 0 입력 , 첫글자 0삭제
	$("#prdtPrc").keyup(function() {
		if ($(this).val() == "") {
			$(this).val("0");
		} else {
			$(this).val($(this).val().replace(/(^0+)/, ""))
		}
	});
	
	$("#prdtImg").click(function() {
		console.log("이미지 클릭했음");
		$("#prdtFileId").click();
	});
	
	// 이미지등록 라벨 클릭 시 이벤트제거
	$("label").click(function(event) {
		event.preventDefault();
	});
	
	// 검색 기능 : 셀렉트박스 변경시
	$("select[name=selectFilter]").on("change", function(evetn) {
		movePage(0);
	});
	// 검색 기능 : 이름 입력 후 검색버튼 클릭 시
	$("#btn-search").click(function() {
		movePage(0);
	})
	$("#search-keyword-prdtNm").keydown(function(key) {
		if( key.keyCode == 13 ){
			movePage(0);
		}
	});
	$("#btn-search-reset").click(function() {
		location.href = "${context}/prdt/list";
	})
	
	
	
})

function chkCount(checkLen) {
	
	if (checkLen > 0) {
		$(".animation").stop();
		$(".animation").slideDown( 600 );
	} else {
		$(".animation").stop();
		$(".animation").slideUp ( 600 );
	}
}

function movePage(pageNo) {
	var srt = $("#search-keyword-prdtSrt").val(); 
	var prdtNm= $("#search-keyword-prdtNm").val(); 
	var useYn= $("#search-keyword-useYn").val(); 
	
	var queryString = "prdtSrt=" + srt;
	queryString += "&prdtNm=" + prdtNm;
	queryString += "&useYn=" + useYn;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/prdt/list?" + queryString; // URL 요청
} 
</script>
</head>
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div>
			<jsp:include page="../include/sidemenu.jsp"></jsp:include>
			<jsp:include page="../include/content.jsp"></jsp:include>
			
		<%-- 	
			<div class="search-row-group">
				<div class="search-group">
					<label for="search-keyword-prdtSrt">분류</label>
					<select id="search-keyword-prdtSrt">
						<option value="">선택</option>
						<option value="분류-가">기역</option>
						<option value="분류-나">니은</option>
						<option value="분류-다">디귿</option>
						<option value="분류-라">리을</option>
					</select>
					
					<label for="search-keyword-prdtNm">이름</label>
					<input type="text" id="search-keyword-prdtNm" class="search-input" value="${prdtVO.prdtNm}">
					
					<button class="btn-search" id="btn-search">검색</button>
				</div>
				<div class="search-group">
				</div>
			</div>
			 --%>
			
			<div class="grid">
				<div class="flex space-between mb-10">
					<button class="inline-flex btn-primary btn-search-reset" 
							id="btn-search-reset">검색초기화</button>
					<div class="inline-flex grid-count align-right">
						<!-- 페이지네이션용  -->
						총 ${prdtList.size() > 0 ? prdtList.get(0).totalCount : 0}건
						<%-- 총 ${prdtList.size() > 0 ? prdtList.size() : 0}건 --%>
					</div>
				</div>
				<table id="dataTable"
						class="mb-10">
					<thead>
						<tr>
							<th><input type="checkbox" id="all-check"/></th>
							<th>ID</th>
							<th>분류
							<select class="selectFilter" name="selectFilter"
									id="search-keyword-prdtSrt">
								<option value="">선택</option>
								<option value="분류-가">기역</option>
								<option value="분류-나">니은</option>
								<option value="분류-다">디귿</option>
								<option value="분류-라">리을</option>
							</select>
							</th>
							<th>이름
							<input type="text" class="selectFilter" 
									id="search-keyword-prdtNm" 
									placeholder="검색어 입력 후 Enter"
									value="${prdtVO.prdtNm}">
							</th>
							<th>가격</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>수정자</th>
							<th>수정일</th>
							<th>사용유무
							<select class="selectFilter" name="selectFilter"
									id="search-keyword-useYn">
								<option value="">선택</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
							</th>
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
										data-prdtfileid="${prdt.prdtFileId}" 
										data-prdtsrt="${prdt.prdtSrt}" 
										data-prdtsrtnm="${prdt.cmmnCdVO.cdNm}" 
										data-prdtrgstr="${prdt.prdtRgstr}" 
										data-prdtrgstdt="${prdt.prdtRgstDt}" 
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
												<c:when test="${prdt.prdtFileId eq 'none'}"><span class="memo">(사진없음)</span>
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
				
				<div class="align-right mt-10 animation" style="display: none;" >
					<button id="btn-delete-all" class="btn-primary btn-delete" style="vertical-align: top;">일괄삭제</button>
				</div>
				
				<div class="pagenate">
					<ul>
						<c:set value="${prdtList.size() > 0 ? prdtList.get(0).lastPage : 0}" var="lastPage"></c:set>
						<c:set value="${prdtList.size() > 0 ? prdtList.get(0).lastGroup : 0}" var="lastGroup"></c:set>
						
						<fmt:parseNumber var="nowGroup" value="${Math.floor(prdtVO.prdtPageNo / prdtVO.prdtPageCnt)}" integerOnly="true" />
						<c:set value="${nowGroup * prdtVO.prdtPageCnt}" var="groupStartPageNo"></c:set>
						<c:set value="${groupStartPageNo + prdtVO.prdtPageCnt}" var="groupEndPageNo"></c:set>
						<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1}" var="groupEndPageNo"></c:set>
						
						<c:set value="${(nowGroup - 1) * prdtVO.prdtPageCnt}" var="prevGroupStartPageNo"></c:set>
						<c:set value="${(nowGroup + 1) * prdtVO.prdtPageCnt}" var="nextGroupStartPageNo"></c:set>
						
						 
						<c:if test="${nowGroup > 0}">
							<li><a href="javascript:movePage(0)">처음</a></li>
							<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
						</c:if>
						
						<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1"	var="prdtPageNo">
							<li><a class="${prdtPageNo eq prdtVO.prdtPageNo ? 'on' : ''}"  href="javascript:movePage(${prdtPageNo})">${prdtPageNo+1}</a></li>
						</c:forEach>
						
						<c:if test="${lastGroup > nowGroup}">
							<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li><a href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</div>
			
				<div class="grid-detail">
					<form id="form-detail">
						<!-- 
						isModify == true -> 수정(update)
						isModify == false -> 등록(insert)
						 -->
						<input type="hidden" id="isModify" value="false" />
						
						<div class="grid-left mr-10">
							<div class="input-group relative">
								<label for="prdtFileId">사진</label>
								<input type="file" id="prdtFileId"  name="prdtFileId" value=""/>
								<div class="img-box">
									<img src="${context}/img/default_photo.jpg" id="prdtImg" class="img">
								</div>
								<button id="del-img" style="position: absolute; right:10px; bottom:10px;">X</button>
								<input type="hidden" id="isDeleteImg" name="isDeleteImg" value="N">
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
									<option value="">선택</option>
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
							<div class="input-group">
								<label for="prdtCntnt">내용</label>
								<textarea class="textarea" id="prdtCntnt" maxlength="1000" placeholder="내용은 1,000자 까지 작성 가능합니다" ></textarea>
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