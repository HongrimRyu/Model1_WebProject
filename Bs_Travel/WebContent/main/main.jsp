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
	</head>
	<body>
		<%
		request.setCharacterEncoding("utf-8");
		BoardDAO bdao= new BoardDAO();
		
		ArrayList<BoardDTO> al = (ArrayList<BoardDTO>)bdao.getBoardList(1,1,5,0);
		%>

			<!-- 헤더파일들어가는 곳 -->
			<jsp:include page="../inc/top.jsp"/>
			<!-- 헤더파일들어가는 곳 -->
			
			<!-- 메인이미지 들어가는곳 -->
			<div class="clear"></div>
			
			<div id="main_img">
				<section class="main_visual slider">
					<div>
						<img src="../images/busan_main01.jpg">
					</div>
					<div>
						<img src="../images/main_img3.jpg">
					</div>
					<div>
						<img src="../images/busan_main.jpg">
					</div>
				</section>
<!-- 				<img src="../images/main_img3.jpg" width="971" height="282"> -->
			</div>
			<!-- 메인이미지 들어가는곳 -->
		
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<article id="front">
			<div class="clear"></div>
			<div id="main_contents">
				<div id="news_notice">
					<h3 class="brown">공지사항 &amp; 뉴스</h3>
					<table>
					<%
						BoardDTO bdto= new BoardDTO();
						Iterator<BoardDTO> iter = al.iterator();
					
						while(iter.hasNext()){
						
							bdto=iter.next();
							String s = new SimpleDateFormat("MM/dd/yy").format(bdto.getCreate_date());
					%>    
					    
						<tr>
							<td class="contxt">
								<a href="../center/nContent.jsp?idx=<%=bdto.getIdx()%>&pageNum=1"><%=bdto.getSubject() %></a>
							</td>
						    <td><%=s %></td>
						</tr>
					<%} %>
					</table>
				</div>	
				<div id="news_notice">
					<h3 class="brown">자유 게시판</h3>
					<table>
					<%
						 al = (ArrayList<BoardDTO>)bdao.getBoardList(2,1,5,0);
						 iter = al.iterator();
					
						while(iter.hasNext()){
						
							bdto=iter.next();
							String s = new SimpleDateFormat("MM/dd/yy").format(bdto.getCreate_date());
					%>    
						<tr>
							<td class="contxt">
								<a href="../center/fContent.jsp?idx=<%=bdto.getIdx()%>&pageNum=1"><%=bdto.getSubject() %></a>
							</td>
						    <td><%=s %></td>
						</tr>
					<%} %>
					</table>
				</div>
					<div id="sec_news">
					<h3><span class="orange">사진</span> 게시판</h3>
					<%
						 al = (ArrayList<BoardDTO>)bdao.getBoardList(3,1,3,0);
						 iter = al.iterator();
					while(iter.hasNext()){
						
						bdto=iter.next();
						String s = new SimpleDateFormat("yyyy/MM/dd").format(bdto.getCreate_date());
		 				String[] file = bdto.getFile().split("/");  
						
					%>
					<div class="g_c" style="margin-top: 0;">
						<a href="../center/gContent.jsp?idx=<%=bdto.getIdx()%>"><img src="../file/sm_<%=file[0]%>"></a>
						<div>
							<a href="../center/gContent.jsp?idx=<%=bdto.getIdx()%>">
							<%if(bdto.getSubject().length()>10){%>
								<%=bdto.getSubject().substring(0,10) %>...
							<%}else{%>
								<%=bdto.getSubject() %>
							<%}%>
							</a>
							<p><%=bdto.getId()%>|(<%=s %>)</p>
						</div>
					</div>	
					<%} %>
				</div>
			</div>
		</article>
		<!-- 메인 콘텐츠 들어가는 곳 -->
		
		<div class="clear"></div>
		
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 들어가는 곳 -->
		
		
		<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
		<script src="../slick-1.8.1/slick/slick.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(document).on('ready', function() {
				$('.main_visual').slick({
					slidesToShow: 1,
					slidesToScroll: 1,
					autoplay: true,
					autoplaySpeed: 2500,
				});
			});
		</script>
	</body>
</html>