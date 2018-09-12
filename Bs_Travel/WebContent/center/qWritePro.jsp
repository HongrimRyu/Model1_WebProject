<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

String realPath=application.getRealPath("/upload");
int maxSize = 20 * 1024 * 1024; // 10MB

MultipartRequest multi = new MultipartRequest(
		request,
		realPath,
		maxSize,
		"utf-8",
		new DefaultFileRenamePolicy()	
		);
BoardDAO bdao = new BoardDAO();
BoardDTO bdto = new BoardDTO();
String fileName = "";


int num=bdao.maxIdx(4);
num++;
bdto.setIdx(num);
bdto.setId(multi.getParameter("id"));
bdto.setSubject(multi.getParameter("subject"));
bdto.setContent(multi.getParameter("content"));
bdto.setCreate_ip(getClientIpAddr(request));
bdto.setRe_ref(num);
bdto.setFile(fileName);
if(bdao.writeBoard(4,bdto)){
%>
<script type="text/javascript">
alert("글쓰기 성공!");
location.href="QnA.jsp?";
</script>

<%	
}else{
%>
<script type="text/javascript">
alert("글쓰기 실패!");
location.href="QnA.jsp";
</script>
<%} %>
</body>
</html>



















