package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import share.RoomDAO;
import share.RoomDTO;

public class share_WriteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
	    
	    String directory="C:/webtest/4.jsp/sou/Project/src/main/webapp/fileFolder";
	    int maxsize = 1024 * 1024 * 100;
	    String encoding="UTF-8";
		request.setCharacterEncoding("utf-8");// 한글처리
	    RoomDTO room = new RoomDTO();
	    
	    try{
	         MultipartRequest multi = new MultipartRequest(request,directory,maxsize,encoding,new DefaultFileRenamePolicy());
	            String filename=multi.getOriginalFileName("file");
	            String fileRealname=multi.getFilesystemName("file");
	            //String room_no=multi.getParameter("room_no");
	          //MemberDTO mem = new MemberDTO();
	            room.setRoom_no(Integer.parseInt(multi.getParameter("room_no")));
	            room.setId_no(Integer.parseInt(multi.getParameter("id_no")));
	            room.setTitle(multi.getParameter("title"));
	            room.setAddress(multi.getParameter("address"));
	            room.setView(Integer.parseInt(multi.getParameter("view")));
	            room.setRoom_count(multi.getParameter("room_count"));
	            room.setRoom_option(multi.getParameter("room_option"));
	            room.setFee(multi.getParameter("fee"));
	            room.setRoom_info(multi.getParameter("room_info"));
	            room.setLat(Double.parseDouble(multi.getParameter("lat")));
	            room.setLng(Double.parseDouble(multi.getParameter("lng")));
	            //추가
	            room.setFilename(filename);
	            room.setFileRealname(fileRealname);
	            System.out.println("세팅후");
	            System.out.println("filename=>"+filename);
	            System.out.println("fileRealname=>"+fileRealname);
	            System.out.println("request.getParameter(id_no)=>"+multi.getParameter("id_no"));
	            System.out.println("request.getParameter(room_no)=>"+multi.getParameter("room_no"));
	            System.out.println("request.getParameter(filename)=>"+multi.getParameter("filename"));
	            System.out.println("request.getParameter(fileRealname)=>"+multi.getParameter("fileRealname"));
	            
	            RoomDAO dbPro = new RoomDAO();
	            dbPro.insertRoom(room);
//	            new RoomDAO().insertRoom(room);        
	            
	        }catch(Exception e)

	        {

	            e.printStackTrace();

	        }
		
//		//MemberDTO mem = new MemberDTO();
//		room.setRoom_no(Integer.parseInt(request.getParameter("room_no")));
//		room.setId_no(Integer.parseInt(request.getParameter("id_no")));
//		room.setTitle(request.getParameter("title"));
//		room.setAddress(request.getParameter("address"));
//		room.setView(Integer.parseInt(request.getParameter("view")));
//		room.setRoom_count(request.getParameter("room_count"));
//		room.setRoom_option(request.getParameter("room_option"));
//		room.setFee(request.getParameter("fee"));
//		room.setRoom_info(request.getParameter("room_info"));
//		room.setLat(Double.parseDouble(request.getParameter("lat")));
//		room.setLng(Double.parseDouble(request.getParameter("lng")));
//		//추가
//		room.setFilename(request.getParameter("filename"));
//		room.setFileRealname(request.getParameter("fileRealname"));
//		System.out.println("세팅후");
//		System.out.println("request.getParameter(id_no)=>"+request.getParameter("id_no"));
//		System.out.println("request.getParameter(room_no)=>"+request.getParameter("room_no"));
//		System.out.println("request.getParameter(filename)=>"+request.getParameter("filename"));
//		System.out.println("request.getParameter(fileRealname)=>"+request.getParameter("fileRealname"));
//		
//		RoomDAO dbPro = new RoomDAO();
//		dbPro.insertRoom(room);

		//3.공유->페이지 이동
		return "/share/share_writePro.jsp";// /list.do로 처리->/list.jsp
	}

}