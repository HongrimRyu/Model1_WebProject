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
<title>Insert title here</title>
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
<%
request.setCharacterEncoding("utf-8");
BoardDAO bdao= new BoardDAO();
String pageNum=request.getParameter("pageNum");
String search= request.getParameter("search");
if(search==null) search="";
if(pageNum==null){
	pageNum="1";
}
int maxNum=0;
if(search.trim().equals("")) maxNum=bdao.maxIdx(4);//총글갯수
else maxNum=bdao.maxIdx(1,search);//총글갯수
int pageSize=10;//한화면에 출력되는 게시글 갯수;
int currentPage=Integer.parseInt(pageNum);
int startRow=(currentPage-1)*pageSize + 1;
ArrayList<BoardDTO> al = null;
if(search.trim().equals("")) al=(ArrayList<BoardDTO>)bdao.getBoardList(4,startRow,pageSize);
else al=(ArrayList<BoardDTO>)bdao.getBoardList(4,startRow,pageSize,search);
%>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/sub_top.jsp"/>
<!-- 헤더들어가는 곳 -->
<!-- 본문들어가는 곳 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<jsp:include page="../inc/sub_menu_notice.jsp"/>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Notice</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
BoardDTO bdto= new BoardDTO();
Iterator<BoardDTO> iter = al.iterator();

while(iter.hasNext()){

	bdto=iter.next();
	String s = new SimpleDateFormat("MM/dd/yyyy").format(bdto.getCreate_date());

%>    
<tr><td><%=bdto.getIdx() %></td>
	<td class="left">
	<%if(bdto.isDel_state()){ %>
	<a href="qContent.jsp?idx=<%=bdto.getIdx()%>&pageNum=<%=currentPage%>">
	<%}%>
	<%=bdto.getSubject() %></a></td>
    <td><%=bdto.getId() %></td>
    <td><%=s %></td>
    <td><%=bdto.getRead_count() %></td></tr>
<%} %>
</table>
<div id="table_search">
<form action="notice.jsp" name="search" method="post">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
<input type="text" name="search" class="input_box" value="<%=search%>">
<input type="submit" value="search" class="btn">
<%
if(session.getAttribute("id")!=null){ %>
<a href="qWrite.jsp?pageNum=<%=pageNum%>"><input type="button" value="글쓰기" class="btn" ></a>
<%}else{%>
<input type="button" value="글쓰기" class="btn" style="display: none;">
<%}%>
</form>

</div>
<div class="clear"></div>
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
	  <a href="QnA.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
	  <%		  
}
// 1~10
for(int i=startPage;i<=endPage;i++){
	  %>
	  <a href="QnA.jsp?pageNum=<%=i%>"><%=i%></a>
	  <%	  
}
// 다음
if(endPage<pageCount){
	  %>
	  <a href="QnA.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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