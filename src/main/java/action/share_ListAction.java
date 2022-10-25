package action;

import java.util.*;

import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import share.*;

//1.requestPro()을 공통메소드로 사용 2.객체형변환때문에(상속기법)
//요청명령어에 해당되는 명령어처리클래스=액션클래스=>스프링(컨트롤러 클래스)
public class share_ListAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		String search = request.getParameter("search");
		String searchtext = request.getParameter("searchtext");

		int count = 0;
		List roomList = null;
		RoomDAO dbPro = new RoomDAO();
		count = dbPro.getRoomSearchCount(search, searchtext);

		if (count > 0) {
			roomList = dbPro.getRoomRooms(search, searchtext);// 검색어
		} else { // count=0
			roomList = Collections.EMPTY_LIST;
		}
		
		// 2.처리한결과를 공유(서버메모리에 저장)=>이동할 페이지에 공유해서 사용(request)
		request.setAttribute("search", search);//
		request.setAttribute("searchtext", searchtext);
		request.setAttribute("roomList", roomList);// ${articleList}

		// 3.공유해서 이동할 수 있도록 페이지를 지정
		return "/share/share_list.jsp";// 컨트롤러가 이동시키면서 공유시켜준다.->view
	}

}
