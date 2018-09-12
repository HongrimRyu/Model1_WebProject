<%@page import="com.ithong.comment.CommentDTO"%>
<%@page import="com.ithong.comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			request.setCharacterEncoding("utf-8");
			int idx=Integer.parseInt(request.getParameter("idx"));
			int c_idx=Integer.parseInt(request.getParameter("c_idx"));
			int board_id = Integer.parseInt(request.getParameter("board_id"));
			String id=request.getParameter("id");
			if(!session.getAttribute("id").equals(id)){
				response.sendRedirect("../main/main.jsp");
			}
			CommentDAO cdao= new CommentDAO();
			CommentDTO cdto= cdao.getComment(board_id,idx, c_idx);
			cdto.setId("hongadmin");
			cdto.setDel_state("false");
			cdto.setLegacy_content(cdto.getContent());
			cdto.setContent("삭제된 댓글입니다.");
			cdao.updateComment(board_id,cdto);
		%>
		<script type="text/javascript">
			location.href="fContent.jsp?pagenum=<%=request.getParameter("pageNum")%>&idx=<%=idx%>"
		</script>
	</body>
</html>