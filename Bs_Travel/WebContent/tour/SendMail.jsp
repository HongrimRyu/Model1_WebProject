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
<%!
public boolean SendMail(TourDTO tdto){
String host = "http://localhost:8088/BsTravel";
String from = "보내는이메일주소";
String to= tdto.getEmail();
String subject = tdto.getName()+"님의 신청이 완료되었습니다.";   
String course="";
if(tdto.getCourse().equals("youngdo")) course="영도다리 건너 깡깡이길 걷다";
if(tdto.getCourse().equals("yongdusan")) course="용두산 올라 부산포 바라보다";
if(tdto.getCourse().equals("ibagu")) course="이바구길 걷다";
if(tdto.getCourse().equals("kukje")) course="국제시장 기웃거리다";
String[] date= tdto.getTour_date().split("-");
String[] member=tdto.getMember().split("/");
String content = "<p>"+tdto.getName()+"님의 신청이 완료되었습니다.</p>"+
				"<br>신청 코스 :"+course+"<br>"+
				"신청 일자 : "+date[0]+"년 "+date[1]+"월 "+date[2]+"일<br>"+
				"신청 인원 : 성인 "+member[0]+"명 청소년"+member[1]+" 아동 "+member[2]+"명<br>"+
				"<br>스토리투어 시작은 오후 2시(14시) 부터 시작합니다.<br>"+
				"시작전 10분전까지 문화관 카운터로 오시면됩니다.<br>감사합니다.<br>";
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
	return true;
}catch(Exception e){
	e.printStackTrace();
}
return false;
}

%>


