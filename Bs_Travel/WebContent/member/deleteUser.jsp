<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/sub_top.jsp"/>
<!-- 헤더들어가는 곳 -->

<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<%
String state=request.getParameter("state") != null ? request.getParameter("state") : "none";
%>


<article>
<h1>Login</h1>
<form action="delPro.jsp" method="post" name="fr" id="join">
<input type="hidden" name="method" value="e">

<fieldset>
<legend>회원탈퇴를 위해 한번더 패스워드를 입력해주세요.</legend>
<label>User ID</label>
<input type="text" name="id" value="<%=(String)session.getAttribute("id")%>" readonly ><br>
<label>Password</label>
<input type="password" name="pass"><br>
<%
if(state.equals("0")){
%>	
<div id="login_state" style="color : red;">
 아이디 또는 비밀번호가 일치하지않습니다.</div>
<%}%>
<%
if(state.equals("-1")){
%>	
<div id="login_state" style="color : red;">
 접속오류입니다. 관리자에게 문의하세요.</div>
<%}%>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원탈퇴" class="submit">
<input type="button" value="취소하기" class="cancel" onclick="location.href='../main/main.jsp'">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear" ></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/sub_bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>