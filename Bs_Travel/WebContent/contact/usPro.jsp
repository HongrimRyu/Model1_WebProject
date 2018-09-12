<%@page import="com.ithong.tour.TourDTO"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SMTPAuthenticatior"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String host = "http://13.209.50.192:8080/BsTravel";
String from = "skyrhl@gmail.com";
String to= "skyrhl@gmail.com";
String ct =request.getParameter("content");
if(ct != null){
	ct =request.getParameter("content").replace("\r\n", "<br/>");	
}
String subject = request.getParameter("name")+"님의 요청 : "+ request.getParameter("title");   
String content = "<p>"+request.getParameter("name")+"님의 요청 메일입니다.</p>"+
				" <br>회사명 :"+request.getParameter("companyname")+"<br>"+
				" <br>부서명 :"+request.getParameter("deptname")+"<br>"+
				" <br>회사연락처:"+request.getParameter("cphone")+"<br>"+
				" <br>개인연락처:"+request.getParameter("phone")+"<br>"+
				" <br>이메일:"+request.getParameter("email")+"<br>"+
				"----------------------------------------<br>"+ct;
// 입력값 받음
 
Properties p = new Properties(); // 정보를 담을 객체 p.put("mail.smtp.user", from);
p.put("mail.smtp.host","smtp.googlemail.com"); // 네이버 SMTP
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
// SMTP 서버에 접속하기 위한 정보들
try{
	Authenticator auth = new SMTPAuthenticatior();
	Session ses = Session.getInstance(p, auth);
	MimeMessage msg = new MimeMessage(ses);
	msg.setSubject(subject);
	Address fromAddr =  new InternetAddress(from);
	msg.setFrom(fromAddr);
	Address toAddr = new InternetAddress(to);
	msg.addRecipient(Message.RecipientType.TO, toAddr);
	msg.setContent(content, "text/html;charset=UTF8");
	Transport.send(msg);
}catch(Exception e){
	e.printStackTrace();
}

response.sendRedirect("../main/main.jsp");
%>


