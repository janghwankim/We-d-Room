package share;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.If;

import member.MemberDTO;
import oracle.jdbc.internal.TTCData;

public class RoomDAO {

	private DBConnectionMgr pool = null;// 1.객체 생성할 멤버변수선언
	// 공통
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;// select
	private String sql = "";// 실행시킬 sql구

	// 생성자 테스트
	public RoomDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("DB접속오류=>" + e);
		}
	}

	public List getRoomRooms(String search, String searchtext) {

		List roomList = null;// ArrayList articleList=null;//(O)

		try {
			con = pool.getConnection();
// -----------------------------------------------------------------
			if (search == null || search == "") {// 검색분야 선택X(검색어를 입력하지 않은 경우)
				sql = "select * from Room";
			} else {// 검색분야(제목,주소,제목+주소)
				if (search.equals("title_address")) {// 제목+주소
					sql = "select * from Room where title like '%" + searchtext + "%' or address like '%" + searchtext
							+ "%'";
				} else {// 제목,주소->매개변수를 이용해서 하나의 sql통합
					sql = "select * from Room where " + search + " like  '%" + searchtext + "%'";
				}
			}
			System.out.println("getRoomRooms 검색sql=>" + sql);
// ------------------------------------------------------------------
			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1, start - 1);// mysql은 레코드순번이 내부적으로 0부터 시작
//			pstmt.setInt(2, end);// 불러와서 담을 갯수
			rs = pstmt.executeQuery();
			if (rs.next()) {// 보여주는 결과가 있다면
				roomList = new ArrayList();// 10=>end갯수만큼 데이터를 담을 공간을 만들어라
				do {
					RoomDTO room = new RoomDTO();// MemberDTO=>필드별로 담을것.
					room = makeRoomFromResult();
					MemberDTO mem = new MemberDTO();
					mem.setId_no(rs.getInt("id_no"));

					roomList.add(room);// 생략하면 데이터가 저장X->for문 에러유발
				} while (rs.next());
			}
		} catch (Exception e) {
			System.out.println("getRoomRooms() 에러유발=>" + e);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return roomList;
	}

	// 검색어에 해당되는 총레코드수를 구하는 메서드(검색분야,검색어)
	public int getRoomSearchCount(String search, String searchtext) {
		int x = 0;// 총레코드갯수를 저장

		try {
			con = pool.getConnection();
			System.out.println("con=>" + con);

			if (search == null || search == "") {// 검색분야 선택X(검색어를 입력하지 않은 경우)
				sql = "select count(*) from Room";
			} else {// 검색분야(제목,주소,제목+주소)
				if (search.equals("title_address")) {// 제목+주소
					sql = "select count(*) from Room where title like '%" + searchtext + "%' or address like '%"
							+ searchtext + "%' ";
				} else {// 제목,주소->매개변수를 이용해서 하나의 sql통합
					sql = "select count(*) from Room where " + search + " like  '%" + searchtext + "%' ";
				}
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {// 보여주는 결과가 있다면
				x = rs.getInt(1);// 변수명=rs.get자료형(필드명 또는 인덱스번호)=>필드명X(그룹함수)
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;
	}

	// 2.방 추가하기(게시판 글쓰기)
	public void insertRoom(RoomDTO room) {
		// 1. rooms
		int room_no = room.getRoom_no(); // 0 신규글 0이아닌경우(답변글)
		System.out.println("3.room_no->"+room_no);
		int number = 0; // 데이터를 저장하기위한 게시물 번호
		
		
		try {
			con = pool.getConnection();
			sql = "select max(room_no) from Room";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {// 보여주는 결과가 있다면
				number = rs.getInt(1) + 1;// 최대값+1
				room_no=number;
				System.out.println("4.room_no=>"+room_no);
				sql = "INSERT INTO Room (room_no,id_no, title, address,view ,room_count, room_option, fee,room_info, lat, lng,fileName,fileRealName)";
	            sql += "VALUE (?,?,?,?,?,?,?,?,?,?,?,?,?)";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1,room_no);
	            pstmt.setInt(2, room.getId_no());
	            pstmt.setString(3, room.getTitle());
	            pstmt.setString(4, room.getAddress());
	            pstmt.setInt(5, room.getView());
	            pstmt.setString(6, room.getRoom_count());
	            pstmt.setString(7, room.getRoom_option());
	            pstmt.setString(8, room.getFee());
	            pstmt.setString(9, room.getRoom_info());
	            pstmt.setDouble(10, room.getLat());
	            pstmt.setDouble(11, room.getLng());
	            //추가
	            pstmt.setString(12, room.getFilename());
	            pstmt.setString(13, room.getFileRealname());
	            int insert = pstmt.executeUpdate();
	            System.out.println("게시판의 글쓰기 성공유무(insert)=>" + insert);
			} else {
				number = 1;// 테이블에 한개의 데이터가 없다면
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("insertRoom() 메서드 에러유발=>" + e);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

	}
	
	public int upload(String filename,String fileRealname) {
	    try {
	        con = pool.getConnection();
            sql = "insert into File value(?,?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, filename);
            pstmt.setString(2, fileRealname);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
	    return -1;
	}

	// 3.방 상세보기(글 상세보기)
	public RoomDTO getRoom(int room_no) {
		RoomDTO room = null;
		//MemberDTO mem = null;
		try {
			con = pool.getConnection();

			sql = "update Room set view=view+1 where room_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, room_no);
			int update = pstmt.executeUpdate();
			sql = "select * from Room where room_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, room_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {// 보여주는 결과가 있다면
				room = makeRoomFromResult();
				
			}

		} catch (Exception e) {
			System.out.println("getRoom() 에러유발=>" + e);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return room;
	}
    
	// ----중복된 레코드 한개를 담을 수 있는 메서드를 따로 만들어서 처리----
	private RoomDTO makeRoomFromResult() throws Exception {
	    RoomDTO room = new RoomDTO();
	    
		room.setRoom_no(rs.getInt("room_no"));
		room.setId_no(rs.getInt("id_no"));
		room.setTitle(rs.getString("title"));
		room.setAddress(rs.getString("address"));
		room.setView(rs.getInt("view"));
		room.setRoom_count(rs.getString("room_count"));
		room.setRoom_option(rs.getString("room_option"));
		room.setFee(rs.getString("fee"));
		room.setRoom_info(rs.getString("room_info"));
		room.setLat(rs.getDouble("lat"));
		room.setLng(rs.getDouble("lng"));
		//추가
		room.setFilename(rs.getString("filename"));
		room.setFileRealname(rs.getString("fileRealname"));
		
//		MemberDTO mem=new MemberDTO();
//        mem.setId(rs.getString("id"));
		return room;
	}

	// ------------------------------------------------------------------

	// 2)수정시키는 메서드 작성=>본인인지 확인절차=>회원탈퇴(암호를 비교=->탈퇴)와 동일한 기능
	public int updateRoom(RoomDTO room,MemberDTO mem) {// insertArticle(BoardDTO article)
		
		int room_no=room.getRoom_no();
		//System.out.println("1.9 room_no호출=>"+room_no);
		String dbpasswd = null;// db에서 찾은 암호를 저장
		int x = -1;// 게시물의 수정성공유무
		System.out.println("2.updteRoom호출");
		try {
			con = pool.getConnection();
			sql = "select * from Room where room_no=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, room_no);
            rs = pstmt.executeQuery();
			sql = "SELECT password from Member m Inner join Room r\n"
			        + "        on m.id_no = r.id_no\n"
			        + "        where r.room_no=?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, room.getRoom_no());
			rs = pstmt.executeQuery();
//			System.out.println("dbpasswd=>"+dbpasswd);
//			System.out.println("3.pstmt=>"+pstmt);
//			System.out.println("mem.id=>"+mem.getId_no());
//			System.out.println("4.mem.getpassword() =>"+mem.getPassword());
			
			if(rs.next()) {// 보여주는 결과가 있다면
				dbpasswd = rs.getString("password");
				System.out.println("dbpasswd=>" + dbpasswd);// 확인한 뒤에 나중에 삭제해야한다.
				if (dbpasswd.equals(mem.getPassword())) {
					sql = "update Room set room_no=?, title=?,address=?,room_count=?,room_option=?,";
					sql += " fee=? ,room_info=? ,lat=? ,lng=? where room_no=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, room.getRoom_no());
					pstmt.setString(2, room.getTitle());
					pstmt.setString(3, room.getAddress());
					pstmt.setString(4, room.getRoom_count());
					pstmt.setString(5, room.getRoom_option());
					pstmt.setString(6, room.getFee());
					pstmt.setString(7, room.getRoom_info());
					pstmt.setDouble(8, room.getLat());
					pstmt.setDouble(9, room.getLng());
					pstmt.setInt(10, room.getRoom_no());
					//System.out.println("Wls pstmt=>"+pstmt);
					int update = pstmt.executeUpdate();
					System.out.println("게시판의 글수정 성공유무(update)=>" + update);
					x = 1;// 수정성공유무
				} else {// 암호가 틀린경우
					x = 0;// 수정실패
				}
			} // if(rs.next())
		} catch (Exception e) {
			System.out.println("updateArticle() 메서드 에러유발=>" + e);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;
	}

	// 글삭제=>암호를 비교->delete from board where num=?
	public int deleteRoom(int room_no, String password) { // 회원탈퇴와 동일한 기능

		String dbpasswd = null;// db에서 찾은 암호를 저장
		int x = -1;// 게시물의 삭제성공유무

		System.out.println("deleteRoom에서의 num=>" + room_no + ",passwd=>" + password);

		try {
			con = pool.getConnection();
			sql = "SELECT password from Member m Inner join Room r\n"
                    + "        on m.id_no = r.id_no\n"
                    + "        where r.room_no=?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, room_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {// 보여주는 결과가 있다면
				dbpasswd = rs.getString("password");
				System.out.println("dbpasswd=>" + dbpasswd);// 확인한 뒤에 나중에 삭제해야한다.
				if (dbpasswd.equals(password)) {
					sql = "delete from Room where room_no=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, room_no);
					int delete = pstmt.executeUpdate();
					System.out.println("게시판의 글삭제 성공유무(delete)=>" + delete);
					x = 1;// 삭제성공유무
				} else {// 암호가 틀린경우
					x = 0;// 삭제실패
				}
			} // if(rs.next())
		} catch (Exception e) {
			System.out.println("deleteRoom() 메서드 에러유발=>" + e);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;
	}


}