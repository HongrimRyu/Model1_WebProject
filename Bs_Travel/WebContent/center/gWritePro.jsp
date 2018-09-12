<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Enumeration"%>
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
String[] fileName= new String[5];
Enumeration fileNames = multi.getFileNames();
int i=0;
while(fileNames.hasMoreElements()){
fileName[i]= multi.getFilesystemName((String)fileNames.nextElement());
if(fileName[i]!=null) i++;
 
} 

String savePath="upload";
ServletContext context = getServletContext();
String sDownloadPath=context.getRealPath(savePath);//C:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Bs_Travel/upload/logo.jpg
String sFilePath="";
String datagroup="";
	for(int j=0;j<fileName.length;j++){
		if(fileName[j]==null) break;
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yy_mm_dd_hh_mm_ss");
		String str = dayTime.format(new Date(time));
	sFilePath = sDownloadPath+"/"+fileName[j];
	String saveName= str+"_"+fileName[j];
	datagroup+="/"+saveName;
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

	ParameterBlock pb = new ParameterBlock();
    pb.add("/usr/local/tomcat8/webapps/Bs_Travel/file/"+saveName);
    RenderedOp rop=JAI.create("fileload",pb);
    
    BufferedImage bi = rop.getAsBufferedImage();
    BufferedImage thumb = new BufferedImage(100,100,BufferedImage.TYPE_INT_BGR);
    
    Graphics2D g = thumb.createGraphics();
    g.drawImage(bi, 0,0,100,100,null);
    
    File file = new File("/usr/local/tomcat8/webapps/Bs_Travel/file/sm_"+saveName);
    ImageIO.write(thumb, "jpg", file); 

	}
	


int num=bdao.maxIdx(3);
num++;
bdto.setIdx(num);
bdto.setId((String)session.getAttribute("id"));
bdto.setSubject(multi.getParameter("subject"));
bdto.setContent(multi.getParameter("content"));
bdto.setCreate_ip(getClientIpAddr(request));
bdto.setRe_ref(num);
bdto.setFile(datagroup.substring(1));
if(bdao.writeBoard(3,bdto)){
%>
<script type="text/javascript">
alert("글쓰기 성공!");
location.href="gallery.jsp?";
</script>
<%	
}else{
%>
<script type="text/javascript">
alert("글쓰기 실패!");
location.href="gallery.jsp";
</script>
<%} %>
</body>
</html>



















