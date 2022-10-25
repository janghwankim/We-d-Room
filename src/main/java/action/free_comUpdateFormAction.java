package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import free.board.*;
import free.comment.*;

public class free_comUpdateFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		   int comment_no=Integer.parseInt(request.getParameter("comment_no"));//게시물번호
		   String pageNum=request.getParameter("pageNum");//페이지 번호
		   int free_no=Integer.parseInt(request.getParameter("free_no"));
		   System.out.println("free_comUpdateFormAction에서의 pageNum=>"+pageNum+",free_no=>"+free_no);
		   
		   Free_comDAO comDao=new Free_comDAO();//메서드 호출목적
		   Free_comDTO list=comDao.updateGetCom(comment_no);
		  
		  //2.서버의 메모리에 저장
		  request.setAttribute("pageNum", pageNum);
		  request.setAttribute("list",list);
		
		return "/free/free_comupdateForm.jsp";
	}
}
