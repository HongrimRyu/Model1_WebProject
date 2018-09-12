<%@page import="com.ithong.comment.CommentDAO"%>
<%@page import="com.ithong.comment.CommentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public static String getClientIpAddr(HttpServletRequest request) {  
	    String ip = request.getHeader("X-Forwarded-For");  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("HTTP_CLIENT_IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getRemoteAddr();  
	    }  
	    return ip;  
}%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			request.setCharacterEncoding("utf-8");
			CommentDAO cdao= new CommentDAO();
			int ref =Integer.parseInt(request.getParameter("c_idx"));
			int board_id = Integer.parseInt(request.getParameter("board_id"));
			String idx=request.getParameter("idx");
			String content=request.getParameter("content_"+ref);
			String id=(String)session.getAttribute("id");
			CommentDTO refdto = cdao.getComment(board_id, Integer.parseInt(idx), ref);
			CommentDTO cdto = new CommentDTO();
	
			cdto.setC_idx(ref);
			cdto.setIdx(Integer.parseInt(idx));
			cdto.setId(id);
			cdto.setContent(content);
			System.out.println(content);
			cdto.setIp(getClientIpAddr(request));
			cdto.setC_lev(1);
			cdto.setRef_id(refdto.getId());
			if(cdao.replyComment(board_id,cdto)){
		%>
			<script type="text/javascript">
			location.href="fContent.jsp?pagenum=<%=request.getParameter("pageNum")%>&idx=<%=idx%>"
			</script>
		<%	}else {%>
		<script type="text/javascript">
			alert("댓글 달기 실패!");
			history.back();
		</script>
		<%} %>
	</body>
</html>