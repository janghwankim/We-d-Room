package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mate.MateDAO;
import mate.MateDTO;



//   /updateForm.do?num=3&pageNum=1
public class mate_UpdateFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		//content.jsp->글수정->updateForm.jsp?num=3&page=1
		int mate_no=Integer.parseInt(request.getParameter("mate_no"));
		String pageNum=request.getParameter("pageNum");
		System.out.println("UpdateFormAction에서의 pageNum=>"+pageNum+",mate_no=>"+mate_no);
		
		MateDAO dbPro=new MateDAO();
		MateDTO article=dbPro.updateGetArticle(mate_no);//조회수X
		//2.서버에 저장
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("article", article);
		
		return "/mate/mate_updateForm.jsp";
	}

}
