<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="com.ithong.board.BoardDAO"%>
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
		<script type="text/javascript">
		function nDelete(pn,idx){
			var delconfirm = confirm("정말 삭제 하시겠습니까?");
			if(delconfirm==true) location.href="nDelete.jsp?pageNum="+pn+"&idx="+idx;
			
		}
		
		</script>
		
		
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
		
		// // updateReadCount(num); 조회수 증가
		
		
		// // 게시판 DB num해당하는 글정보를 가져오기
		// //  DTO객체 <=getBoard(num);
		 BoardDTO bdto = bdao.getBoard(1,num);   
		 String nick= bdao.getNick(bdto.getId());
		 String fileName = bdto.getFile();
		 if(!bdto.isDel_state()){
			response.sendRedirect("../main/main.jsp");
		 }
		 bdao.updateCount(1,num);
		%>
		
		<h1>Notice Content</h1>
		
		
		<div class="title_bar">
			<span class="btitle"><%=bdto.getSubject() %></span>
		</div>
		<div class="content_info">
			<span class="bname"><%=nick %>(<%=bdto.getId() %>)</span>
			<span class="bar2">|</span>
			<span class="bdate"><%=bdto.getCreate_date() %></span>
			<span class="bar2">|</span>
			<span class="bcount"><%=bdto.getRead_count() %></span>
		</div>
		<div class="content_main">
			<div style="margin: 10px 40px 10px 40px;">
				<%=bdto.getContent() %>
			</div>
		</div>
		<!-- 첨부파일 다운로드 영역-->
		다운로드 : 
		<%if(bdto.getFile()!=null){ %>
		<a href="file_down.jsp?file=<%=bdto.getFile()%>"><%=bdto.getFile() %></a>
		<%} %>
		<!-- 첨부파일 다운로드 -->
		
		
		<div id="table_search">
			<%if(id.equals(bdto.getId())||id.equals("hongadmin")) {%>
			<input type="button" value="수정하기" class="btn"
			     onclick="location.href='nUpdate.jsp?pageNum=<%=pageNum%>&idx=<%=bdto.getIdx()%>'">
			 <input type="button" value="삭제하기" class="btn"
			     onclick="nDelete('<%=pageNum%>','<%=bdto.getIdx()%>');">
			<%} %>
			<input type="button" value="목록보기" class="btn"
			     onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
		</div>
		<div class="clear"></div>
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