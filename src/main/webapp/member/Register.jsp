<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
 <%//새로고침
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");//메모리
 response.setDateHeader("Expires",0);//보관하지마라
%>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script language="JavaScript" src="script.js?af"></script>
  <!-- <script language="JavaScript" src="prototype.js"></script>이거떄매 jquery 안먹음 뭔지 알고 쓰기.   -->
  <script language="JavaScript" src="searchWord.js?af"></script>
  
  <title>회원가입</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link rel="stylesheet" href="css/register.css" type="text/css" />

</head>
<%
	int id_no = 0;
	if(request.getParameter("id_no") != null){
		id_no=Integer.parseInt(request.getParameter("id_no"));		
	}
	request.setAttribute("id_no", id_no);
%>
<body onLoad="document.forms['validation-form'].id.focus()">
  <div class="container">
    <div class="input-form-background row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-4"><img src="image/logo.png" id="logo"></h4>
        
        <form class="validation-form" id="registerForm" name="validation" action="Register_Pro.jsp" method="post" novalidate>
            <div class="col-md-8 mb-4">
             <div class="input-group">
             <input type="hidden" name="id_no" value="<%=id_no%>">
              <input type="text" class="form-control" name="id" placeholder="아이디" value="" required>
              &nbsp;
              <span class="input-group-lg">
              <button class="btn btn-outline-info btn-default" type="button" onClick="idCheck(this.form.id.value)">중복확인</button>
	     	  </span>
            </div>
          </div>
          <div class="col-md-8 mb-4">
            <input type="password" class="form-control" name="password" placeholder="비밀번호 입력" required>
          </div>
          
          <div class="col-md-8 mb-4">
            <input type="password" class="form-control" name="repassword" placeholder="비밀번호 재입력" required>
          </div>
          <div id="gendercheck">
            <label for="gender">성별</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="gender" value="MAN" id="male">
            <label for="male">남자</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="gender" value="WOMAN" id="female">
            <label for="female">여자</label>
          </div>
          <br>
		  <div class="col-md-8 mb-4">
            <input type="text" class="form-control" name="age" placeholder="생년월일(YYYYMMDD)" required>
          </div>
          <div class="col-md-8 mb-4">
            <input type="number" class="form-control" name="phone" placeholder="휴대폰 번호 입력( '-' 제외 11자리 입력)" required>
          </div>     
          <div class="col-md-8 mb-4">
            <input type="email" class="form-control" name="email" placeholder="이메일주소@wedroom.com" required>
          </div>
          <div class="col-md-8 mb-4">
            <input type="text" class="form-control" name="kakaotalk" placeholder="카카오톡 오픈채팅 아이디" required>
          </div>
          <div class="col-md-8 mb-1 text-center">
          <button class="btn btn-info btn-lg" type="button" onclick="inputCheck()">가입하기</button>
        </div>
        </form>
      </div>
    </div> 
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; WedRoom Corp.</p>
    </footer>
  </div>
  
<script>
	
/* function joinMember(){
	//JQUERY 사용법 $("#html에서 적은 id값")
	var formData = new FormData(document.getElementById('registerForm'));
	//FORM데이터에 뭐가 들어있는지 찍어보기.
	for (let key of formData.keys()) {
		console.log(key, ":", formData.get(key));
	}
	debugger;
	$.ajax({
	    url: "/member",
	    type: "post",
	    data: formData,
	    processData: false, // formdata를 사용할때 필요한 변수.
	    success: function(data){
	  		alert(data);
	  		debugger;
	    },
	    error: function (request, status, error){        

	    }
	});
} */

function inputCheck(){
	var frm =document.validation
	
	if (frm.id.value.length < 1) {
		alert("아이디를 입력해주세요");
		frm.id.focus();
		return;
	}
	if (frm.password.value.length < 1) {
		alert("비밀번호를 입력해주세요");
		frm.password.focus();
		return;
	}
	if (frm.repassword.value.length < 1) {
		alert("비밀번호 확인을 입력해주세요");
		frm.repassword.focus();
		return;
	}
	if (frm.age.value.length < 1) {
		alert("생년월일을 입력해주세요");
		frm.age.focus();
		return;
	}
	if (frm.phone.value.length < 1) {
		alert("전화번호를 입력해주세요");
		frm.kakaotalk.focus();
		return;
	}
	
	if (frm.email.value.length < 1) {
		alert("이메일을 입력해주세요");
		frm.email.focus();
		return;
	}
	
	if (frm.kakaotalk.value.length < 1) {
		alert("카카오톡 아이디를 입력해주세요");
		frm.id.focus();
		return;
	}
	if (frm.password.value != frm.repassword.value) {
		alert("비밀번호와 비밀번호 확인란이 일치하지 않습니다..");
		frm.password.value = "";
		frm.repassword.value = "";
		frm.password.focus();
		return

	}

	frm.method = "post";
	frm.action = "Register_Pro.jsp"; //넘어간화면
	frm.submit();
} 
</script>
</body>
</html>