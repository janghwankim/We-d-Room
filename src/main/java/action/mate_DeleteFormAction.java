package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mate_DeleteFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		//deleteForm.jsp?num=2&pageNum=1=>deletePro.jsp
		int mate_no=Integer.parseInt(request.getParameter("mate_no"));
		String pageNum=request.getParameter("pageNum");//페이지번호
		System.out.println
			("DeleteFormAction의 mate_no=>"+mate_no+",pageNum=>"+pageNum);

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("mate_no", mate_no);
		
		return "/mate/mate_deleteForm.jsp";
	}

}
