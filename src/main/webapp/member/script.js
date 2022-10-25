function loginCheck(){
	if(document.login.mem_id.value==""){
		alert("아이디를 입력해주세요.");
		document.login.mem_id.focus();
		return;
	}
	if(document.login.mem_passwd.value==""){
		alert("비밀번호를 입력해주세요.");
		document.login.mem_passwd.focus();
		return;
	}
	document.login.submit();//document.폼객체명.submit() 해야 전송이 됨
}

//중복ID체크 해주는 자바스크립트함수 선언
/*
function idCheck(id){
   if(id==""){
   alert("아이디를 먼저 입력하세요!");
   document.forms['validation-form'].id.focus();//document.폼객체명.입력양식객체명.함수명()
   }else{
   url="IdCheck.jsp?id="+id;//request.getParameter("id");//null
   window.open(url,"post","left=450,top=150,width=300,height=150");
}
}
*/


