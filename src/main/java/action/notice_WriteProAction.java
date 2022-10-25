package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.*;

import java.sql.Timestamp;//추가할 부분(시간)


public class notice_WriteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		     request.setCharacterEncoding("UTF-8");//한글처리
		     
		     NoticeDTO article=new NoticeDTO();
		     article.setNotice_no(Integer.parseInt(request.getParameter("notice_no")));
		     article.setId_no(Integer.parseInt(request.getParameter("id_no")));
		     article.setTitle(request.getParameter("title"));
		     article.setId(request.getParameter("id"));
		     article.setContent(request.getParameter("content"));
		     //article.setViews(Integer.parseInt(request.getParameter("views")));
		     article.setCreated_datetime(new Timestamp(System.currentTimeMillis()));//오늘 날짜 수동저장
		    
		     NoticeDAO dbPro=new NoticeDAO();
		    dbPro.insertArticle(article);
	
		return "/notice/notice_writePro.jsp";
	}
}
