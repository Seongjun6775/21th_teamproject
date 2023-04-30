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
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<script type="text/javascript">

// input 가격 입력의 최대길이를 제한하기 위한 기능
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
}

   // 특수문자 모두 제거    
function chkChar(obj){
    var RegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;	//정규식 구문
    if (RegExp.test(obj.value)) {
      obj.value = obj.value.replace(RegExp , '');
    }
}
   
function confirmFileExtension(file) {
	console.log(file);
	// 정규식을 사용히여 jpg, jpeg, png, gif, bmp등 이미지파일의 확장자를 가진것을 추려낸다.
	var reg = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/;
  	if(file.match(reg)) {
		alert("해당 파일은 이미지 파일입니다.");
	} else {
		alert("해당 파일은 이미지 파일이 아닙니다.");
}

  	/* 
function fileCheck() {
	
	if (form.imgFile.value) {
		var fileName = form.imgFile.value;
		var fileExt = fileName.substring(fileName.lastIndexOf(".")+1);
		var fileExt = fileExt.toLowerCase();
		
		if ("jpg" != fileExt && "jpeg" != fileExt && "gif" != fileExt 
				&& "png" != fileExt && "bmp" != fileExt) {
			alert("파일 형식은 이미지만 가능합니다.\n .jpg .jpeg .gif .png .bmp");
			return;
			}
		}
	}
	 */
	
}
  	
  	
$().ready(function() {
	
	console.log("ready function!")
	var ajaxUtil = new AjaxUtil();
	
	
	 $("#search-keyword-prdtSrt").val("${prdtVO.prdtSrt}");
	 $("#search-keyword-useYn").val("${prdtVO.useYn}");
	 var evntYn = ""
	 if (${prdtVO.evntVO.evntId != ""} && ${not empty prdtVO.evntVO.evntId} ) {
		 evntYn = "${prdtVO.evntVO.evntId}"
	 }
	 $("#search-keyword-evntYn").val(evntYn);
	
	
	var table = document.getElementById("dataTable");
	var rowCount = table.rows.length;
	console.log(rowCount);
	
	
	
	$("tbody").children("tr").click(function() {
		
		$(this).closest("tbody").find(".on").removeClass("on");
		$(this).addClass("on");
		
		if ($(this).attr('id') == "notFound") {
			return;
		}
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
		$("#prdtCntnt").val(data.prdtcntnt);

		
// 		$("#validEvnt>a>span").remove();
// 		$("#validEvnt>a").removeAttr("href")
// 		if (data.evntid != "") {
// 			$("#validEvnt>a").attr("href", "${context}/evnt/detail/"+data.evntid)
// 			$("#validEvnt>a").append("<span>"+data.evntttl+"</span>")
// 			$("#validEvnt>a").append("<span> 가격 : <del>"+data.prdtprc+"</del> → " +data.evntprdtchngprc+"</span>")
// 			$("#validEvnt>a").append("<span> 기간 : "+data.evntstrtdt+" ~ "+data.evntenddt+"</span>")
// 		}
		$("#evntId").val(data.evntid);
		$("#evntTtl").val(data.evntttl);
		$("#evntPrdtChngPrc").val(data.evntprdtchngprc);
		var startDt = data.evntstrtdt.substring(0,10).replaceAll("-", ".")
		var endDt = data.evntenddt.substring(0,10).replaceAll("-", ".")
		var evntDt = startDt+" ~ "+endDt;
		$("#evntDt").val(evntDt);
		
		
		
		$("#useYn").prop("checked", data.useyn == "Y");
		
		var uuidFlNm = data.uuidflnm;
		if (uuidFlNm==""){
			uuidFlNm= "errorFileNameIsNull";
		}
		$("#prdtImg").attr("src", "${context}/prdt/img/" + uuidFlNm + "/");
		
		
	});
	
	$("#evntTtl").click(function() {
		console.log($("#evntTtl"))
		
		if ($("#evntTtl") != "") {
			console.log("!")
			
		}
	});
	$("#evntaa").click(function() {
		var evntTtl = $("#evntTtl").val();
		if (evntTtl != "") {
			var evntId = $("#evntId").val();
			window.open("${context}/evnt/detail/"+evntId, "이벤트 - "+evntTtl, "width=600, height=450");
		}
	})
	
	
	
	
	$("#all-check").change(function(){
		$(".check-idx0").prop("checked",$(this).prop("checked"));
		var checkLen = $(".check-idx0:checked").length;
		//chkCount(checkLen);
	})
	$(".check-idx0").change(function(){
		var count = $(".check-idx0").length;
		var checkCount = $(".check-idx0:checked").length;
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
	
	
	
	$("#prdtFile").change(function() {
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
			$("#prdtFile").val("");
			$("#prdtImg").attr("src", "${context}/img/default_photo.jpg")
			$("#isDeleteImg").val("Y");
		}
	});
	$("#del-img").click(function(event) {
		event.preventDefault();
		$("#prdtFile").val("");
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
			}, {"prdtFile":"uploadFile"})
		} else {
			ajaxUtil.upload("#form-detail", "${context}/api/prdt/update", function(response) {
				if (response.status == "200 OK") {
					console.log("메뉴 수정 성공")
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			}, {"prdtFile":"uploadFile"})
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
		var checkLen = $(".check-idx0:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if (!confirm("체크한 항목이 일괄 삭제됩니다.\n정말 삭제하시겠습니까?")) {
			return;
		}
		
		var form = $("<form></form>")
		
		$(".check-idx0:checked").each(function() {
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
	
	/* 
	// 체크박스가 되었다면 일괄삭제버튼 나타내기
	$("input:checkbox").click(function() {
		var checkLen = $(".check-idx0:checked").length;
		chkCount(checkLen);
	});
	 */	
	 
	 $("#btn-update-all").click(function() {
		var checkLen = $(".check-idx0:checked").length;
		if (checkLen == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		if ($("select-useYn").val() == "") {
			alert("사용유무가 선택되지 않았습니다.");
		}
		if (!confirm("체크한 항목이 일괄 수정됩니다.")) {
			return;
		}
		
		var form = $("<form></form>")
		
		$(".check-idx0:checked").each(function() {
			console.log($(this).val());
			form.append("<input type='hiedden' name='prdtIdList' value='" + $(this).val() + "'>");
		});
			form.append("<input type='hiedden' name='useYn' value='" + $("#select-useYn").val() + "'>");
		
		$.post("${context}/api/prdt/updateAll", form.serialize(), function(response) {
			if (response.status == "200 OK") {
				location.reload(); //새로고침
			}
			else {
				alert(response.errorCode + " / " + response.message);
			}
		});
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
		$("#prdtFile").click();
	});
	
	// 이미지등록 라벨 클릭 시 이벤트제거
	$("label").click(function(event) {
		event.preventDefault();
	});
	
	// 검색 기능 : 셀렉트박스 변경시
	$("select[name=selectFilter]").on("change", function(event) {
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
			alert("본인에게 쪽지를 보낼 수 없습니다.");
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
	var evntYn= $("#search-keyword-evntYn").val(); 
	if (evntYn == "" || srt == null) {
		evntYn = '%'
	}
	
	var queryString = "prdtSrt=" + srt;
	queryString += "&prdtNm=" + prdtNm;
	queryString += "&useYn=" + useYn;
	queryString += "&evntVO.evntId=" + evntYn;
	queryString += "&prdtPageNo=" + pageNo;
	
	location.href = "${context}/prdt/list?" + queryString; // URL 요청
} 
</script>
</head>
<body>
	
	<jsp:include page="../include/openBody.jsp" />
		
		<!-- contents -->
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
			<span class="fs-5 fw-bold">메뉴 관리</span>
		</div>
		<div class="bg-white rounded shadow-sm " style=" padding: 23px 18px 23px 18px; height: 1000px; margin: 20px;">
		
			<div class="space-between mb-10">
			<div class="top-bar">
				<button id="btn-search-reset"
						class="btn btn-primary" >검색초기화</button>
				<label>메뉴 이름 검색</label>
				<input type="text" class="selectFilter" 
									id="search-keyword-prdtNm" 
									placeholder="검색어 입력 후 Enter"
									onkeyup="chkChar(this)" 
									value="${prdtVO.prdtNm}">	
				<button id="btn-search" class="btn btn-primary">검색</button>
			</div>
				
			
				
			</div>
			<table id="dataTable"
					class="table table-sm table-hover  align-center"
					style="table-layout: fixed">
				<thead>
					<tr>
						<th class="th-checkbox align-center"><input type="checkbox" id="all-check"/></th>
						<th class="width180">ID</th>
						<th class="width100">
						<select class="select-align-center" name="selectFilter"
								id="search-keyword-prdtSrt">
							<option value="">분류</option>
							<c:choose>
								<c:when test="${not empty srtList}">
									<c:forEach items="${srtList}"
												var="srt">
										<option value="${srt.cdId}">${srt.cdNm}</option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
						</th>
						<th class="min-width300">메뉴 이름</th>
						<th class="width100">가격</th>
						<th class="width100 ">
							<select class="select-align-center" name="selectFilter"
									id="search-keyword-evntYn">
								<option value="">이벤트유무</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</th>
						<th class="width100">변경가격</th>
						<th class="width120">등록자</th>
						<th class="width120">등록일</th>
						<th class="width120">수정자</th>
						<th class="width120">수정일</th>
						<th class="width100">
							<select class="select-align-center" name="selectFilter"
									id="search-keyword-useYn">
								<option value="">사용유무</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:choose>
						<c:when test="${not empty prdtList}">
							<c:forEach items="${prdtList}"
										var="prdt"
										varStatus="index">
								<tr data-prdtid="${prdt.prdtId}" 
									data-prdtnm="${prdt.prdtNm}" 
									data-prdtprc="${prdt.prdtPrc}" 
									data-prdtcntnt="${prdt.prdtCntnt}" 
									data-prdtsrt="${prdt.prdtSrt}" 
									data-orgnflnm="${prdt.orgnFlNm}" 
									data-uuidflnm="${prdt.uuidFlNm}" 
									data-flsize="${prdt.flSize}" 
									data-flext="${prdt.flExt}" 
									data-prdtsrtnm="${prdt.cmmnCdVO.cdNm}" 
									data-prdtrgstr="${prdt.prdtRgstr}" 
									data-prdtrgstdt="${prdt.prdtRgstDt}" 
									data-evntid="${prdt.evntVO.evntId}" 
									data-evntttl="${prdt.evntVO.evntTtl}" 
									data-evntstrtdt="${prdt.evntVO.evntStrtDt}" 
									data-evntenddt="${prdt.evntVO.evntEndDt}" 
									data-evntPrdtChngPrc="${prdt.evntPrdtVO.evntPrdtChngPrc}" 
									data-mdfyr="${prdt.mdfyr}" 
									data-mdfydt="${prdt.mdfyDt}"
									data-useyn="${prdt.useYn}"
									data-prdtrgstrnm="${prdt.prdtRgstrMbrVO.mbrNm}"
									data-mdfyrnm="${prdt.mdfyrMbrVO.mbrNm}"> 
									<td class="align-center">
										<input type="checkbox" class="check-idx0" value="${prdt.prdtId}" />
									</td>
									<td class="ellipsis">${prdt.prdtId}</td>
									<td>${prdt.cmmnCdVO.cdNm}</td>
									<td class="ellipsis">
										<c:choose>
											<c:when test="${empty prdt.uuidFlNm}"><i class='bx bx-camera-off' ></i>
											</c:when>
										</c:choose>
										${prdt.prdtNm}
									</td>
									<td class="money">
										<fmt:formatNumber>${prdt.prdtPrc}</fmt:formatNumber>원
									</td>
									<td>
										${empty prdt.evntVO.evntId ? "N" : "Y"}
									</td>
									<td class="money">
										<c:choose>
											<c:when test="${empty prdt.evntVO.evntId}">
												-
											</c:when>
											<c:otherwise>
												<fmt:formatNumber>${prdt.evntPrdtVO.evntPrdtChngPrc}</fmt:formatNumber>원
											</c:otherwise>
										</c:choose>
									</td>
									<td class="ellipsis"
										onclick="event.cancelBubble=true">
										<a class="open-layer" href="javascript:void(0);" 
											val="${prdt.prdtRgstrMbrVO.mbrId}">
											${prdt.prdtRgstrMbrVO.mbrNm eq null ? '<i class="bx bx-error-alt" ></i>이름없음' : prdt.prdtRgstrMbrVO.mbrNm}</a>
									</td>
									<td>
										<fmt:parseDate value="${prdt.prdtRgstDt}" pattern="yyyy-MM-dd" var="prdtRgstDt"/>
										<fmt:formatDate value="${prdtRgstDt}" pattern="yyyy.MM.dd"/>
									</td>
									<td class="ellipsis"
										onclick="event.cancelBubble=true">
										<a class="open-layer" href="javascript:void(0);" 
											val="${prdt.mdfyrMbrVO.mbrId}">
											${prdt.mdfyrMbrVO.mbrNm eq null ? '<i class="bx bx-error-alt" ></i>이름없음' : prdt.mdfyrMbrVO.mbrNm}</a>
									</td>
									<td>
										<fmt:parseDate value="${prdt.mdfyDt}" pattern="yyyy-MM-dd" var="mdftyDt"/>
										<fmt:formatDate value="${mdftyDt}" pattern="yyyy.MM.dd"/>
									</td>
									<td>${prdt.useYn}</td>
								</tr>
							</c:forEach>	
						</c:when>
						<c:otherwise>
							<tr id="notFound">
								<td colspan="12" class="no-items">
									등록된 항목이 없습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<div class="relative">
				<div class="align-left absolute fontsize14">
					<!-- 페이지네이션용  -->
					총 ${prdtList.size() > 0 ? prdtList.get(0).totalCount : 0}건
					<%-- 총 ${prdtList.size() > 0 ? prdtList.size() : 0}건 --%>
				</div>
				<div class="align-right absolute " style="right: 0px;" >
					<select class="selectFilter"
							id="select-useYn">
						<option value="">사용유무</option>
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
					<button id="btn-update-all" 
							class="btn btn-success" 
							style="vertical-align: top;">일괄수정</button>
							
					<button id="btn-delete-all" 
							class="btn btn-danger" 
							style="vertical-align: top;">일괄삭제</button>
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
							<li><a href="javascript:movePage(${prevGroupStartPageNo+prdtVO.prdtPageCnt-1})">이전</a></li>
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
							<div>
								<label for="prdtFile">사진</label>
								<button id="del-img" style="position: absolute; right:10px; bottom:10px;">X</button>
								<input type="file" id="prdtFile"  name="prdtFile" value=""/>
							</div>
							<div class="img-box">
								<img src="${context}/img/default_photo.jpg" id="prdtImg" class="img">
							</div>
							
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
								<c:choose>
								<c:when test="${not empty srtList}">
									<c:forEach items="${srtList}"
												var="srt">
										<option value="${srt.cdId}">${srt.cdNm}</option>
									</c:forEach>
								</c:when>
							</c:choose>
							</select>
						</div>
						<div class="input-group inline">
							<label for="prdtNm">이름</label>
							<input type="text" id="prdtNm"  name="prdtNm"  
									maxlength="20"  onkeyup="chkChar(this)" value=""/>
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
				
				<div>
					<div>적용중인 이벤트</div>
					<div id="evntaa">
						<div class="show-group inline none">
							<input type="text" id="evntId" disabled style="display: none;" value=""/>
						</div>
						<div class="show-group inline">
							<label for="evntTtl">이벤트명</label>
							<input type="text" id="evntTtl" disabled value=""/>
						</div>
						<div class="show-group inline">
							<label for="evntPrdtChngPrc">변경가격</label>
							<input type="text" id="evntPrdtChngPrc" disabled value=""/>
						</div>
						<div class="show-group inline">
							<label for="evntDt">기간</label>
							<input type="text" id="evntDt" disabled value=""/>
						</div>
					</div>
				</div>
				
			</div>
			<div class="align-right grid-btns">
				<a href="${context}/strprdt/list">매장x메뉴  </a>
				<a href="${context}/prdt/list2">손님용 ㄱㄱ</a>
				<button id="btn-new" class="btn-primary">신규</button>
				<button id="btn-save" class="btn-primary">저장</button>
				<button id="btn-delete" class="btn-primary btn-delete">삭제</button>
			</div>
			
			
			<div class="layer_popup" id="layer_popup" style="display: none;">
				<div class="popup_box">
					<div class="popup_content">
						<a class="send-memo-btn" href="javascript:void(0);">
						<i class='bx bx-mail-send' ></i>
						쪽지 보내기</a>
					</div>
					<div>
						<a class="close-memo-btn" href="javascript:void(0);">
						<i class='bx bx-x'></i>
						닫기</a>
					</div>
				</div>
			</div>
			
			
		</div>
		<!-- /contents -->
		
	<jsp:include page="../include/closeBody.jsp" />

</body>
</html>