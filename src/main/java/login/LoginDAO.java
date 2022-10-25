package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import login.DBConnectionMgr;

//로그인
public class LoginDAO {

	//1.객체생성할 멤버변수선언
	private DBConnectionMgr pool=null;//DB
	
	private Connection con=null;
	private PreparedStatement pstmt=null;//SQL구문실행
	private ResultSet rs=null;//select
	private String sql="";//실행시킬 SQL구문
	
	//2.생성자를 통해 DB연결
	public LoginDAO() {
		try {
			pool=DBConnectionMgr.getInstance();//DB생성 객체 불러오기
		} catch(Exception e) {
			System.out.println("DB접속 오류=>"+e);
		}
	}
	
	//3.메서드 작성
//	public int login(String id,String password) {
//		
//		try {
//			con=pool.getConnection();
//			System.out.println("con=>"+con);
//			sql="select id from member where id=? and passwd=?";
//			pstmt=con.prepareStatement(sql);
//			pstmt.setString(1, id);
//			pstmt.setString(2, password);
//			rs=pstmt.executeQuery();
//			check=rs.next();
//		} catch(Exception e) {
//			System.out.println("loginCheck() 실행에러유발=>"+e);
//		} finally {
//			pool.freeConnection(con, pstmt, rs);
//		}
//		return check;
//	}
	public int login(String id,String password) {
		String SQL = "select password from Member where id=?";
		try {
			con=pool.getConnection();
			pstmt=con.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(password)) {
					return 1;//로그인성공
				} else return 0;//비밀번호 불일치
			}
			return -1;//아이디가 없음
		} catch(Exception e) {
			System.out.println("login() 실행에러유발=>"+e);
		}
		return -2;//데이터베이스 오류
	}
}
