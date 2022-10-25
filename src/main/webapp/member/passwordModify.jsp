<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="member.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>WedRoom</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/register.css" type="text/css" />
<script>
function pw_check() {
 	var frm = document.passwordForm;
 	if (frm.currPassword.value.length < 1) {
 		  alert("현재 비밀번호를 입력해주세요");
 		  return;
 		 }
 	if (frm.password1.value.length < 1) {
 		  alert("새로운 비밀번호를 입력해주세요.");
 		  return;
 		 }
 	if (frm.password2.value.length < 1) {
 		  alert("새로운 비밀번호 확인란을 입력해주세요.");
 		  return;
 		 }
 	
	if (frm.password1.value != frm.password2.value) {
		alert("새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다..");
		frm.password1.value = "";
		frm.password2.value = "";
		frm.password1.focus();
		return

	}
	frm.method = "POST";
	frm.action = "passwordModifyPro.jsp";
	frm.submit();
}
</script>
</head>

<%
/* String id=(String)session.getAttribute("id"); */
String msg = (String) request.getAttribute("msg");
if (msg == null)
	msg = "";
%>

<body>
	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">
					<img src="image/logo.png" id="logo">
				</h4>
				<form class="validation-form" name="passwordForm"
					action="./passwordModifyPro.jsp" method="post" novalidate>
					<div class="col-md-8 mb-4">
						<input type="password" class="form-control" name="currPassword"
							value="" placeholder="현재 비밀번호를 입력해주세요."
							required>
					</div>
					<div class="col-md-8 mb-4">
						<input type="password" class="form-control" name="password1"
							value="" placeholder="새로운 비밀번호를 입력해주세요."
							required>
					</div>
					<div class="col-md-8 mb-4">
						<input type="password" class="form-control" name="password2"
							value="" placeholder="새로운 비밀번호 한번 더 입력해주세요."
							required>
					</div>
					<div class="col-md-8 mb-1 text-center">
						<button class="btn btn-info btn-lg" type="button" onclick="pw_check()">변경하기</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-warning btn-lg" type="button"
							onclick="history.back()">뒤로가기</button>
					</div>
				</form>
				<br><br>
				<footer class="my-3 text-center text-small">
					<p class="mb-1">&copy; WedRoom Corp.</p>
				</footer>
			</div>
		</div>
	</div>
</body>
<script>
	
</script>
</html>
