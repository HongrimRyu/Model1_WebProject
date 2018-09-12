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
int maxSize = 10 * 1024 * 1024; // 10MB

MultipartRequest multi = new MultipartRequest(
		request,
		realPath,
		maxSize,
		"utf-8",
		new DefaultFileRenamePolicy()	
		);
BoardDAO bdao = new BoardDAO();
BoardDTO bdto = new BoardDTO();
String fileName = multi.getFilesystemName("file"); 
if (fileName != null) {       
	String fileExt = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
	if (!"gif".equals(fileExt) && !"jpg".equals(fileExt) && !"png".equals(fileExt)){	             
	%>
	<script type="text/javascript">
	alert("허용되지 않는 확장자입니다.");
	history.back();
	</script>
	<%
	}   
}

String savePath="upload";
ServletContext context = getServletContext();

String sDownloadPath=context.getRealPath(savePath);//C:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Bs_Travel/upload/logo.jpg

String sFilePath = sDownloadPath+"\\"+fileName;
int data=0;
int cnt=0;
try {
		InputStream fis = new FileInputStream(sFilePath);
		OutputStream fos= new FileOutputStream("C:\\workspace\\Bs_Travel\\WebContent\\file\\"+fileName);
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

int re_ref=Integer.parseInt(multi.getParameter("re_ref"));
int re_lev=Integer.parseInt(multi.getParameter("re_lev"));
int re_seq=Integer.parseInt(multi.getParameter("re_seq"));


bdto.setId(multi.getParameter("id"));
bdto.setSubject(multi.getParameter("subject"));
bdto.setContent(multi.getParameter("content"));
bdto.setCreate_ip(getClientIpAddr(request));
bdto.setRe_ref(re_ref);
bdto.setRe_lev(re_lev);
bdto.setRe_seq(re_seq);
bdto.setFile(fileName);
if(bdao.reInsertBoard(2,bdto)){
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



















