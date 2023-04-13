<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="${context}/css/str_common.css?p=${date}" />
<script type="text/javascript">
	$().ready(function() {
		
		$(".grid > table > tbody > tr").click(function(){
			$("#isModify").val("true"); //수정모드
			var data = $(this).data();
			$("#strId").val(data.strid);
			$("#strNm").val(data.strnm);
			$("#strAddr").val(data.straddr);
			$("#strCallNum").val(data.strcallnum);
			$("#mbrId").val(data.mbrid);
			$("#strOpnTm").val(data.stropntm);
			$("#strClsTm").val(data.strclstm);
			$("#useYn").prop("checked", data.useyn == "Y");
		});
		
		$("#new_btn").click(function() {
			$("#isModify").val("false"); //등록모드
			
			$("#strId").val("");
			$("#strNm").val("");
			$("#strAddr").val("");
			$("#strCallNum").val("");
			$("#mbrId").val("");
			$("#strOpnTm").val("");
			$("#strClsTm").val("");
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function(){
				var strId = $("#strId").val();
				if(strId == ""){
					alert("선택한 매장이 없습니다.")
					return;	
				}
				if(!confirm("정말 삭제하시겠습니까?")){
					return;
				}
			$.post("${context}/api/str/delete/" + strId, function(response){	
				if(response.status == "200 OK"){
					location.reload(); // 새로고침
				}
				else{
					
					alert(respones.errorCode + " / " + response.message);
				}
			});
		})
		
		$("#save_btn").click(function(){
				if($("#isModify").val() == "false"){
					
			$.post("${context}/api/str/create", $("#detail_form").serialize(), function(response) {
				if(response.status == "200 OK"){
					location.reload(); // 새로고침
				}
				else{
					alert(response.errorCode + " / " + response.message);
					}
				});
			}
			else{
				//수정
				$.post("${context}/api/str/update", $("#detail_form").serialize(), function(response) {
					console.log($("#detail_form").serialize());
				if(response.status == "200 OK"){
					location.reload(); // 새로고침
				}
				else{
					alert(response.errorCode + " / " + response.message);
					}
				});
			}
		});
			$("#search-btn").click(function(){
				movePage(0);
			});
			
			$("#all_check").change(function(){
				console.log($(this).prop("checked"));
				$(".check_idx").prop("checked", $(this).prop("checked"));
			});
			
			$(".check_idx").change(function(){
				var count = $(".check_idx").length;
				var checkCount = $(".check_idx:checked").length;
				$("#all_check").prop("checked", count == checkCount);
			});
		});
		function movePage(pageNo){
		//전송
		//입력 값.
		var strNm = $("#search-keyword").val();
		//url요청
		location.href = "${context}/str/list?strNm=" +strNm + "&pageNo=" + pageNo;
		}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
		
			<div class="path"> 매장 관리</div>
				<div class="search-group">
					<label for="search-keyword">매장명</label>
					<input type="text" id="search-keyword" class="search-input" value="${strVO.strNm}"/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
			
			<div class="grid">
				
					<div class="grid-count align-right">
					 	총${strList.size() > 0 ? strList.get(0).totalCount : 0}건
					</div>
				
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>매장ID</th>
						<th>매장명</th>
						<th>매장주소</th>
						<th>전화번호</th>
						<th>관리자ID</th>
						<th>오픈시간</th>
						<th>종료시간</th>
						<th>사용여부</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty strList}">
							<c:forEach items="${strList}"
									var="str">
							<tr data-strid="${str.strId}" 
							data-strnm="${str.strNm}" 
							data-straddr="${str.strAddr}" 
							data-strcallnum="${str.strCallNum}" 
							data-mbrid="${str.mbrId}" 
							data-stropntm="${str.strOpnTm}" 
							data-strclstm="${str.strClsTm}" 
							data-useyn="${str.useYn}" >
							<td>
								<input type="checkbox" class="check_idx" value="${str.strId}"/>
							</td>
								<td>${str.strId}</td>
								<td>${str.strNm}</td>
								<td>${str.strAddr}</td>
								<td>${str.strCallNum}</td>
								<td>${str.mbrId}</td>
								<td>${str.strOpnTm}</td>
								<td>${str.strClsTm}</td>
								<td>${str.useYn}</td>
							</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="9" class="no-items">
									등록된 매장이 없습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="pagenate">
				<ul>
					<c:set value="${strList.size() > 0 ? strList.get(0).lastPage : 0}" var="lastPage"/>
					<c:set value="${strList.size() > 0 ? strList.get(0).lastGroup : 0}" var="lastGroup"/>
					
					<fmt:parseNumber var="nowGroup" value="${Math.floor(strVO.pageNo / 10)}" integerOnly="true"/>
					<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
					<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
					<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo"/>
				
					
					<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo"/>
					<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo"/>
				
					<c:if test="${nowGroup > 0}">
						<li><a href="javascript:movePage(0)">처음</a></li>
						<li><a href="javascript:movePage(${prevGroupStartpageNo})">이전</a></li>
					</c:if>
					
					<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
						<li><a class="${pageNo eq strVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
					</c:forEach>
				
					<c:if test=" ${lastGroup > nowGroup}">
						<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
						<li><a href="javascript:movePage(${lastPage})">끝</a></li>
					</c:if>
				</ul>
			</div>
			<div class="grid-detail">
				<form id="detail_form">
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="strId" style="width:180px">매장 ID</label>
						<input type="text" id="strId" name="strId" readonly value=""/>
					</div>
					<div class="input-group inline">
						<label for="strNm" style="width:180px">매장명</label>
						<input type="text" id="strNm" name="strNm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strAddr" style="width:180px">매장주소</label>
						<input type="text" id="strAddr" name="strAddr" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strCallNum" style="width:180px">전화번호</label>
						<input type="text" id="strCallNum" name="strCallNum" value=""/>
					</div>
					<div class="input-group inline">
						<label for="mbrId" style="width:180px">관리자ID</label>
						<input type="text" id="mbrId" name="mbrId" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strOpnTm" style="width:180px">오픈시간</label>
						<input type="text" id="strOpnTm" name="strOpnTm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="strClsTm" style="width:180px">종료시간</label>
						<input type="text" id="strClsTm" name="strClsTm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="useYn" style="width:180px">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" value="Y"/>
					</div>
				</form>
			</div>
		</div>
			<div class="align-right">
				<button id="new_btn" class="btn-primary">신규</button>
				<button id="save_btn" class="btn-primary">저장</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
