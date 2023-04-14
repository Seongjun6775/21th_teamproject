<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/evntCommon.css">
<meta charset="UTF-8">
<title>이벤트 상세 페이지</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$().ready(function() {
	
   
	console.log("${evntVO.evntStrtDt}");
	console.log("${evntVO.evntEndDt}");
	//수정 버튼을 누르면 수정화면으로 전환 
   $("#btn-update").click(function(){
	   
	   location.href="${context}/evnt/update/${evntVO.evntId}"
	   
	//var pop = window.open("${context}/evnt/update", "resPopup", "width=1100, height=900, scrollbars=yes, resizable=yes")
    //			pop.focus();
	/*    $.post(
	            // 1. 호출할 주소
	            "${context}/evnt/update",
	            
	            // 2. 파라미터
	            {
	               evntId: $("#evntId").val(),
	     
	            },
	            
	            // 3. 결과 처리
	            function(response) {
	               if (response.status == "200 OK") {
	                  alert(response.message);
	                  //location.reload(); // 새로고침
	               } else {
	                  alert(response.errorCode + " / " + response.message);
	               }
	            }); */
   });
   
   $("#btn-updateDelete").click(function(){
      $.post(
            // 1. 호출할 주소
            "${context}/api/evnt/delete",
            
            // 2. 파라미터
            {
               evntId: $("#evntId").val(),
     
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
   });
   
   
   //'목록으로'버튼 누르면 뒤로 돌아가기
   $("#btn-cancle").click(function(){
	   //location.href="${context}/evnt/list3"
	   history.go(-1);
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
                  style="width: 99%;" value="${evntVO.evntId}" readonly="readonly" style="background-color:red;" /></td>
            </tr>

            <tr>
               <td>이벤트 제목</td>
               <td colspan="3"><input type="text" id="evntTtl"
                  style="width: 99%;" value="${evntVO.evntTtl}" readonly="readonly" /></td>
            </tr>

            <tr>
               <td>이벤트 내용</td>
               <td colspan="3"><input type="text" id="evntCntnt"
                  style="width: 99%; height: 99px" value="${evntVO.evntCntnt}" readonly="readonly" /></td>
            </tr>

            <tr>
               <td>이벤트 시작일</td>
               <td><input type="date" id="evntStrtDt" value="${evntVO.evntStrtDt}" readonly="readonly" /></td>
               <td>이벤트 종료일</td>
               <td><input type="date" id="evntEndDt" value="${evntVO.evntEndDt}" readonly="readonly" /></td>
            </tr>

            <tr>
               <td>이벤트 사진</td>
               <td colspan="3"><input type="file" id="evntPht"
                  style="width: 99%;" value="${evntVO.evntPht}" readonly="readonly" /></td>
            </tr>

            <tr>
               <td>사용 여부</td>
               <td><input type="checkbox" id="useYn"
                  value="" checked/></td><td>${evntVO.useYn}</td>
               <td>삭제 여부</td>
               <td><input type="checkbox" id="delYn" value="${evntVO.delYn}" readonly="readonly" /></td>
            </tr>

            <tr>
               <td></td>
               <td></td>
               <td><button type="submit" id="btn-update" class="btn-primary" style="width:100%;">수정</button></td>
               <td><button type="submit" id="btn-updateDelete" class="btn-primary" style="width:100%;">삭제</button></td>
               <td><button type="submit" id="btn-cancle" class="btn-primary" style="width:100%;">목록으로</button></td>
            </tr>
         </table>
      </div>
   </div>
</body>
</html>