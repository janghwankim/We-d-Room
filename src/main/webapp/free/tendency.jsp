<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="login.*,java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");//한글처리 %>
<jsp:useBean id="login" class="login.LoginDTO" scope="page" />
<jsp:setProperty name="login" property="id" />
<jsp:setProperty name="login" property="password" />
<jsp:setProperty name="login" property="id_no" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WedRoom</title>
    <link href="./css/tendency.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div class="wrap">
        <!-- 로고 -->
		<header class="hd">
			<div class="logo">
				<a href="./main.jsp"><img src="./img/logo.png" /></a>
			</div>
		</header>
		<!-- 메뉴바 -->
		<nav class="nav">
			<ul class="menu">
				<li><a href="share_list.do">쉐어하우스</a></li>
				<li><a href="mate_list.do">룸메이트</a></li>
				<li><a href="free_list.do">자유게시판</a></li>
				<li><a href="notice_list.do">공지사항</a></li>
				<li><a href="tendency.do">성향테스트</a></li>
			</ul>
		</nav>

        <!-- 성향테스트 -->
        <div class="back">
            <form method="post" action="/Project/tendencyPro.do?id_no=${id_no}">
            <%-- <input type="hidden" name="id_no" value="${id_no}"> --%>
            <input type="hidden" name="id_no" value="1">
            <div class="text">
            <h2>성향테스트</h2>
            <h5>등록된 성향으로 빠르게 룸메이트를 찾을 수 있습니다.<br>
                정확하게 응답해주세요.</h5>
            </div>
            <div class="selectbox">
                <h3>1. 출근 시간을 골라주세요.</h3>
                <select id="starttime" name="starttime">
                    <option value="08:00">08:00</option>
                    <option value="09:00">09:00</option>
                    <option value="10:00">10:00</option>
                    <option value="11:00">11:00</option>
                    <option value="night">night</option>
                </select>
            </div>
            <div class="selectbox">
                <h3>2. 퇴근 시간을 골라주세요.</h3>
                <select id="endtime" name="endtime">
                    <option value="17:00">17:00</option>
                    <option value="18:00">18:00</option>
                    <option value="19:00">19:00</option>
                    <option value="20:00">20:00</option>
                    <option value="others">others</option>
                </select>
            </div>
            <div class="selectbox">
                <h3>3. 수면시간을 골라주세요.</h3>
                <select id="sleeptime" name="sleeptime">
                    <option value="22:00">22:00</option>
                    <option value="23:00">23:00</option>
                    <option value="24:00">24:00</option>
                    <option value="01:00">01:00</option>
                    <option value="02:00">02:00</option>
                </select>
            </div>
            <div class="selectbox">
                <h3>4. 샤워시간을 골라주세요.</h3>
                <select id="showertime" name="showertime">
                    <option value="AM">AM</option>
                    <option value="PM">PM</option>
                </select>
            </div>
            <div class="checkbox">
                <h3>잠버릇유무</h3>
                <span>있음</span>
                <input type="radio" name="sleepinghabbit" value="YES">
                <span>없음</span>
                <input type="radio" name="sleepinghabbit" value="NO">
            </div>
            <div class="checkbox">
                <h3>흡연유무</h3>
                <span>흡연</span>
                <input type="radio" name="smoking" value="YES">
                <span>비흡연</span>
                <input type="radio" name="smoking" value="NO">
            </div>
            <div class="checkbox">
                <h3>반려동물</h3>
                <span>있음</span>
                <input type="radio" name="pet" value="YES">
                <span>없음</span>
                <input type="radio" name="pet" value="NO">
            </div>
                <input id="btn" type="submit" value="등록">
            </form>
        </div>
        <!-- 꼬리말 -->
        <footer class="ft">
            <nav class="nav2">
                <ul>
					<li><a href="#">서비스 이용약관</a></li>
					<li class="l1">l</li>
					<li><a href="#">개인정보처리 방침</a></li>
					<li class="l1">l</li>
					<li><a href="#">광고 문의</a></li>
					<li class="l1">l</li>
					<li><a href="#">고객서비스 센터</a></li>
                    <li class="l1">l</li>
					<li><a href="#">위치기반 서비스 이용약관</a></li>
				</ul>
            </nav>
            <br>
            <p class="p">
                <a>상호 : (주)위드룸&nbsp;|&nbsp;주소 : 서울특별시 강남구 테헤란로1길 10&nbsp;|&nbsp;팩스 : 02-123-4567</a>
                <br>
                <a>서비스 이용문의 : 1234-9876&nbsp;|&nbsp;이메일 : cs@wedroom.com</a>
            </p>
        </footer>

    </div>
</body>
</html>