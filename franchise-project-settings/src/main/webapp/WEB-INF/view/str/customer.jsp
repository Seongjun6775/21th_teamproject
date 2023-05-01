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
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script type="text/javascript">
	$().ready(function() {

		$("#search-btn").click(function() {
			movePage(0);
		});

		$("#index_btn").click(function() {
			location.href = "${context}/index";
		});

	});
</script>
</head>

<jsp:include page="../include/openBody.jsp" />
<div class="bg-white rounded shadow-sm  "
	style="padding: 23px 18px 23px 18px; margin: 20px;">
	<span class="fs-5 fw-bold">매장 > 매장지도</span>
</div>
<body>
	<p style="margin-top: -12px">
		<em class="link"> <a href="javascript:void(0);"
			onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
				혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요. </a>
		</em>
	</p>
	<div id="map" style="width:500px;height:400px;"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7121fa95573c132c57b4649cfa281f57&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('강원도 춘천시 지석로67',function(result, status) {

		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {

			var coords = new kakao.maps.LatLng(result[0].y,
					result[0].x);

			// 결과값으로 받은 위치를 마커로 표시합니다
			var marker = new kakao.maps.Marker({
				map : map,
				position : coords
			});

			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new kakao.maps.InfoWindow(
					{
						content : '<div style="width:150px;text-align:center;padding:6px 0;">붕어빵 춘천점</div>'
					});
			infowindow.open(map, marker);

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
		}
	});
</script>
</body>
<div style="float: right; display: flex; flex-direction: row-reverse;">
	<button id="index_btn" class="btn-index">처음 페이지로 돌아가기</button>
</div>
</html>