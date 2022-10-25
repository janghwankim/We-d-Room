<%@page import="mate.MateDTO"%>
<%@page import="mate.MateDAO"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File" %>
<jsp:useBean id="memMgr" class="member.MemberDAO" />
<jsp:useBean id="tenDao" class="tendency.TendencyDAO" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<html>
<head>
<title>roommate board</title>
  <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
  <!-- Bootstrap icons-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
  <!-- Core theme CSS (includes Bootstrap)-->
  <link href="css/bootstrap.css" rel="stylesheet" /> 
  <link href="css/styles.css?2" rel="stylesheet" />
  <script language="JavaScript" src="script.js?ver=1"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<script>
function commonChk(chk,cmd) {
	if(chk.checked)
		document.getElementById(cmd).value="YES";
	else
		document.getElementById(cmd).value="NO";
}
</script>
<%
String id=null;
if(session.getAttribute("id") != null) {
	id=(String)session.getAttribute("id");
}
int id_no=memMgr.loginSession(id);
boolean check=tenDao.checkTendency(id_no); 
if(id==null){
%>
<script type="text/javascript">
	alert("로그인 후 이용 가능합니다!")
	//document.location('/login/Login.jsp')
</script>
<%} %>
 <body>
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
	                <li class="menu4"><a href="notice_list.do">공지사항</a></li>
<%if(check==true){%>
				<li class="menu5"><a href="tendency_updateForm.do?id_no=<%=id_no%>">성향테스트</a></li>
<%} else {%>
                <li class="menu5"><a href="tendency.do?id_no=<%=id_no%>">성향테스트</a></li>
<%}%>
         	   </ul>
            </nav>
       <div class="op">
        <form name="filter" class="filter" action="/Project/mate_list.do" method="post" onsubmit="doSearch();">
        <select class="form-select form-select-lg" name="starttime">
            <option value="" selected>출근시간</option>
            <option value="08:00">08:00</option>
            <option value="09:00">09:00</option>
            <option value="10:00">10:00</option>
            <option value="11:00">11:00</option>
            <option value="night">night</option>
        </select>
            <select class="form-select form-select-lg" name="endtime">
                <option value=""  selected>퇴근시간</option>
                <option value="17:00">17:00</option>
                <option value="18:00">18:00</option>
                <option value="19:00">19:00</option>
                <option value="20:00">20:00</option>
                <option value="others">others</option>
            </select>
            <select class="form-select form-select-lg" name="sleepTime">
                <option value=""  selected>수면시간</option>
                <option value="22:00">22:00</option>
                <option value="23:00">23:00</option>
                <option value="24:00">24:00</option>
                <option value="01:00">01:00</option>
                <option value="02:00">02:00</option>
            </select>
            <select class="form-select form-select-lg" name="showerTime">
                <option value=""  selected>샤워시간</option>
                <option value="AM">AM</option>
                <option value="PM">PM</option>
            </select>
            <p>
                 <div class="form-check">
                    <input class="form-check-input" type="checkbox" onclick="commonChk(this,'smokeYN')" id="c_box1" >
                    <input type="hidden" name="smokeYN" id="smokeYN">
                    <label class="form-check-label" for="c_box1">
                      흡연유무
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="c_box2" onclick="commonChk(this,'petYN')" >
                    <input type="hidden" name="petYN" id="petYN">
                    <label class="form-check-label" for="c_box2">
                      반려동물유무
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="c_box3" onclick="commonChk(this,'sleepinghabbitYN')" >
                    <input type="hidden" name="sleepinghabbitYN" id="sleepinghabbitYN">
                    <label class="form-check-label" for="c_box3">
                      잠버릇유무
                    </label>
                  </div>
                  <div class="form-check" style="right: 14px;">
                    <input class="btn btn-outline-secondary" type="submit" value="검색하기">
                   <!--  <input type="text" class="searchText" name="searchText" style=""/> -->
                  </div>
                  
             	</form> 
            </div>
            
            
		<!-- 데이터의 유무 -->
		<c:if test="${pgList.count==0 }">

	     	<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	     	<tr>
				<td class="add_bt" align="right">
               	 	<input class="btn btn-outline-secondary" type="submit" value="새 글 작성"  OnClick="window.location='/Project/mate_writeForm.do'">
            	</td>
			</tr>
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
			</tr>
		</table>
		</c:if>

    <%
    	MateDTO article=new MateDTO();
    	String filename=article.getFilename();
    %>
 		<c:if test="${pgList.count > 0 }">
        <!-- Section-->
        <section class="py-5">
            <span class="add_bt">
                <input class="btn btn-outline-secondary" type="submit" value="새 글 작성"  OnClick="window.location='/Project/mate_writeForm.do'">
            </span>

            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
          		
          		 <c:set var="number" value="${pgList.number}" />
                <c:forEach var="article" items="${articleList}">
                
                    <div class="col mb-5">
                        <div class="card h-100" onclick="location.href='/Project/mate_content.do?num=${article.mate_no}&pageNum=${pgList.currentPage}'">
                            <!-- Product image-->
                          <div class="col_up">
                          		<div class="card_pf" >
                          			<img class="list_img" src="<%=request.getContextPath() %>/fileFolder/${article.filename}">
                          		</div>
                   
                          </div>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${article.title}</h5>
                                    <!-- Product price-->
                                    ${article.member.id}
                                </div>
                                
                                <c:if test="${article.tendency.smoking =='YES'}">
                                	<span class="mini_1">흡연</span>
                                </c:if>
                                <c:if test="${article.tendency.smoking =='NO'}">
                                	<span class="mini_2">비흡연</span>
                                </c:if>
                                
                                <c:if test="${article.tendency.pet =='YES'}">
                                	<span class="mini_3">반려동물</span>
                                </c:if>
                                <c:if test="${article.tendency.pet =='NO'}">
                                	<span class="mini_4">반려동물x</span>
                                </c:if>
                               
                                <c:if test="${article.tendency.sleepinghabbit =='YES'}">
                                 	<span class="mini_5">잠버릇</span>
                                </c:if>
                                <c:if test="${article.tendency.sleepinghabbit =='NO'}">
                                 	<span class="mini_6">잠버릇x</span>
                                </c:if>
                                
                            </div>
                        </div>
                    </div>
                        
                </c:forEach> 
      
                </div>
            </div>  
            
        </section>
        </c:if>


 <!-- 페이징 처리 -->
<!-- 	블럭이 10개 이상이면 이거 적용 -->
 	 <c:if test="${pgList.startPage > pgList.blockSize}">
		<a href="/Project/mate_list.do?pageNum=${pgList.startPage-pgList.blockSize}&search=${search}&searchtext=${searchtext}"> [이전]</a>
	</c:if> 
	
	<center>
	<div class="paging">
			<a href="/Project/mate_list.do?pageNum=${pgList.startPage}" class="prev"><img src="./image/left-next.png"></a>
	
		<c:forEach var="i" begin="${pgList.startPage}" end="${pgList.endPage}">
			<a href="/Project/mate_list.do?pageNum=${i}" class="num">
			<c:if test="${pgList.currentPage==i}">
				<b>${i}</b>
			</c:if>	
			<c:if test="${pgList.currentPage!=i}">
				${i}
			</c:if>	
		</a>
	</c:forEach>
	
	<c:if test="${pgList.endPage <pgList.pageCount}">
		<a href="/Project/mate_list.do?pageNum=${pgList.startPage+pgList.blockSize}&search=${search}&searchtext=${searchtext}"> [다음]</a>
	</c:if>
	<a href="/Project/mate_list.do?pageNum=${pgList.endPage}"class="prev"><img src="./image/right-next.png"></a>
	</div>
</center>  
<p>

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