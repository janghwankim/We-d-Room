<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<c:if test="${check==true}" >
	<script>
		alert("정상적으로 성향테스트가 수정되었습니다.");
	</script> 
	<meta http-equiv="Refresh" content="0;url=/Project/main.jsp">
</c:if>
<%-- <c:if test="${check!=true}">
	<script>
		alert("성향테스트 수정에 실패했습니다.");
		history.go(-1);
	</script> 
</c:if> --%>
