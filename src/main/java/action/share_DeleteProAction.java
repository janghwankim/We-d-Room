package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import share.*;

public class share_DeleteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		//pageNum = request.getParameter("pageNum");// BoardDTO의 멤버변수가 아니기에
		// 추가
		String password = request.getParameter("password");
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		System.out.println("deletePro.do의 room_no=>" + room_no + ",passwd=>" + password);

		RoomDAO dbPro = new RoomDAO();
		int check = dbPro.deleteRoom(room_no, password);// 암호찾고->웹상의 암호체크

		// 공유
		request.setAttribute("check", check);// 삭제성공유무

		return "/share/share_deletePro.jsp";
	}
	
}
