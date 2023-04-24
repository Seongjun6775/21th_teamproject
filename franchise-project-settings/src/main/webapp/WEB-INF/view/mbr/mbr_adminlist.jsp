<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	var str;
	function addStrFn(search){
		$("#search-strId").val(search.strid);
		$("#search-strNm").val(search.strnm);
	}
	
	$().ready(function(){
		$(".grid > table > tbody > tr").click(function(){
			var data = $(this).data();
			$("#mbrId").val(data.mbrid);
			$("#mbrNm").val(data.mbrnm);
			$("#mbrEml").val(data.mbreml);
			$("#prev-mbrLvl").val(data.mbrlvlnm);
			$("#prev-strNm").val(data.strnm);
			$("#prev-mbrLvl-hidden").val(data.mbrlvl);
			$("#prev-strId-hidden").val(data.strid);
		});
		
		$("#search-btn").click(function(){
			movePage(0);
		});
		$("#mbrLvl").val("${mbrVO.mbrLvl}");
		$("#search-keyword-delYn").prop("checked", $("#search-keyword-delYn").val() == 'Y');
		$("#search-keyword-mbrNm").keydown(function(key){
			if (key.keyCode == 13) {
	        	$("#search-btn").click();
	        }
		});
		$("#search-clear-btn").click(function(){
			$("#search-keyword-mbrNm").val("");
			$("#mbrLvl").val("");
			$("#search-keyword-delYn").prop("checked", false);
			$("#search-keyword-startdt").val("");
			$("#search-keyword-enddt").val("");
		});
		$("#update_btn").click(function(){
			var updateLvl = $("#select-mbrLvl").val();
			var prevLvl = $("#prev-mbrLvl-hidden").val();
			var serialize = $("#detail_form").serialize();
			serialize += "&prevLvl="+prevLvl;
			if(prevLvl.length ==0){
				alert("회원을 선택하세요.");
				return;
			}
			if(updateLvl.length==0){
				alert("변경시킬 등급을 선택하세요.");
				return;
			}
			if(updateLvl == prevLvl){
				alert("선택한 회원의 등급과 변경하려는 등급이 같습니다.");
				return;
			}
			$.post("${context}/api/mbr/update/admin",$("#detail_form").serialize(),function(resp){
				if(resp.status=="200 OK"){
					alert("변경이 완료되었습니다.");
					location.reload();
				}
				else{
					alert(resp.message);
				}
			});
		});
		$("#search-str-btn").click(function(event){
			event.preventDefault();
			str=window.open("${context}/str/search","매장검색", "width=500, height=500");
		});
		
	});
	
	function movePage(pageNo){
		var mbrLvl = $("#mbrLvl option:selected").val();
		var mbrNm = $("#search-keyword-mbrNm").val();
		var startDt = $("#search-keyword-startdt").val();
		var endDt = $("#search-keyword-enddt").val();
		
		var intStartDt = parseInt(startDt.split("-").join(""));
		var intEndDt = parseInt(endDt.split("-").join(""));
		
		if(intStartDt > intEndDt){
			alert("시작 일자를 확인해 주세요");
			return;
		}
		var queryString = "mbrLvl=" + mbrLvl;
		queryString += "&mbrNm=" + mbrNm;
		queryString += "&startDt=" + startDt;
		queryString += "&endDt=" + endDt;
		queryString += "&pageNo=" + pageNo;
		
		location.href="${context}/mbr/admin/list?" + queryString;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/mbrMgmtSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">회원관리 > 회원 목록</div>
				<!-- 검색영역 -->
				<div class="search-row-group">
					<div class="search-group">
						<label for="search-keyword-mbrNm" >이름</label>
						<input type="text" id="search-keyword-mbrNm" class="search-input" value="${mbrVO.mbrNm}"/>
						<select id="mbrLvl" name="mbrLvl">
							<option value="">멤버등급</option>
							<c:choose>
									<c:when test="${not empty srtList}">
										<c:forEach items="${srtList}" var="srt">
											<option value="${srt.cdId}">${srt.cdNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
						</select>
						<label for="search-keyword-startdt" >조회기간</label>
						<input type="date" id="search-keyword-startdt" class="search-input" value="${mbrVO.startDt}"/>
						<input type="date" id="search-keyword-enddt" class="search-input" value="${mbrVO.endDt}"/>
						
						<button class="btn-search" id="search-btn">검색</button>
						<button class="btn-search-clear" id="search-clear-btn">초기화</button>
					</div>
				</div>	
				<!-- 조회영역 -->
				<div class="grid">
					<div class="grid-count align-right">총 ${mbrList.size() > 0 ? mbrList.get(0).totalCount : 0 }건</div>
					<table>
						<thead>
							<tr>
								<th>순번</th>
								<th>ID</th>
								<th>이름</th>
								<th>이메일</th>
								<th>매장명</th>
								<th>회원등급</th>
								<th>가입일</th>
								<th>최근 로그인 날짜</th>
								<th>최근 로그인 IP</th>
								<th>로그인 제한</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty mbrList}">
									<c:forEach items="${mbrList}" var="mbr" varStatus="index">
										<tr data-mbrId="${mbr.mbrId}" 
											data-mbrNm="${mbr.mbrNm }" 
											data-strId="${mbr.strId }" 
											data-mbrEml="${mbr.mbrEml }" 
											data-mbrLvl="${mbr.mbrLvl }" 
											data-mbrLvlNm ="${mbr.cmmnCdVO.cdNm}"
											data-mbrRgstrDt="${mbr.mbrRgstrDt }" 
											data-useYn="${mbr.useYn}" 
											data-mbrRcntLgnDt="${mbr.mbrRcntLgnDt }" 
											data-mbrRcntLgnIp="${mbr.mbrRcntLgnIp}" 
											data-mbrLgnFlCnt="${mbr.mbrLgnFlCnt }" 
											data-mbrLgnBlckYn="${mbr.mbrLgnBlckYn}" 
											data-mbrLstLgnFlDt="${mbr.mbrLstLgnFlDt }" 
											data-mbrPwdChngDt="${mbr.mbrPwdChngDt }" 
											data-mbrLeavDt="${mbr.mbrLeavDt}"
											data-delYn="${mbr.delYn}"
											data-strNm="${mbr.strVO.strNm}"
											>
											<td>${index.index+1}</td>
											<td>${mbr.mbrId}</td>
											<td>${mbr.mbrNm}</td>
											<td>${mbr.mbrEml}</td>
											<td>${mbr.strVO.strNm}</td>
											<td>${mbr.cmmnCdVO.cdNm}</td>
											<td>${mbr.mbrRgstrDt}</td>
											<td>${mbr.mbrRcntLgnDt}</td>
											<td>${mbr.mbrRcntLgnIp}</td>
											<td>${mbr.mbrLgnBlckYn}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="10" class="no-items">등록된 관리자가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					
						<div class="pagenate">
							<ul>
								<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastPage : 0}" var="lastPage"/>
								<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastGroup : 0}" var="lastGroup"/>
								
								<!-- Math.floor(mbrVO.pageNo / 10) -->
								<fmt:parseNumber var="nowGroup" value="${Math.floor(mbrVO.pageNo / 10)}" integerOnly = "true"/>
								<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
								<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
								<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1 }" var="groupEndPageNo"/>
								
								<c:set value="${(nowGroup - 1 ) * 10}" var="prevGroupStartPageNo"/>
								<c:set value="${(nowGroup + 1 ) * 10}" var="nextGroupStartPageNo"/>
								 
								<%-- lastPage: ${lastPage }
								lastGroup: ${lastGroup }
								nowGroup: ${nowGroup }
								groupStartPageNo:${groupStartPageNo }
								groupEndPageNo:${groupEndPageNo}
								prevGroupStartPageNo: ${prevGroupStartPageNo }
								nextGroupStartPageNo: ${nextGroupStartPageNo } --%>
								
								<c:if test="${nowGroup > 0}">
									<li><a href="javascript:movePage(0)">처음</a></li>
									<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
								</c:if>
								
								<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
									<li><a class="${pageNo eq mbrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
								</c:forEach>
								
								<c:if test="${lastGroup >nowGroup}">
									<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
									<li><a href="javascript:movePage(${lastPage})">끝</a></li>
								</c:if>
							</ul>
						</div>
				</div>
				<div class="grid-detail">
					<h1>권한/소속 변경</h1>
					<form id="detail_form">
						<!-- 
							 isModity== true -> 수정(update)
							 isModity== false -> 등록(insert) 
						--> 
						<input type="hidden" id="isModify" value="false"/>
						<div class="input-group inline">
							<label for="mbrId" style="width: 180px;">ID</label><input
								type="text" id="mbrId" name="mbrId" readonly value="" />
						</div>
						<div class="input-group inline">
							<label for="mbrNm" style="width: 180px;">이름</label><input
								type="text" id="mbrNm" name="mbrNm" readonly value="" />
						</div>
						<div class="input-group inline">
							<label for="mbrEml" style="width: 180px;">이메일</label><input
								type="email" id="mbrEml" name="mbrEml" readonly value="" />
						</div>
						<div class="input-group inline">
							<label for="mbrLvl" style="width: 180px;">현재등급</label><input
								type="text" id="prev-mbrLvl" name="cmmnCdVO.cdNm" readonly value="" />
							<input type="hidden" id="prev-mbrLvl-hidden" name="originMbrLvl" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prev-strNm" style="width: 180px;">소속매장</label><input
								type="text" id="prev-strNm" name="strVO.strNm" readonly value="" />
							<input type="hidden" id="prev-strId-hidden" name="originStrId" value=""/>
						</div>
						<div class="update-group">
							<div class="input-group inline">
								<label for="mbrLvl" style="width: 180px;">등급변경</label>
								<select id="select-mbrLvl" name="mbrLvl">
									<option value="">멤버등급</option>
									<option value="001-02">중간관리자</option>
									<option value="001-03">하위관리자</option>
								</select>
							</div>
							<div class="input-group inline">
								<label for="mbrLvl" style="width: 180px;">소속변경</label>
								<input type="text" id="search-strNm" name="strNm" readonly value="" />
								<input type="hidden" id="search-strId" name="strId" readonly value="" />
								<input type="hidden" id="prev-strId" name="originStrId" value="" />
								<button id="search-str-btn">검색</button>
							</div>
						</div>
					</form>
				</div>
				<div class="align-right">
					<button id="update_btn" class="btn-primary">변경</button>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>
