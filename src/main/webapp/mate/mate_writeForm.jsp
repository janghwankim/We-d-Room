<%@page import="mate.*"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>roommate_add</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
  <!-- Bootstrap icons-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
  <!-- Core theme CSS (includes Bootstrap)-->
  <link href="css/bootstrap.css" rel="stylesheet" /> 
  <link href="css/styles.css" rel="stylesheet" />
<script language="JavaScript" src="script.js?ver=1"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
 <script type="text/javascript">
	
 //이미지 미리보기
	var sel_file;
	
	$(document).ready(function() {
		$("#file").on("change", handleImgFileSelect);
	});
	
	function handleImgFileSelect(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
		
		filesArr.forEach(function(f) {
			if (!f.type.match(reg)) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#img").attr("src", e.target.result);
			};
			reader.readAsDataURL(f);
		});
	}
	
    	
 </script>
 
<body>  
<%  // 성향값이 없으면 새글작성 못하게 막기 
    String str=(String)request.getAttribute("smoking");
	if(str.length()==0){ 
%>
		<script>
			alert("성향테스트를 완료해야 작성가능합니다.");
			history.back();
		</script>
<%
	}
%>
<%
/*
	String id=null;
	if(session.getAttribute("id") != null) {
		id=(String)session.getAttribute("id");
	}*/
%>
<div class="wrap">
            <!-- 로고 -->
            <header class="hd">
                <div class="logo">
                    <a href="main.jsp"><img src="image/logo.png"></a>
                </div>
            </header>
            <!-- 메뉴바 -->
            <nav class="nav">
                <ul class="menu">
	                <li class="menu1"><a href="share_list.do">쉐어하우스</a></li>
	                <li class="menu2"><a href="mate_list.do">룸메이트</a></li>
	                <li class="menu3"><a href="free_list.do">자유게시판</a></li>
	                <li class="menu4"><a href="notice.do">공지사항</a></li>
	                <li><a href="tendency.do">성향테스트</a></li>
         	   </ul>
            </nav>
            <p>
	<div>

	
	
	<form method="post" name="writeform" 
		   action="/Project/mate_writePro.do" enctype="multipart/form-data"
		   onsubmit="return writeSave()">
		   
	<!-- 입력하지 않고 매개변수로 전달해서 테이블에 저장(hidden) -->		   
	<input type="hidden" name="mate_no" value="${num}"> 
	<input type="hidden" name="id_no" value="${id_no}"> <!-- ${id_no} -->
	<input type="hidden" name="views" value="0">
	

		<div class="pf_session">
                <div class="pf">  
                    <div class="pf_top">
                    
                        <div class="pf_img"> 
                        	<div class="img_wrap">
                            	<img src="img/profil.png" class="write_img" id="img" width="230px" height="230px" 
                            				style="border-radius: 50%; display:inline-block;" /> 
							</div>                             
                             <div style="text-align: center;">
                              	<input type="file" class="form-control" id="file" name="file"  required />
                              </div>
                              
                        </div> 
                       
                    </div>
                    <div class="pf_body">
                            <table width="770" border="1" cellspacing="0" cellpadding="0" align="center" >
                                <tr>
                                    <td bgcolor="#F5F5F5"><b>작성자</b></td>
                                    <td>
                                        <input type="text" class="pf_input" name="writer" value="<c:out value="${id}"/>"  readonly >
                                    </td>
                                    <td bgcolor="#F5F5F5"><b>성별</b></td>
                                    <td>
                                        <input type="text" class="pf_input" name="gender" value="<c:out value="${gender}"/>" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#F5F5F5"><b>제목</b></td>
                                    <td colspan="3">
                                        <input type="text" class="pf_input" name="title" required placeholder="제목을 입력하세요." >
                                    </td>
                                 
                                </tr>
                                <tr>
                                    <td bgcolor="#F5F5F5"><b>성향</b></td>
                                    <td colspan="3">
                                    출근시간: ${starttime} 퇴근시간: ${endtime}<br>
                                    수면시간: ${sleeptime} 샤워시간: ${showertime} <br> 
                                    흡연 : ${smoking} 반려동물: ${pet} 잠버릇: ${sleepinghabbit} <br>
                                        <input type="hidden" class="pf_input" style="width: 100%; height:120px"
                                        value="<c:out value="흡연: ${smoking} 수면시간: ${sleeptime}  반려동물: ${pet} 잠버릇: ${sleepinghabbit} 샤워시간: ${showertime} 출근시간: ${starttime} 퇴근시간: ${endtime}"  />"  >
									</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#F5F5F5"><b>라이프스타일</b></td>
                                    <td colspan="3">
                                        <input type="text" class="pf_input" name="lifestyle" placeholder='성향외의 스타일을 입력하세요  ex) 청소습관 등'>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#F5F5F5"><b>기타사항</b></td>
                                    <td colspan="3">
                                        <input type="text" class="pf_input" name="other_matter" placeholder="한줄메세지를 입력하세요.">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                    <input class="btn btn-outline-secondary" type="reset" value="다시작성">  
                                    <input class="btn btn-outline-secondary" type="submit" value="생성하기">
                                    <input class="btn btn-outline-secondary" type="button" value="목록보기" OnClick="window.location='/Project/mate_list.do'">
                                    </td>
                                </tr>
                            </table>
                    </div>
             </div>
            </div>
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
