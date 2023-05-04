<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		var valueUtil = new ValueUtil();
		var originNm = "${myMbr.getMbrNm()}";
		
		$("#mbrNm").keyup(function(){
			var mbrNm = $(this).val();
			mbrNm = mbrNm.replace(/\s/gi, "");
			$("#mbrNm").val(mbrNm);
		});
		
		$("#update_info_btn").click(function(event){
			event.preventDefault();
			var mbrNm = $("#mbrNm").val();
			if(!valueUtil.requires("#mbrNm")){
				return;
			}
			if(originNm == mbrNm){
				alert("변경된 부분이 없습니다.");
				return;
			}
			$.post("${context}/api/mbr/update", $("#info_form").serialize(), function(resp){
				if(resp.status =="200 OK"){
					location.href="${context}"+resp.redirectURL;
				}
				else{
					alert(resp.message);
				}
			});
		});
		$("#update_pwd_btn").click(function(event){
			location.href="${context}/mbr/change/pwd";
		});
		$("#signout_mbr_btn").click(function(event){
			if(confirm("회원탈퇴를 진행하시겠습니까?")){
				$.get("${context}/api/mbr/signout", function(resp){
					if(resp.status == "200 OK"){
						alert("정상적으로 탈퇴되었습니다.");
						location.href="${context}"+resp.redirectURL;
					}else{
						alert(resp.message);
					}
				});
			}else{
				
			}
		});
	});
</script>
</head>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">회원정보 > 개인정보</div>
				
				<div class="infoGroup">
					<div>
						<form id="info_form" class="info_form">
							<!-- 
								 isModity== true -> 수정(update)
								 isModity== false -> 등록(insert) 
							-->
							<div class="infoBox">
								<input type="hidden" id="isModify" value="false"/>
								<div class="info-item">
									<label for="mbrId" style="width: 180px;">ID</label><input
										type="text" class="readonly" id="mbrId" name="mbrId" readonly onfocus="this.blur()" value="${myMbr.getMbrId()}" />
								</div>
								<div class="info-item">
									<label for="mbrNm" style="width: 180px;">이름</label><input
										type="text" id="mbrNm" name="mbrNm" value="${myMbr.getMbrNm()}" data-field-name="이름" />
								</div>
								<div class="info-item">
									<label for="mbrEml" style="width: 180px;">이메일</label><input
										type="email" class="readonly" id="mbrEml" name="mbrEml" readonly onfocus="this.blur()" value="${myMbr.getMbrEml()}" />
								</div>
								<div class="info-item">
									<label for="mbrLvl" style="width: 180px;">회원등급</label>
									<input type="text" class="readonly" id="mbrLvl" readonly onfocus="this.blur()" value="${myMbr.getCmmnCdVO().getCdNm()}" />
								</div>
								<div class="info-item">
									<label for="mbrPyMn" style="width: 180px;">내지갑</label><input
										type="text" class="readonly" id="mbrPyMn" readonly onfocus="this.blur()" value="${myMbr.getMbrPyMn()}" />
								</div>
							</div>
						</form>
						<button class="update-btn" id="update_info_btn">수정</button>
						<button class="update-btn" id="update_pwd_btn">비밀번호 변경</button>
						<button class="leave-btn" id="signout_mbr_btn">회원탈퇴</button>
					</div>	
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</html>