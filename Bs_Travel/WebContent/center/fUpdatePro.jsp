<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
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
BoardDAO bdao = new BoardDAO();
BoardDTO bdto = new BoardDTO();
String realPath=application.getRealPath("/upload");
int maxSize = 10 * 1024 * 1024; // 10MB

MultipartRequest multi = new MultipartRequest(
		request,
		realPath,
		maxSize,
		"utf-8",
		new DefaultFileRenamePolicy()	
		);
String fileName = multi.getFilesystemName("file").toLowerCase(); 

String savePath="upload";
ServletContext context = getServletContext();
String sDownloadPath=context.getRealPath(savePath);//C:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Bs_Travel/upload/logo.jpg
String sFilePath="";
String datagroup="";

	long time = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yy_mm_dd_hh_mm_ss");
	String str = dayTime.format(new Date(time));
	sFilePath = sDownloadPath+"/"+fileName;
	String saveName= str+"_"+fileName;
	int data=0;
	int cnt=0;
	try {
			InputStream fis = new FileInputStream(sFilePath);
			OutputStream fos= new FileOutputStream("/usr/local/tomcat8/webapps/Bs_Travel/file/"+saveName);
			while((data=fis.read()) != -1){
				fos.write(data);
		        cnt++;
			}
			fos.close();
	
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();}


bdto.setIdx(Integer.parseInt(multi.getParameter("idx")));
bdto.setId(multi.getParameter("id"));
bdto.setSubject(multi.getParameter("subject"));
bdto.setContent(multi.getParameter("content"));
bdto.setFile(saveName);
bdto.setModify_id((String)session.getAttribute("id"));
bdto.setModify_ip(getClientIpAddr(request));
if(bdao.updateBoard(2,bdto)){
%>
<script type="text/javascript">
alert("글쓰기 성공!");
location.href="freeboard.jsp?";
</script>
<%	
}else{
%>
<script type="text/javascript">
alert("글쓰기 실패!");
location.href="freeboard.jsp";
</script>
<%} %>
</body>
</html>



















