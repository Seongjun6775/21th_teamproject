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
			<div style="position: absolute; right: 0;top: 0; margin: 20px;">
				<button id="delete_btn" class="btn btn-danger">삭제</button>
				<button id="list_btn" class="btn btn-secondary" >목록</button>
			</div>
		</c:if>	
	    </div>		
		<div class="bg-white rounded shadow-sm" style="padding: 23px 18px 23px 18px;  margin:20px;">
			<div class="flex">
				<div class="half-left">
					<div class="input-group">
						<label for="prdtId" class="col-form-label">리뷰ID</label>
						<div>
							<input type="text" class="form-control" readonly value="${rvDetail.rvId}"/>
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
				<label for="prdtCntnt" class="col-form-label">상품이름</label>
				<div>
					<textarea id="prdtCntnt" style="margin-top: 0.5rem; height:20px; resize: none;"
							class="form-control">${rvDetail.prdtVO.prdtNm}</textarea>
				</div>
			</div>
			<div class="input-group" style="flex: 1;">
				<label for="prdtCntnt" class="col-form-label">내용</label>
				<div>
					<textarea id="prdtCntnt" style="margin-top: 0.5rem; height:400px; resize: none;"
							class="form-control">${rvDetail.rvCntnt}</textarea>
				</div>
			</div>
		</div>				

<jsp:include page="../include/closeBody.jsp" />
</html>