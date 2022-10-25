<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");//메모리
 response.setDateHeader("Expires",0);//보관하지마라
%>
<%
String id=(String)session.getAttribute("id");
System.out.println("MemberUpdate.jsp의 id=>"+id);
MemberDAO memMgr = new MemberDAO();
MemberDTO mem = memMgr.getMember(id);
System.out.println("MemberUpdate.jsp의 객체(mem)=>"+mem);//null
%>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script language="JavaScript" src="script.js"></script>
  <script language="JavaScript" src="prototype.js"></script>
  <script language="JavaScript" src="searchWord.js"></script>
  
  
  <title>회원수정</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link rel="stylesheet" href="css/register.css" type="text/css" />

</head>

<body onLoad="document.forms['validation-form'].id.focus()">
  <div class="container">
    <div class="input-form-background row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-4"><img src="image/logo.png" id="logo"></h4>
        
        <form class="validation-form" name="validation-form" action="./MemberUpdateProc.jsp" method="post" novalidate>
       	<div class="col-md-8 mb-4">
        	<div class="input-group">
        		<input type="text" class="form-control" name="id" placeholder="아이디" value="<%=mem.getId() %>" readonly required>      
        	</div>
        </div>
        <!-- <div class="col-md-8 mb-4">
            <input type="password" class="form-control" name="password" placeholder="비밀번호 입력" required>
        </div>  
        <div class="col-md-8 mb-4">
            <input type="password" class="form-control" name="repassword" placeholder="비밀번호 재입력" required>
        </div> -->
        <%-- <div id="gendercheck">
            <label for="gender">성별</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="gender" value="<%=mem.getGender() %>" id="male"  onclick="return(false);">
            <label for="male">남자</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="gender" value="<%=mem.getGender() %>" id="female"  onclick="return(false);">
            <label for="female">여자</label>
        </div> --%>
        <br>
		<div class="col-md-8 mb-4">
            <input type="text" class="form-control" name="age" value="<%=mem.getAge()%>" placeholder="생년월일(YYYYMMDD)" required>
        </div>
        <div class="col-md-8 mb-4">
            <input type="number" class="form-control" name="phone" value="<%=mem.getPhone() %>" placeholder="휴대폰 번호 입력( '-' 제외 11자리 입력)" required>
        </div>     
        <div class="col-md-8 mb-4">
            <input type="email" class="form-control" name="email" value="<%=mem.getEmail() %>" placeholder="이메일주소@wedroom.com" required>
        </div>
        <div class="col-md-8 mb-4">
            <input type="text" class="form-control" name="kakaotalk" value="<%=mem.getKakaotalk() %>" placeholder="카카오톡 오픈채팅 아이디" required>
        </div>
        <div class="col-md-8 mb-1 text-center">
 	      <button class="btn btn-info btn-lg" type="button" onclick="inputCheck()">수정하기</button>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <button class="btn btn-info btn-lg" type="button" onclick="history.back()">뒤로가기</button>
        </div>
        </form>
      
      </div>
    </div> 
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; WedRoom Corp.</p>
    </footer>
  </div>
  
<script>
    function inputCheck(){
    	
    	if(document.forms['validation-form'].age.value==""){
    		alert("생년월일을 입력해주세요.");
    		document.forms['validation-form'].age.focus();
    		return;
    	}
    	if(document.forms['validation-form'].phone.value==""){
    		alert("연락처를 입력해주세요.");
    		document.forms['validation-form'].phone.focus();
    		return false;
    	}
    	if(document.forms['validation-form'].email.value==""){
    		alert("이메일을 입력해주세요.");
    		document.forms['validation-form'].email.focus();
    		return false;
    	}
    	if(document.forms['validation-form'].kakaotalk.value==""){
    		alert("카카오톡 아이디를 입력해주세요.");
    		document.forms['validation-form'].kakaotalk.focus();
    		return false;
    	}
    	
    	document.forms['validation-form'].submit(); 
    } 
  </script>
</body>
</html>