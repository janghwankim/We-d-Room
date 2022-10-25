package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mate.*;

import java.sql.Timestamp;//DB에서의 필드의 날짜자료형때문에

public class mate_UpdateProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		//1.updatePro.jsp의 자바처리 구문
		request.setCharacterEncoding("utf-8");//한글처리
		//추가(수정할 페이지로 이동)
		String pageNum=request.getParameter("pageNum");
		System.out.println("UpdateProAction에서의 pageNum=>"+pageNum);
		
	    MateDTO article=new MateDTO();//모델2 여기에서는 자바빈 액션태그로 불가능 그래서 다 불러와야함 
	    
	    article.setMate_no(Integer.parseInt(request.getParameter("mate_no")));//hidden
	    article.setWriter(request.getParameter("writer"));
	    article.setGender(request.getParameter("gender"));
	    article.setTitle(request.getParameter("title"));
	    article.setLifestyle(request.getParameter("lifestyle"));
	    article.setOther_matter(request.getParameter("other_matter"));
	    //article.setPasswd(request.getParameter("passwd"));
			
		MateDAO dbPro=new MateDAO();
		int check=dbPro.updateArticle(article);
		//2.공유
		request.setAttribute("pageNum", pageNum);// 페이지이동
		request.setAttribute("check", check);//${check} 데이터 수정성공유무
		
		//3.공유->페이지 이동
		return "/mate/mate_updatePro.jsp";//  /list.do로 처리->/list.jsp
	}
}
