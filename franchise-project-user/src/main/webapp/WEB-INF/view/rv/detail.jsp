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
<jsp:include page="../include/stylescript.jsp" />

<link rel="stylesheet" href="${context}/css/brd_common.css?p=${date}"/>
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

	$().ready(function() {
		
		$("#list_btn").click(function() {
			location.href="${context}/mbr/rv/list";
		});
		
		$("#delete_btn").click(function(){
			
			if(confirm("정말 삭제하시겠습니까?")) {
				var form = $("<form></form>")
				var myMbrId = "${rvDetail.mbrId}";
				var myMbrLvl = "${sessionScope.__MBR__.mbrLvl}";
				var mbrId = "${sessionScope.__MBR__.mbrId}";
				if (myMbrLvl == "001-04" && myMbrId != mbrId) {
					Swal.fire({
				    	  icon: 'error',
				    	  title: '자신의 리뷰만 삭제 가능합니다.',
				    	  showConfirmButton: false,
				    	  timer: 2500
					});
					/* alert("자신의 리뷰만 삭제 가능합니다."); */
					return;		
				}
				$.post("${context}/mbr/api/rv/delete/${rvDetail.rvId}", function(response){
					if(response.status == "200 OK"){
						Swal.fire({
					    	  icon: 'success',
					    	  title: '리뷰가 삭제되었습니다.',
					    	  showConfirmButton: true,
					    	  confirmButtonColor: '#3085d6'
						}).then((result)=>{
							if(result.isConfirmed){
								location.href = "${context}/mbr/rv/list" + response.redirectURL;
							}
						});
						/* alert("리뷰가 삭제되었습니다.") */
					}
					else {
						Swal.fire({
					    	  icon: 'error',
					    	  title: response.message,
					    	  showConfirmButton: false,
					    	  timer: 2500
						});
						/* alert(response.errorCode + "권한이 없습니다." + response.message); */
					}
				})
			}
		});
		
		var ajaxUtil = new AjaxUtil();
		
		$("#showOdrLst").click(function() {
			
			var Id = $(this).val();
			$("#staticBackdropLabel").html(Id);
			
			$.post("${context}/api/odrLst/odrDtl", {odrLstId: Id}, function(data) {
				
				var table = $("<table></table>");
				table.addClass("table table-hover align-center");
				var thead = $("<thead></thead>");
				table.addClass("table table-striped");
				var tr = $("<tr></tr>");
				var thList = [
				  $("<th>주문상세ID</th>"),
				  $("<th>상품이름</th>"),
				  $("<th>단가</th>"),
				  $("<th>수량</th>"),
				  $("<th>금액</th>"),
				];
				thList.forEach(function(th) {
				  tr.append(th);
				});
				thead.append(tr);
				table.append(thead);
				
				var tbody = $("<tbody></tbody>");
				tbody.addClass("table-group-divider");
				var pay = 0;
				for (var i = 0; i < data.length; i++) {
				    var odrDtlId = data[i].odrDtlId;
				    var prdtNm = data[i].prdtVO.prdtNm;
				    var odrDtlPrdtCnt = data[i].odrDtlPrdtCnt;
				    var odrDtlPrc = data[i].odrDtlPrc;
				    var tr = $("<tr></tr>");
				    var tdList = [
						  $("<td>" + odrDtlId + "</td>"),
						  $("<td>" + prdtNm + "</td>"),
						  $("<td>" + odrDtlPrc.toLocaleString() + "</td>"),
						  $("<td>" + odrDtlPrdtCnt.toLocaleString() + "</td>"),
						  $("<td>" + (odrDtlPrc * odrDtlPrdtCnt).toLocaleString() + "</td>"),
						];
				    pay = pay + (odrDtlPrc * odrDtlPrdtCnt);
				    
						tdList.forEach(function(td) {
						  tr.append(td);
						});
					tbody.append(tr);
			    }
				table.append(tbody);
				
				$("div[class=modal-body]").html(table);
				var div = $("<div> 총 금액 : "+pay.toLocaleString() +"원</div>")
				div.css({
					"text-align":"right",
					"font-weight":"bold",
				});
				table.after(div);
				
				$("#modal").click();
			});		
			
		});
		$('body').on('click', function(event) {
			if ($("#staticBackdrop").attr("class").includes("show")) {
				if (!$(event.target).closest('.modal-content').length) {
					$('button[data-bs-dismiss=modal]').click();
				}
			}
		});
		$('body').keydown(function(key) {
			if (key.keyCode == 27) {
				$('button[data-bs-dismiss=modal]').click();
			}
		});
		
		
		
	});
</script>
<style>
.label-left-border{
	padding: 5px;
	border-left: solid #ffbe2e;
}
 .half-left , .half-right {
	width: 50%;
	display: inline-block;
}

.btn-default {
	border: solid 2px;
    font-weight: 800;
/*     margin-right: 15px; */
}
.ntc-label{ 
    border: 1px solid;
    padding: 3px 8px;
    border-radius: 5px;
}
</style>
</head>
<body class="scroll">
	<jsp:include page="../include/header_user.jsp" />

	<div class="visualArea flex relative">
		<div class="content-setting title">리뷰</div>
		<div class="overlay absolute"></div>
	</div>
	<div style="background-color: #ccc; height: 250px; display: flex;align-items: center;">
		<p style="margin: 0 auto; color: #fff; font-weight: bold; font-size: 20px;">변화를 만나는 곳, 변화를 만드는 곳.<br>프랜차이즈의 리뷰를 작성해보세요. </p>
	</div>
	<div id="menu" class="flex-column">	
		<div class="bg-white rounded shadow-sm" style="padding: 60px;  margin:20px; position: relative;">
				<div style="position: absolute; right: 0;top: 0; margin: 20px;">
					<button id="delete_btn" class="btn btn-outline-danger btn-default">삭제</button>
					<button id="list_btn" class="btn btn-secondary" >목록</button>
				</div>
			<h2 class="fw-bold" style="margin: 30px 30px 80px 30px;">구매후기</h2>
			
			
			<div class="flex">
				<div class="input-group" style="flex: 1; margin-top: 10px;">
					<label for="prdtCntnt" class="col-form-label">상품이름</label>
					<div>
						<textarea id="prdtCntnt" style="height:20px; resize: none; width: 45.5%;" readonly
								class="form-control">${rvDetail.prdtVO.prdtNm} 외 ${odrDtl.size() -1}건</textarea> 
					</div>
				</div>
			</div>
			<div class="half-right">
				<div class="input-group">
					<label for="prdtNm" class="col-form-label">제목</label>
					<div>
						<input type="text" class="form-control" readonly value="${rvDetail.rvTtl}"/>
					</div>
				</div>
				<div class="input-group">
					<label for="prdtNm" class="col-form-label">평가</label> 
					<div>
						<input type="text" id="rvLkDslk" name="rvLkDslk" class="form-control fw-bold" readonly style="color:${rvDetail.rvLkDslk eq 'T' ? '#00f' : '#f00'};" value="${rvDetail.rvLkDslk eq 'T' ? '좋아요!' : '싫어요!'}">
					</div>
				</div>
				<div class="input-group" style="flex: 1;">
					<label for="prdtCntnt" class="col-form-label" style="height: 40px;">내용</label>
					<div>
						<textarea id="prdtCntnt" style="height:220px; resize: none;" readonly
								class="form-control">${rvDetail.rvCntnt}</textarea>
					</div>
				</div>
			</div>
		</div>
	</div>				

	<!-- Button trigger modal -->
	<button id="modal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" style="display: none">
	  Launch static backdrop modal
	</button>
	<!-- modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content" style="width:960px; max-height: 70%; position: relative; top: 50%; left: 50%; transform: translateY(-50%) translateX(-50%);">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel"></h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
					<div class="modal-body">
					
					
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
<!-- <button type="button" class="btn btn-primary">Understood</button> -->
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../include/closeBody.jsp" />
</body>
</html>