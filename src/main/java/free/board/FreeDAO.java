package free.board;


import java.sql.*;//DB사용
import java.text.SimpleDateFormat;
import java.util.*;//ArrayList,List을 사용

//자유게시판
public class FreeDAO {
	
	//1.객체생성할 멤버변수선언
	private DBConnectionMgr pool=null;//DB
	
	private Connection con=null;
	private PreparedStatement pstmt=null;//SQL구문실행
	private ResultSet rs=null;//select
	private String sql="";//실행시킬 SQL구문 저장
	
	//2.생성자를 통해 DB연결=>의존관계
	public FreeDAO() {
		try {
			pool=DBConnectionMgr.getInstance();//DB생성 객체 불러오기
		}catch(Exception e) {
			System.out.println("DB접속 오류=>"+e);
		}
	}
	
	//3.메서드작성
	//1.페이징 처리를 위한 전체레코드 수 구하는 메서드
	public int getArticleCount() { 
		int x=0;//총레코드갯수를 저장
		try {
			con=pool.getConnection();
			sql="select count(*) from Free";//작성
			pstmt=con.prepareStatement(sql);//저장
			rs=pstmt.executeQuery();//실행
			if(rs.next()) {
				x=rs.getInt(1);//x=rs.getInt("x");
			}
		}catch(Exception e) {
			System.out.println("getArticleCount() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;
	}
	
	//검색어에 해당되는 총레코드수를 구하는 메서드(검색분야,검색어)
	public int getArticleSearchCount(String search,String searchtext) {
		int x=0;//총레코드갯수를 저장
		try {
			con=pool.getConnection();

			if(search==null || search=="") {//검색분야 선택X
			sql="select count(*) from Free";
			}else {
				if(search.equals("all")) {//제목+본문
					sql="select count(*) from Free where title like '%"+
				           searchtext+"%' or content like '%"+searchtext+"%' ";
				}else {//제목,작성자->매개변수를 이용해서 하나의 sql통합
				   sql="select count(*) from Free where "+search+" like  '%"+searchtext+"%' ";
				}
			}
			System.out.println("getArticleSearchCount 검색sql=>"+sql);

			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {//보여주는 결과가 있다면
				x=rs.getInt(1);
			}
		}catch(Exception e) {
			System.out.println("getArticleSearchCount() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;
	}
	
	//2.글목록보기에 대한 메서드구현->레코드 한개이상->한 페이지당 10개씩 끊어서 보여준다.
	//1)레코드의 시작번호  2) 불러올 레코드의 갯수
	public List<FreeDTO> getArticles(int start,int end) {
		
		List<FreeDTO> articleList=null;
		
		try {
			con=pool.getConnection();
			//sql="select * from (select * from Free order by free_no desc) where rownum >= ? and rownum <= ?";
			sql="SELECT a.*  \n"
			        + "FROM (SELECT @rnum := @rnum+1 AS rnum, f.*  \n"
			        + "FROM  (SELECT * \n"
			        + "FROM Free order by free_no desc) f)a,\n"
			        + "(select @rnum:=0) AS R\n"
			        + " where rnum > ? and rnum <= ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, start-1+end);//불러와서 담을 갯수
			rs=pstmt.executeQuery();
			if(rs.next()) {
				articleList=new ArrayList(end);//10=>end갯수만큼 데이터를 담을 공간을 만들어라
				do {
				  FreeDTO article=new FreeDTO();
				  article.setFree_no(rs.getInt("free_no"));
				  article.setId_no(rs.getInt("id_no"));
				  article.setTitle(rs.getString("title"));
				  article.setId(rs.getString("id"));
				  article.setContent(rs.getString("content"));
				  article.setViews(rs.getInt("views"));
				  article.setCreated_datetime(rs.getTimestamp("created_datetime"));
				  articleList.add(article);//생략하면 데이터가 저장X->for문 에러유발
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("getArticleCount() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return articleList;
	}
	
	//(2)검색어에 따른 레코드의 범위지정에 대한 메서드
	public List getBoardArticles(int start,int end,String search,String searchtext) {
		
		List articleList=null;
		
		try {
			con=pool.getConnection();
			if(search==null || search=="") {
			   //sql="select * from (select * from Free order by free_no desc) where rownum >= ? and rownum <= ?";
				sql="SELECT a.*  \n"
				        + "FROM (SELECT @rnum := @rnum+1 AS rnum, f.*  \n"
				        + "FROM  (SELECT * \n"
				        + "FROM Free order by free_no desc) f)a,\n"
				        + "(select @rnum:=0) AS R\n"
				        + " where rnum > ? and rnum <= ?";
			}else {
				if(search.equals("all")) {
					sql="SELECT a.*  \n"
					        + "FROM (SELECT @rnum := @rnum+1 AS rnum, f.*  \n"
					        + "FROM  (SELECT * \n"
					        + "FROM Free where title like '%"+
							searchtext+"%' or content like '%"+searchtext+"%' order by free_no desc) f)a,\n"
							        + "(select @rnum:=0) AS R\n"
							        + " where rnum > ? and rnum <= ?";
				}else {
				   sql="SELECT a.*  \n"
				           + "FROM (SELECT @rnum := @rnum+1 AS rnum, f.*  \n"
				           + "FROM  (SELECT * \n"
				           + "FROM Free where  title like '%"+search+"%' or content like '%"+
						   searchtext+"%' order by free_no desc) f)a,\n"
						           + "(select @rnum:=0) AS R\n"
						           + " where rnum > ? and rnum <= ?";
				}
			}
			System.out.println("getBoardArticles()의 sql=>"+sql);

			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, start-1+end);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				articleList=new ArrayList(end);
				do {
				  FreeDTO article=new FreeDTO();
				  article.setFree_no(rs.getInt("free_no"));
				  article.setId_no(rs.getInt("id_no"));
				  article.setTitle(rs.getString("title"));
				  article.setId(rs.getString("id"));
				  article.setContent(rs.getString("content"));
				  article.setViews(rs.getInt("views"));
				  article.setCreated_datetime(rs.getTimestamp("created_datetime"));
				  articleList.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("getBoardArticles() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return articleList;
	}
	
	//(3)페이징 처리 계산 정리해주는 메서드(ListAction)
	//Hashtable=>페이징 처리에 관련된 처리결과를 저장할 변수들을 하나의 객체에 담아서 반환
	public Hashtable pageList(String pageNum,int count) {
		
		//1.페이징 처리결과를 저장할 Hashtable객체를 선언
		Hashtable<String,Integer> pgList=new Hashtable<String,Integer>();

	    int pageSize=10;//numPerPage->페이지당 보여주는 게시물수(=레코드수) 10
	    int blockSize=10;//pagePerBlock->블럭당 보여주는 페이지수 10
	  
	 //게시판을 맨 처음 실행시키면 무조건 1페이지 부터  출력->가장 최근의 글이 나오기때문에 
	 if(pageNum==null){
		 pageNum="1";//default(무조건 1페이지는 선택하지 않아도 보여줘야 되기때문에)
	 }
	 int currentPage=Integer.parseInt(pageNum);//"1"->1 (=nowPage(현재페이지))
	 //                    (1-1)*10+1=1,(2-1)*10+1=11,(3-1)*10+1=21
	 int startRow=(currentPage-1)*pageSize+1;//시작 레코드 번호
	 int endRow=currentPage*pageSize;//1*10=10,2*10=20,3*10=30(마지막 레코드번호)
	 int number=0;//beginPerPage=>페이지별로 시작하는 맨 처음에 나오는 게시물번호
	 System.out.println("현재 레코드수(count)=>"+count);
	 //             122-(1-1)*10=122,122-(2-1)*10=112,,,
	 number=count-(currentPage-1)*pageSize;
	 System.out.println("페이지별 number=>"+number);
	 
	 //1.총페이지수 구하기
	 //                     122/10=12.2+1.0=13.2=13,(122%10)=1
	 int pageCount=count/pageSize+(count%pageSize==0?0:1);
     //2.시작페이지
     int startPage=0;
     if(currentPage%blockSize!=0){//1~9,11~19,21~29
   	  startPage=currentPage/blockSize*blockSize+1;
     }else{//10%10=0,(10,20,30,40)
   		              //((10/10)-1)*10+1
   	  startPage=((currentPage/blockSize)-1)*blockSize+1;//1
     }
     //종료페이지
     int endPage=startPage+blockSize-1;//1+10-1=10
     System.out.println("startPage="+startPage+",endPage="+endPage);
     //블럭별로 구분해서 링크 걸어서 출력(마지막 페이지 > 총페이지수)
     // 11>10=>endPage=10
     if(endPage > pageCount) endPage=pageCount;//마지막페이지=총페이지수
     
     //페이징처리에 대한 계산결과=>Hashtable,HashMap=>ListAction에 전달->
     //메모리에 저장->공유->list.jsp에서 불러다 사용
     pgList.put("pageSize", pageSize);//<->pgList.get(키명)("pageSize")
     pgList.put("blockSize", blockSize);
     pgList.put("currentPage", currentPage);
     pgList.put("startRow", startRow);
     pgList.put("endRow",  endRow);
     pgList.put("count", count);
     pgList.put("number", number);
     pgList.put("startPage", startPage);
     pgList.put("endPage", endPage);
     pgList.put("pageCount", pageCount);
     
      return pgList;
	}
	
	//3.게시판의 글쓰기
	public void insertArticle(FreeDTO article) {
		int free_no=article.getFree_no();//0 신규글
		
		int number=0;//데이터를 저장하기위한 게시물번호 
		System.out.println("insertArticle메서드의 내부 free_no=>"+free_no);
		
		try {
			con=pool.getConnection();
			sql="select max(free_no) from Free";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {//보여주는 결과가 있다면
				int max=rs.getInt(1);
				article.setFree_no(max+1);
				//number=rs.getInt(1)+1;//최대값+1
				System.out.println("insertArticle메서드의 number=>"+number);
			}else {
				number=1;//테이블에 한개의 데이터가 없다면
			}
			sql="insert into Free(free_no,id_no,title,id,content,created_datetime,views) values(?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,article.getFree_no());
			pstmt.setInt(2,article.getId_no());
			pstmt.setString(3, article.getTitle());
			pstmt.setString(4, article.getId());
			pstmt.setString(5, article.getContent());
			pstmt.setTimestamp(6, article.getCreated_datetime());
			pstmt.setInt(7, article.getViews());
			int insert=pstmt.executeUpdate();
			System.out.println("free_no"+article.getFree_no());
			System.out.println("게시판의 글쓰기 성공유무(insert)=>"+insert);
		}catch(Exception e) {
			System.out.println("insertArticle() 메서드 에러유발=>"+e);
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
	}
	
	//4.게시판 글상세보기
	public FreeDTO getArticle(int free_no) {
		FreeDTO article=null;
		
		try {
			con=pool.getConnection();
		
			sql="update Free set views=views+1 where free_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, free_no);
			int update=pstmt.executeUpdate();
			System.out.println("조회수 증가유무(update)=>"+update);//1
			
			sql="select * from Free where free_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, free_no);
			rs=pstmt.executeQuery();
			if(rs.next()) {//보여주는 결과가 있다면
				 article=makeArticleFromResult();//생성된 객체를 얻어온다.
				  /*
				  article=new FreeDTO();
				  article.setFree_no(rs.getInt("free_no"));
				  article.setId_no(rs.getInt("id_no"));
				  article.setTitle(rs.getString("title"));
				  article.setId(rs.getString("id"));
				  article.setContent(rs.getString("content"));
				  article.setViews(rs.getInt("views"));
				  article.setCreated_datetime(rs.getTimestamp("created_datetime"));
				  */
			}
		}catch(Exception e) {
			System.out.println("getArticle() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return article;
	}
	
	//----중복된 레코드 한개를 담을 수 있는 메서드를 따로 만들어서 처리----
	//접근지정자가 private인 경우=->외부에서 호출목적X ,내부에서 호출목적으로 사용
	private FreeDTO makeArticleFromResult()throws Exception {
		  FreeDTO article=new FreeDTO();
		  article.setFree_no(rs.getInt("free_no"));
		  article.setId_no(rs.getInt("id_no"));
		  article.setTitle(rs.getString("title"));
		  article.setId(rs.getString("id"));
		  article.setContent(rs.getString("content"));
		  article.setViews(rs.getInt("views"));
		  article.setCreated_datetime(rs.getTimestamp("created_datetime"));
		  return article;
	}
	
	//5.게시판 글수정
	//1)수정할 데이터를 찾을 메서드 필요
	public FreeDTO  updateGetArticle(int free_no) {
		
      FreeDTO article=null;
		try {
			con=pool.getConnection();
			sql="select * from Free where free_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, free_no);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				 article=makeArticleFromResult();
			}
		}catch(Exception e) {
			System.out.println("updateGetArticle() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return article;
	}
	
	//2)수정시키는 메서드 작성
		public int updateArticle(FreeDTO article) {
			int x = -1;
			try {
				con = pool.getConnection();
				sql = "update Free set title=?,content=?,created_datetime=? where free_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, article.getTitle());
				pstmt.setString(2, article.getContent());
				pstmt.setTimestamp(3, article.getCreated_datetime());
				pstmt.setInt(4, article.getFree_no());
				int update = pstmt.executeUpdate();
				System.out.println("게시판의 글수정 성공유무(update)=>" + update);
				x = 1;
			} catch (Exception e) {
				System.out.println("updateArticle() 메서드 에러유발=>" + e);
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return x;
		}
	
		//6.게시판 글삭제
		public int deleteArticle(int free_no) {
			int x = -1;// 게시물의 삭제성공유무
			try {
				con = pool.getConnection();
				sql = "delete from Free where free_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, free_no);
				int delete= pstmt.executeUpdate();
				System.out.println("게시판의 글삭제 성공유무(delete)=>" + delete);
				x = 1;// 삭제성공유무
			} catch (Exception e) {
				System.out.println("deleteArticle() 메서드 에러유발=>" + e);
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return x;
		}	
		
}
