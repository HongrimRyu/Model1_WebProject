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
			 *{
			 list-style: none;
			 }
			 .img_s{
			     transition: all 0.5s ease-in-out; /* 부드러운 모션을 위해 추가*/
			     max-width:90%;  
			  }

		 </style>
   <script type="text/javascript" src="board.js"></script>

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
			
					 bdao.updateCount(2,num);
					
					 // // 게시판 DB num해당하는 글정보를 가져오기
					 // //  DTO객체 <=getBoard(num);
					 BoardDTO bdto = bdao.getBoard(2,num);   
					 if(!bdto.isDel_state()) response.sendRedirect("../main/main.jsp");
					 String nick= bdao.getNick(bdto.getId());
					 String fileName = bdto.getFile();
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
				<%
					if(fileName!=null){
				%>
					<div class="img_main">
						<img src="../file/<%=fileName %>" class="img_s">
					</div>
				<%
					}
				%>
				<div style="margin: 10px 40px 10px 40px;">
					<%=bdto.getContent() %>
				</div>
				</div>
			
				<!-- 첨부파일 다운로드 영역-->
				다운로드 : 
				<%if(bdto.getFile()!=null){ %>
				<a href="file_down.jsp?file=<%=bdto.getFile()%>"><%=bdto.getFile() %></a>
				<%}%>
				<!-- 첨부파일 다운로드 -->
				<!--덧글영역 시작-->
				<div id="f_comment">
					<fieldset>
						<legend>댓글</legend>
						<%String ssid= (String)session.getAttribute("id");
						if(ssid!=null){%>
						<div id="w_comment">
							<form action="commentAttach.jsp?pageNum=<%=pageNum%>" name=fr method="post">
								<input type="hidden" name="id" value=<%=session.getAttribute("id") %> >
								<input type="hidden" name="idx" value=<%=request.getParameter("idx") %> >
								<input type="hidden" name="board_id" value="2">
								<input type="hidden" name="content">
								<textarea class="input_con" rows="6" id="reply_input" placeholder="로그인을 하셔야 댓글 작성이 가능합니다" onkeydown="keylength('reply_input','text_length')"></textarea>
								<div id="w_button">
									<input type="button" value="덧글작성" onclick="comment_vail()">
									<br><br>
									<p>Text</p>
									<p id="text_length">(0/150)<p>
								</div>
							</form>
						</div>
						<br><br>
						<%} %>
						<div id="comment">
						<ul>
							<%
							
								CommentDAO cdao = new CommentDAO();
								ArrayList<CommentDTO> al= (ArrayList<CommentDTO>)cdao.getCommandList(2,num);
								
								
								for(int i = 0 ; i < al.size();i++){
									CommentDTO cdto =  al.get(i);
									String c_nick=bdao.getNick(cdto.getId());
									String content = cdto.getContent();
								
									if(content != null){
										content = cdto.getContent().replace("\r\n", "<br/>");	
									}
							%>	
							<li class="li_c">
								<%if(cdto.getC_lev()==1){ %>
								<div><img src="../images/comment.png"></div>
								<%} %>
								<div class="comment_form">
								<div>
									<span class="meta"><%=c_nick%>(<%=cdto.getId() %>)</span>
									<span><%=cdto.getCrate_date() %></span>
									<%if(cdto.getDel_state().equals("true")&&(String)session.getAttribute("id")!=null){ %>
									<button style="text-align:right; margin-top:5px;" id="reply_b_<%=cdto.getC_idx() %>"  value="1" onclick="showreply('<%=cdto.getC_idx() %>')">답글달기</button>
									<%} %>
								</div>
								<div class="r_comment">
									<%
									System.out.println(cdto.getRef_id());
									System.out.println(cdto.getId());
									if(!cdto.getRef_id().equals(cdto.getId())){ %>
									[<%=cdto.getRef_id()%>]<%} %><%=content %>
									
								</div>
								<%if(cdto.getId().equals(session.getAttribute("id"))){%>
								<div id="modify_c_<%=cdto.getC_idx() %>" style="margin:5px; display: none;">
									<form action="commentUpdate.jsp?pageNum=<%=pageNum%>" name="mfr_<%=cdto.getC_idx() %>" method="post">
										<input type="hidden" name="id" value=<%=session.getAttribute("id") %> >
										<input type="hidden" name="idx" value=<%=request.getParameter("idx") %> >
										<input type="hidden" name="c_idx" value=<%=cdto.getC_idx()%> >
										<input type="hidden" name="board_id" value="2">
										<textarea class="input_con" rows="6" id="C_update"  name="content_<%=cdto.getC_idx() %>" placeholder="로그인을 하셔야 댓글 작성이 가능합니다" onkeydown="keylength('C_update','<%="m"+cdto.getC_idx() %>')"></textarea>
										<div id="w_button">
											<input type="submit" value="덧글수정" >
											<br><br>
											<p>Text</p>
											<p id="m<%=cdto.getC_idx() %>">(0/150)<p>
										</div>
									</form>
								</div>
								<button style="text-align:right; margin-top:5px;" id="modify_b_<%=cdto.getC_idx() %>"  value="1" onclick="showmodi('<%=cdto.getC_idx() %>')">수정하기</button>
								<button style="text-align:right; margin-top:5px;" id="delete_b_<%=cdto.getC_idx() %>"  onclick="deleteComment('<%=session.getAttribute("id")%>','<%=request.getParameter("idx")%>','<%=cdto.getC_idx()%>')">삭제하기</button>
								<%} %>
								<div id="reply_c_<%=cdto.getC_idx() %>"  style="margin:5px; display: none;">
									<form action="commentReply.jsp?pageNum=<%=pageNum%>" name="mfr_<%=cdto.getC_idx() %>" method="post">
										<input type="hidden" name="id" value=<%=session.getAttribute("id") %> >
										<input type="hidden" name="idx" value=<%=request.getParameter("idx") %> >
										<input type="hidden" name="c_idx" value=<%=cdto.getC_idx()%> >
										<input type="hidden" name="board_id" value="2">
										<textarea class="input_con" rows="6" id="C_update"  name="content_<%=cdto.getC_idx() %>" placeholder="로그인을 하셔야 댓글 작성이 가능합니다" onkeydown="keylength('C_update','<%="m"+cdto.getC_idx() %>')"></textarea>
										<div id="w_button">
											<input type="submit" value="답글달기" >
											<br><br>
											<p>Text</p>
											<p id="m<%=cdto.getC_idx() %>">(0/150)<p>
										</div>
									</form>
								</div>
								</div>
							</li>
							<%}%>
						</ul>
						</div>
						
					</fieldset>
				</div>			
				<!--덧글영역  끝-->
				<div id="table_search">
					<input type="button" value="답글달기" class="btn"
					     onclick="location.href='fReply.jsp?pageNum=<%=pageNum%>&idx=<%=bdto.getIdx()%>'">
					<%if(id.equals(bdto.getId())||id.equals("hongadmin")) {%>
					<input type="button" value="수정하기" class="btn"
					     onclick="location.href='fUpdate.jsp?pageNum=<%=pageNum%>&idx=<%=bdto.getIdx()%>'">
					 <input type="button" value="삭제하기" class="btn"
					     onclick="fDelete('<%=pageNum%>','<%=bdto.getIdx()%>');">
					<%} %>
					<input type="button" value="목록보기" class="btn"
					     onclick="location.href='freeboard.jsp?pageNum=<%=pageNum%>'">
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