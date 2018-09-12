<%@page import="com.ithong.tour.TourDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="mail.Current_Date"%>
<%@page import="mail.GetCalendar"%>
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
		

	</head>
	<body>
		<%
		 Current_Date cd = new Current_Date();
		 String[] date=cd.GetDate().split("-");
		 String yy=request.getParameter("yy");
		 String mm=request.getParameter("mm");
		 int Oyy=0;
		 String dd=date[2];
		 if(yy==null||yy.equals("0")){
		 	yy=date[0];
		 	Oyy=Integer.parseInt(date[0]);
		 }else Oyy =Integer.parseInt(request.getParameter("yy"));
		 if(mm==null)  mm=date[1];
		
		 if(yy!=null||mm!=null) dd="1"; 
		 if(mm.equals("1")) Oyy= Integer.parseInt(yy)-1;
		 if(mm.equals("12")) Oyy= Integer.parseInt(yy)+1;
		 if(Integer.parseInt(mm)<1) mm="12";
		 if(Integer.parseInt(mm)>12) mm="1";
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
		
		<!-- 게시판 -->
		<article>
		<h1>부산 스토리 투어</h1>
			<form action="reservation.jsp" method="post" name="fr">
			<input type="hidden" name="mode" value="">
			<input type="hidden" name="view" value="">
			<input type="hidden" name="mm" value=<%=mm %>>
			<input type="hidden" name="yy" value=<%=yy %>>
			<input type="hidden" name="tour_date">
			<table style="width:100%;">
			<colgroup>
				<col width="15%">
				<col width="14%">
				<col width="14%">
				<col width="14%">
				<col width="14%">
				<col width="14%">
				<col width="15%">
			</colgroup>
			<tbody><tr>
			<td height="40" align="center" bgcolor="#FFFFFF" colspan="7" style="font-size:16pt;color:#000;font-family:tahoma;">
				<a href="story.jsp?mm=<%=Integer.parseInt(mm)-1%>&yy=<%=Oyy %>"><img src="../images/tour/prev.png" alt="이전달"></a>
				<strong><%=yy%>년 <%=mm %>월 </strong>
				<a href="story.jsp?mm=<%=Integer.parseInt(mm)+1%>&yy=<%=Oyy %>"><img src="../images/tour/next.png" alt="다음달"></a>
			</td> 
			</tr>
			<tr>
			</tr>
			<tr>
			<td height="30" align="center" bgcolor="#F2F2F2" style="color:#ff12a4"><b>일</b></td>
			<td align="center" bgcolor="#F5F5F5"><b>월</b></td>
			<td align="center" bgcolor="#F5F5F5"><b>화</b></td>
			<td align="center" bgcolor="#F5F5F5"><b>수</b></td>
			<td align="center" bgcolor="#F5F5F5"><b>목</b></td>
			<td align="center" bgcolor="#F5F5F5"><b>금</b></td>
			<td align="center" bgcolor="#F5F5F5" style="color:#138bd1"><b>토</b></td>
			</tr>
			<%
			GetCalendar gc = new GetCalendar(Integer.parseInt(yy),Integer.parseInt(mm));
			String[][] cal= gc.printCal();
			String color;
			TourDAO tdao= new TourDAO();
			if(mm.length()<2){	
				mm = "0"+mm;
			}
			System.out.println(mm);
			ArrayList<String> t_date= tdao.getDateList(mm);
			boolean ck=false;
			for(int j=0 ; j<6; j++){%>
				<tr style="border-bottom:1px solid #C4C4C4;">
				<%for(int i=0;i<7;i++){
					
					if(i==0) color="#ff12a4";
					else if(i==6) color="#138bd1";
					else color="#000000";
					 
					if(cal[j][i]!=null){
				%>
						<td height="50px" align="left" valign="top" bgcolor="#FFFFFF" style="padding:5px;FONT-FAMILY: 굴림,gulim; color:<%=color%>;">
					 	<font><b><%=cal[j][i] %></b></font>
				<%	if(!cal[j][i].equals("")){ 
					 if(Integer.parseInt(mm)<Integer.parseInt(date[1]))	ck=true;
					 else{
						for(int m = 0 ; m<t_date.size(); m++){
							if(Integer.parseInt(mm)==Integer.parseInt(date[1])){
							   if(t_date.get(m).equals(cal[j][i])||Integer.parseInt(cal[j][i])<=Integer.parseInt(date[2]))	ck=true;
							}else{
								if(t_date.get(m).equals(cal[j][i]))	ck=true;
							}
					 		
						}
					 }
					if(ck==false){
				%>
						<br><a href="#none" onclick="javascript:selectdate('<%=cal[j][i]%>')">예약가능</a>
				<%
					}else{
				%>
						<br>예약불가
				<%
					}
					ck=false;
					}
					}
				%>
					</td>
				<%
				} 
				%>
				</tr>
			<%}%>
			</tbody></table>
			</form>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/sub_bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
		</div>
		<script type="text/javascript">
			function selectdate(dd){
				if(dd<10) dd="0"+dd;
				var date=fr.yy.value+"-"+fr.mm.value+"-"+dd;
				fr.tour_date.value=date;
				fr.submit();
			}
		</script>
	</body>
</html>