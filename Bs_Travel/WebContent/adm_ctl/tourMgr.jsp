
<%@page import="com.ithong.tour.TourDAO"%>
<%@page import="com.ithong.tour.TourDTO"%>
<%@page import="com.ithong.member.MemberDTO"%>
<%@page import="com.ithong.member.MemberDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	
		<title>투어예약현황</title>
		
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
		<style type="text/css">
		.member_list{

			width: 100%;
			min-height:300px;
		}
		.mlist{
		border: 1px double;	
		}
		.mlist > tr,td,th{
		border: 1px solid;
		text-align: center;
		}
		.controller{
			border: 1.5px solid skyblue;
			border-radius: 3px;
			padding: 10px;
			

		}
		.controller > form {
		
		text-align: right;
		}
		</style>
	</head>
	<body>
	
		<%
			request.setCharacterEncoding("utf-8");
			String search=request.getParameter("search");
			if(search==null) search="";
			int num = 10;
			if(request.getParameter("number")!=null){
				num+=Integer.parseInt(request.getParameter("number")); 
			}
			TourDAO tdao = new TourDAO();
			ArrayList<TourDTO> al=null;
			if(search=="")	al = tdao.getTourList(num);
			else al = tdao.getTourList(num,search);
		%>
		<%=search %>
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/sub_top.jsp"/>
		<!-- 헤더들어가는 곳 -->
		
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu"><jsp:include page="../inc/sub_menu_mgr.jsp"/></nav>
		<!-- 왼쪽메뉴 -->
		
		<!-- 회원목록 -->
		<article>
		<h1>투어예약현황</h1>
		<div class="member_list">
			<table class="mlist" style="width: 100%">
				<colgroup>
				<col width="5%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
				</colgroup>
				<thead style="background-color: yellow;">
					<tr>
						<th>#</th>
						<th>이름</th>
						<th>코스정보</th>
						<th>방문목적</th>
						<th>투어인원</th>
						<th>이메일</th>
						<th>투어날짜</th>
						<th>연락처</th>
					</tr>
				</thead>
				<tbody>
				<%
					Iterator<TourDTO> iter = al.iterator();
					String course="";
					int i=1;
					while(iter.hasNext()){
						TourDTO tdto= iter.next();
						if(tdto.getCourse().equals("youngdo")) course="영도다리 건너 깡깡이길 걷다";
						if(tdto.getCourse().equals("yongdusan")) course="용두산 올라 부산포 바라보다";
						if(tdto.getCourse().equals("ibagu")) course="이바구길 걷다";
						if(tdto.getCourse().equals("kukje")) course="국제시장 기웃거리다";
				%>
					<tr>
						<td><%=i %></td>
						<td><%=tdto.getName() %></td>
						<td><%=course %></td>
						<td><%=tdto.getPurpose()%></td>
						<td><%=tdto.getMember() %></td>
						<td><%=tdto.getEmail()%></td>
						<td><%=tdto.getTour_date() %></td>
						<td><%=tdto.getPhone() %></td>
				<%
					i++;
					}%>
				</tbody>
			</table>
		</div>
		<div class="controller"><form action="tourMgr.jsp" method="post">
		<input type="hidden" name="number" value=<%=num %>>
		<input type="text" name="search" value="<%=search %>" placeholder="아이디검색">
		<input type="submit" value="검색">
		<input type="button" value="10개 더보기" onclick="location.href='tourMgr.jsp?number=10'">
		</form>
		</div>
		</article>
		<!-- 회원목록 -->
		
		<div class="clear"></div>
		
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/sub_bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->

	</body>
</html>