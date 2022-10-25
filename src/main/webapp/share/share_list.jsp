<%@page import="share.RoomDAO"%>
<%@page import="share.RoomDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>WedRoom</title>
<link href="./css/main.css?a1f" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous" />
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
		<!-- 바디 -->
		<center>
			<%-- <b>등록된 방 현황(전체 방:${room_no})</b> --%>
			<form name="test" action="/Project/share_list.do">
				<select name="search">
					<option value="title">제목</option>
					<option value="title_address">제목+주소</option>
					<option value="address">주소</option>
				</select> <input type="text" size="15" name="searchtext">&nbsp; <input
					type="submit" value="검색">
			</form>
			<a href="/Project/share_write.do"> <img
				src="./img/Add button flat color ui icon.jpeg"
				class="btn_map_add" href="#" />
			</a>

			<c:set var="roomtest" value="${roomList}"></c:set>
			<div id="map" style="width: 100%; height: 800px"></div>
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5953d5b2a1f9f76a2ef6941f004f467f&libraries=services"></script>
			<script type="text/javascript" src="./js/map.js?ver=2">
					</script>
			<script type="text/javascript">
						var positions=new Array()
						<c:forEach var="room" items="${roomList}">
							var content= '<div style="padding:5px; "><a href="share_content.do?room_no=${room.room_no}"">${room.title} 자세히보기!</a></div>'
							var lat=${room.lat}
							var lng=${room.lng}
							
							 var test={content:content ,latlng: new kakao.maps.LatLng(lat,lng)}
							positions.push(test) 						
						</c:forEach>
						 

							 
						for (var i = 0; i < positions.length; i++) {
							var marker = new kakao.maps.Marker({
								map : map, // 마커를 표시할 지도
								position : positions[i].latlng, // 마커를 표시할 위치
							});
							
							var iwRemoveable=true
							// 마커에 표시할 인포윈도우를 생성합니다 
						    var infowindow = new kakao.maps.InfoWindow({
						        content: positions[i].content,// 인포윈도우에 표시할 내용
						        removable: iwRemoveable
						    });

						    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
						    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
						    
						}
						// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
						function makeClickListener(map, marker, infowindow) {
						    return function() {
						        infowindow.open(map, marker);
						    };
						}
					
					</script>


		</center>
</body>
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
	<br />
	<p class="p">
		<a>상호 : (주)위드룸&nbsp;|&nbsp;주소 : 서울특별시 강남구 테헤란로1길 10&nbsp;|&nbsp;팩스
			: 02-123-4567</a> <br /> <a>서비스 이용문의 : 1234-9876&nbsp;|&nbsp;이메일 :
			cs@wedroom.com</a>
	</p>
</footer>
</body>
</html>
