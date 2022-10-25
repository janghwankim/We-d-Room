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
</head>
<title>PW찾기</title>
</head>
<body>
	<div class="container">
		<div class="input-form-background row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">
					<img src="image/logo.png" id="logo">
				</h4>
				<form class="validation-form" name="pwsearch" method="POST">
					<div class="search-title">
						<h3>본인확인</h3>
						<br>
					</div>
					<section class="form-search">
						<div class="col-md-8 mb-4">
							<label>아이디 :</label> &nbsp;&nbsp; <input type="text" name="id"
								class="btn-name" placeholder="등록한 아이디"> <br>
						</div>
						<div class="col-md-8 mb-4">
							<label>이메일 :</label> &nbsp;&nbsp; <input type="text" name="email"
								class="btn-name" placeholder="등록한 이메일주소"> <br>
						</div>
						<br>
					</section>
					<div class="col-md-8 mb-1 text-center">
						<input class="btn btn-info btn-lg" type="button" name="enter"
							value="찾기" onClick="pw_search()">
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
<script type="text/javascript">
	function pw_search() {
		var frm = document.pwsearch;

		if (frm.id.value.length < 1) {
			alert("아이디를 입력해주세요");
			return;
		}

		if (frm.email.value.length < 1) {
			alert("이메일을 입력해주세요");
			return;
		}

		frm.method = "post";
		frm.action = "findPwResult.jsp"; //넘어간화면
		frm.submit();
	}
</script>
</html>