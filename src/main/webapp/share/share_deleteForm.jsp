<%@page import="share.RoomDAO"%>
<%@page import="share.RoomDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>게시판</title>
<link rel="stylesheet" href="./css/register.css?" type="text/css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<script type="text/javascript">
	function room_del() {
		var frm = document.delForm;

		if (frm.password.value.length < 1) {
			alert("비밀번호를 입력해주세요");
			frm.password.focus();
			return;
		}

		frm.method = "post";
		frm.action = "share_deletePro.do?&room_no=${room_no}"; //넘어간화면
		frm.submit();
	}
</script>

</head>

<body style="min-height: 100vh; background: #F8F2C2">
	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">
					<img src="./image/logo.png" id="logo">
				</h4>
				<form method="POST" name="delForm" class="validation-form"
					action="/Project/share_deletePro.do?&room_no=${room_no}"
					onsubmit="return deleteSave()">
					<section class="form-search">
						<div class="col-md-8 mb-4">
							<b>비밀번호를 입력해 주세요.</b> &nbsp;&nbsp; <input type="password"
								name="password" size="20" maxlength="30"> <br>
						</div>

						<br>
					</section>
					<div class="col-md-8 mb-1 text-center">
						<input class="btn btn-info btn-lg" type="button" name="enter"
							value="삭제" onClick="room_del()">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
							class="btn btn-warning btn-lg" type="button" name="cancle"
							value="취소" onClick="history.back()">
					</div>
				</form>
				<br>
				<br>
				<footer class="my-3 text-center text-small">
					<p class="mb-1">&copy; WedRoom Corp.</p>
				</footer>
			</div>
		</div>
	</div>
</body>
</html>
