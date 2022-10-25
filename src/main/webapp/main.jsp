<%@page import="share.RoomDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="share.RoomDTO,member.*"%>
<jsp:useBean id="tenDao" class="tendency.TendencyDAO" />
<jsp:useBean id="memMgr" class="member.MemberDAO" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WedRoom</title>
    <link href="css/wedroomstyle.css?1" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css"/>

    
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
    $(function(){
        // 이미지 슬라이드
        $('.slide').slick({
            variableWidth: true, //width크기 조절
            slidesToShow: 3,
            slidesToScroll: 1,
            infinite: true,
            prevArrow:'<i class="fa-solid fa-angle-left left_arrow"/>',
            nextArrow:'<i class="fa-solid fa-angle-right right_arrow"/>',
        });

    });
    
    document.addEventListener('DOMContentLoaded', ()=>{
        var interval = window.setInterval(rollingCallback, 3000);
    })
    function rollingCallback(){
        //.prev 클래스 삭제
        document.querySelector('.rollingbanner .prev').classList.remove('prev');

        //.current -> .prev
        let current = document.querySelector('.rollingbanner .current');
        current.classList.remove('current');
        current.classList.add('prev');

        //.next -> .current
        let next = document.querySelector('.rollingbanner .next');
        //다음 목록 요소가 널인지 체크
        if(next.nextElementSibling == null){
            document.querySelector('.rollingbanner ul li:first-child').classList.add('next');
        }else{
            //목록 처음 요소를 다음 요소로 선택
            next.nextElementSibling.classList.add('next');
        }
        next.classList.remove('next');
        next.classList.add('current');
    }
    
</script>
 <script>
 function memberRegister(){
		document.location="./member/agreement.jsp";
	}
 </script>
</head>
<body>
<%
	RoomDTO room=new RoomDTO();
	String filename=room.getFilename();
	session.setAttribute("id_no", room.getId_no());
	
	String id=null;
	if(session.getAttribute("id") != null) {
		id=(String)session.getAttribute("id");
	}
	int id_no=memMgr.loginSession(id);
	System.out.println("session.id=>"+id+", session.id_no=>"+id_no);
	boolean check=tenDao.checkTendency(id_no);
%>
    <div class="wrap">
        <!-- 로고 -->
        <header class="hd">
            <div class="logo">
                <a href="main.jsp"><img src="image/logo.png" class="main-logo"></a>
            </div>
        <!-- 메뉴바 -->
        <div class="menu-bar">
            <ul class="menu">
                <li class="menu1"><a href="./share_list.do">쉐어하우스</a></li>
                <li class="menu2"><a href="./mate_list.do">룸메이트</a></li>
                <li class="menu3"><a href="./free_list.do">자유게시판</a></li>
                <li class="menu4"><a href="./notice_list.do">공지사항</a></li>
<%if(check==true){%>
				<li class="menu5"><a href="tendency_updateForm.do?id_no=<%=id_no%>">성향테스트</a></li>
<%} else {%>
                <li class="menu5"><a href="tendency.do?id_no=<%=id_no%>">성향테스트</a></li>
<%}%>
            </ul>
        </div>
        </header>

        <!-- 메뉴 밑 이미지 -->
        <nav class="nav">
            <div class="img">
                <a href="./mate_list.do" class="imgs"><img src="image/main_img.PNG"></a>
                <button type="button" class="room_btn" onclick="location.href='./mate_list.do'">바로가기</button>
            </div>
        </nav>
<%
	if(id == null) {
%>        
        <!-- 로그인 -->
        <div class="login">
            <nav class="nav2">
                <p>더 안전하고 편리하게 이용하세요!</p>
                <form name="login" method="post" action="./login/login_Pro.jsp">
                    <input type="text" name="id" placeholder="아이디"><br>
                    <input type="password" name="password" placeholder="비밀번호">
                    <button type="submit" class="login_btn" onclick="">로그인</button>
                </form>
                <br>
                <a class="text1" href="./member/memberFind.jsp">아이디 | 비밀번호 찾기</a>
                <!-- <a class="text2" href="./member/agreement.jsp">회원가입</a> -->
                <a class="text2" onclick="memberRegister()">회원가입</a>
            </nav>
        </div>
<%
	}else{
%>
        <!-- 마이페이지 -->
        <div class="mypage">
            <nav class="nav2_2">
                <p>환영합니다.</p>
                <img src="image/personal.PNG" alt="">
                <strong><%=(String)session.getAttribute("id")%>님</strong>
                <button type="button" class="logout_btn" onclick="location.href='./login/logoutAction.jsp'">로그아웃</button>
                <br>
                <a class="text3" href="./member/member_edit.jsp">회원수정</a>
                <a class="text4" href="./member/member_deleteForm.jsp">회원탈퇴</a>
                <a class="text5" href="./member/passwordModify.jsp">비밀번호 변경</a>
            </nav>
        </div>
<%}%>
<!-- 추천쉐어룸 이미지슬라이드 -->
<article class="atc1">
    <h3 class="shareroom">추천 쉐어룸</h3>
    <div class="slider">
        <div class="container"> 
            <div class="row slide">

                <div class="room">
                    <img src="/Project/fileFolder/seuol.jpeg" alt="" class="img-fluid">
                    <h3>서울 호캉스</a></h3>
                    <p><a href="./share_content.do?room_no=73">상세정보</a></p>
                </div>
           
                <div class="room">
                    <img src="/Project/fileFolder/room2.jpeg" alt="" class="img-fluid">
                    <h3>해뜨는곳</a></h3>
                    <p><a href="./share_content.do?room_no=71">상세정보</a></p>
                </div>
              
                <div class="room">
                    <img src="/Project/fileFolder/busan.jpeg" alt="" class="img-fluid">
                    <h3>부산 호캉스</a></h3>
                    <p><a href="./share_content.do?room_no=74">상세정보</a></p>
                </div>
                
                <div class="room">
                    <img src="/Project/fileFolder/jeju.jpeg" alt="" class="img-fluid">
                    <h3>제주 호캉스</a></h3>
                    <p><a href="./share_content.do?room_no=75">상세정보</a></p>
                </div>
                    
            </div>
        </div>
    </div>
</article>

        <!-- 공지사항 -->
        <article class="atc2">
            <h3 class="notice-board">공지사항</h3>
            <div class="rollingbanner">
                <div class="title">📢</div>
            <div class="notice">
                <ul>
                    <li class="current">
                        <a href="http://localhost:8090/Project/notice_content.do?notice_no=1&pageNum=1">첫번째 공지사항</a>
                    </li>
                    <li class="next">
                        <a href="http://localhost:8090/Project/notice_content.do?notice_no=2&pageNum=1">두번째 공지사항</a>
                    </li>
                    <li>
                        <a href="http://localhost:8090/Project/notice_content.do?notice_no=3&pageNum=1">세번째 공지사항</a>
                    </li>
                    <li>
                        <a href="http://localhost:8090/Project/notice_content.do?notice_no=4&pageNum=1">네번째 공지사항</a>
                    </li>
                    <li class="prev">
                        <a href="http://localhost:8090/Project/notice_content.do?notice_no=5&pageNum=1">마지막 공지사항</a>
                    </li>
                </ul>
            </div>
            </div>
        </article>
        <!-- 꼬리말 -->
        <div class="foot">
            <footer class="ft">
                <ul>
					<li><a href="terms.html">서비스 이용약관</a></li>
					<li class="l1">l</li>
					<li><a href="#">개인정보처리 방침</a></li>
					<li class="l1">l</li>
					<li><a href="#">광고 문의</a></li>
					<li class="l1">l</li>
					<li><a href="#">고객서비스 센터</a></li>
                    <li class="l1">l</li>
					<li><a href="#">위치기반 서비스 이용약관</a></li>
				</ul>
            <br>
            <p class="p">
                <a>상호 : (주)위드룸&nbsp;|&nbsp;주소 : 서울특별시 강남구 테헤란로1길 10&nbsp;|&nbsp;팩스 : 02-123-4567</a>
                <br>
                <a>서비스 이용문의 : 1234-9876&nbsp;|&nbsp;이메일 : cs@wedroom.com</a>
            </p>
            </footer>
        </div>
    </div>
</body>
</html>