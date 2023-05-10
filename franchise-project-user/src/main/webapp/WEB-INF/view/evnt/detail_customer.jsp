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
	
		
		//'목록으로'버튼 누르면 뒤로 돌아가기
		$("#btn-cancle").click(function() {
			location.href="${context}/evnt/list"
			//history.go(-1);
		});

	})
</script>
<style>
.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
}
</style>
</head>
<jsp:include page="../include/openBody.jsp" />
	<div class="bg-white rounded shadow-sm  " style=" padding: 23px 18px 23px 18px; margin: 20px;">	
			<span class="fs-5 fw-bold">이벤트 > 상세페이지</span>
			<div style="float: right;">
				<button type="submit" id="btn-cancle" class="btn btn-secondary">목록</button>
			</div>
	</div>
	
	
		<div class="card hr_table_grid bg-white rounded shadow-sm" style="margin: 20px; padding:20px; border-radius:30px; display:inline-flex;">
            <div class="bd-placeholder-img card-img-top" >
            	<div style="text-align: center;; background-color: #FFFFF;">
            		<img src="${context}/evnt/img/${evntVO.uuidFlNm}" style="height:100; width:70;" />
            	</div>
            </div>

            <div class="card-body">
            	<p class="card-text" style="float: right;">이벤트 기간: ${evntVO.evntStrtDt} ~ ${evntVO.evntEndDt}</p>
            	<p class="card-text fw-bold" >${evntVO.evntTtl}</p>
            	<p class="card-text">${evntVO.evntCntnt}</p>

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