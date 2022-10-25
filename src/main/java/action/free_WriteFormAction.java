package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class free_WriteFormAction implements CommandAction {

	  @Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		   int free_no=0;
		   
		   //free_content.do에서 매개변수가 전달
		   if(request.getParameter("free_no")!=null){//0은 아니고 ,음수X=>양수 1이상
			   free_no=Integer.parseInt(request.getParameter("free_no"));//"3"=>3
		     System.out.println("free_content.jsp에서 넘어온 매개변수확인");
		     System.out.println("free_no=>"+free_no);
		   }
		   //실행결과->서버의 메모리에 저장->이동
		   request.setAttribute("free_no", free_no);
		   
		   return "/free/free_writeForm.jsp";
	}
}
