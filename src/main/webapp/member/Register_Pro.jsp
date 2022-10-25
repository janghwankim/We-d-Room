<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	System.out.println("doPst");
	int id_no = Integer.parseInt(request.getParameter("id_no"));
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String gender = request.getParameter("gender");
	String age = request.getParameter("age");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String kakaotalk = request.getParameter("kakaotalk");
	
	MemberDTO memberDTO = new MemberDTO();
	
	memberDTO.setId_no(id_no);
	memberDTO.setId(id);
	memberDTO.setPassword(password);
	memberDTO.setGender(gender);
	memberDTO.setAge(age);
	memberDTO.setPhone(phone);
	memberDTO.setEmail(email);
	memberDTO.setKakaotalk(kakaotalk);
	
	MemberDAO memberDAO = new MemberDAO();
	System.out.println(memberDAO.memberInsert(memberDTO));
	
	/* RequestDispatcher rd = null;
	rd = request.getRequestDispatcher("src/main/webapp/main.jsp");
	String result = "회원가입에 성공하였습니다.";
	request.setAttribute("result", result); */
	
	/*
	 * response.setContentType("text/html; charset=UTF-8"); PrintWriter out =
	 * response.getWriter();
	 * 
	 * out.println("<script language='javascript'>");
	 * out.println("alert('회원가입에 성공하였습니다.')"); out.println("</script>");
	 * 
	 * out.close();
	 */
	
	/* rd.forward(request, response); */
	%>
<body>
<script>
	alert("회원가입에 성공하셨습니다!")
	location.href="../main.jsp";
</script>
</body>
</html>