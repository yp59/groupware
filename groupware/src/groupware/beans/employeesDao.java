package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class employeesDao {

	public static final String USERNAME= "kh75";
	public static final String PASSWORD= "kh75";
	
	public boolean login(employeesDto employeesdto)throws Exception{
		
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "select * from employees"
				+ " where emp_no = ? and emp_pw = ?";
				
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, employeesdto.getEmpNo());
		ps.setString(2, employeesdto.getEmpPw());
		
		ResultSet rs = ps.executeQuery();
		
		boolean login;
		
		if(rs.next()) login = true;
		else login = false;
		
		con.close();
		return login;
	}
	
	public void regist(employeesDto employeesdto)throws Exception{
		
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "insert into employees values"
				+ " (?,?,?,?,?,?,?,?)";
				
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, employeesdto.getEmpNo());
		ps.setString(2, employeesdto.getEmpPw());
		ps.setInt(3, employeesdto.getPo_no());
		ps.setString(4, employeesdto.getEmpName());
		ps.setString(5, employeesdto.getJoinDate());
		ps.setString(6, employeesdto.getEmpPhone());
		ps.setString(7, employeesdto.getEmail());
		ps.setString(8, employeesdto.getAddress());
		
		ps.executeUpdate();
		con.close();
	}
	

	
}
