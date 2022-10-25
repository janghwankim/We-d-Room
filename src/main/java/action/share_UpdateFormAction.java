package action;

import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;

import share.*;

public class share_UpdateFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		System.out.println("0.폼액션 updateForm1111호출");
		
		
		int room_no=Integer.parseInt(request.getParameter("room_no"));
		int id_no = 1;
		//int id_no=Integer.parseInt(request.getParameter("id_no"));
		
		RoomDAO dbPro = new RoomDAO();
		RoomDTO room=dbPro.getRoom(room_no);
		
		
		request.setAttribute("id_no", id_no);
		request.setAttribute("room_no", room_no);
		request.setAttribute("room", room);
		
		System.out.println("**id_no->"+id_no);
		System.out.println("**room_no->"+room_no);
		
		//int id_no=0;
//		if (request.getParameter("id_no") != null) {// 0은 아니고 ,음수X=>양수 1이상
//			//id_no = Integer.parseInt(request.getParameter("id_no"));// "3"=>3
//			System.out.println("content.jsp에서 넘어온 매개변수확인");
//			System.out.println("room_no=>" + room_no );
//		}
//		//System.out.println("id_no=>"+id_no);
		
		return "/share/share_updateForm.jsp";
	}

}
