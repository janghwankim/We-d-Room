<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="notice.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WedRoom</title>
    <link href="./css/notice.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/board.js"></script>
</head>
<body>
<%
	String id=null;
	if(session.getAttribute("id") != null) {
		id=(String)session.getAttribute("id");
	}
%>
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
        <!-- 게시글 작성 -->
        <article class="notice_write">
            <p class="tiele">공지게시판 작성</p>
            <form method="post" name="notice_write" action="/Project/notice_writePro.do">
            	<input type="hidden" name="notice_no" value="${notice_no}" >
            	<%-- <input type="hidden" name="id_no" value="${id_no}" > --%>
            	<input type="hidden" name="id_no" value="1">
                <table class="write">
                    <tr>
                        <td class="write_id"><strong>아이디</strong></td>
                       	<input type="hidden" name="id" value="${id}" />
                       	<td><%=(String)session.getAttribute("id")%></td>
                        <!-- <td><input type="text" name="id" placeholder="아이디를 입력해주세요." /></td> -->
                    </tr>
                    <tr>
                        <td class="write_title"><strong>제목</strong></td>
                        <td><input type="text" name="title" class="board-title" placeholder="제목을 입력해주세요."></td>
                        <span class="msg" id="title_error">제목을 입력해주세요.</span>
                    </tr>
                    <tr>
                        <td class="write_content"><strong>내용</strong></td>
                        <td><textarea class="board-content" name="content" rows="20" placeholder="내용을 입력해주세요."></textarea></td>
                        <span class="msg2" id="content_error">내용을 입력해주세요.</span>
                    </tr>
                </table>
                <div class="btn-write">
                    <input type="button" class="btn-cancel" onclick="window.location='/Project/notice_list.do'" value="취소">
                    <input type="submit" class="btn-register" value="등록">
                </div>
            </form>
        </article>

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