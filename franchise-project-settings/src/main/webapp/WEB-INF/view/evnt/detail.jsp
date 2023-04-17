<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ktds.fr.mbr.vo.MbrVO" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<%
	MbrVO mbrVO = (MbrVO) session.getAttribute("__MBR__");
%>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 상세 페이지</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {

		//수정 버튼을 누르면 수정화면으로 전환 
		$("#btn-update").click(function() {

			location.href = "${context}/evnt/update/${evntVO.evntId}"
		});

		$("#btn-updateDelete").click(function() {
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
		});
		
		// '참여매장등록하기' 버튼 클릭 시
		$("#btn-evntCreateStr").click(function() {
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
			var pop = window.open("${context}/evntStr/list/${evntVO.evntId}", "resPopup", "width=500, height=400, scrollbars=yes, resizable=yes"); 
		       pop.focus();	
		});
		
		//'이벤트상품목록' 버튼 클릭 시 팝업창으로 리스트 뜸
		$("#btn-evntPrdt").click(function() {
			var pop = window.open("${context}/evntPrdt/list/${evntVO.evntId}", "resPopup", "width=500, height=400, scrollbars=yes, resizable=yes"); 
		       pop.focus();	
		});

	})
</script>
</head>
<body>

	<div class="main-layout">
		<div>
			<table border=1 style="width: 600px;">
				<tr>
					<td colspan="4"><h1 style="text-align: center;">이벤트 상세
							페이지</h1></td>
				</tr>
				<tr>
					<td>이벤트 ID</td>
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
					<td>이벤트 시작일</td>
					<td><input type="date" id="evntStrtDt"
						value="${evntVO.evntStrtDt}" readonly="readonly" /></td>
					<td>이벤트 종료일</td>
					<td><input type="date" id="evntEndDt"
						value="${evntVO.evntEndDt}" readonly="readonly" /></td>
				</tr>

				<tr>
					<td>이벤트 사진</td>
					<td colspan="3"><input type="file" id="evntPht"
						style="width: 99%;" value="${evntVO.evntPht}" readonly="readonly" /></td>
				</tr>

				<tr>
					<td>사용 여부</td>
					<td><input type="checkbox" id="useYn" value="${evntVO.useYn}" checked/></td>
					<td>삭제 여부</td>
					<td><input type="checkbox" id="delYn" value="${evntVO.delYn}"
						readonly="readonly" /></td>
				</tr>

				<tr>
					<td><button type="submit" id="btn-cancle" class="btn-primary"
							style="width: 100%;">목록으로</button></td>
					<td></td>
					<td><button type="submit" id="btn-update" class="btn-primary"
							style="width: 100%;">수정</button></td>
					<td><button type="submit" id="btn-updateDelete"
							class="btn-primary" style="width: 100%;">삭제</button></td>
				</tr>

				<tr>
					<td><button type="submit" id="btn-evntStr" class="btn-primary"
							style="width: 100%;">참여매장목록</button></td>
					<td><button type="submit" id="btn-evntPrdt" class="btn-primary"
							style="width: 100%;">이벤트상품목록</button></td>
					<td><button type="submit" id="btn-evntCreateStr" class="btn-primary"
							style="width: 100%;">참여매장등록</button></td>
					<td></td>
				</tr>
			</table>
		</div>
	</div>
	
	<script type="text/javascript">
	const btn1 = document.getElementById("btn-evntStr");
	const btn2 = document.getElementById("btn-evntCreateStr");
	
	var mbrLvl = "<%=mbrVO.getMbrLvl()%>";
	alert("mbrLv1 : " + mbrLvl);

	if (mbrLvl == "ADMIN"){
		btn1.style.visibility = "visible";
	} else {
		btn1.style.visibility = "hidden";
	}

	if (mbrLvl == "MANAGER"){
		btn2.style.visibility = "visible";
	} else {
		btn2.style.visibility = "hidden";
	}
	
	</script>
	
	
</body>
</html>