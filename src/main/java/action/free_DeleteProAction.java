package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import free.board.*;

public class free_DeleteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		String pageNum=request.getParameter("pageNum");
	    
		//추가
	    int free_no=Integer.parseInt(request.getParameter("free_no"));
	    //System.out.println("free_deletePro.do의 free_no=>"+free_no+",pageNum=>"+pageNum);
	    
	    FreeDAO dbPro=new FreeDAO();
	    int check=dbPro.deleteArticle(free_no);
	    
	    //공유
	    request.setAttribute("pageNum", pageNum);
	    request.setAttribute("check", check);
		
		return "/free/free_deletePro.jsp";
	}
}
