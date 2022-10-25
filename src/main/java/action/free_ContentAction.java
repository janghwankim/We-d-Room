package action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import free.board.*;
import free.comment.*;

// free_content.jsp에 바로 요청->메서드를 호출->처리결과->공유->jsp로 이동
// /free_content.do?num=3&pageNum=1
public class free_ContentAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		  //글상세보기=>게시판
		  //free_list.jsp에서 링크,free_no,pageNum
		  int free_no=Integer.parseInt(request.getParameter("free_no"));//게시물번호
		  String pageNum=request.getParameter("pageNum");//페이지 번호
		  System.out.println("ContentAction의 pageNum=>"+pageNum+", free_no=>"+free_no);
		 
	
		  FreeDAO dbPro=new FreeDAO();//메서드 호출목적
		  FreeDTO article=dbPro.getArticle(free_no);//조회수 증가,레코드 한개
		  
		  //댓글
		  Free_comDAO comDao=new Free_comDAO();
		  Free_comDTO list=comDao.getListCom(free_no);

		  int count=0;
		  count=comDao.getCountCom(free_no);
		  System.out.println("현재 댓글 수(count)=>"+count);
		  
		  List<Free_comDTO> comList=null;
		  if (count > 0){
			  comList=comDao.getComs(free_no);
			  System.out.println("comList=>"+comList);
		  }

		  //2.처리결과를 서버의 메모리에 저장->request->jsp에 ${키명}
		  request.setAttribute("free_no", free_no);//${num}
		  request.setAttribute("pageNum", pageNum);
		  request.setAttribute("article", article);//${article}->각각의 필드분리
		  
		  //추가
		  request.setAttribute("list", list);
		  request.setAttribute("count", count);
		  request.setAttribute("comList", comList);
		  
		return "/free/free_content.jsp";
	}

}
