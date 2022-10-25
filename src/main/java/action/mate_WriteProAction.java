package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//사진 업로드를 위한 추가
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import mate.*;

public class mate_WriteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		String directory="C:/webtest/4.jsp/sou/Project/src/main/webapp/fileFolder"; //저장될 폴더
	    int maxsize = 1024 * 1024 * 100; 
		String encoding="UTF-8";		
			request.setCharacterEncoding("utf-8");//한글처리
	    MateDTO article=new MateDTO();
	    TendencyDTO ten=new TendencyDTO();
	    
	    
	    try{
	        MultipartRequest multi = new MultipartRequest(request,directory,maxsize,encoding,new DefaultFileRenamePolicy());
			String filename=multi.getOriginalFileName("file");
			String fileRealname=multi.getFilesystemName("file");
			
		    article.setMate_no(Integer.parseInt(multi.getParameter("mate_no")));
		    article.setId_no(Integer.parseInt(multi.getParameter("id_no")));
		    article.setWriter(multi.getParameter("writer"));
		    article.setGender(multi.getParameter("gender"));  
		    article.setTitle(multi.getParameter("title"));
		    article.setLifestyle(multi.getParameter("lifestyle"));
			article.setOther_matter(multi.getParameter("other_matter"));
			article.setViews(Integer.parseInt(multi.getParameter("views")));
			article.setFilename(filename);
			article.setFileRealname(fileRealname);
			

			MateDAO dbPro=new MateDAO();
			dbPro.insertArticle(article,ten);
			
		  }catch(Exception e) {
			    	
			    	e.printStackTrace();
			    }
		//3.공유->페이지 이동
		return "/mate/mate_writePro.jsp";//  /list.do로 처리->/list.jsp
	}
}
