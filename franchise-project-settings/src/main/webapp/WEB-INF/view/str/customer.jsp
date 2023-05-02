<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 지도</title>
<jsp:include page="../include/stylescript.jsp" />
<link rel="stylesheet" href="${context}/css/str_common.css?p=${date}" />
<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script type="text/javascript">
	$().ready(function() {
		$(".table_grid > table > tbody > tr").click(function(){
			$("#isModify").val("true"); //수정모드
			var data = $(this).data();
			$("#strId").val(data.strid);
			$("#strNm").val(data.strnm);
			$("#strLctn").val(data.strlctn);
			$("#strCty").val(data.strcty);
			$("#strAddr").val(data.straddr);
			$("#strCallNum").val(data.strcallnum);
			$("#mbrId").val(data.mbrid + "(" + data.mbrnm + ")");
			$("#strOpnTm").val(data.stropntm);
			$("#strClsTm").val(data.strclstm);
			$("#strRgstr").val(data.strrgstr);
			$("#strRgstDt").val(data.strrgstdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			$("#useYn").prop("checked", data.useyn == "Y");
		});
		$("#strnm").click(function() {
			
		});
		
		$("#new_btn").click(function() {
			$("#isModify").val("false"); //등록모드
			$("#strId").val("");
			$("#strNm").val("");
			$("#strLctn").val("");
			$("#strCty").val("");
			$("#strAddr").val("");
			$("#strCallNum").val("");
			$("#mbrId").val("");
			$("#strOpnTm").val("");
			$("#strClsTm").val("");
			$("#strRgstr").val("${mbrVO.mbrId}");
			$("#strRgstDt").val("");
			$("#mdfyr").val("${mbrVO.mbrId}");
			$("#mdfyDt").val("");
			$("#useYn").prop("checked", false);
		});
			
			$("#index_btn").click(function(){
				location.href= "${context}/index";
			});
			
			$("#all_check").change(function(){
				console.log($(this).prop("checked"));
				$(".check_idx").prop("checked", $(this).prop("checked"));
			});
			
			$(".check_idx").change(function(){
				var count = $(".check_idx").length;
				var checkCount = $(".check_idx:checked").length;
				$("#all_check").prop("checked", count == checkCount);
			});
			
			$("#search-keyword-strLctn").change(function(){
				movePage(0);
			});
			$("#search-keyword-strCty").change(function(){
				movePage(0);
			});
			
			$("#strLctn").change(function() {
				
				var strLctn = $("#strLctn").val();
				
				$.get("${context}/api/str/changecty", {"lctId": strLctn}, function(response){})
			});
			
		});
		function movePage(pageNo){
		//전송
		//입력 값.
		var searchIdx = $("#search-select").val();
		var keyword = $("#search-keyword").val();
		var strLctn = $("#search-keyword-strLctn").val();
		var strCty = $("#search-keyword-strCty").val();
		
		var queryString = "searchIdx=" + searchIdx;
		queryString += "&keyword=" + keyword;
		queryString += "&strLctn=" +strLctn;
		queryString += "&strCty=" +strCty;
		queryString += "&pageNo=" +pageNo;
		
		
		//url요청
		location.href = "${context}/str/list?" + queryString;
		}
		</script>
</head>

<jsp:include page="../include/openBody.jsp" />
<div class="bg-white rounded shadow-sm  "
	style="padding: 23px 18px 23px 18px; margin: 20px;">
	<span class="fs-5 fw-bold">매장 > 매장지도</span>
</div>
		<div class="table_grid bg-white rounded shadow-sm" style="padding: 30px; margin: 20px; ">
		<div style="margin: 13px;">총${strList.size() > 0 ? strList.get(0).totalCount : 0}건</div>	
			<table class="table caption-top table-hover" style="text-align: center;">
				<thead class="table-secondary" style="border-bottom: 2px solid #adb5bd;">
					<tr>
						<th scope="col" style="width:250px; padding: 20px 20px 8px 20px;">매장명</th>
						<th scope="col" style="padding: 20px 20px 8px 20px; width: 150px">
							<select class="form-select" name="selectFilter" 
										id="search-keyword-strLctn">
								<option value="">지역명</option>
								<c:choose>
									<c:when test="${not empty lctList}">
										<c:forEach items="${lctList}"
													var="lct"> 
											<option value="${lct.lctId}" ${strVO.strLctn eq lct.lctId ? 'selected' : ''}>${lct.lctNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</th>
						<th scope="col" style="padding: 20px 20px 8px 20px; width: 150px">
							<select class="form-select" name="selectFilter"
										id="search-keyword-strCty">
								<option value="">도시명</option>
								<c:choose>
									<c:when test="${not empty ctyList}">
										<c:forEach items="${ctyList}"
													var="cty" >
											<option value="${cty.ctyId}" ${strVO.strCty eq cty.ctyId ? 'selected' : ''}>${cty.ctyNm}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty strList}">
							<c:forEach items="${strList}"
									var="str">
							<tr  data-strid="${str.strId}" 
							data-strnm="${str.strNm}" 
							data-strlctn="${str.lctCdVO.lctId}" 
							data-strcty="${str.ctyCdVO.ctyId}" 
							data-straddr="${str.strAddr}" 
							data-strcallnum="${str.strCallNum}" 
							data-mbrid="${str.mbrId}" 
							data-mbrnm="${str.mbrVO.mbrNm}" 
							data-stropntm="${str.strOpnTm}" 
							data-strclstm="${str.strClsTm}" 
							data-strrgstr="${str.strRgstr}" 
							data-strrgstdt="${str.strRgstDt}" 
							data-mdfyr="${str.mdfyr}" 
							data-mdfydt="${str.mdfyDt}" 
							data-useyn="${str.useYn}" >
								<td>${str.strNm}</td>
								<td>${str.lctCdVO.lctNm}</td>
								<td>${str.ctyCdVO.ctyNm}</td>
							</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="9" class="no-items">
									등록된 매장이 없습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="pagenate">
				<nav aria-label="Page navigation example">
					<ul class="pagination" style="text-align: center;">
						<c:set value="${strList.size() > 0 ? strList.get(0).lastPage : 0}" var="lastPage"/>
						<c:set value="${strList.size() > 0 ? strList.get(0).lastGroup : 0}" var="lastGroup"/>
						
						<fmt:parseNumber var="nowGroup" value="${Math.floor(strVO.pageNo / 10)}" integerOnly="true"/>
						<c:set value="${nowGroup * 10}" var="groupStartPageNo"/>
						<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo"/>
						<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo"/>
					
						
						<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo"/>
						<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo"/>
					
						<c:if test="${nowGroup > 0}">
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(0)">처음</a></li>
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${prevGroupStartpageNo})">이전</a></li>
						</c:if>
						
						<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
							<li class="page-item"><a class="page-link text-secondary" class="${pageNo eq strVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
						</c:forEach>
					
						<c:if test=" ${lastGroup > nowGroup}">
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
							<li class="page-item"><a class="page-link text-secondary" href="javascript:movePage(${lastPage})">끝</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
	<div id="map" style="width:500px;height:400px;"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7121fa95573c132c57b4649cfa281f57&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨
		};
	
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		geocoder.addressSearch('서울 강남구 강남대로 406 글라스타워 2층',function(result, status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y,
						result[0].x);

	 			// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new kakao.maps.Marker({
					map : map,
					position : coords
				});

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			} 
		// 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    {
		        title: '서귀포점', 
		    	geocoder: new addressSearch('제주특별자치도 서귀포시 가가로 25',function(result, status);
		        latlng: new kakao.maps.LatLng(result[0].y,result[0].x)
		    },
		    
		    {
		        title: '서초점', 
		    	geocoder: new addressSearch('서울 서초구 서초대로46길 3 경중빌딩 101-1호',function(result, status);
		    	latlng: new kakao.maps.LatLng(result[0].y,result[0].x)
		    },
		    
		    {
		        title: '해운대점', 
		        geocoder: new addressSearch('부산 해운대구 우동1로20번길 19',function(result, status);
		        latlng: new kakao.maps.LatLng(result[0].y,result[0].x)
		    },
		    
		    {
		        title: '강남점	',
		        geocoder: new addressSearch('서울 강남구 강남대로 406 글라스타워 2층',function(result, status);
		        latlng: new kakao.maps.LatLng(result[0].y,result[0].x)
		    },
		    
		    {
		        title: '분당점',
		        geocoder: new addressSearch('경기 성남시 분당구 성남대로916번길 7 서일빌딩',function(result, status);
		        latlng: new kakao.maps.LatLng(result[0].y,result[0].x)
		    }
		];

		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		    
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		}
		});
		
</script>
	<div style="float: right; display: flex; flex-direction: row-reverse;">
		<button id="index_btn" class="btn-index">처음 페이지로 돌아가기</button>
	</div>
</div>
</html>