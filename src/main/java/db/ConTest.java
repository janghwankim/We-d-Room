package db;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.net.aso.f;

/**
 * Servlet implementation class ConTest
 */
@WebServlet("/ConTest")
public class ConTest extends HttpServlet {

	// id,passwd,file
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 입력
		String id = request.getParameter("id");
		String pwd = "";
		String decrypt = request.getParameter("decrypt");
		// Properties파일에서 불러올 키값을 변수선언
		String _driver, _url, _user, _password;

		if (pwd == null || "".equals(pwd)) {
			try {

				///Users/bumkey/국비교육/10.secure/test
				String location="/Users/bumkey/국비교육/4.JSP/sou/Project/src/main/webapp/dbtest"; //location 수정해야함!!!
				String location2="dbmysql.properties"+decrypt;//암호파일
				System.out.println("location2=>"+location2);
				
				//1)DB파일설정파일->암호화시켜서 암호화파일 생성
				Crypt.encryptFile(location, location2);//원본파일명,암호파일명
				
				/* 나중에 지우기
				//2.원본파일 지우기
				File f=new File(location);
				f.delete();//원본파일 삭제
				*/
				
				//3.복호화 시키기위한 암호화된 파일 불러오기
				///Users/bumkey/국비교육/4.JSP/sou/WebSecure2/src/main/webapp/back
				Crypt.decryptFile(location2, 
						"/Users/bumkey/국비교육/DB/jdbc22.properties");//뒤에 생성시킬 이름생성
				//dbtest경로 집어넣기!!!!!
				//4.복호화된 파일->Properties객체를 생성->메모리에 올려서 각 키 불러오기
				Properties props = new Properties();
				// 원본->암호화

				// 암호화->복호화
				FileInputStream in = new FileInputStream(
						"/Users/bumkey/국비교육/DB/jdbc22.properties");
				props.load(in);// 파일의 내용을 메모리에 불러오기
				in.close();
				_driver = props.getProperty("jdbc.drivers");
				// 드라이브만 시스템에 반영
				if (_driver != null) {
					System.setProperty("jdbc.drivers", _driver);
					_url = props.getProperty("jdbc.url");
					_user = props.getProperty("jdbc.username");
					_password = props.getProperty("jdbc.password");
					System.out.println("_driver=>"+(_driver)+", _url=>"+(_url)+",_user=>"+(_user)+",+, _password=>"+(_password));
					//DB연결테스트
					Connection con=DBConnect(_url, _user, _password);
					if(con!=null) {
						out.println("DB접속에 성공했습니다=>"+con);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} // doPost()
	}

	public static Connection DBConnect(String _url, String _user, String _password) {
		Connection conn = null;
		try {
//			Class.forName("oracle.jdbc.driver.OracleDriver");
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(_url, _user, _password);
			System.out.println("conn=" + conn);
		} catch (Exception e) {
			System.out.println("DB연결실패=" + e);
		}
		return conn;
	}
}
