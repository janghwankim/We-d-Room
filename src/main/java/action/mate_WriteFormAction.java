package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mate.DBConnectionMgr;
import mate.MemberDTO;
import mate.TendencyDTO;

public class mate_WriteFormAction implements CommandAction {

	private Connection con = null;
	private DBConnectionMgr pool = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;// select를 해서 찾은값을 담는 상자라고 생각하기
	private String sql = "";// 실행시킬 SQL구문
	private HttpSession session;
	
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		
		int num=0;
		    
		   		   
		   session = request.getSession();
		   String loginUserID = (String) session.getAttribute("id"); 
		   System.out.println("mate_WriteFormAction에서의 loginUserID값(id)=>"+loginUserID);
		   
		   pool = DBConnectionMgr.getInstance();
		   con=pool.getConnection();
		   sql = "SELECT A.ID, A.GENDER, B.* FROM MEMBER A "
		   		+ "INNER JOIN TENDENCY B "
		   		+ "ON A.ID_NO = B.ID_NO"
		   		+ " where A.id='"+loginUserID +"'";
		   
		   pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			String gender= "";
			String id = "";
			
			int id_no= 0;
			String sleeptime= "";
			String smoking ="";
			String pet ="";
			String sleepinghabbit ="";
			String showertime ="";
			String starttime ="";
			String endtime ="";
			
			if (rs.next()) {
				gender = rs.getString("gender");
				id = rs.getString("id");
				
				id_no=rs.getInt("id_no");
				sleeptime = rs.getString("sleeptime");
				smoking = rs.getString("smoking");
				pet = rs.getString("pet");
				sleepinghabbit = rs.getString("sleepinghabbit");
				showertime = rs.getString("showertime");
				starttime = rs.getString("starttime");
				endtime = rs.getString("endtime");
			}
			
		     System.out.println("mate_WriteFormAction에서의 검색후 결과(id_no)=>"+id_no);//?
		   //content.do에서 매개변수로 전달
		   if(request.getParameter("num")!=null){//0,음수X=>양수1이상
			   num=Integer.parseInt(request.getParameter("num"));//"3"=>3

			   System.out.println("content.jsp에서 넘어온 매개변수 확인");
			   System.out.println("num=>"+num);
				
		   }
		   //2.실행결과->서버의 메모리에 저장=>공유해서 이동
		   	request.setAttribute("num", num); //${num}
		   	request.setAttribute("id", id); //${id}
		   	request.setAttribute("gender", gender); //${gender}

		   	request.setAttribute("id_no", id_no);//${id_no}
		   	request.setAttribute("sleeptime", sleeptime);
		   	request.setAttribute("smoking", smoking);
		   	request.setAttribute("pet", pet);
		   	request.setAttribute("sleepinghabbit", sleepinghabbit);
		   	request.setAttribute("showertime", showertime);
		   	request.setAttribute("starttime", starttime);
		   	request.setAttribute("endtime", endtime);
	
		   	
		return "/mate/mate_writeForm.jsp";
	}

}