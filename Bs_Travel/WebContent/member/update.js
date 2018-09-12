 function execDaumPostcode() {
     new daum.Postcode({
         oncomplete: function(data) {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
             var fullAddr = ''; // 최종 주소 변수
             var extraAddr = ''; // 조합형 주소 변수

             // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                 fullAddr = data.roadAddress;

             } else { // 사용자가 지번 주소를 선택했을 경우(J)
                 fullAddr = data.jibunAddress;
             }

             // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
             if(data.userSelectedType === 'R'){
                 //법정동명이 있을 경우 추가한다.
                 if(data.bname !== ''){
                     extraAddr += data.bname;
                 }
                 // 건물명이 있을 경우 추가한다.
                 if(data.buildingName !== ''){
                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                 }
                 // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                 fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
             }

             // 우편번호와 주소 정보를 해당 필드에 넣는다.
             document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
             document.getElementById('address').value = fullAddr;

             // 커서를 상세주소 필드로 이동한다.
             document.getElementById('address2').focus();
         }
     }).open();
 }


function valiName(){
	var oMsg = document.getElementById("name_ck");
	var check =  /[^가-힣a-zA-Z0-9]/gi;
	var nameLen=(fr.name.value.length <= 20) && (fr.name.value.length >= 2);
	if(!check.test(document.fr.name.value) && nameLen){
		
		oMsg.innerHTML="";
		document.fr.namecheck.value ="1"
		document.fr.name.style.backgroundColor="MediumSeaGreen";
	
	}else{
		oMsg.innerHTML ="한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
		document.fr.namecheck.value =="0"
		document.fr.name.style.backgroundColor="Tomato";
	}
}
function valiNick(){
	  var xhttp = new XMLHttpRequest();
	  var id=document.fr.nick.value;
	  var oMsg = document.getElementById("nick_ck");
	  if(id==fr.orinick.value){
	    	 document.fr.nick.style.backgroundColor="MediumSeaGreen";
	    	 document.fr.nickcheck.value="1";
	    	 return null;
	  }
	 
//	  if(id=="admin"){
//		  document.fr.nickcheck.value="0";
//		  document.fr.nick.style.backgroundColor="Tomato";
//		  oMsg.innerHTML = "올바르지않는 닉네임입니다.";
//		  return null;
//	  }
	
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	     	var myArr = JSON.parse(this.responseText);
	     if(myArr.length==0){
	    	 oMsg.innerHTML ="";
	    	 document.fr.nick.style.backgroundColor="MediumSeaGreen";
	    	 document.fr.nickcheck.value="1";
	     }
	     	for(var i = 0 ; i < myArr.length ; i++){
	     		if(document.fr.nick.value==myArr[i]){
	     			document.fr.nick.style.backgroundColor="Tomato";
	     			document.fr.nickcheck.value="0";
	     			oMsg.innerHTML ="중복된 아이디입니다.";
	     			break;
	     		}
	     		else {
	     			oMsg.innerHTML ="";
	     			document.fr.nick.style.backgroundColor="MediumSeaGreen";
	     			document.fr.nickcheck.value="1";
	     		}
	     	}
	        
	      this.responseText;
	    }
	  };
	  xhttp.open("GET", "joinNickCheck.jsp", true);
	  xhttp.send();
	
	}
function valiGender(){
	if(document.fr.gender.value == "none"){
		document.getElementById("gen_ck").innerHTML="성별을 정하세요.";
		document.fr.gender.style.backgroundColor="Tomato";
		fr.gender.focus();
		return null;
	}else{
		document.getElementById("gen_ck").innerHTML="";
		document.fr.gender.style.backgroundColor="MediumSeaGreen";
		return null
	}
	
}
function valiEmail(){
	var oMsg = document.getElementById("mail_ck");
	var email=fr.email.value;
	if(email == "") {
		oMsg.innerHTML="Email주소를 입력하세요."
		document.fr.email.style.backgroundColor="Tomato";
		document.fr.mailcheck.value="0";
	    return null;
	    }

	    if(email != "" && email == fr.email2.value) {
	    
	 
	    if(email.search("@")==-1){
	    	 oMsg.innerHTML="올바른 Email주소를 입력하세요."
	    	document.fr.mailcheck.value="0";
	    	document.fr.email.style.backgroundColor="Tomato";
	    	return null;
	     }
	     
	     
	    } else {
	    	 oMsg.innerHTML ="1차 E-mail주소와 일치 하지 안습니다.";
	    	  document.fr.email.style.backgroundColor="Tomato";
	    	  document.fr.mailcheck.value="0";
	    	  fr.email2.value="";
	    	  return null;
	    }
	    oMsg.innerHTML ="";
	    document.fr.mailcheck.value="1";
	    document.fr.email.style.backgroundColor="MediumSeaGreen";
	  
}

function valiAge(){
	var oMsg=document.getElementById("birth_ck");
	var age= document.fr.age.value;
	var vAge= /[^0-9]/;
	if(age==""){
		oMsg.innerHTML="나이를 입력하세요.";
		fr.agecheck.value="0"
		return null
	}
	if(vAge.test(age) || age < 0){
		oMsg.innerHTML="나이가 이상합니다..";
		fr.agecheck.value="0"
		return null
	}
	oMsg.innerHTML="";
	fr.agecheck.value="1"
}
function validation(){


	valiNick();
	valiAge();
	valiGender();
	valiEmail();
	if(fr.pass.value.trim() == "") {
		document.fr.pass.style.backgroundColor="Tomato";
		return null;
	}
	if(document.fr.chpwcheck.value =="1") {
		if(document.fr.pwcheck.value !="1") {
			changePassword();
			return null;
	}}
	if(document.fr.nickcheck.value !="1") {
		
		return null;
	}
	if(document.fr.agecheck.value !="1"){
		
		return null;
	}
	if(document.fr.gender.value =="none") {
		
		return null;
	}
	if(document.fr.mailcheck.value != "1"){
	
		return null;
	}

	fr.submit();
	
}


function changePassword(){
	var oMsg = document.getElementById("pw_ck");
	if(fr.pass1.value == "") {
		document.fr.pass.style.backgroundColor="Tomato";
		document.fr.pwcheck.value="0";
	    return null;
	    }

	    if(fr.pass1.value != "" && fr.pass1.value == fr.pass2.value) {
	    
	     re = /^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/;
	     if(!re.test(fr.pass1.value)){
	    	  oMsg.innerHTML ="대소문자, 숫자, 특수문자 조합으로 8자리 이상 입력하세요!";
	    	  document.fr.pass1.style.backgroundColor="Tomato";
	    	  document.fr.pwcheck.value="0";
	    	  return null;
	      }
	    } else {
	    	 oMsg.innerHTML ="1차 비밀번호랑 일치 하지 안습니다.";
	    	  document.fr.pass1.style.backgroundColor="Tomato";
	    	  document.fr.pwcheck.value="0";
	    	  return null;
	    }
	    oMsg.innerHTML ="";
	    document.fr.pwcheck.value="1";
	    document.fr.pass1.style.backgroundColor="MediumSeaGreen";
	  
}

function changePass(){

	if(fr.chpwcheck.value=="0"){
	document.getElementById("password").style.display="block";
	document.fr.chpw.value="비밀번경변경안함"
	fr.chpwcheck.value="1";
	return null;
	}
	if(fr.chpwcheck.value=="1"){
	document.getElementById("password").style.display="none";
	document.fr.chpw.value="비밀번경변경"
		fr.chpwcheck.value="0";
	return null;
	}
		
		
}

function delconfirm(){
	var con = confirm("정말 탈퇴 하시겠습니까?");
	if(con==true){
		location.href="deleteUser.jsp";
	}
	
}



	