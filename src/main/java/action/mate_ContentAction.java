package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mate.*;

public class mate_ContentAction implements CommandAction {

	
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		//1.content.jsp에서 처리한 자바코드를 대신실행
		//글상세보기=>(쇼핑물 상품의 정보 SangDetail.jsp?sangid=3&pageNum=1) 쇼핑물이라면
		int num=Integer.parseInt(request.getParameter("num"));
		String pageNum=request.getParameter("pageNum");
		System.out.println("contentAction의 pageNum="+pageNum+",num=>"+num);
		
		MateDAO dbPro=new MateDAO();
		MateDTO article=dbPro.getArticle(num);

		
		//2.실행결과 서버메모리에 저장
		request.setAttribute("num", num);//${키명}때문에 키명이랑 value값을 같게 설정함
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("article", article);
	
		//3.페이지 공유
		return "/mate/mate_content.jsp"; //경로에 맞게 설계  
	}

}
