package action;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import member.*;
import share.RoomDAO;
import share.RoomDTO;

public class share_UpdateProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		// 값을 입력을 받아서 BoardDTO에 저장->테이블에 저장하는 구문
		request.setCharacterEncoding("utf-8");


		RoomDTO room = new RoomDTO();// 데이터 담을 객체
		MemberDTO mem=new MemberDTO();
		
//		System.out.println("1.request.getParameter(room_no)=>"+request.getParameter("room_no"));
//		System.out.println("1.request.getParameter(id_no)=>"+request.getParameter("id_no"));
		
		mem.setId_no(Integer.parseInt(request.getParameter("id_no")));
		room.setRoom_no(Integer.parseInt(request.getParameter("room_no")));//이 부분을 추가해야함
		room.setTitle(request.getParameter("title"));
		room.setAddress(request.getParameter("address"));
		room.setRoom_count(request.getParameter("room_count"));
		room.setRoom_option(request.getParameter("room_option"));
		room.setFee(request.getParameter("fee"));
		room.setRoom_info(request.getParameter("room_info"));
		room.setLat(Double.parseDouble(request.getParameter("lat")));
		room.setLng(Double.parseDouble(request.getParameter("lng")));
		mem.setPassword(request.getParameter("password"));

		RoomDAO dbPro = new RoomDAO();
		int check = dbPro.updateRoom(room,mem);

		//request.setAttribute("mem", mem);
		request.setAttribute("check", check);// 데이터 수정성공유무

		return "/share/share_updatePro.jsp";
	}

}
