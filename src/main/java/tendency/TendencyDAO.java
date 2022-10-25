package tendency;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import tendency.DBConnectionMgr;

//성향테스트
public class TendencyDAO {
	
	//1.객체생성할 멤버변수선언
		private DBConnectionMgr pool=null;//DB
		
		private Connection con=null;
		private PreparedStatement pstmt=null;//SQL구문실행
		private ResultSet rs=null;//select
		private String sql="";//실행시킬 SQL구문
		
		//2.생성자를 통해 DB연결
		public TendencyDAO() {
			try {
				pool=DBConnectionMgr.getInstance();//DB생성 객체 불러오기
				System.out.println("pool=>"+pool);
			} catch(Exception e) {
				System.out.println("DB접속 오류=>"+e);
			}
		}
		
		//3.메서드처리
		//(0)성향테스트를 했는지 안했는지 체크?
		public boolean checkTendency(int id_no) {
			boolean check = false;
			try {
				con=pool.getConnection();
				System.out.println("con=>"+con);
				sql="select * from Tendency where id_no=?";
				pstmt=con.prepareStatement(sql);//저장
				pstmt.setInt(1, id_no);
				rs=pstmt.executeQuery();//실행
				check=rs.next();// 데이터가 존재 true or 없으면 false
				System.out.println("checkTendency에서 check값=>"+check);
			} catch(Exception e) {
				System.out.println("checkTendency() 에러유발=>"+e);
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return check;
		}
		
		//1)성향테스트 등록
		public boolean insertTendency(TendencyDTO tend) {
			boolean check=false;//성향 등록확인유무
			try {
				con=pool.getConnection();
				sql="insert into Tendency values(?,?,?,?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, tend.getId_no());
				pstmt.setString(2, tend.getStarttime());
				pstmt.setString(3, tend.getEndtime());
				pstmt.setString(4, tend.getSleeptime());
				pstmt.setString(5, tend.getShowertime());
				pstmt.setString(6, tend.getSleepinghabbit());
				pstmt.setString(7, tend.getSmoking());
				pstmt.setString(8, tend.getPet());
				int insert=pstmt.executeUpdate();
				con.commit();
				System.out.println("insert(데이터 입력유무)=>"+insert);
				if(insert > 0) {
					check=true;//데이터 성공확인
				}
			} catch(Exception e) {
				System.out.println("insertTendency()실행에러유발=>"+e);
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return check;
		}
		
		//2)성향테스트 수정하기
		//2-1)id_no에 맞는 성향테스트 결과 찾기
		public TendencyDTO getTendency(int id_no) {
			TendencyDTO tend=null;//id_no에 해당되는 레코드 한개를 저장
			try {
				con=pool.getConnection();
				sql="select * from Tendency where id_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, id_no);
				rs=pstmt.executeQuery();
				if(rs.next()) {//레코드를 찾았다면
					tend=new TendencyDTO();
					tend.setStarttime(rs.getString("starttime"));
					tend.setEndtime(rs.getString("endtime"));
					tend.setSleeptime(rs.getString("sleeptime"));
					tend.setShowertime(rs.getString("showertime"));
					tend.setSleepinghabbit(rs.getString("sleepinghabbit"));
					tend.setSmoking(rs.getString("smoking"));
					tend.setPet(rs.getString("pet"));
				}
			} catch(Exception e) {
				System.out.println("getTendency()실행에러유발=>"+e);
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return tend;
		}
		
		//2-2)찾은 결과 수정하기
		public boolean updateTendency(TendencyDTO tend) {
			boolean check=false;//성향테스트 수정 성공유무
			try {
				con=pool.getConnection();
				sql="update Tendency set starttime=?,endtime=?,sleeptime=?,showertime=?,sleepinghabbit=?,smoking=?,pet=? where id_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, tend.getStarttime());
				pstmt.setString(2, tend.getEndtime());
				pstmt.setString(3, tend.getSleeptime());
				pstmt.setString(4, tend.getShowertime());
				pstmt.setString(5, tend.getSleepinghabbit());
				pstmt.setString(6, tend.getSmoking());
				pstmt.setString(7, tend.getPet());
				pstmt.setInt(8, tend.getId_no());
				int update=pstmt.executeUpdate();//반환값 1(성공), 0(실패)
				//con.commit();
				System.out.println("update(데이터 수정유무)=>"+update);
				if(update==1) {
					check=true;//데이터 수정 성공확인
				}
			} catch(Exception e) {
				System.out.println("updateTendency()실행에러유발=>"+e);
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return check;
		}
		
}
