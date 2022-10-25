<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
   
<c:if test="${check==1}" ><!-- 글수정에 성공했다면 -->
	<meta http-equiv="Refresh"
           	  content="0;url=/Project/notice_list.do?pageNum=${pageNum}">
</c:if>
<c:if test="${check==0}">
	<script>
		alert("댓글수정 실패했습니다.");
		history.go(-1);
	</script> 
</c:if> 