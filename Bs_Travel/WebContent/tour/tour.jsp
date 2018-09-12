<%@page import="com.sun.org.apache.bcel.internal.generic.INEG"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ithong.board.BoardDAO"%>
<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<title>부산 투어</title>
		
		<link href="../css/default.css" rel="stylesheet" type="text/css">
		<link href="../css/subpage.css" rel="stylesheet" type="text/css">
		
		<!--[if lt IE 9]>
			<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
			<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
		<![endif]-->
		<!--[if IE 6]>
			<script src="../script/DD_belatedPNG_0.0.8a.js"></script>
			<script>
				/* EXAMPLE */
				DD_belatedPNG.fix('#wrap');
				DD_belatedPNG.fix('#main_img');   	
			 </script>
		 <![endif]-->
	

	</head>
	<body>
		<div id="wrap">
		
			<!-- 헤더들어가는 곳 -->
			<jsp:include page="../inc/sub_top.jsp"/>
			<!-- 헤더들어가는 곳 -->
			
			<!-- 왼쪽메뉴 -->
			<nav id="sub_menu">
				<jsp:include page="../inc/sub_menu_tour.jsp"/>
			</nav>
			<!-- 왼쪽메뉴 -->
			
			<!-- 게시판 -->
			<article>
				<h1>여행준비</h1>
				<p style="text-align: center; font-style:bold;">&lt;주요지역 관광 안내소1&gt;</p>
				<div id="map" style="width:60%;height:350px;"></div>
				<br>
				<img alt="부산정보" src="../images/tinfo.png">
				
			</article>
			<!-- 게시판 -->
			
			<!-- 본문들어가는 곳 -->
		
			<div class="clear"></div>
			
			<!-- 푸터들어가는 곳 -->
			<jsp:include page="../inc/sub_bottom.jsp"/>
			<!-- 푸터들어가는 곳 -->
			
		</div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=312c67dc873490accb87f187a24f777c&libraries=services,clusterer,drawing"></script>
		<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new daum.maps.LatLng(35.149545, 129.049890), // 지도의 중심좌표
		        level: 9 // 지도의 확대 레벨
		    };
		
		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		 
		// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
		var positions = [
		    {
		        content: '<div>부산 중구 종합관광안내소</div>', 
		        latlng: new daum.maps.LatLng(35.098293, 129.032270)
		    },
		    {
		        content: '<div>부산 해운대구 종합관광안내소</div>', 
		        latlng: new daum.maps.LatLng(35.159481, 129.160304)
		    },
		    {
		        content: '<div>부산 부산진구 종합관광안내소</div>', 
		        latlng: new daum.maps.LatLng(35.158638, 129.057602)
		    },
		    {
		        content: '<div>부산 광안리 종합관광안내소</div>',
		        latlng: new daum.maps.LatLng(35.153988, 129.118451)
		    }
		];
		
		for (var i = 0; i < positions.length; i ++) {
		    // 마커를 생성합니다
		    var marker = new daum.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng // 마커의 위치
		    });
		
		    // 마커에 표시할 인포윈도우를 생성합니다 
		    var infowindow = new daum.maps.InfoWindow({
		        content: positions[i].content // 인포윈도우에 표시할 내용
		    });
		
		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}
		
		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}
		</script>
	</body>
</html>