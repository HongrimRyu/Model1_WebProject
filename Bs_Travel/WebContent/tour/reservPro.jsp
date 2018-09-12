<%@page import="com.ithong.tour.TourDAO"%>
<%@ include file="SendMail.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<% request.setCharacterEncoding("utf-8"); %>
		<jsp:useBean id="tdto" class="com.ithong.tour.TourDTO"/>
		<jsp:setProperty property="*" name="tdto"/>
		<%
		TourDAO tdao= new TourDAO();
		int idx= tdao.maxIdx();
		idx++;
		tdto.setIdx(idx);
		if(tdao.insertTourInfo(tdto)){
			SendMail(tdto);
		%>
		<script type="text/javascript">
			alert("신청이 완료되었습니다.");
			location.href="../main/main.jsp";
		</script>
		<%
		}else{
		%>
		<script type="text/javascript">
			alert("오류가 발생하였습니다. 지속되면 관리자에게 문의하세요.");
			history.back();
		</script>
		<%} %>
	</body>
</html>