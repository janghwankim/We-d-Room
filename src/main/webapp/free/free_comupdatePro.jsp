<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
   
<c:if test="${check==1}">
	<script>
		opener.parent.location.reload();
		window.close();
	</script>
</c:if>

