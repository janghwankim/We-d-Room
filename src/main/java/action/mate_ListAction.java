package action;

import java.util.Collections;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mate.MateDAO;
import mate.MateDTO;
import mate.TendencyDTO;

//1.requestPro()을 공통메서드로 사용  2.객체형변환떄문에(상속기법)
public class mate_ListAction implements CommandAction {
	
	
	//null 예외처리를 위한 메서드 =>  null을 "" 로 치환해줌
	public String nullToEmpty(String param) {
		if(param == null)
			param ="";
		return param;
	}

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		   HttpSession session=request.getSession();
		    String id=(String)session.getAttribute("id");
		    if(id==null) {
		      //response.sendRedirect("/login.do");//LoginAction->login.jsp로 이동
		    	return "/login.do";
		    }
		    
			//1. /list.jsp에서 매개변수가 전달받음
		 	String pageNum=nullToEmpty(request.getParameter("pageNum"));
			//추가
			String search=nullToEmpty(request.getParameter("search"));//검색분야
			String searchtext=nullToEmpty(request.getParameter("searchtext"));
			System.out.println("ListAction의 매개변수확인");
			System.out.println("pageNum=>"+pageNum+",search=>"+search+",searchtext=>"+searchtext);
			
			//추가(필터에 대한 값 가져오기)
			String starttime=nullToEmpty(request.getParameter("starttime"));
			String endtime=nullToEmpty(request.getParameter("endtime"));
			String sleepTime=nullToEmpty(request.getParameter("sleepTime"));
			String showerTime=nullToEmpty(request.getParameter("showerTime"));
			String smokeYN=nullToEmpty(request.getParameter("smokeYN"));
			String petYN=nullToEmpty(request.getParameter("petYN"));
			String sleepinghabbitYN=nullToEmpty(request.getParameter("sleepinghabbitYN"));
			String searchText=nullToEmpty(request.getParameter("searchText"));
			
			TendencyDTO tenDTO = new TendencyDTO();
			tenDTO.setStarttime(starttime);
			tenDTO.setEndtime(endtime);
			tenDTO.setSleeptime(sleepTime);
			tenDTO.setShowertime(showerTime);
			tenDTO.setSmoking(smokeYN);
			tenDTO.setPet(petYN);
			tenDTO.setSleepinghabbit(sleepinghabbitYN);
			tenDTO.setSearchText(searchText);
			
			
			int count=0;//총레코드수
			List<MateDTO> articleList=null;//화면에 출력할 레코드를 저장할 변수
			MateDAO dbPro=new MateDAO();
			count=dbPro.getArticleSearchCount(search, searchtext);
			System.out.println("ListAction에서의 현재레코드수=>"+count);
			
			//1.화면에 출력할 패이지번호, 2.출력할 레코드갯수
			@SuppressWarnings("unchecked") 
			Hashtable<String,Integer>pgList=dbPro.pageList(pageNum, count);
			if(count > 0) {
				System.out.println(pgList.get("startRow")+","+pgList.get("endRow"));
				articleList=dbPro.getFriendArticles(pgList.get("startRow"),//첫번째 레코드번호 
																	  pgList.get("pageSize"),//불러올 갯수 
																	  tenDTO);
				System.out.println("ListAction의 articleList=>"+articleList);
			}else {//count=0
				articleList=Collections.EMPTY_LIST;//비어있는 List객체반환
			}
			
			//2.처리한 결과를 공유(서버메모리에 저장)=>이동할페이지에 공유(request)
		
			request.setAttribute("search", search);//${search}
			request.setAttribute("searchtext", searchtext);
			request.setAttribute("pgList", pgList);//10개 들어있는거
			request.setAttribute("articleList", articleList);// ${articleList}
			
			//3.공유해서 이동할 수 있도록 페이지를 지정
				return "/mate/mate_list.jsp";//컨트롤러가 이동시키면서 공유시켜준다.=>view
    }
}