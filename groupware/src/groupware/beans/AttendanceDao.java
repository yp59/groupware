package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDao {
	
	public static final String USERNAME = "kh75";
	public static final String PASSWORD = "kh75";
	
	// 출근
	public void attend(AttendanceDto attendanceDto) throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql ="insert into attendance values(sysdate,?,sysdate,sysdate,0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		
		ps.execute();
		con.close();		
	}
	
	// 퇴근
	public boolean leave(AttendanceDto attendanceDto) throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql="update attendance "
				+ "set att_leave= sysdate where emp_no=?,att_date=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		ps.setDate(2,attendanceDto.getAttDate());
		
		int count = ps.executeUpdate();
		
		
		con.close();
		return count>0;
	}
	
	// 근태목록 보기 
	public List<AttendanceDto> list(String empNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql ="select * from attendance where emp_no=? order by att_date asc";

			PreparedStatement ps =con.prepareStatement(sql);
			ps.setString(1,empNo);
			ResultSet rs = ps.executeQuery();
			
			List<AttendanceDto> attendanceList = new ArrayList<>();
			
			while(rs.next()) {
				AttendanceDto attendanceDto = new AttendanceDto();
				attendanceDto.setAttDate(rs.getDate("att_date"));
				attendanceDto.setEmpNo(rs.getString("emp_no"));
				attendanceDto.setAttAttend(rs.getDate("att_attend"));
				attendanceDto.setAttLeave(rs.getDate("att_leave"));
				attendanceDto.setAttOvertime(rs.getInt("att_overtime"));
				
				attendanceList.add(attendanceDto);
			}
			con.close();
			
			return attendanceList;
		}

	
	

}
