<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="free.board.*,free.comment.*,java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="memMgr" class="member.MemberDAO" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WedRoom</title>
    <link href="css/free.css" rel="stylesheet" type="text/css">
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
        <!-- 자유게시판(본문) -->
        <article class="freeboard_contnent">
            <p class="title">자유게시판</p>
<%
	int free_no=Integer.parseInt(request.getParameter("free_no"));
	System.out.println("free_content.jsp에서 free_no=>"+free_no);
	FreeDAO dbPro=new FreeDAO();
	FreeDTO article=dbPro.updateGetArticle(free_no);

	String id=null;
	if(session.getAttribute("id") != null) {
		id=(String)session.getAttribute("id");
	}
	int id_no=memMgr.loginSession(id);
	System.out.println("session.id=>"+id+", session.id_no=>"+id_no);
	if(id.equals(article.getId())) {
%>
            <div class="board_control">
                <a href="#" class="free_update" onclick="document.location.href='/Project/free_updateForm.do?free_no=${article.free_no}&pageNum=${pageNum}'">수정</a>&nbsp;&nbsp;
                <a href="#" class="free_delete" onclick="document.location.href='/Project/free_deleteForm.do?free_no=${article.free_no}&pageNum=${pageNum}'">삭제</a>
            </div>
<%} else { %>
			<div class="board_control">
                <a href="#" class="free_update"></a>&nbsp;&nbsp;
                <a href="#" class="free_delete"></a>
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
                    <button class="btn_list" type="button" onclick="document.location.href='/Project/free_list.do?pageNum=${pageNum}'">목록</button>
                </div>
            </div>
        </article>
        
        <!-- 댓글-->
        <article class="board_comment">
            <div class="comment">
                <span class="count">
                    💬 <strong>${count}</strong>개의 댓글이 있습니다. 
                </span>
                <form class="text" method="post" action="/Project/free_comwritePro.do?pageNum=${pageNum}&free_no=${article.free_no}&id=<%=id%>">
               		<input type="hidden" id="com_free_no" name="free_no" value="${article.free_no}">
               		<%-- <input type="hidden" name="id_no" value="${id_no}" > --%>
            		<input type="hidden" name="id_no" value="<%=id_no%>">
                	<input type="hidden" id="com_id" name="id" value="<%=id%>">
                	<%-- <input type="text" name="id" placeholder="아이디를 입력해주세요."  value="<%=id%>"/> --%>
                    <textarea id="comment" name="content" title="댓글 입력" rows="2" placeholder="댓글을 입력해주세요."></textarea>  
                    <input type="submit" class="btn_review" value="등록">
                </form>
            </div>

           		<c:if test="${count > 0}">
                <c:set var="free_no"  value="${free_no}" />
    			<c:forEach var="list"  items="${comList}">
    			<div class="comment-review">
    			<form id="comment_update">
    			<table class="comment-table">
    			<input type="hidden" name="comment_no" value="${list.comment_no}" />
    			<input type="hidden" name="free_no" value="${article.free_no}">
    			<input type="hidden" name="id" value="${list.id}">
    			<%-- <input type="hidden" name="id_no" value="${id_no}" > --%>
                    <tr>
                        <td style="border:0px;"><strong>${list.id}</strong></td>
                    </tr>
                    <tr>
                        <td id="comment_content" style="border:0px;">${list.content}</td>
                    </tr>
                    <tr>
                        <td class="date" style="border:0px;"><fmt:formatDate value="${list.created_datetime}"  timeStyle="medium" pattern="yy.MM.dd hh:mm" /></td>
                    </tr>
<%
	Free_comDAO comDao=new Free_comDAO();
	Free_comDTO list=comDao.getListCom(free_no);
	
	if(id.equals(list.getId())) {
%>
                    <form class="btn-comment">
                        <input type="button" class="btn-comupdate" onclick="popup(${article.free_no},${pageNum},${list.comment_no})" value="수정">
                        <input type="button" class="btn-comdelete" onclick="document.location.href='/Project/free_comdeleteForm.do?free_no=${article.free_no}&pageNum=${pageNum}&comment_no=${list.comment_no}'" value="삭제">
                    </form>
<%}%>
                </table>
                </form>
                </div>
                </c:forEach>
                
                </c:if>

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
	function popup(free_no,pageNum,comment_no){
		window.name = "commentUpdate";
		var url= "free_comupdateForm.do?free_no="+free_no+"&pageNum="+pageNum+"&comment_no="+comment_no;
		window.open(url,"","width=600,height=330,left=300,top=100");
	}
</script>
</html>