package action;

import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;

import share.*;

public class share_DeleteFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		
		//deleteFrom.jsp?num2&pageNum=1
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		System.out.println("deleteForm.jsp의 room_no=>"+room_no);
		RoomDAO dbPro= new RoomDAO();
		RoomDTO room =dbPro.getRoom(room_no);
	
		request.setAttribute("room_no", room_no);
		request.setAttribute("room", room);
		
		
		return "/share/share_deleteForm.jsp";
	}

}
