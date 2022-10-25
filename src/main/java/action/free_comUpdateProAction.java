package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import free.board.*;
import free.comment.*;

import java.sql.Timestamp;//추가할 부분(시간)

public class free_comUpdateProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		     request.setCharacterEncoding("UTF-8");//한글처리
		     //추가(수정된 게시물로 이동시키기위해서 필요)
		     String pageNum=request.getParameter("pageNum");
		     System.out.println("free_comUpdateProAction 불러옴");
		     //--------------------------------------------------------
		     int free_no=Integer.parseInt(request.getParameter("free_no"));
		     
		     Free_comDTO list=new Free_comDTO();
		     
		     list.setFree_no(Integer.parseInt(request.getParameter("free_no")));
		     list.setComment_no(Integer.parseInt(request.getParameter("comment_no")));
		     list.setContent(request.getParameter("content"));//글내용
		     list.setCreated_datetime(new Timestamp(System.currentTimeMillis()));
		     System.out.println("content->"+list.getContent());
		     
		     Free_comDAO comDao=new Free_comDAO();
		     int check=comDao.updateCom(list);
		   
		     //2개의 공유값이 필요
		     request.setAttribute("pageNum", pageNum);//수정할 페이지로 이동
		     request.setAttribute("check", check);//데이터 수정성공유무
		     request.setAttribute("list", list);
		    
		return "/free/free_comupdatePro.jsp";
	}
}
