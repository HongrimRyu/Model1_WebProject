<%@page import="mail.GetCalendar"%>
<%@page import="mail.Current_Date"%>
<%@page import="com.ithong.member.MemberDTO"%>
<%@page import="com.ithong.member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.INEG"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ithong.board.BoardDAO"%>
<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>부산 투어</title>
	<link href="../css/default.css" rel="stylesheet" type="text/css">
	<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function validation(){
	if(fr.course.value==""){
	alert("입력값을 채워주세요.");
	return false;
	}
	if(fr.purpose.value==""){
		alert("입력값을 채워주세요.");
	return false;
	}
	if(fr.memo.value==""){
		alert("입력값을 채워주세요.");
	return false;
	}
	if(fr.phone1.value.length > 3){
		alert("입력값을 채워주세요.");
		return false;
	}
	if(fr.phone2.value.length > 4){
		alert("입력값을 채워주세요.");
		return false;
	}
	if(fr.phone3.value.length > 4){
		alert("입력값을 채워주세요.");
		return false;
	}
	fr.phone.value=fr.phone1.value+"-"+fr.phone2.value+"-"+fr.phone3.value;
	fr.member.value= fr.adult.value+"/"+fr.child.value+"/"+fr.baby.value;
	fr.submit();
	
}

</script>
</head>

<body>
<%
String id=(String)session.getAttribute("id");
if(id==null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.');");
	script.println("location.href='../member/login.jsp'");
	script.println("</script>");
	script.close();
}
MemberDAO mdao = new MemberDAO();
MemberDTO mdto = mdao.searchMember(id);

%>

	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/sub_top.jsp"/>
		<!-- 헤더들어가는 곳 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
		<jsp:include page="../inc/sub_menu_tour.jsp"/>
		</nav>
		<!-- 왼쪽메뉴 -->
		
		<article>
			<h1>예약신청</h1>
			<form action="reservPro.jsp" method="post" name="fr">
			<input type="hidden" name="id" value=<%=mdto.getId() %>>
			<input type="hidden" name="name" value=<%=mdto.getName() %>>
			<input type="hidden" name="email" value=<%=mdto.getEmail() %>>
			<input type="hidden" name="phone">
			<input type="hidden" name="member">
			<input type="hidden" name="tour_date" value=<%=request.getParameter("tour_date") %>>
			<div>
			<fieldset>
			<legend>투어정보</legend>
			투어 코스 :<select  name="course" style="margin-top:10px;">
				    <option value="">-투어코스 선택-</option>
					<option value="youngdo">영도다리 건너 깡깡이길 걷다</option>
					<option value="yongdusan">용두산 올라 부산포 바라보다</option>
					<option value="ibagu">이바구길 걷다</option>
					<option value="kukje">국제시장 기웃거리다</option></select><br>
			투어 일시 : <%=request.getParameter("tour_date") %>
			</fieldset> 
			</div>
			<fieldset>
			<legend>신청자 정보</legend>
		
			아이디:<%=mdto.getId() %><br>
			이름:<%=mdto.getName() %><br>
			구성인원 : 성인 <input type="text" name="adult" size="3"> 청소년 <input type="text" name="child" size="3"> 아동 <input type="text" name="baby" size="3"><br>
			<br>
			연락처 : <input type="text" name="phone1" size="3">-<input type="text" name="phone2" size="4">-<input type="text" name="phone3" size="4"><br>
			<br>
			방문목적 : <select  name="purpose" style="margin-top:10px;">
				    <option value="">-방문 목적-</option>
					<option value="travel">여행</option>
					<option value="work">비지니스</option>
					<option value="edu">교육</option></select><br>
			<br>
			하고싶은말 : <br><textarea class="inputBox01" name="memo" style="width: 496px; height: 77px; margin: 0px;"></textarea>
			
			</fieldset>
			<br>
			<input type="button" value="예약하기" onclick="validation()">
			</form>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/sub_bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>