package action;

import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;

import share.*;

public class share_ContentAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		
		//글 상세보기=>게시판(쇼핑몰 상품의 정보 SangDetail.jsp?sandgid=3&pageroom_no=1)
	  	int room_no=Integer.parseInt(request.getParameter("room_no"));//게시물번호
	  	System.out.println("room_no"+room_no);
		RoomDAO dbPro=new RoomDAO();
		RoomDTO room=dbPro.getRoom(room_no);
		
		request.setAttribute("room_no", room_no);
	    request.setAttribute("room", room);
		
		
		return "/share/share_content.jsp";
	}

}
