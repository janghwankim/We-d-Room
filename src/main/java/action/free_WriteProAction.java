package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import free.board.*;

import java.sql.Timestamp;//추가할 부분(시간)


public class free_WriteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		     request.setCharacterEncoding("UTF-8");//한글처리
		     
		     FreeDTO article=new FreeDTO();
		     article.setFree_no(Integer.parseInt(request.getParameter("free_no")));
		     article.setId_no(Integer.parseInt(request.getParameter("id_no")));
		     article.setTitle(request.getParameter("title"));
		     article.setId(request.getParameter("id"));
		     article.setContent(request.getParameter("content"));
		     //article.setViews(Integer.parseInt(request.getParameter("views")));
		     article.setCreated_datetime(new Timestamp(System.currentTimeMillis()));//오늘 날짜 수동저장
		    
		    FreeDAO dbPro=new FreeDAO();
		    dbPro.insertArticle(article);
	
		return "/free/free_writePro.jsp";
	}
}
