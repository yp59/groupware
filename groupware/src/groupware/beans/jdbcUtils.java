package groupware.beans;

import java.sql.Connection;
import java.sql.DriverManager;

public class jdbcUtils {

	public static Connection con(String USERNAME,String PASSWORD)throws Exception{
		Class.forName("oracle.jdbc.OracleDriver");
		
		Connection con  = DriverManager.getConnection
				("jdbc:oracle:thin:@www.sysout.co.kr:1521:xe", USERNAME, PASSWORD);
		
		return con;
	}
	
}
