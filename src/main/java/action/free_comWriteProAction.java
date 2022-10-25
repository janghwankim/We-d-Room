package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import free.board.*;
import free.comment.*;

import java.sql.Timestamp;//추가할 부분(시간)

// /comwritePro.do
public class free_comWriteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
			System.out.println("free_comWriteProAction 불러옴");
		    
			request.setCharacterEncoding("UTF-8");//한글처리
		    //추가
		    String pageNum=request.getParameter("pageNum");
		    int free_no=Integer.parseInt(request.getParameter("free_no"));
		    
		    Free_comDTO list=new Free_comDTO();
		    //list.setComment_no(Integer.parseInt(request.getParameter("comment_no")));
		    list.setFree_no(Integer.parseInt(request.getParameter("free_no")));
		    list.setId_no(Integer.parseInt(request.getParameter("id_no")));
		    list.setId(request.getParameter("id"));
		    list.setContent(request.getParameter("content"));
		    list.setCreated_datetime(new Timestamp(System.currentTimeMillis()));
		    System.out.println("free_comWriteProAction에서 free_no->"+list.getFree_no());
		    System.out.println("free_comWriteProAction 에서 id->"+list.getId());
		    System.out.println("free_comWriteProAction에서 content->"+list.getContent()); 
		    
		    Free_comDAO comDao=new Free_comDAO();
		    comDao.writeCom(list);
		    //추가
		    request.setAttribute("pageNum", pageNum);
		    request.setAttribute("free_no", free_no);
		    
		return "/free/free_comwritePro.jsp";
	}
}
