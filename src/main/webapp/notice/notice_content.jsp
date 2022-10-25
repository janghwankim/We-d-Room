<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.*,java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WedRoom</title>
    <link href="css/notice.css" rel="stylesheet" type="text/css">
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
        <!-- 공지게시판(본문) -->
        <article class="noticeboard_contnent">
            <p class="title">공지게시판</p>
<%
	int notice_no=Integer.parseInt(request.getParameter("notice_no"));
	System.out.println("notice_content.jsp에서 notice_no=>"+notice_no);
	NoticeDAO dbPro=new NoticeDAO();
	NoticeDTO article=dbPro.getArticle(notice_no);	

	String id=null;
	if(session.getAttribute("id") != null) {
		id=(String)session.getAttribute("id");
	}
	if(id==null){
		%>
		<script type="text/javascript">
			alert("로그인 후 이용가능합니다!")
			history.back()
		</script>
<%
	}else if(id.equals(article.getId())) {
%>
            <div class="board_control">
                <a href="#" class="notice_update" onclick="document.location.href='/Project/notice_updateForm.do?notice_no=${article.notice_no}&pageNum=${pageNum}'">수정</a>&nbsp;&nbsp;
                <a href="#" class="notice_delete" onclick="document.location.href='/Project/notice_deleteForm.do?notice_no=${article.notice_no}&pageNum=${pageNum}'">삭제</a>
            </div>
<%} else { %>
			<div class="board_control">
                <a href="#" class="notice_update"></a>&nbsp;&nbsp;
                <a href="#" class="notice_delete"></a>
            </div>
<%}%>
            <div class="board_content">
                <table class="table_content">
                    <thead class="thead_content">
                    <tr>
                        <td class="td_contenttitle" style="width:650px;">${article.title}</td>
                        <td>${article.id}</td>
                        <td><fmt:formatDate value="${article.created_datetime}"  timeStyle="medium" pattern="yy.MM.dd" /></td>
                        <td>조회수 : ${article.views}</td>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="td_content" colspan="4">${article.content}</td>
                        </tr>
                    </tbody>
                </table>
                <div class="btn">
                    <button class="btn_list" type="button" onclick="document.location.href='/Project/notice_list.do?pageNum=${pageNum}'">목록</button>
                </div>
            </div>
        </article>

        <!-- 꼬리말 -->
        <footer class="ft" style="top:70px;position:relative;">
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
<script type="text/javascript">
	function popup(notice_no,pageNum,comment_no){
		window.name = "commentUpdate";
		var url= "notice_comupdateForm.do?notice_no="+notice_no+"&pageNum="+pageNum+"&comment_no="+comment_no;
		window.open(url,"","width=600,height=330,left=300,top=100");
	}
</script>
</html>