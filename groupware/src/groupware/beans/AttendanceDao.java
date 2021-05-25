package groupware.beans;

import java.sql.Connection;
import java.sql.Date;
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
		
		String sql ="insert into attendance values(to_char(sysdate, 'yyyy-mm-dd'),?, sysdate, null, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		
		ps.execute();
		con.close();		
	}
	
	// 퇴근
	public boolean leave(AttendanceDto attendanceDto) throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql="update attendance set att_leave=sysdate " 
				+ "where emp_no=? and att_date = to_char(sysdate, 'yyyy-mm-dd')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		
		int count = ps.executeUpdate();
		
		
		con.close();
		return count>0;
	}
	
	
	// 추가 근무시간 계산
	public boolean overtime(AttendanceDto attendanceDto) throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql="update attendance set att_leave=sysdate, att_overtime=? " 
				+ "where emp_no=? and att_date = to_char(sysdate, 'yyyy-mm-dd')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		String spl2="select where att_leave-att_attend> ";
		
		int overTime = 0;
		ps.setInt(1, overTime);
		ps.setString(2,attendanceDto.getEmpNo());
		
		int count = ps.executeUpdate();
		
		
		con.close();
		return count>0;
	}
	
	// 근태목록 보기 
	public List<AttendanceDto> list(String empNo) throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql ="select "
				+ "att_date, emp_no, to_char(att_attend,'HH24:mi:ss') as att_attend, to_char(att_leave,'HH24:mi:ss') as att_leave, att_overtime "
				+ "from attendance where emp_no=? order by att_date asc";

			PreparedStatement ps =con.prepareStatement(sql);
			ps.setString(1,empNo);
			ResultSet rs = ps.executeQuery();
			
			List<AttendanceDto> attendanceList = new ArrayList<>();
			
			while(rs.next()) {
				AttendanceDto attendanceDto = new AttendanceDto();
				attendanceDto.setAttDate(rs.getString("att_date"));
				attendanceDto.setEmpNo(rs.getString("emp_no"));
				attendanceDto.setAttAttend(rs.getString("att_attend"));
				attendanceDto.setAttLeave(rs.getString("att_leave"));
				attendanceDto.setAttOvertime(rs.getInt("att_overtime"));
				
				attendanceList.add(attendanceDto);
			}
			con.close();
			
			return attendanceList;
		}
	
	
	// 근태 내역 상세보기 
		public AttendanceDto get(String empNo, String attDate) throws Exception{
			Connection con = jdbcUtils.con(USERNAME, PASSWORD);
			
			String sql = "select "
						+ "att_date, emp_no, to_char(att_attend,'HH24:mi:ss') as att_attend, to_char(att_leave,'HH24:mi:ss') as att_leave , att_overtime "
						+ "from attendance where emp_no =? and att_date=?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, empNo);
			ps.setString(2, attDate);
			ResultSet rs = ps.executeQuery();
			
			AttendanceDto attendanceDto;
			if(rs.next()) {
				attendanceDto = new AttendanceDto();
				attendanceDto.setAttDate(rs.getString("att_date"));
				attendanceDto.setEmpNo(rs.getString("emp_no"));
				attendanceDto.setAttAttend(rs.getString("att_attend"));
				attendanceDto.setAttLeave(rs.getString("att_leave"));
				attendanceDto.setAttOvertime(rs.getInt("att_overtime"));				
			}
			else {
				attendanceDto = null;
			}
		
			con.close();
			return attendanceDto;
		}
	

	
	

}
