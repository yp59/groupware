package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AttendanceDao {
	
	// 출근
	public void attend(AttendanceDto attendanceDto) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql ="insert into attendance values(sysdate,?,sysdate,sysdate,0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		
		ps.execute();
		con.close();		
	}
	
	// 퇴근
	public boolean leave(AttendanceDto attendanceDto) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql="update attendance "
				+ "set att_leave= sysdate where emp_no=?,att_date=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		ps.setDate(2,attendanceDto.getAttDate());
		
		int count = ps.executeUpdate();
		
		
		con.close();
		return count>0;
	}
	
	
	
	

}
