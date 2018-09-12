
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
			MemberDAO mdao = new MemberDAO();
			ArrayList<MemberDTO> al=null;
			if(search=="")	al = mdao.getMemberList(num);
			else al = mdao.getMemberList(num,search);
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
		<h1>회원목록</h1>
		<div class="member_list">
			<table class="mlist" style="width: 100%">
				<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
				</colgroup>
				<thead style="background-color: yellow;">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>별명</th>
						<th>성별</th>
						<th>나이</th>
						<th>이메일</th>
						<th>부가<br>정보</th>
					</tr>
				</thead>
				<tbody>
				<%
					Iterator<MemberDTO> iter = al.iterator();
					int i=1;				
					while(iter.hasNext()){
						MemberDTO mdto= iter.next();
				%>
					<tr>
						<td><%=mdto.getId() %></td>
						<td><%=mdto.getName() %></td>
						<td><%=mdto.getNick() %></td>
						<td><%=mdto.getGender() %></td>
						<td><%=mdto.getAge() %></td>
						<td><%=mdto.getEmail() %></td>
						<td><button onclick="showInfo(<%=i%>);" id="sbtn_<%=i%>">보기</button></td>
					</tr>
					<tr id="optional_col_<%=i %>" style="display:none;">
						<td>주소</td>
						<td colspan="4"><%=mdto.getAddr() %></td>
						<td>전화번호</td>
						<td><%=mdto.getPhone() %></td>
					</tr>
				<%
					i++;
					}%>
				</tbody>
			</table>
		</div>
		<div class="controller"><form action="memberMgr.jsp" method="post">
		<input type="hidden" name="number" value=<%=num %>>
		<input type="text" name="search" value="<%=search %>">
		<input type="submit" value="검색">
		<input type="button" value="10개 더보기" onclick="location.href='memberMgr.jsp?number=10'">
		</form>
		</div>
		</article>
		<!-- 회원목록 -->
		
		<div class="clear"></div>
		
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/sub_bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
		<script type="text/javascript">
			function showInfo(num){
				var colId="optional_col_"+num;
				var btnId="sbtn_"+num;
				var show=document.getElementById(colId).style.display;
				if(show=="none"){
					document.getElementById(colId).style.display="table-row";
					document.getElementById(btnId).innerHTML="닫기";
				}else{
					document.getElementById(colId).style.display="none";
					document.getElementById(btnId).innerHTML="보기";					
				}
			}
		</script>
	</body>
</html>