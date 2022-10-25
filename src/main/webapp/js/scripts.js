//우편번호를 검색해주는 함수선언
function findLoc(){
	//check=y->검색전의 창의모습을 구분하는 인자(매개변수로 지정해서 전달하기위해 필요)
	//menubar(메뉴바),status(상태바),scrollbars(스크롤기능),toolbar=yes|no
    url="./share/findLoc.jsp?check=y"
    window.open(url,"post","left=200,top=120,width=1200,height=750,"+
    		                "menubar=no,status=yes,toolbar=no,scrollbars=yes")	
}