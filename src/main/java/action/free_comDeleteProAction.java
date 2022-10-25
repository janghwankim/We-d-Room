package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import free.board.*;
import free.comment.*;

public class free_comDeleteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
	    int comment_no=Integer.parseInt(request.getParameter("comment_no"));
	    int free_no=Integer.parseInt(request.getParameter("free_no"));
	    String pageNum=request.getParameter("pageNum");
	    System.out.println("free_comdeletePro.do의 comment_no=>"+comment_no+",pageNum=>"+pageNum+",free_no=>"+free_no);
	    
	    Free_comDAO comDao=new Free_comDAO();
	    int check=comDao.deleteCom(comment_no);
	    
	    //공유
	    request.setAttribute("comment_no", comment_no);
	    request.setAttribute("free_no", free_no);
	    request.setAttribute("pageNum", pageNum);
	    request.setAttribute("check", check);
		
		return "/free/free_comdeletePro.jsp";
	}
}
