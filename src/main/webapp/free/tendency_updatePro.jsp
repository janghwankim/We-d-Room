<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <script>
		alert("정상적으로 성향테스트가 수정되었습니다.");
</script> 
<meta http-equiv="Refresh" content="0;url=/Project/main.jsp"> -->

<c:if test="${check==1}" ><!-- 글수정에 성공했다면 -->
	<script>
		alert("정상적으로 성향테스트가 수정되었습니다.");
	</script> 
	<meta http-equiv="Refresh" content="0;url=/Project/main.jsp">
</c:if>
<c:if test="${check==0}">
	<script>
		alert("성향테스트 수정에 실패했습니다.");
		history.go(-1);
	</script> 
</c:if>
