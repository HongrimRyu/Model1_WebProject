<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="board.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
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
String pageNum=request.getParameter("pageNum");
if(request.getParameter("pageNum")==null){
 	pageNum="1";
 }

%>
<!-- 게시판 -->
<article>
<h1>Notice</h1>
<form action="gWritePro.jsp" method="post" name="fr" enctype="multipart/form-data">
<input type="hidden" name="pageNum" value=<%=pageNum%>>
<%-- <input type="hidden" name="id" value=<%=session.getAttribute("id")%>> --%>
<%-- <input type="hidden" name="pageMum" value=<%=pageNum%>> --%>
<div style="width:950px;border: 1px solid; min-height: 900px;" >
	<div class="write_subject">
		<p><input type="text" name="subject" class="subject" placeholder="제목을 입력해주세요."></P>
	</div>
	<div class="write_form">	
	<div class="write_c">
    <div id="editor_frame">
	    <p id="cma_image_1" style="width:99%;height: 20%;border:1px solid #000;display:none;"></p>
	    <p id="cma_image_2" style="width:99%;height: 20%;border:1px solid #000;display:none;"></p>
	    <p id="cma_image_3" style="width:99%;height: 20%;border:1px solid #000;display:none;"></p>
	    <p id="cma_image_4" style="width:99%;height: 20%;border:1px solid #000;display:none;"></p>
	    <p id="cma_image_5" style="width:99%;height: 20%;border:1px solid #000;display:none;"></p>
    </div>
    </div>
        <div class="comment">
    	<TEXTAREA id=editor style="DISPLAY: none; VISIBILITY: hidden" name=content></TEXTAREA>
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
					],height: 200
					
				} );
			</script>
    </div>
	<div class="imgbtn">
	<button class="file_1" id="replace">파일 업로드</button>
	<input type="file" id="upload" class="file_1" name="file_1" onchange="updateImageDisplay('1',this,$('#cma_image_1'))">  
	<span class="file_1" id="fMsg_1">파일이 없습니다.</span>
	</div>
	<div class="img_ctl">
		<input type="button" value="추가하기" onclick="addimg();">
		<input type="button" value="삭제하기" onclick="delimg('#cma_image_');">
	</div>
	<div class="write_button">
		<input type="submit" value="글쓰기" class="submit" onclick="vali()">
		<input type="reset" value="새로쓰기" class="cancel">
	</div>
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