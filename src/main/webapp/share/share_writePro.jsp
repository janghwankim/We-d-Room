<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Timestamp,share.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    <%    
     //response.sendRedirect("list.jsp");//입력한후 다시 DB접속->새로 고침해서 화면에 새로운글 반영
    %>  

<%@page import="share.RoomDTO"%>
<%@page import="share.RoomDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String path = session.getServletContext().getRealPath("/");
%>

 
 
 <meta http-equiv="Refresh" content="0;url=/Project/share_list.do">
 
 