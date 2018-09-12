<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
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
 <script type="text/javascript" src="joinid.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/sub_top.jsp"/>
<!-- 헤더들어가는 곳 -->
<!-- <nav id="sub_menu"> -->
<!-- <ul> -->
<!-- </ul> -->
<!-- </nav> -->
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="joinPro.jsp" id="join" method="post" name="fr">
<input type="hidden" name="method" value="e">
<input type="hidden" name="idcheck" value="0">
<input type="hidden" name="pwcheck" value="0">
<input type="hidden" name="namecheck" value="0">
<input type="hidden" name="nickcheck" value="0">
<input type="hidden" name="mailcheck" value="0">
<input type="hidden" name="agecheck" value="0">
<input type="hidden" name="agree" value="<%=request.getParameter("agree")%>">

	<fieldset>
	<legend>Basic Info</legend>
	<label>User ID</label>
		<input type="text" name="id" class="id"  autocomplete="off" onblur="checkId()" >
		<span id="id_ck" class="alertMsg" ></span>
		<br>
	<label>Password</label>
		<input type="password" name="pass"><span id="pw_ck" class="alertMsg" ></span><br>
	<label>Retype Password</label>
		<input type="password" name="pass2" onblur="valiPassword()"><br>
	<label>Name</label>
		<input type="text" name="name" onblur="valiName()">
		<span id="name_ck" class="alertMsg" ></span><br>
	<label>NickName</label>
		<input type="text" name="nick" onblur="valiNick()">
		<span id="nick_ck" class="alertMsg" ></span><br>
	<label>Age</label>
		<input type="text" name="age" maxlength="4" size="5" onblur="valiAge()">
		<span id="birth_ck" class="alertMsg" ></span>
		<br>
	<label>Gender</label>
		<select name="gender" class="gender">
		<option value="none"> 선택하세요.</option>
		<option value="male"> 남성</option>
		<option value="female"> 여성</option>
		<option value="unknown"> 성별이없습니다.</option>
		</select>
		<span id="gen_ck" class="alertMsg" ></span><br>
	<label>E-Mail</label>
		<input type="email" name="email" autocomplete="off"><span id="mail_ck" class="alertMsg"></span><br>
	<label>Retype E-Mail</label>
		<input type="email" name="email2"  autocomplete="off" onblur="valiEmail()"><br>
	</fieldset>
	
	<fieldset>
	<legend>Optional</legend>
	<label>Address</label>
	<input type="text" name="postcode"id="postcode" placeholder="우편번호" readonly>
	<input type="button" onclick="execDaumPostcode()" class="dup" value="우편번호 찾기"><br>
	<label></label>
	<input type="text" name="address" id="address" placeholder="주소" readonly>
	<input type="text" name="address2" id="address2" placeholder="상세주소"><br>

<!-- 	<input type="text" name="addr"><br> -->
	<label>Mobile Phone Number</label>
	<input type="text" name="phone"><br>
	</fieldset>
	<div class="clear"></div>
	<div id="buttons">
		<input type="button" value="Submit" class="submit" onclick="validation()">
		<input type="reset" value="Cancel" class="cancel">
	</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/sub_bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>