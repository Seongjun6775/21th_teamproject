<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>매장 지도</title>
	<jsp:include page="../include/stylescript.jsp" />
	<link rel="stylesheet" href="${context}/css/str_common.css?p=${date}" />
	<link rel="stylesheet" href="${context}/css/jy_common.css?p=${date}" />
</head>
<body>
	<div id="map" style="width:500px;height:400px;"></div>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7121fa95573c132c57b4649cfa281f57"></script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing" >
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
	</script>
</body>
</html>