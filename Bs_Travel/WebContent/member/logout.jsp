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
// 세션값 초기화
session.invalidate();
// main.jsp 페이지로 이동
// "로그아웃 !!"
%>
<script type="text/javascript">
   alert("로그아웃!!");
   location.href="../main/main.jsp";
</script>






</body>
</html>