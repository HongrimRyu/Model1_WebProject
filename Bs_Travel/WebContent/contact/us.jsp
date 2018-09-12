<%@page import="java.util.ArrayList"%>
<%@page import="com.ithong.board.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ithong.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>부산에 빠지다-부산 홍보</title>
		
		<link href="../css/default.css" rel="stylesheet" type="text/css">
		<link href="../css/front.css" rel="stylesheet" type="text/css">
		<link href="../css/content.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="../slick-1.8.1/slick/slick.css">
		<link rel="stylesheet" type="text/css" href="../slick-1.8.1/slick/slick-theme.css">
		
		<!--[if lt IE 9]>
			<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
			<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
		<![endif]-->
		
		<!--[if IE 6]>
			<script src="script/DD_belatedPNG_0.0.8a.js"></script>
			<script>
			  /* EXAMPLE */
			  DD_belatedPNG.fix('#wrap');
			  DD_belatedPNG.fix('#main_img');   
			</script>
		<![endif]--> 
		<style type="text/css">
		.contact_us{
			font-size: large;
			
			
		}
		</style>
	</head>
	<body>

			<!-- 헤더파일들어가는 곳 -->
			<jsp:include page="../inc/top.jsp"/>
			<!-- 헤더파일들어가는 곳 -->
			
			<!-- 메인이미지 들어가는곳 -->
			<div class="clear"></div>
			
			<div id="main_img">
				<section class="main_visual slider">
					<div>
						<img src="../images/busan_main.jpg">
					</div>
				</section>
<!-- 				<img src="../images/main_img3.jpg" width="971" height="282"> -->
			</div>
			<!-- 메인이미지 들어가는곳 -->
		
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<article id="front">
		<div class="contact_us">
			<form action="usPro.jsp" style="margin-left: 600px ">
		   <table border="1" style="width: 400px">
		   <colgroup>
		   		<col width="30%">
				<col width="70%">
		   </colgroup>
		   <tr><th>이름</th><td><input type="text" name="name"></td></tr>
		   <tr><th>회사명</th><td><input type="text" name="companyname"></td></tr>
		   <tr><th>부서명</th><td><input type="text" name="deptname"></td></tr>
		   <tr><th>이메일</th><td><input type="text" name="email"></td></tr>
		   <tr><th>회사연락처</th><td><input type="text" name="cphone"></td></tr>
		   <tr><th>개인연락처</th><td><input type="text" name="phone"></td></tr>
		   <tr><th>제목</th><td><input type="text" name="title"></td></tr>
		   <tr><th>내용</th><td><textarea class="input_con" rows="6" name="content"></textarea></td></tr>
		   </table>
		   <input type="submit" value="Submit">
		   </form>
		 </div>
		</article>
		<!-- 메인 콘텐츠 들어가는 곳 -->
		
		<div class="clear"></div>
		
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 들어가는 곳 -->
		
		

	</body>
</html>