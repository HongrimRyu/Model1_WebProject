<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="com.ithong.board.BoardDAO"%>
<%@page import="com.ithong.comment.CommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ithong.comment.CommentDAO"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="../css/default.css" rel="stylesheet" type="text/css">
		<link href="../css/subpage.css" rel="stylesheet" type="text/css">
		<link href="../css/content.css" rel="stylesheet" type="text/css">
		<link href="../css/board.css" rel="stylesheet" type="text/css">
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
		 <style type="text/css">
		 	*{list-style: none;}
			 .msg_main{
			 	text-align: center;
			 	border: 1px solid;
			 	height: 20%;
			 	font-size: x-large;}
			 .img_s{
			     transition: all 0.5s ease-in-out; /* 부드러운 모션을 위해 추가*/
			     max-width:90%;  
			  }
			.img_s:HOVER {
			  transform: scale(1.2);
			  -webkit-transform: scale(1.2);
			  -moz-transform: scale(1.2);
			  -ms-transform: scale(1.2);
			  -o-transform: scale(1.2);
			}
		 </style>

	</head>
	<body>
		<div id="wrap">
			<!-- 헤더들어가는 곳 -->
			<jsp:include page="../inc/sub_top.jsp"/>
			<!-- 헤더들어가는 곳 -->
			<!-- 왼쪽메뉴 -->
			<nav id="sub_menu">
				<jsp:include page="../inc/sub_menu_notice.jsp"/>
			</nav>
			<!-- 왼쪽메뉴 -->
			
			<!-- 게시판 -->
			<article>
				<%
					String id=session.getAttribute("id")==null? "0" : (String)session.getAttribute("id");
					// // num,pageNum 파라미터 저장하기 
					int num = Integer.parseInt(request.getParameter("idx"));
					String pageNum=request.getParameter("pageNum");
					if(pageNum==null) pageNum="1";
					// // BoardDAO 객체 생성
					BoardDAO bdao = new BoardDAO();
					
					
					 // // 게시판 DB num해당하는 글정보를 가져오기
					 // //  DTO객체 <=getBoard(num);
					 BoardDTO bdto = bdao.getBoard(3,num);   
					 if(!bdto.isDel_state()) response.sendRedirect("../main/main.jsp");
					 bdao.updateCount(3,num);
					 String nick= bdao.getNick(bdto.getId());
					 String[] fileName = bdto.getFile().split("/");
				 %>
				
				<h1>Notice Content</h1>
				<div class="title_bar"><span class="btitle"><%=bdto.getSubject() %></span></div>
				<div class="content_info">
					<span class="bname"><%=nick %>(<%=bdto.getId() %>)</span>
					<span class="bar2">|</span>
					<span class="bdate"><%=bdto.getCreate_date() %></span>
					<span class="bar2">|</span>
					<span class="bcount"><%=bdto.getRead_count() %></span>
				</div>
				<div class="content_main">
					<div class="img_main">
						<%for(int i = 0; i<fileName.length; i++){ %>
							<img src="../file/<%=fileName[i] %>" class="img_s">
							<br>
						<%} %>
					</div>
					<div class="msg_main"><%=bdto.getContent() %></div>
				</div>
				<!-- 첨부파일 다운로드 영역-->
				<%for(int j=0;j<fileName.length;j++){ %>
				다운로드 : 
				<%if(bdto.getFile()!=null){ %>
				<a href="file_down.jsp?file=<%=fileName[j]%>"><%=fileName[j] %></a><br>
				<%}}%>
				<!-- 첨부파일 다운로드 -->
				<!--덧글영역 시작-->
						
				<!--덧글영역  끝-->
				<div id="table_search">
					<input type="button" value="답글달기" class="btn"
					     onclick="location.href='fReply.jsp?pageNum=<%=pageNum%>&idx=<%=bdto.getIdx()%>'">
					<%if(id.equals(bdto.getId())||id.equals("hongadmin")) {%>
					<input type="button" value="수정하기" class="btn"
					     onclick="location.href='fUpdate.jsp?pageNum=<%=pageNum%>&idx=<%=bdto.getIdx()%>'">
					 <input type="button" value="삭제하기" class="btn"
					     onclick="gDelete('<%=pageNum%>','<%=bdto.getIdx()%>');">
					<%} %>
					<input type="button" value="목록보기" class="btn"
					     onclick="location.href='gallery.jsp?pageNum=<%=pageNum%>'">
				</div>
				<div class="clear"></div>
			</article>
			<!-- 게시판 -->
			<!-- 본문들어가는 곳 -->
			<div class="clear"></div>
			<!-- 푸터들어가는 곳 -->
			<jsp:include page="../inc/sub_bottom.jsp"/>
			<!-- 푸터들어가는 곳 -->
			<script type="text/javascript" src="board.js"></script>
		</div>
	</body>
</html>