<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.Timestamp,share.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:if test="${check==1}">
	<meta http-equiv="Refresh"
		content="0;url=/Project/share_list.do">
</c:if>
<c:if test="${check==0}">
	<script>
		alert("비밀번호가 맞지않습니다.\다시 비밀번호를 확인해주세요");
		history.go(-1);
	</script>
</c:if>



