package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class notice_DeleteFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub

		int notice_no=Integer.parseInt(request.getParameter("notice_no"));//게시물번호
		String pageNum=request.getParameter("pageNum");//페이지 번호
	    System.out.println("notice_deleteForm.do의 notice_no=>"+notice_no+",pageNum=>"+pageNum);
	    
	    request.setAttribute("notice_no", notice_no);
	    request.setAttribute("pageNum", pageNum);
		
		return "/notice/notice_deleteForm.jsp";
	}

}
