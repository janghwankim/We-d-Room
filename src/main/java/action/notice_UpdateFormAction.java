package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.*;

public class notice_UpdateFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub

		  int notice_no=Integer.parseInt(request.getParameter("notice_no"));//게시물번호
		  String pageNum=request.getParameter("pageNum");//페이지 번호
		  System.out.println("notice_UpdateFormAction에서의 pageNum=>"+pageNum);//0
		   
		  NoticeDAO dbPro=new NoticeDAO();
		  NoticeDTO article=dbPro.updateGetArticle(notice_no);//조회수가 증가X
		  
		  //2.서버의 메모리에 저장
		  request.setAttribute("pageNum", pageNum);
		  request.setAttribute("article",article);
		
		return "/notice/notice_updateForm.jsp";
	}
}
