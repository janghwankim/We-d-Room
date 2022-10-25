<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
<!DOCTYPE html>
<%
//MemberUpdate.jsp->MemberUpdateProc.jsp(수정메서드호출)
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mem" class="member.MemberDTO" />
<jsp:setProperty name="mem" property="*" />
<%
//추가
String id=(String)session.getAttribute("id");
String password=request.getParameter("password");

System.out.println("MemberdeleteProc.jsp의 password=>"+password);

//String id= (String)session.getAttribute("sessionID"); 
//String pw = request.getParameter("password");
//-----------------------------------------------------------
MemberDAO memMgr=new MemberDAO();
int check=memMgr.memberDelete(id, password);//회원삭제
System.out.println("MemberUpdateProc.jsp의 회원 삭제 유무=>"+check);


%>
<html>
<head>
<meta charset="UTF-8">
</head>
<body bgcolor="#FFFFCC">
<br>
<center>
<%
	if(check==1){//회원수정에 성공
%>
		<script>
		<% session.invalidate();  %> // 삭제했다면 세션정보를 삭제한다.
		alert("성공적으로 탈퇴가 되었습니다. \n 작성했던 글들은 모두 삭제되었습니다!");
		location.href="../main.jsp";//아직 로그아웃하지 않은 상태
		</script>	
	<% }else{%>
		<script>
		alert("비밀번호가 일치하지 않습니다");
		history.back();//history.go(-1) 전의 페이지에서 다시 수정하라.
		</script>
	<% } %>
</center>
</body>
</html>