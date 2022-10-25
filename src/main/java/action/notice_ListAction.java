package action;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.*;

import java.util.*;//List

//요청명령어에 해당되는 명령어 처리클래스=액션클래스=컨트롤러클래스
public class notice_ListAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		// 1./notice_list.jsp에서 처리했던 자바코드를 ->결과를 request에 담고 이동->jsp
		String pageNum=request.getParameter("pageNum");	
		//추가(검색분야,검색어)
		String search=request.getParameter("search");//검색분야
		String searchtext=request.getParameter("searchtext");
		System.out.println("notice_ListAction의 매개변수 확인");
		System.out.println("pageNum=>"+pageNum+",search=>"+search+",searchtext=>"+searchtext);
		
		int count=0;//총레코드수
		List articleList=null;//화면에 출력할 레코드를 저장할 변수
	 
		NoticeDAO dbPro=new NoticeDAO();
		count=dbPro.getArticleSearchCount(search,searchtext);//sql구문에 따라 검색어가 달라진다.
		System.out.println("현재 레코드수(count)=>"+count);
		//1.화면에 출력할 페이지번호,2.출력할 레코드갯수
		Hashtable<String,Integer> pgList=dbPro.pageList(pageNum, count);
	 
		if (count > 0){
			System.out.println(pgList.get("startRow")+","+pgList.get("endRow")+"pageSize->"+pgList.get("pageSize"));
			articleList=dbPro.getBoardArticles(pgList.get("startRow"),//첫번째레코드번호
				                                            pgList.get("pageSize"),//불러올 갯수
				                                            search,searchtext);//검색분야,검색어
			System.out.println("notice_ListAction의 articleList=>"+articleList);
		}else {//count=0
			articleList=Collections.EMPTY_LIST;//비어있는 List객체반환
		}
		//2.처리한 결과를 공유(서버메모리에 저장)->이동할 페이지에 공유해서 사용(request)
		request.setAttribute("search", search);//${search} 검색어
		request.setAttribute("searchtext", searchtext);//검색어
		request.setAttribute("pgList", pgList);//페이징 처리 10개 정보
		request.setAttribute("articleList", articleList);//${articleList}
		
		//3.공유해서 이동할 수있도록 페이지를 지정
		return "/notice/notice_list.jsp";//컨트롤러가 이동시키면서 공유시켜준다.
	}
}




