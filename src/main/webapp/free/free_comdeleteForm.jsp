<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WedRoom</title>
<script language="JavaScript">           
  	if(window.confirm("삭제된 댓글은 복구할 수 없습니다. \n삭제하시겠습니까?")){
  		document.location.href='/Project/free_comdeletePro.do?pageNum=${pageNum}&free_no=${free_no}&comment_no=${comment_no}'
  	} else {
  		history.go(-1);
  	}
</script>
</head>
<body>

</body>
</html>