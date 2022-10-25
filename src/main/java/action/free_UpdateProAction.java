package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import free.board.*;

import java.sql.Timestamp;//추가할 부분(시간)


public class free_UpdateProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		     request.setCharacterEncoding("UTF-8");//한글처리
		     
		     //추가(수정된 게시물로 이동시키기위해서 필요)
		     String pageNum=request.getParameter("pageNum");
		     System.out.println("free_UpdateProAction에서의 pageNum=>"+pageNum);//0
		     //--------------------------------------------------------
		     FreeDTO article=new FreeDTO();
		     
		     article.setFree_no(Integer.parseInt(request.getParameter("free_no")));
		     article.setTitle(request.getParameter("title"));
		     //article.setId(request.getParameter("id"));
		     article.setContent(request.getParameter("content"));//글내용
		     article.setCreated_datetime(new Timestamp(System.currentTimeMillis()));
		     
		    FreeDAO dbPro=new FreeDAO();
		    int check=dbPro.updateArticle(article);
		   
		    //2개의 공유값이 필요
		    request.setAttribute("pageNum", pageNum);//수정할 페이지로 이동
		    request.setAttribute("check", check);//데이터 수정성공유무
		    
		return "/free/free_updatePro.jsp";
	}
}
