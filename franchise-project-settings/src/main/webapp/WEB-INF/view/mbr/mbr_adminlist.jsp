<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		
		$(".admin_table_grid > table > tbody > tr").click(function(){
			var data = $(this).data();
			$("#mbrId").val(data.mbrid);
			$("#mbrNm").val(data.mbrnm);
			$("#mbrEml").val(data.mbreml);
			$("#prev-mbrLvl").val(data.mbrlvlnm);
			$("#prev-strNm").val(data.strnm);
			$("#prev-mbrLvl-hidden").val(data.mbrlvl);
			$("#prev-strId-hidden").val(data.strid);
		});
		
		$("#all_check").click(function() {
			$(".check_idx").prop("checked", $("#all_check").prop("checked"));
		});
		$("#all_check").change(function(){
			$(".check-idx").prop("checked", $(this).prop("checked"));
		});
		$(".check-idx").change(function(){
			var count = $(".check-idx").length;
			var checkCount = $(".check-idx:checked").length;
			
			$("#all_check").prop("checked", count == checkCount);
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
			var strNm = $("#search-strNm").val();
			console.log(updateLvl);
			console.log(prevLvl);
			console.log(strNm);
			if(prevLvl.length ==0){
				if(prevLvl.length ==0){
					alert("회원을 선택하세요.");
					return;
				}
			}
			if(strNm.length == 0 ){
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
			}
			else if (strNm.length > 0){
				if(updateLvl == prevLvl || updateLvl.length==0){
					var confirmAlert = confirm("선택한 관리자의 등급과 변경하려는 등급이 같습니다.\n이대로 진행하시겠습니까?");
					if(confirmAlert){
						$("#select-mbrLvl").val(prevLvl);
						$.post("${context}/api/mbr/update/admin",$("#detail_form").serialize(),function(resp){
							if(resp.status=="200 OK"){
								alert("변경이 완료되었습니다.");
								location.reload();
							}
							else{
								alert(resp.message);
							}
						});
					}else{
						return;
					}
				}else{
					$.post("${context}/api/mbr/update/admin",$("#detail_form").serialize(),function(resp){
						if(resp.status=="200 OK"){
							alert("변경이 완료되었습니다.");
							location.reload();
						}
						else{
							alert(resp.message);
						}
					});
				}
			}
		});
		$("#search-str-btn").click(function(event){
			event.preventDefault();
			var prevMbrLvl = $("#prev-mbrLvl-hidden").val();
			var mbrLvl = $("#select-mbrLvl").val();
			if(prevMbrLvl.length == 0){
				alert("회원을 선택하세요");
				return;
			}
			if(mbrLvl.length == 0){
				mbrLvl = prevMbrLvl;
			}
			str=window.open("${context}/str/search/"+mbrLvl,"매장검색", "width=670, height=680");
		});
		$("#fire-btn").click(function(event){
			var confirmFire = confirm("선택된 관리자의 권한을 해지하시겠습니까?");
			var checkLen = $(".check-idx:checked").length;
			if(checkLen == 0){
				alert("권한을 해지할 관리자를 선택하세요.");
				return;
			}
			var mbrVOList=[];
			$(".check-idx:checked").each(function(){
				var mbrId = $(this).val();
				var mbrLvl = $(this).closest("tr").data("mbrlvl");
				var strId = $(this).closest("tr").data("strid");
				var mbrVO={
						"mbrId": mbrId,
						"mbrLvl": mbrLvl,
						"strId": strId
				};
				mbrVOList.push(mbrVO);
			});
			if(confirmFire){
				$.ajax({
				    type: "POST",
				    url: "${context}/api/mbr/admin/fire",
				    data: JSON.stringify(mbrVOList),
				    contentType: "application/json",
				    success: function(resp) {
				    	if(resp.status == "200 OK"){
							alert("관리자가 해임되었습니다.");
							location.reload();
						}else{
							alert(resp.message);
						}
				    }
				});
			}
		});
		$("#mbrLvl").change(function(){
			movePage(0);
		});
	});

	function movePage(pageNo){
		var mbrLvl = $("#mbrLvl option:selected").val();
		var mbrNm = $("#search-keyword-mbrNm").val();
		var startDt = $("#search-keyword-startdt").val();
		var endDt = $("#search-keyword-enddt").val();
		var strNm = $("#search-keyword-strNm").val();
		if(strNm == null || strNm.length == 0){
			strNm="%";
		}
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
		queryString += "&strVO.strNm=" + strNm;
		queryString += "&pageNo=" + pageNo;
		
		location.href="${context}/mbr/admin/list?" + queryString;
	}
</script>
</head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<jsp:include page="../include/openBody.jsp" />
			<!-- contents -->
			<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">
				<span class="fs-5 fw-bold">회원 > 관리자 > 관리자 목록</span>
		    </div>
      		<!-- /contents -->
      		<!-- searchbar -->
      		<div class="bg-white rounded shadow-sm " style="padding: 10px 18px 10px 18px;margin: 20px;display: flex;align-items: center;">
			  <!-- <label class="fs-7" style="min-width: 80px;display: inline-block;" for="startDt">Search</label> -->
			  <i class="bi bi-search" style="margin: 15px;"></i>
			  <!-- <label for="search-keyword-mbrNm" >이름</label> -->
					<input type="date" style ="margin-right: 10px;" id="search-keyword-startdt" class="form-control" value="${mbrVO.startDt}"/>
					<input type="date" style ="margin-right: 10px;" id="search-keyword-enddt" class="form-control" value="${mbrVO.endDt}"/>
					<input type="text" style ="margin-right: 10px;" id="search-keyword-mbrNm" class="form-control me-2" placeholder="이름 검색" value="${mbrVO.mbrNm}"/>
					<input type="text" style ="margin-right: 10px;" id="search-keyword-strNm" class="form-control me-2" placeholder="매장 검색" value="${mbrVO.strVO.strNm}"/>
					
					
					<button id="search-btn" class="btn btn-outline-success" type="submit" style="border: solid 2px;font-size: 17px;FONT-WEIGHT: 800;margin: 10px;">Search</button>
			</div>
      		<!-- searchbar -->
      		<!-- 조회영역 -->

	      		<div class="rounded" style="margin: 20px;">
	      			<div class="row" style="justify-content: space-between; margin: 0px;">
	      				<div class="col-9 admin_table_grid bg-white rounded shadow-sm" style="padding: 30px; height: auto;">
							<div>총 ${mbrList.size() > 0 ? mbrList.get(0).totalCount : 0 }건</div>
								<table class="table caption-top table-hover" style="text-align: center;">
									<thead class="table-secondary">
										<tr>
											<th scope="col" class="col-1"><input type="checkbox" id="all_check" class="form-check-input"/></th>
											<th scope="col" class="col-1">ID</th>
											<th scope="col" class="col-1">이름</th>
											<th scope="col" class="col-1">이메일</th>
											<th scope="col" class="col-1">매장명</th>
											<th scope="col" class="col-1">
												<select id="mbrLvl" name="mbrLvl" class="form-select" aria-label="Default select example">
													<option value="">직급</option>
													<c:choose>
															<c:when test="${not empty srtList}">
																<c:forEach items="${srtList}" var="srt">
																	<option value="${srt.cdId}">${srt.cdNm eq '가맹점주' ? '가맹점주' : '점원'}</option>
																</c:forEach>
															</c:when>
														</c:choose>
												</select>
											</th>
											<th scope="col" class="col-2">최근 로그인</th>
											<th scope="col" class="col-1">로그인 제한</th>
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
														<td class="firstcell">
															<input type="checkbox" class="check-idx form-check-input" value="${mbr.mbrId}"/>
														</td>
														<td>${fn:substring(mbr.mbrId, 0, fn:length(mbr.mbrId)-3)}***</td>
														<td>${mbr.mbrNm}</td>
														<td>${mbr.mbrEml}</td>
														<td>${mbr.strVO.strNm}</td>
														<td>${mbr.cmmnCdVO.cdNm eq '가맹점주' ? '가맹점주' : '점원'}</td>
														<td>${mbr.mbrRcntLgnDt}</td>
														<td>${mbr.mbrLgnBlckYn}</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="8" class="no-items">등록된 관리자가 없습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
										<div class="align-right mt-10">
											<button id="fire-btn" class="btn btn-outline-danger fire-btn" style="border: solid 2px; font-weight: 800;">해임</button>
										</div>
										<div class="pagenate">
											<nav aria-label="Page navigation example">
												<ul class="pagination" style="text-align: center;">
													<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastPage : 0}" var="lastPage"/>
													<c:set value = "${mbrList.size() > 0 ? mbrList.get(0).lastGroup : 0}" var="lastGroup"/>
													
													<!-- Math.floor(mbrVO.pageNo / 10) -->
													<fmt:parseNumber var="nowGroup" value="${Math.floor(mbrVO.pageNo / 10)}" integerOnly = "true"/>
													<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
													<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
													<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1 }" var="groupEndPageNo"/>
													
													<c:set value="${(nowGroup - 1 ) * 10}" var="prevGroupStartPageNo"/>
													<c:set value="${(nowGroup + 1 ) * 10}" var="nextGroupStartPageNo"/>
													
													<c:if test="${nowGroup > 0}">
														<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
														<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
													</c:if>
													
													<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
														<li class="page-item"><a class="page-link text-secondary ${pageNo eq mbrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
													</c:forEach>
													
													<c:if test="${lastGroup >nowGroup}">
														<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
														<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
													</c:if>
												</ul>
											</nav>
										</div>
				      		<!-- 조회영역 -->
							</div>
	      			
	      					<div class="col-2 admin_detail_table_grid bg-white rounded shadow-sm" style="padding: 30px; height: auto; width: 380px">
								<!-- 변경영역 -->
					      		<div class="grid-detail">
									<h5>관리자 정보</h5>
									<form id="detail_form" class="needs-validation">
										<div class="row g-3">
											<div class="input-group col-12">
												<span class="input-group-text">&nbsp;ID&nbsp;&nbsp;</span>
												<input type="text" id="mbrId" name="mbrId" class="form-control" readonly value="">
											</div>
											<div class="input-group col-12">
												<span class="input-group-text">이름</span>
												<input type="text" id="mbrNm" name="mbrNm" class="form-control" readonly value="">
											</div>
											<div class="input-group col-12">
												<span class="input-group-text">&nbsp;@&nbsp;&nbsp;</span>
												<input type="text" id="mbrEml" name="mbrEml" class="form-control" readonly value="">
											</div>
											<div class="input-group col-12">
												<span class="input-group-text">직급</span>
												<input type="text" id="prev-mbrLvl" name="cmmnCdVO.cdNm" class="form-control rounded-end" readonly value="">
												<input type="hidden" id="prev-mbrLvl-hidden" name="originMbrLvl" value=""/>
											</div>
											<div class="input-group col-12">
												<span class="input-group-text">소속</span>
												<input type="text" id="prev-strNm" name="strVO.strNm" class="form-control rounded-end" readonly value="">
												<input type="hidden" id="prev-strId-hidden"  name="originStrId" value=""/>
											</div>
											<div class="update-group row g-3">
												<h5>직급 변경</h5>
												<div class="input-group col-12">
													<select id="select-mbrLvl" class="form-select" name="mbrLvl" >
														<option value="">변경 직급</option>
														<option value="001-02">가맹점주</option>
														<option value="001-03">점원</option>
													</select>
												</div>
												<h5>소속 변경</h5>
												<div class="input-group col-12">
													<button class="btn btn-outline-success" id="search-str-btn" style="font-weight: 800;">Search</button>
													<input type="text" id="search-strNm" name="strNm" class="form-control rounded-end" placeholder="매장 검색" readonly value="" aria-describedby="search-str-btn">
													
													<input type="hidden" id="search-strId" name="strId" readonly value="" />
												</div>
											</div>
										</div>
									</form>
									
								</div>
								<div class="align-right" style="margin-top: 16px;">
	 								<button id="update_btn" class="btn btn-outline-primary" style="border: solid 2px; font-weight: 800; margin-right: 15px;">변경</button>
								</div>
							</div>
	      			</div>
	      		</div>
<jsp:include page="../include/closeBody.jsp" />
<body>
				
</body>
</html>
