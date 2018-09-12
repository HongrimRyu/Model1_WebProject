<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
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
// file_down.jsp

// 한글처리
request.setCharacterEncoding("UTF-8");

// file_name 파라미터값 저장
String fileName = request.getParameter("file");

ServletContext context = getServletContext();

String sFilePath = "usr/local/tomcat8/webapps/Bs_Travel/file/"+fileName;/// \\winver:C:\\workspace\\Bs_Travel\\WebContent\\file\\
System.out.println("sFilePath : "+sFilePath);
//파일 입출력

byte[] b = new byte[4096];

File oFile = new File(sFilePath);
FileInputStream in = new FileInputStream(oFile);

String sMimeType=getServletContext().getMimeType(sFilePath);

System.out.println("sMimeType : "+sMimeType);

//octet-stream=> 8비트 형식의 데이터 타입, 지정되지 않은 파일 형식타입
if(sMimeType == null)
	sMimeType="application/octet-stream";


response.setContentType(sMimeType);

String userAgent=request.getHeader("User-Agent");

boolean flag=(userAgent.indexOf("MSIE") > -1) || (userAgent.indexOf("Trident") > -1);

String sEncoding=null;

if(flag){
	sEncoding=URLEncoder.encode(fileName,"UTF-8");
	System.out.println("sEncoding : "+sEncoding);
}else{
	sEncoding= new String(fileName.getBytes("UTF-8"),"8859_1");
	System.out.println("sEncoding : "+sEncoding);
}


response.setHeader("Content-Disposition","attachment; filename="+sEncoding);

ServletOutputStream out2 = response.getOutputStream();

int numRead=0;

// 배열에 0~ 배열의 길까지 브라우져로 출력
while( (numRead = in.read(b, 0, b.length)) != -1 ){
	out2.write(b,0,numRead);	
}
out2.flush();
out2.close();
in.close();

out.clear();

out = pageContext.pushBody();
















%>





</body>
</html>