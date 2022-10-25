package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mate.*;

public class mate_DeleteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		String pageNum=request.getParameter("pageNum");//멤버변수X 직접 받아야함
		String password=request.getParameter("password");//입력 O
		int mate_no=Integer.parseInt(request.getParameter("mate_no"));

		
		MateDAO dbPro=new MateDAO();
		int check=dbPro.deleteArticle(mate_no,password);
		//2개의 공유값이 필요
		
		request.setAttribute("pageNum", pageNum);// 페이지이동
		request.setAttribute("check", check);
				
		return "/mate/mate_deletePro.jsp";//updatePro.jsp와 소스코드가 동일
	}

}
