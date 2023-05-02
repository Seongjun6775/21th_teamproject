<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ktds.fr.mbr.vo.MbrVO" %>
<%@page import="java.util.Random"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<%
	MbrVO mbrVO = (MbrVO) session.getAttribute("__MBR__");
%>
<link rel="stylesheet" href="../../css/evntCommon.css?p=${date}" />
<meta charset="UTF-8">
<title>이벤트 상세 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		$("#useYn").prop("checked", "${evntVO.useYn}" == "Y");
		
		//수정 버튼을 누르면 수정화면으로 전환 
		$("#btn-update").click(function() {
			location.href = "${context}/evnt/update/${evntVO.evntId}"
		});
		//삭제 버튼 누르면 삭제하시겠습니까? 물어보고 삭제하기
		
		$("#btn-updateDelete").click(function() {
			
	      if(!confirm("삭제 하시겠습니까?")){
				alert("취소되었습니다.")		
			} 
	      else{
				$.post(							
						// 1. 호출할 주소
						"${context}/api/evnt/delete",
						// 2. 파라미터
						{
							evntId : $("#evntId").val(),
						},
						// 3. 결과 처리
						function(response) {
							if (response.status == "200 OK") {
								alert(response.message);
								//location.reload(); // 새로고침
								location.href="${context}/evnt/list";
							} else {
								alert(response.errorCode + " / " + response.message);
							}
						});
					} 
				});
		
		// '참여매장등록하기' 버튼 클릭 시
		$("#btn-createEvntStr").click(function() {
			if (!confirm("소속 매장을 이벤트 참여 매장으로 하시겠습니까?\n확인(예) 또는 취소(아니오)를 선택해주세요.")) {
	            alert("취소(아니오)를 누르셨습니다.");
	        } else {
	        	$.post(
	        			// 1. 호출할 주소
	        			"${context}/api/evntStr/create",
	        			// 2. 파라미터
	        			{
	        				evntId : $("#evntId").val(),
	        			},
	        			// 3. 결과 처리
	        			function(response) {
	        				if (response.status == "200 OK") {
	        					alert(response.message);
	        					//location.reload(); // 새로고침
	        				} else {
	        					alert(response.errorCode + " / " + response.message);
	        				}
	        			});
	        }
		});
		
		//'목록으로'버튼 누르면 뒤로 돌아가기
		$("#btn-cancle").click(function() {
			//location.href="${context}/evnt/list3"
			history.go(-1);
		});
		
		//'참여매장목록' 버튼 클릭 시 팝업창으로 리스트 뜸
		$("#btn-evntStr").click(function() {
			var pop = window.open("${context}/evntStr/list/${evntVO.evntId}", "resPopup", "width=800, height=600, scrollbars=yes, resizable=yes"); 
		       pop.focus();	
		});
		
		//'이벤트상품목록' 버튼 클릭 시 팝업창으로 리스트 뜸
		$("#btn-evntPrdt").click(function() {
			var pop = window.open("${context}/evntPrdt/list/${evntVO.evntId}", "resPopup", "width=500, height=400, scrollbars=yes, resizable=yes"); 
		       pop.focus();	
		});
		
		//'이벤트상품등록' 버튼 클릭 시 팝업창으로 뜸
		$("#btn-createEvntPrdt").click(function() {
			var pop = window.open("${context}/evntPrdt/prdtList2/${evntVO.evntId}" ,  "resPopup", "width=1500, height=800, scrollbars=yes, resizable=yes"); 
		       pop.focus();	
		});
	})
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">이벤트 > 상세페이지</span>
			<div style="float: right;">
				<button type="submit" id="btn-cancle" class="btn btn-secondary">목록</button>
			</div>
	</div>
	
	
		<div class="card hr_table_grid bg-white rounded shadow-sm" style="margin: 20px;">
            <div class="bd-placeholder-img card-img-top" >
            	<div style="text-align: center;; background-color: #55595c;">
            		<img src="${context}/evnt/img/${evntVO.uuidFlNm}" style="width:60%" />
            	</div>
            </div>

            <div class="card-body">
            	<p class="card-text" style="float: right;">이벤트 기간: ${evntVO.evntStrtDt} ~ ${evntVO.evntEndDt}</p>
            	<p class="card-text">${evntVO.evntTtl}</p>
            	<p class="card-text">${evntVO.evntCntnt}</p>
	            <div class="d-flex justify-content-between align-items-center">
		            <div class="btn-group">
			            <c:if test="${mbrVO.mbrLvl eq '001-01'}">
							<button type="button" id="btn-createEvntPrdt" class="btn btn-sm btn-outline-secondary">이벤트상품등록</button>
							<button type="button" id="btn-evntStr" class="btn btn-sm btn-outline-secondary">참여매장목록</button>
						</c:if>
						<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-02'}">
						<button type="button" id="btn-evntPrdt" class="btn btn-sm btn-outline-secondary">이벤트상품목록</button>
						</c:if>
						<c:if test="${mbrVO.mbrLvl eq '001-02'}">
							<button type="submit" id="btn-createEvntStr" class="btn btn-sm btn-outline-secondary">참여매장등록</button>
						</c:if>
		            </div>  
                <div>
                	<div class="form-check" style="display: inline-block; margin: 10px;">
					  <input type="checkbox" id="useYn" class="form-check-input" value="${evntVO.useYn}"  onclick="return false;"/>
					  <label class="form-check-label" for="flexCheckDefault">
					    사용여부
					  </label>
					</div>
					
					<c:if test="${mbrVO.mbrLvl eq '001-01'}">
						<button type="button" id="btn-update" class="btn btn-sm btn-success">수정</button>
					</c:if>
					<c:if test="${mbrVO.mbrLvl eq '001-01'}">
						<button type="button" id="btn-updateDelete"class="btn btn-sm btn-danger" >삭제</button>
					</c:if>
                </div>
              </div>
            </div>
          </div>
<%-- 		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<table border=1 style="width: 600px;">
				<tr>
					<td colspan="4"><h1 style="text-align: center;">이벤트 상세페이지</h1></td>
				</tr>
				<tr>
					<td style="width:150px;">이벤트 ID</td>
					
					<td colspan="3"><input type="text" id="evntId"
						style="width: 99%;" value="${evntVO.evntId}" readonly="readonly"
						style="background-color:red;" /></td>
				</tr>

				<tr>
					<td>이벤트 제목</td>
					<td colspan="3"><input type="text" id="evntTtl"
						style="width: 99%;" value="${evntVO.evntTtl}" readonly="readonly" /></td>
				</tr>

				<tr>
					<td>이벤트 내용</td>
					<td colspan="3"><input type="text" id="evntCntnt"
						style="width: 99%; height: 99px" value="${evntVO.evntCntnt}"
						readonly="readonly" /></td>
				</tr>

				<tr>
					<td style="width:150px;">이벤트 시작일</td>
					<td style="width:150px;"><input type="date" id="evntStrtDt"
						value="${evntVO.evntStrtDt}" readonly="readonly" /></td>
					<td style="width:150px;">이벤트 종료일</td>
					<td style="width:150px;"><input type="date" id="evntEndDt"
						value="${evntVO.evntEndDt}" readonly="readonly" /></td>
				</tr>

				<tr>
		
					<td>이벤트 사진</td>
					<td colspan="3">
					<img src="${context}/evnt/img/${evntVO.uuidFlNm}" style="width:100%;"/>
					
					</td>
						
				</tr>

				<tr>
					<td>사용 여부</td>
					<td><input type="checkbox" id="useYn" value="${evntVO.useYn}"  onclick="return false;"/></td>
					
				</tr>

				<tr>
					<td></td>
					<td></td>
					<c:if test="${mbrVO.mbrLvl eq '001-01'}">
					<td><button type="submit" id="btn-update" class="btn-primary"
							style="width: 100%;">수정</button></td>
					</c:if>
					<c:if test="${mbrVO.mbrLvl eq '001-01'}">
					<td><button type="submit" id="btn-updateDelete"
							class="btn-primary" style="width: 100%;">삭제</button></td>
					</c:if>
				</tr>

				<tr>
					<c:if test="${mbrVO.mbrLvl eq '001-01'}">
					<td><button type="submit" id="btn-evntStr" class="btn-primary"
							style="width: 100%;">참여매장목록</button></td>
					</c:if>
					<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-02'}">
					<td><button type="submit" id="btn-evntPrdt" class="btn-primary"
							style="width: 100%;">이벤트상품목록</button></td>
					</c:if>
					<c:if test="${mbrVO.mbrLvl eq '001-02'}">
					<td><button type="submit" id="btn-createEvntStr" class="btn-primary"
							style="width: 100%;">참여매장등록</button></td>
					</c:if>
					<c:if test="${mbrVO.mbrLvl eq '001-01'}">
					<td><button type="submit" id="btn-createEvntPrdt" class="btn-primary"
							style="width: 100%;">이벤트상품등록</button></td>
					</c:if>
				</tr>
			</table>
		</div> --%>
<jsp:include page="../include/closeBody.jsp" />
 	<%-- <script type="text/javascript">
	const btn1 = document.getElementById("btn-evntStr");
	const btn2 = document.getElementById("btn-createEvntStr");
	
	var mbrLvl = "<%=mbrVO.getMbrLvl()%>";
	alert("mbrLv1 : " + mbrLvl);
	if (mbrLvl == "001-01"){
		btn1.style.visibility = "visible";
	} else {
		btn1.style.visibility = "hidden";
	}
	if (mbrLvl == "001-02"){
		btn2.style.visibility = "visible";
	} else {
		btn2.style.visibility = "hidden";
	} 
	
	</script>  --%>
	
	

</html>