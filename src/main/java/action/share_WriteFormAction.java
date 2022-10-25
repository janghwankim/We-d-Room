package action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import share.RoomDAO;
import share.RoomDTO;

public class share_WriteFormAction implements CommandAction {

    @Override
    public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
        
        System.out.println("0.room_no확인");
        int room_no = 0;
        System.out.println("room_no->"+room_no);
        
        if (request.getParameter("room_no") != null && request.getParameter("room_no") != "") {
            room_no = (int) request.getAttribute("room_no");// "3"=>3
            System.out.println("content.jsp에서 넘어온 매개변수확인");
            System.out.println("room_no=>" + room_no );
        }

        // 2.처리한결과를 공유(서버메모리에 저장)=>이동할 페이지에 공유해서 사용(request)
        request.setAttribute("room_no", room_no);

        
        // 3.공유해서 이동할 수 있도록 페이지를 지정
        return "/share/share_writeForm.jsp";
    }
}