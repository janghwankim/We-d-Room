<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
   
<c:if test="${check==1}">
<script>
        alert("댓글이 삭제되었습니다.");
</script>
<meta http-equiv="Refresh" content="0;url=/Project/free_content.do?pageNum=${pageNum}&free_no=${free_no}">
</c:if>
