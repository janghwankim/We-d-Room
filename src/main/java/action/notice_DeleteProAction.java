package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.*;

public class notice_DeleteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		String pageNum=request.getParameter("pageNum");
	    
		//추가
	    int notice_no=Integer.parseInt(request.getParameter("notice_no"));
	    //System.out.println("notice_deletePro.do의 notice_no=>"+notice_no+",pageNum=>"+pageNum);
	    
	    NoticeDAO dbPro=new NoticeDAO();
	    int check=dbPro.deleteArticle(notice_no);
	    
	    //공유
	    request.setAttribute("pageNum", pageNum);
	    request.setAttribute("check", check);
		
		return "/notice/notice_deletePro.jsp";
	}
}
