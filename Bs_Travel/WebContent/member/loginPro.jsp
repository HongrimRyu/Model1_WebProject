<%@page import="com.ithong.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="KISA_SHA256.jsp" %>
<%request.setCharacterEncoding("utf-8"); %>
<%!
public byte[] getBytes(String data) {
	String[] str = data.split(",");
	byte[] result = new byte[str.length];
	for(int i=0; i<result.length; i++) {
		result[i] = getHex(str[i]);
	}
	return result;
}

public String getString(byte[] data) {
	String result = "";
	for(int i=0; i<data.length; i++) {
		result = result + toHex(data[i]);
	}
	return result;
}

public byte getHex(String str) {
	str = str.trim();
	if(str.length() == 0)
		str = "00";
	else if(str.length() == 1)
		str = "0" + str;
	
	str = str.toUpperCase();
	return (byte)(getHexNibble(str.charAt(0)) * 16 + getHexNibble(str.charAt(1)));
}

public byte getHexNibble(char c) {
	if(c >= '0' && c<='9')
		return (byte)(c - '0');
	if(c >= 'A' && c<='F')
		return (byte)(c - 'A' + 10);
	return 0;
}

public String toHex(int b) {
	char c[] = new char[2];
	c[0] = toHexNibble((b>>4) & 0x0f);
	c[1] = toHexNibble(b & 0x0f);
	return new String(c);
}

public char toHexNibble(int b) {
	if(b >= 0 && b <= 9)
		return (char)(b + '0');
	if(b >= 0x0a && b <= 0x0f)
		return (char)(b + 'A' - 10);
	return '0';
}

%>

<%
byte defaultPlainText[] = {
		(byte)0x00, (byte)0x01, (byte)0x02, (byte)0x03, (byte)0x04, (byte)0x05, (byte)0x06, (byte)0x07, (byte)0x08, (byte)0x09, (byte)0x0a, (byte)0x0b, (byte)0x0c, (byte)0x0d, (byte)0x0e, (byte)0x0f
};
byte[] defaultCipherText = Sha256EncryptB(defaultPlainText);

String method = request.getParameter("method");
String encrypt_plainText = "";
String encrypt_cipherText = "";
String encrypt_cipherText_base64 = "";

if(method != null && method.equals("e")) {
	String plainTextStr = request.getParameter("pass");

	byte[] plainText = plainTextStr.getBytes("UTF-8");
	String cipherTextStr = getString(Sha256EncryptB(plainText));
	encrypt_plainText = plainTextStr;
	encrypt_cipherText = cipherTextStr;
	encrypt_cipherText_base64 = Sha256Encrypt(plainText);
	
}



%>
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
String id=request.getParameter("id");
String pass=encrypt_cipherText;
String ip=getClientIpAddr(request);
MemberDAO mdao = new MemberDAO();
int[] check = mdao.loginCheck(id, pass, ip);


if(check[0]==1){
	session.setAttribute("id", id);
	if(check[1]==1){
		response.sendRedirect("../main/main.jsp?expired=1");
	}else {response.sendRedirect("../main/main.jsp");}
}else if(check[0]==0){
	response.sendRedirect("login.jsp?state=0");
}else{
	response.sendRedirect("login.jsp?state=-1");
}

%>
</body>
</html>




























