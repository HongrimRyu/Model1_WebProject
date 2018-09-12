<%@page import="com.sun.org.apache.bcel.internal.generic.INEG"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ithong.board.BoardDAO"%>
<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>부산 투어</title>
		<link href="../css/default.css" rel="stylesheet" type="text/css">
		<link href="../css/subpage.css" rel="stylesheet" type="text/css">
		
		<link rel="stylesheet" href="../tour/css/bootstrap.min.css">
		<link rel="stylesheet" href="../tour/css/busan_map.css">
		<link rel="stylesheet" href="../tour/css/dynomap.css">
		
		<script src="http://code.jquery.com/jquery-latest.js"></script>
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
			
			<!-- 본문들어가는 곳 -->
			<article>
				<div class="container">
					<!-- Header의 시작 -->
					<header>
						<h3>지도</h3>
					</header>
					<!-- Header의 끝 -->
				
					<!-- Body의 시작 -->
					<section>
						<div class="row">
							<div class="col-sm-12 col-lg-6">
								<!-- Dynomap 시작 -->
								<div class="dynomap"></div>
								<!-- Dynomap 끝 -->
							</div>
				
							<div class="col-sm-12 col-lg-6">
								<!-- 구 정보의 시작 -->
								<div class="gis-gu-info"></div>
								<!-- 구 정보의 끝 -->
							</div>
						</div>
					</section>
					<!-- Body의 끝 -->
				</div>
			</article>
			<!-- 본문들어가는 곳 -->
			
			<div class="clear"></div>
			
			<!-- 푸터들어가는 곳 -->
			<jsp:include page="../inc/sub_bottom.jsp"/>
			<!-- 푸터들어가는 곳 -->
		</div>
		
		<script type="text/javascript" src="../tour/js/dynomap.js"></script>
		<script type="text/javascript" src="../tour/js/busan_map.js"></script>
	</body>
</html>