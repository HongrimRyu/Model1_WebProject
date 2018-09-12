<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
// 로그인 성공시 id 세션값 설정
// 세션값 가져오기 
String id =(String) session.getAttribute("id");

// 세션값 있을때 없을때 
if( id != null){
	// 세션값 있을때
	
	%>
	<div id="login"><%if(id.equals("hongadmin")){%><a href="../adm_ctl/memberMgr.jsp">관리자페이지</a> | <%}%><%=id %>님 환영합니다. | <a href="../member/update.jsp">회원정보 수정</a> | <a href="../member/logout.jsp">로그아웃</a></div>
	<%	
}else{
	// 세션값 없을때
	%>
	<div id="login"><a href="../member/login.jsp">로그인</a> | <a href="../member/preJoin.jsp">회원가입</a></div>
	<%
}
%>

	<!-- 로고들어가는 곳 -->
	<div id="logo"><a href="/Bs_Travel/"><img src="../images/logo.jpg" width="265" height="62" alt="Busan Travel"></a></div>
	<!-- 로고들어가는 곳 -->
	<nav id="top_menu">
	<ul>
		<li><a href="../index.html">HOME</a></li>
		<li><a href="../tour/tour.jsp">부산관광</a></li>
		<li><a href="../center/notice.jsp">커뮤니티</a></li>
		<li><a href="../contact/us.jsp">CONTACT US</a></li>
	</ul>
	</nav>
</header>
<div class="clear"></div>
<div id="sub_img">
	<img src="../images/center/sub_img01.png" width="100%" height="282">
</div>
<div class="content_wrap">

