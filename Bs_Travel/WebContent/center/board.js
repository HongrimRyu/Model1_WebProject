
/*사진게시판 JS*/
var num = 2;
function updateImageDisplay(num,html,$target) {
	var file="file_"+num;
	var fMsg="fMsg_"+num;
	var obj=document.getElementsByName(file)[0];	
 	if ( obj.value != "" ) {
 	var pathHeader = obj.value.lastIndexOf("\\");
 	var pathMiddle = obj.value.lastIndexOf(".");
 	var pathEnd = obj.value.length;
 	var fileName = obj.value.substring(pathHeader+1, pathMiddle);
 	var extName = obj.value.substring(pathMiddle+1, pathEnd); 
 	document.getElementById(fMsg).innerHTML=fileName+"."+extName;
 	} else {
 		document.getElementById(fMsg).innerHTML="파일이 없습니다.";
 	}
 	if (!html.files && html.files[0]) {
 	
        var reader = new FileReader();
        reader.onload = function (e) {
            $target.css('display', '');
            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
            $target.html('<img src="' + e.target.result + '" style="width: 80%;height: 250px;border: 1px solid rgb(0, 0, 0);margin: 20px 90px 20px 90px;" border="0" alt="" />');
        }
        reader.readAsDataURL(html.files[0]);
    }else{
    	$target.css('display', 'none');
    	$target.html('<img src="">');
    	
    }
}


function addimg(){
	if(num <6){
	$( ".imgbtn" ).append( "<button class='file_"+num+"' id='replace'>파일 업로드</button>" );
	$( ".imgbtn" ).append( "<input type='file' id='upload' class='file_"+num+"' name='file_"+num+"' onchange=updateImageDisplay('"+num+"',this,$('#cma_image_"+num+"'))>  " );
	$( ".imgbtn" ).append( "<span class='file_"+num+"' id='fMsg_"+num+"'>파일이 없습니다.</span>" );

	num++;}else alert("허용갯수초과");
}
function delimg(img){
	var delnum=num-1;
	var imgdel=img+delnum;
	if(delnum>1){
	var del=".file_"+delnum
	var deldiv=".cma_image_"+delnum;
	$(imgdel).css('display', 'none');
	$(imgdel).html('<img src="">');
	$(del).remove();
	$(deldiv).remove();
	num--;}
}
/*사진게시판 JS*/
/*댓글*/
function keylength(name,txt){
	var len=document.getElementById(name);
	var ctext=document.getElementById(txt)
	ctext.innerHTML="("+(len.value.length+1)+"/150)";
	if(len.value.length>=150){
		alert("허용치를 벗어났습니다.");
	}
	
}

function comment_vail(){
	var len=document.getElementById("reply_input").value.trim().length
	document.fr.content.value=document.getElementById("reply_input").value;
	document.getElementById("reply_input").innerHTML=" ";
	if(len < 0){
	 alert("댓글을 작성해주세요.");
	 return null;
	}
	fr.submit();
}
function showmodi(cidx){
		var btn=document.getElementById("modify_b_"+cidx);
		var view=document.getElementById("modify_c_"+cidx);
		if(btn.value == "1"){
			view.style.display="block";
			btn.innerHTML="수정하기닫기";
			btn.value ="0";
		}else{
			view.style.display="none";
			btn.innerHTML="수정하기";
			btn.value ="1";
		}
}
function modifyC(cidx){
	var len=document.getElementById("C_update").value.trim().length
	var cform=document.getElementById("mfr_"+cidx);
	if(len < 0){
	 alert("댓글을 작성해주세요.");
	 return null;
	}
	cform.submit();
}
function showreply(cidx){
	var btn=document.getElementById("reply_b_"+cidx);
	var view=document.getElementById("reply_c_"+cidx);
	if(btn.value == "1"){
		view.style.display="block";
		btn.innerHTML="답글하기닫기";
		btn.value ="0";
	}else{
		view.style.display="none";
		btn.innerHTML="답글하기";
		btn.value ="1";
	}
}
function deleteComment(id,idx,c_idx){
	var del = confirm("정말 삭제하시겠습니까?");
	if(del==true)	location.href="commentDelete.jsp?board_id=2&id="+id+"&idx="+idx+"&c_idx="+c_idx;
	else return null;
	
}
function fDelete(pn,idx){
	var delconfirm = confirm("정말 삭제 하시겠습니까?");
	if(delconfirm==true) location.href="fDelete.jsp?pageNum="+pn+"&idx="+idx;
	
}function gDelete(pn,idx){
	var delconfirm = confirm("정말 삭제 하시겠습니까?");
	if(delconfirm==true) location.href="gDelete.jsp?pageNum="+pn+"&idx="+idx;
	
}
/*댓글*/
