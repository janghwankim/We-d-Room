<%@page import="member.MemberDTO"%>
<%@page import="login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memMgr" class="member.MemberDAO" />

<%
	//Login.jsp->LoginProc.jsp -> LoginSuccess.jsp
	MemberDTO member=new MemberDTO();
	String id=request.getParameter("id");
	String password=request.getParameter("password");
	int id_no = 0;
	if(request.getParameter("id_no") !=null){
		id_no=Integer.parseInt(request.getParameter("id_no"));
		
	}
	System.out.println("id=>"+id+",password=>"+password+",id_no=>"+id_no);
	//System.out.println("id_no=>"+member.getId_no());
	//MemberDAO 객체 필요-> loginCheck() 호출
	//MemberDAO memMgr=new MemberDAO();
	boolean check=memMgr.loginCheck(id, password);
	//session.setAttribute("id_no", member.getId_no());
%>
<%
//check->LoginSuccess.jsp(인증화면),LogError.jsp(에러페이지)
if(check){//if(check==true)인증성공
	session.setAttribute("id", id);
	session.setAttribute("id_no", id_no);
	System.out.println("id_no=>"+id_no);

	//response.sendRedirect("LoginSuccess.jsp");//단순페이지이동
	System.out.println("로그인 성공");
	response.sendRedirect("../main.jsp");
}else{
	System.out.println("로그인 실패");
	response.sendRedirect("LoginError.jsp");
	
}

%>
