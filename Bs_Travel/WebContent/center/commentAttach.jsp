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
			String idx=request.getParameter("idx");
			String content=request.getParameter("content");
			String id=request.getParameter("id");
			int board_id = Integer.parseInt(request.getParameter("board_id"));
			CommentDTO cdto= new CommentDTO();
			CommentDAO cdao= new CommentDAO();
			int c_idx=cdao.idxCheck(board_id,Integer.parseInt(idx));
			c_idx++;
			cdto.setC_idx(c_idx);
			cdto.setIdx(Integer.parseInt(idx));
			cdto.setId(id);
			cdto.setContent(content);
			cdto.setIp(getClientIpAddr(request));
			cdto.setC_lev(0);
			cdto.setC_seq(0);
			if(cdao.attachComment(board_id,cdto)){
		%>
				<script type="text/javascript">
				location.href="fContent.jsp?pagenum=<%=request.getParameter("pageNum")%>&idx=<%=idx%>"
				</script>
		<%	}else{%>
				<script type="text/javascript">
				alert("댓글 달기 실패!");
				history.back();
				</script>
		<%	
			} 
		%>
	</body>
</html>