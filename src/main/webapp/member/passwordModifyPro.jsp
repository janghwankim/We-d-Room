<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WedRoom</title>
</head>
<%
	//전달받은 현재 비밀번호 및 새로운 비밀번호를 반환받아 저장
	String id=(String)session.getAttribute("id");
	String currPassword=request.getParameter("currPassword");
	String newPassword=request.getParameter("password1");
	
	//현재 비밀번호가 맞을 경우 새로운 비밀번호로 member테이블의 회원정보 변경
	MemberDAO mem = new MemberDAO();
	int rows=mem.modifyPassword(id, currPassword, newPassword);
	System.out.println("row=>"+rows);
	
	//비밀번호가 변경된 경우
	if(rows==1){
		%>
		 <script type="text/javascript">
		 	alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.");
		 	location.href="../login/logoutAction.jsp"
		 </script>
		 <%-- <% 
		response.sendRedirect("../login/logoutAction.jsp");
		%> --%>
	<%
	} else {
		%>
		<script type="text/javascript">
		 	alert("입력된 현재 비밀번호가 일치하지 않습니다");
		 	location.href="passwordModify.jsp"
		 </script>
		 <%
		/* request.setAttribute("msg", "입력된 현재 비밀번호가 일치하지 않습니다");
		request.getRequestDispatcher("passwordModify.jsp").forward(request, response); */
	}
	
%>
<body>

</body>
</html>