<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="com.ithong.board.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		<![endif]-->>
	</head>
	<body>
	<%
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}

%>
		<div id="wrap">
		
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/sub_top.jsp"/>
		<!-- 헤더들어가는 곳 -->
		
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<jsp:include page="../inc/sub_menu_notice.jsp"/>
		</nav>
		<!-- 왼쪽메뉴 -->
		<%
		request.setCharacterEncoding("utf-8");
		String id = (String)session.getAttribute("id");
		BoardDAO bdao= new BoardDAO();
		int maxNum=bdao.maxIdx(3);//총글갯수
		int pageSize=8;//한화면에 출력되는 게시글 갯수;
		int currentPage=Integer.parseInt(pageNum);
		int startRow=(currentPage-1)*pageSize + 1;
		ArrayList<BoardDTO> al = (ArrayList<BoardDTO>)bdao.getBoardList(3,startRow,pageSize);
		%>
		<!-- 게시판 -->
		<article>
			<h1>Gallery</h1>
			<div class="galley_contents">
			<%
			BoardDTO bdto= new BoardDTO();
			Iterator<BoardDTO> iter = al.iterator();
			
			while(iter.hasNext()){
			
				bdto=iter.next();
				String s = new SimpleDateFormat("yyyy/MM/dd").format(bdto.getCreate_date());
 				String[] file = bdto.getFile().split("/");  
			%>
			<div class="g_c">
				<a href="gContent.jsp?idx=<%=bdto.getIdx()%>"><img src="../file/sm_<%=file[0]%>"></a>
				<div>
					<a href="gContent.jsp?idx=<%=bdto.getIdx()%>"><%=bdto.getSubject() %></a>
					<p><%=bdto.getId()%>|(<%=s %>)</p>
				</div>
			</div>		
			<%} %>
			</div>
		
			<div id="table_search">
					<input type="text" name="search" class="input_box">
					<input type="button" value="search" class="btn">
					<a href="gWrite.jsp?pageNum=<%=pageNum%>"><input type="button" value="write" class="btn" ></a>
			</div>
			<div id="page_control">
				<%
				
				if(maxNum != 0){
				// 전체 페이지수 구하기
				int pageCount= maxNum/pageSize+(maxNum%pageSize==0? 0:1);
				// 한페이지에 보여줄 페이지수 설정
				int pageBlock =10;
				// 한 페이지에서 보여줄, 시작하는 페이지 번호
				int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
				// 한 페이지에서 보여줄, 끝나는 페이지 번호  
				int endPage = startPage+pageBlock-1;
				
				if(endPage > pageCount){
					  endPage = pageCount;
				}
				
				// 이전
				if(startPage>pageBlock){
					  %>
					  <a href="gallery.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
					  <%		  
				}
				// 1~10
				for(int i=startPage;i<=endPage;i++){
					  %>
					  <a href="gallery.jsp?pageNum=<%=i%>"><%=i%></a>
					  <%	  
				}
				// 다음
				if(endPage<pageCount){
					  %>
					  <a href="gallery.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
					  <%
				}
					  
				}
				%>
				
				
			</div>
		</article>	
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/sub_bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
		</div>
	</body>
</html>