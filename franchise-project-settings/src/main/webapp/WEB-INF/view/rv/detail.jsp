<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${context}/css/bootstrap.min.css?p=${date}">
<%-- <link rel="stylesheet" href="${context}/css/rv_common.css?p=${date}" /> --%>
<link rel="stylesheet" href="${context}/css/hr_mstr.css?p=${date}">
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("#list_btn").click(function() {
			location.href="${context}/rv/list";
		});
		
		$("#delete_btn").click(function(){
			
			if(confirm("정말 삭제하시겠습니까?")) {
				var form = $("<form></form>")
				var myMbrId = "${rvDetail.mbrId}";
				var myMbrLvl = "${sessionScope.__MBR__.mbrLvl}";
				var mbrId = "${sessionScope.__MBR__.mbrId}";
				if (myMbrLvl == "001-04" && myMbrId != mbrId) {
					alert("자신의 리뷰만 삭제 가능합니다.");
					return;		
				}
				$.post("${context}/api/rv/delete/${rvDetail.rvId}", function(response){
					if(response.status == "200 OK"){
						location.href = "${context}/rv/list" + response.redirectURL;
						alert("리뷰가 삭제되었습니다.")
					}
					else {
						alert(response.errorCode + "권한이 없습니다." + response.message);
					}
				})
			}
		});
	});
</script>
</head>
<jsp:include page="../include/openBody.jsp" />
		<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px; position: relative;">	
			<span class="fs-5 fw-bold"> 리뷰 > 리뷰목록 > 리뷰상세</span>
			<c:if test="${mbrVO.mbrLvl eq '001-01' || mbrVO.mbrLvl eq '001-04'}">
			<div style="position: absolute; right: 0;top: 0; margin: 20px;"">
				<button id="delete_btn" class="btn btn-danger">삭제</button>
				<button id="list_btn" class="btn btn-secondary" >목록</button>
			</div>
		</c:if>	
	    </div>	
	    		
	    		
	    <div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px; margin:20px;">
			<div style="padding:10px;">
				<span class="fs-5 fw-bold">${rvDetail.rvTtl}</span>
				<div class="hr_detail_header">(${rvDetail.rvId})</div>
			</div>
			<div style="margin-top: 10px">
			
			<div style="border-bottom: 1px solid #e0e0e0; padding-bottom: 15px; text-align: right;">
				<div class="hr_detail_header">등록일 : ${rvDetail.rvRgstDt}</div>
				<div class="hr_detail_header">작성자 : ${rvDetail.mbrId}</div>
			</div>
				<div style="padding:10px; ">

					<div style="padding: 10px;">
						<div class="fw-semibold" style="margin-bottom: 100px; height:220px; overflow: auto;">${rvDetail.rvCntnt}</div>
					</div>
				</div>
			</div>
		</div>	
		
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px;  margin:20px;">
			<div class="flex">
				<div class="half-left">
					<div class="input-group">
						<label for="prdtId" class="col-form-label">리뷰ID</label>
						<div>
							<input type="text" class="form-control readonly" readonly value="${rvDetail.rvId}"/>
						</div>
					</div>
					<div class="input-group">
						<label for="prdtNm" class="col-form-label">회원ID</label>
						<div>
							<input type="text" class="form-control" readonly value="${rvDetail.mbrId}"/>
						</div>
					</div>
					<div class="input-group">
						<label for="prdtNm" class="col-form-label">매장명</label>
						<div>
							<input type="text" class="form-control" readonly value="${rvDetail.strVO.strNm}"/>
						</div>
					</div>
					<div class="input-group">
						<label for="prdtNm" class="col-form-label">제목</label>
						<div>
							<input type="text" class="form-control" readonly value="${rvDetail.rvTtl}"/>
						</div>
					</div>
				</div>
				<div class="half-right">
					<div class="input-group">
						<label for="prdtNm" class="col-form-label">주문서ID</label>
						<div>
							<input type="text" class="form-control" readonly value="${rvDetail.odrLstId}"/>
						</div>
					</div>
					<div class="input-group">
						<label for="prdtNm" class="col-form-label">등록일</label>
						<div>
							<input type="text" class="form-control" readonly value="${rvDetail.rvRgstDt}"/>
						</div>
					</div>
					<div class="input-group">
						<label for="prdtNm" class="col-form-label">수정일</label>
						<div>
							<input type="text" class="form-control" readonly  value="${rvDetail.mdfyDt}"/>
						</div>
					</div>
					<div class="input-group">
						<label for="prdtNm" class="col-form-label">평가</label>
						<div>
							<input type="text" id="rvLkDslk" name="rvLkDslk" class="form-control" readonly value="${rv.rvLkDslk eq 'T' ? '좋아요' : '싫어요'}">
						</div>
					</div>
				</div>
			</div>
			
			<div class="input-group" style="flex: 1;">
				<label for="prdtCntnt" class="col-form-label">내용</label>
				<div>
					<textarea id="prdtCntnt" style="margin-top: 0.5rem; height:100px; resize: none;"
							class="form-control">${rvDetail.rvCntnt}</textarea>
				</div>
			</div>
		</div>	
		
											
		<div class="hr_table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
			<form id="detail_form" method="post">
				<div class="detail-group-inline">
					<label for="rvId">리뷰 ID</label>
					<input type="text" id="rvId" name="rvId" disabled value="${rvDetail.rvId}">
				</div>
				<div class="detail-group-inline">
					<label for="mbrId">회원 ID</label>
					<input type="text" id="mbrId" name="mbrId" disabled value="${rvDetail.mbrId}">
				</div>
				<div class="detail-group-inline">
					<label for="strNm">매장명</label>
					<input type="text" id="strNm" name="strNm" disabled value="${rvDetail.strVO.strNm}">
				</div>
				<div class="detail-group-inline">
					<label for="odrLstId">주문서 ID</label>
					<input type="text" id="odrLstId" name="odrLstId" disabled value="${rvDetail.odrLstId}">
				</div>
				<div class="detail-group-inline">
					<label for="rvTtl">제목</label>
					<input type="text" id="rvTtl" name="rvTtl" 
						   style="width: 665px;"
						   disabled value="${rvDetail.rvTtl}">
				</div>
				<div class="detail-group-inline">
					<label for="rvCntnt">내용</label>
					<div id="rvCntnt" 
						 style="display: grid; 
						   		margin: 3px; 
						   		width: 700px; 
						   		height: 400px; 
						   		resize: none; 
						   		border: none; 
						   		background-color: #3331; 
						   		white-space: pre-wrap;">${rvDetail.rvCntnt}</div>
				</div>
				<div class="detail-group-inline">
					<label for="rvLkDslk">좋아요/싫어요</label>
					<input type="text" id="rvLkDslk" name="rvLkDslk" disabled value="${rv.rvLkDslk eq 'T' ? '좋아요' : '싫어요'}">
				</div>
				<div class="detail-group-inline" style= "display: inline-flex;">
					<label for="rvRgstDt">등록일</label>
					<input type="text" id="rvRgstDt" name="rvRgstDt"								    
						   disabled value="${rvDetail.rvRgstDt}">
				</div>
				<div class="detail-group-inline" style= "display: inline-flex;">
					<label for="mdfyDt">수정일</label>
					<input type="text" id="mdfyDt" name="mdfyDt"								   
						   disabled value="${rvDetail.mdfyDt}">
				</div>
			</form>
		</div>
		

<jsp:include page="../include/closeBody.jsp" />
</html>