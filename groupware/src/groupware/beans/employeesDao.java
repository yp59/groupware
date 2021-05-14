package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.Session;

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
		ps.setInt(3, employeesdto.getPono());
		ps.setString(4, employeesdto.getEmpName());
		ps.setString(5, employeesdto.getJoinDate());
		ps.setString(6, employeesdto.getEmpPhone());
		ps.setString(7, employeesdto.getEmail());
		ps.setString(8, employeesdto.getAddress());
		
		ps.executeUpdate();
		con.close();
	}
	public employeesDto loginInfo(String empNo)throws Exception{
		
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "select * from employees where emp_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, empNo);
		
		ResultSet rs = ps.executeQuery();
		
		employeesDto employeesdto ;
		if(rs.next()) {
			employeesdto = new employeesDto();
			
			employeesdto.setEmpNo(rs.getString(1));
			employeesdto.setEmpPw(rs.getString(2));
			employeesdto.setPono(rs.getInt(3));
			employeesdto.setEmpName(rs.getString(4));
			employeesdto.setJoinDate(rs.getString(5));
			employeesdto.setEmpPhone(rs.getString(6));
			employeesdto.setEmail(rs.getString(7));
			employeesdto.setAddress(rs.getString(8));
			
		}
		else {
			employeesdto=null;
			
		}
		con.close();
		return employeesdto;
	}

	public String position(String empNo)throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "select E.emp_no,E.emp_name,P.posi"
				+ " from employees E inner join"
				+ " position P on E.po_no=P.po_no"
				+ " where emp_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ResultSet rs = ps.executeQuery();
		String posi;
		if(rs.next()) {
		posi = rs.getString("posi");
		}
		else {
			posi=null;
		}
		con.close();
		return posi;
	}
	
	public void loginInfoEdit(employeesDto employeesdto)throws Exception{//회원정보 수정 Dao
		Connection con  = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "update employees set"
					+" emp_pw=?,"
					+" emp_name=?,"
					+" emp_phone=?,"
					+" email=?,"
					+" address=?"
					+" where emp_no = ?";//비밀번호 이름 핸드폰 이메일 주소
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, employeesdto.getEmpPw());
		ps.setString(2, employeesdto.getEmpName());
		ps.setString(3, employeesdto.getEmpPhone());
		ps.setString(4, employeesdto.getEmail());
		ps.setString(5, employeesdto.getAddress());
		ps.setString(6, employeesdto.getEmpNo());
		ps.executeUpdate();

		con.close();
	}
}
