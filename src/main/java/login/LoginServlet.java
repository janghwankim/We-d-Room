package login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import member.MemberDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
 	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 		System.out.println("도착했음doPost");
 		String id = request.getParameter("id");
 		String password = request.getParameter("password");
 		System.out.println(id);
 		System.out.println(password);
 		
 		MemberDAO memberDAO = new MemberDAO();
 		boolean result = memberDAO.loginCheck(id, password);
 		RequestDispatcher rd = null;
 		if(result) {
 			request.setAttribute("idKey", id);
 			rd = request.getRequestDispatcher("/Project/login/LoginSuccess.jsp");
 			System.out.println("로그인 성공");
 			 
 		}else {
 			rd = request.getRequestDispatcher("/Project/login/LoginError.jsp");
 			System.out.println("로그인 실패");
 		}
 		rd.forward(request, response);
 		
    }
}
