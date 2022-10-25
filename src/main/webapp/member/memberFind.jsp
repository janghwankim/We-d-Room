<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="member.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");//메모리
response.setDateHeader("Expires", 0);//보관하지마라
%>
<%
String id = (String) session.getAttribute("id");
System.out.println("MemberUpdate.jsp의 id=>" + id);
MemberDAO memMgr = new MemberDAO();
MemberDTO mem = memMgr.getMember(id);
System.out.println("MemberUpdate.jsp의 객체(mem)=>" + mem);//null
%>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script language="JavaScript" src="script.js"></script>
<script language="JavaScript" src="prototype.js"></script>
<script language="JavaScript" src="searchWord.js"></script>


<title>ID찾기/PW찾기</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/register.css" type="text/css" />

</head>
<body>
	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">
					<img src="image/logo.png" id="logo" />
				</h4>
				<br></br>
				<div class="col-md-8 mb-1 text-center" style="margin-left: 100px;">
					<input class="btn btn-info btn-lg" type="button" value="ID찾기"
						onClick="location.href='idFind.jsp'" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input
						class="btn btn-info btn-lg" type="button" value="PW찾기"
						onClick="location.href='pwFind.jsp'" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="btn btn-warning btn-lg" type="button" value="뒤로가기"
						onclick="history.back()" />
				</div>
				<br><br>
				<footer class="my-3 text-center text-small">
					<p class="mb-1">&copy; WedRoom Corp.</p>
				</footer>
			</div>
		</div>
	</div>
</body>
</html>