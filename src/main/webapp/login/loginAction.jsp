<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="login.*,java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");//한글처리 %>
<jsp:useBean id="login" class="login.LoginDTO" scope="page" />
<jsp:setProperty name="login" property="id" />
<jsp:setProperty name="login" property="password" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<%
		LoginDAO loginDAO=new LoginDAO();
		int result=loginDAO.login(login.getId(),login.getPassword());
		if(result == 1) {
			session.setAttribute("id", login.getId());
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		} else if(result == 0) {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -1) {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -2) {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>

</body>
</html>