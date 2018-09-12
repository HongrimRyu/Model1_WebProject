<%@page import="com.ithong.board.BoardDTO"%>
<%@page import="com.ithong.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
public static String getClientIpAddr(HttpServletRequest request) {  
    String ip = request.getHeader("X-Forwarded-For");  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getHeader("Proxy-Client-IP");  
    }  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getHeader("WL-Proxy-Client-IP");  
    }  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getHeader("HTTP_CLIENT_IP");  
    }  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
    }  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getRemoteAddr();  
    }  
    return ip;  
}%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.write_subject{
	width: 93%;
	border-style: solid ;
	border-color: rgba(255, 148, 77, 0.9);
	padding:1px;
	margin-bottom: 10px;

}
.subject{
background-color: rgba(191, 191, 191,0.4);
width: 94%;
height: 20px;
padding:5px;
margin: 1px;
}
.write_form {
width: 95%;
padding: 1px;
}
.write_button{
margin-top:4px;
float : right;
}
.submit, .cancel{
	height: 30px; width: 150px; border: 1px solid #666;
	border-radius:10px; box-shadow:3px 3px 2px #CCC;
	font-size: 14px;
}
.cancel{
background-image: url("../images/member/submit_back.jpg");
background-repeat: repeat-x;
background-position: center center;
color: #fff;
}/*
배경이미지 images/member/submit_back.jpg
repeat-x center center 글자색 #fff*/
.submit{margin: 0 0 0 20px;
background-image: url("../images/member/cancel_back.jpg");
background-repeat: repeat-x;
background-position: center center;
color: #fff;
}
.upload{
  border: solid;
  opacity: 0;       /*input type="file" tag 투명하게 처리*/
  position: relative;
  width:80px;
margin-top: 10px;
}
button.replace {    /*button tag 에 원하는 스타일 적용*/
  margin-top: 10px;
  position: absolute; 
  width: 80px;
  height: 30px;
  border-radius: 3px;
  border-color: transparent;
  font-size: 12px;
  color: #fff;
cursor: pointer;
}



</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../ckeditor/ckeditor.js">

</script>



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
<script>
var input = document.querySelector('.upload');
var preview = document.querySelector('.preview');

function updateImageDisplay() {
	var obj=fr.up;
 	if ( obj.value != "" ) {
 	var pathHeader = obj.value.lastIndexOf("\\");
 	var pathMiddle = obj.value.lastIndexOf(".");
 	var pathEnd = obj.value.length;
 	var fileName = obj.value.substring(pathHeader+1, pathMiddle);
 	var extName = obj.value.substring(pathMiddle+1, pathEnd);
    
 	document.getElementById("fMsg").innerHTML=fileName+"."+extName;
 	} else {
 		document.getElementById("fMsg").innerHTML="파일이 없습니다.";
 	}
}

</script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/sub_top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<jsp:include page="../inc/sub_menu_notice.jsp"/>
</nav>
<!-- 왼쪽메뉴 -->
<%
if(session.getAttribute("id")==null){
	response.sendRedirect("../main/main.jsp");
}
if(request.getParameter("idx")==null){
	response.sendRedirect("../main/main.jsp");
}
String pageNum=request.getParameter("pageNum");
if(request.getParameter("pageNum")==null){
	pageNum="1";
}
request.setCharacterEncoding("utf-8");
int idx=Integer.parseInt(request.getParameter("idx"));
BoardDAO bdao = new BoardDAO();
BoardDTO bdto = bdao.getBoard(1,idx);
%>
<!-- 게시판 -->
<article>
<h1>Notice</h1>
<form action="nUpdatePro.jsp" method="post" name="fr">
<input type="hidden" name="modify_id" value=<%=session.getAttribute("id")%>>
<input type="hidden" name="id" value=<%=session.getAttribute("id")%>>
<input type="hidden" name="pageNum" value=<%=pageNum%>>
<input type="hidden" name="idx" value=<%=bdto.getIdx()%>>
	<div class="write_subject">
		<p><input type="text" name="subject" class="subject" placeholder="제목을 입력해주세요." value="<%=bdto.getSubject() %>"></P>
		</div>	
		<div class="write_form">
			<TEXTAREA id=editor style="DISPLAY: none; VISIBILITY: hidden" name=content><%=bdto.getContent() %></TEXTAREA>
			<script>
				CKEDITOR.replace('editor', {
					// Define the toolbar: http://docs.ckeditor.com/ckeditor4/docs/#!/guide/dev_toolbar
					// The full preset from CDN which we used as a base provides more features than we need.
					// Also by default it comes with a 3-line toolbar. Here we put all buttons in a single row.
					toolbar: [
						{ name: 'document', items: [ 'Print' ] },
						{ name: 'clipboard', items: [ 'Undo', 'Redo' ] },
						{ name: 'styles', items: [ 'Format', 'Font', 'FontSize' ] },
						{ name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting' ] },
						{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
						{ name: 'align', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
						{ name: 'links', items: [ 'Link', 'Unlink' ] },
						{ name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
						{ name: 'insert', items: [ 'Image', 'Table' ] },
					],height: 600
					
				} );
			
			</script>
		<div class="preview">
		<button class="replace">파일 업로드</button>
		<input type="file" value="파일 업로드" class="upload" name="up" onchange="updateImageDisplay()">
		<span id="fMsg">파일이 없습니다.</span>
		</div>
		<div class="write_button">
			<input type="submit" value="글수정" class="submit">
			<input type="reset" value="새로쓰기" class="cancel">
		</div>
	</div>
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















