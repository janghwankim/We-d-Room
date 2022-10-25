<%@page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/register.css" type="text/css" />
<title>WedRoom</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	MemberDAO mem = new MemberDAO();
	String f_pw = mem.findPw(id, email);//비밀번호를 디비에서 가져옴..실패시 널
	%>
	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">
					<img src="image/logo.png" id="logo">
				</h4>
				<br><br>
				<form name="pwsearch" class="validation-form" method="post">
					<%
					if (f_pw != null) {
					%>

					<div class="container">
						<div class="found-success" style="margin-left: 30px;">
							<h4>회원님의 비밀번호는 다음과 같습니다</h4><br><br>
							<h2 style="color: red; margin-left: 120px">
								<div class="found-pw"><%=f_pw%></div>
							</h2>
							<br><br>
						</div>
						<div class="col-md-8 mb-1 text-center">
							<input class="btn btn-primary btn-lg" type="button" id="btnLogin"
								value="로그인" onclick="location.href='../main.jsp'" />

						</div>
					</div>
					<%
					} else {
					%>
					<div class="container">
						<div class="found-fail" style="margin-left: 30px;">
							<h4 style="margin-left: 50px;">등록된 정보가 없습니다</h4>
							<br><br>
						</div>
						<div class="col-md-8 mb-1 text-center">
							<input class="btn btn-info btn-lg" type="button" id="btnjoin"
								value="회원가입" onClick="location.href='./agreement.jsp'" /> &nbsp;&nbsp;&nbsp; <input
								class="btn btn-warning btn-lg" type="button" id="btnback"
								value="다시 찾기" onClick="history.back()" />
						</div>
					</div>

					<%
					}
					%>
				</form>
				<br><br>
				<footer class="my-3 text-center text-small">
					<p class="mb-1">&copy; WedRoom Corp.</p>
				</footer>
			</div>
		</div>
	</div>
</body>
</html>