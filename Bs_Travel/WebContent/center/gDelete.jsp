<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="com.ithong.board.BoardDAO"%>
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
if(session.getAttribute("id")==null){
	response.sendRedirect("../main/main.jsp");
}
if(request.getParameter("idx")==null){
	response.sendRedirect("../main/main.jsp");
}
String pageNum=request.getParameter("pageNum");
if(request.getParameter("pageNum")==null){
	pageNum="1";
}
int idx=Integer.parseInt(request.getParameter("idx"));
BoardDAO bdao = new BoardDAO();
BoardDTO bdto = bdao.getBoard(3,idx);
//bdto.setModify_ip(getClientIpAddr(request));
bdto.setSubject("이 게시글은 삭제 되었습니다.");
bdto.setDel_state(false);
if(bdao.deleteBoard(3,bdto)){
%>
<script type="text/javascript">
alert("삭제 성공!");
location.href="freeboard.jsp?";
</script>
<%	
}else{
%>
<script type="text/javascript">
alert("삭제 실패!");
history.back();
</script>
<%} %>
</body>
</html>



















