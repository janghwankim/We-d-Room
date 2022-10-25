package action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.*;

// notice_content.jsp에 바로 요청->메서드를 호출->처리결과->공유->jsp로 이동
// /notice_content.do?num=3&pageNum=1
public class notice_ContentAction implements CommandAction {

    @Override
    public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
        // TODO Auto-generated method stub
          //글상세보기=>게시판
          //notice_list.jsp에서 링크,notice_no,pageNum
          int notice_no=Integer.parseInt(request.getParameter("notice_no"));//게시물번호
          String pageNum=request.getParameter("pageNum");//페이지 번호
          System.out.println("ContentAction의 pageNum=>"+pageNum+", notice_no=>"+notice_no);
         
    
          NoticeDAO dbPro=new NoticeDAO();//메서드 호출목적
          NoticeDTO article=dbPro.getArticle(notice_no);//조회수 증가,레코드 한개
          
          

          //2.처리결과를 서버의 메모리에 저장->request->jsp에 ${키명}
          request.setAttribute("notice_no", notice_no);//${num}
          request.setAttribute("pageNum", pageNum);
          request.setAttribute("article", article);//${article}->각각의 필드분리
          
        return "/notice/notice_content.jsp";
    }

}
