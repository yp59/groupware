package groupware.beans;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class jdbcUtils {

	public static Connection con(String USERNAME,String PASSWORD)throws Exception{
		Class.forName("oracle.jdbc.OracleDriver");
		
		Connection con  = DriverManager.getConnection
				("jdbc:oracle:thin:@www.sysout.co.kr:1521:xe", USERNAME, PASSWORD);
		
		return con;
	}
	
	private static DataSource ds;
	static {
		try {
			Context ctx = new InitialContext();
			ds=(DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		}
		catch(Exception e) {
			System.out.println("데이터베이스 연결 실패");
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws Exception {
		return ds.getConnection();
	}
	
}
