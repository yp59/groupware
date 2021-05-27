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
		Connection con = jdbcUtils.getConnection();
		
		String sql ="insert into attendance values(to_char(sysdate, 'yyyy-mm-dd'),?, sysdate, null, 0, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		
		ps.execute();
		con.close();		
	}
	
	// 퇴근
	public boolean leave(AttendanceDto attendanceDto) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql="update attendance set att_leave=sysdate " 
				+ "where emp_no=? and att_date = to_char(sysdate, 'yyyy-mm-dd')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,attendanceDto.getEmpNo());
		
		int count = ps.executeUpdate();
		
		
		con.close();
		return count>0;
	}
	
	
	//총 근무시간 계산
	public boolean totaltime(String empNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		//총 근무시간(원래 근무시간 + 추가 근무시간) 계산
		String sql="update attendance set att_totaltime = round((att_leave-att_attend)*24,1) "
				+ "where emp_no = ? and att_date = to_char(sysdate, 'yyyy-mm-dd')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,empNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	//추가 근무 시간 계산 가져오기 + 값 수정
	public boolean overtime(String empNo) throws Exception{
		Connection con = jdbcUtils.getConnection();

		//근무 시간 : 8시간으로 설정
		//추가근무시간 : 총 근무시간 - 8시간
		String sql = "update attendance set att_overtime = GREATEST(att_totaltime-8, 0)"
				+ "where emp_no=? and att_date = to_char(sysdate, 'yyyy-mm-dd')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	// 근태목록 보기 
	public List<AttendanceDto> list(String empNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql ="select"
						+ " A.att_date,A.emp_no,to_char(A.att_attend,'HH24:mi:ss') as att_attend,"
						+ "to_char(A.att_leave,'HH24:mi:ss') as att_leave, A.att_totaltime ,"
						+ " A.att_overtime, E.emp_name"
					+ " from attendance A inner join employees E "
				+ "on E.emp_no = A.emp_no and A.emp_no=? order by att_date desc";

			PreparedStatement ps =con.prepareStatement(sql);
			ps.setString(1,empNo);
			ResultSet rs = ps.executeQuery();
			
			List<AttendanceDto> attendanceList = new ArrayList<>();
			
			while(rs.next()) {
				AttendanceDto attendanceDto = new AttendanceDto();
				attendanceDto.setAttDate(rs.getString("att_date"));
				attendanceDto.setEmpNo(rs.getString("emp_no"));
				attendanceDto.setEmpName(rs.getString("emp_name"));
				attendanceDto.setAttAttend(rs.getString("att_attend"));
				attendanceDto.setAttLeave(rs.getString("att_leave"));
				attendanceDto.setAttTotaltime(rs.getFloat("att_totaltime"));
				attendanceDto.setAttOvertime(rs.getInt("att_overtime"));
				
				attendanceList.add(attendanceDto);
			}
			con.close();
			
			return attendanceList;
		}
	
	
	// 근태 내역 상세보기 
	public AttendanceDto get(String empNo, String attDate) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select"
							+ " A.att_date,A.emp_no,to_char(A.att_attend,'HH24:mi:ss') as att_attend, "
							+ "to_char(A.att_leave,'HH24:mi:ss') as att_leave, A.att_totaltime ,"
							+ " A.att_overtime, E.emp_name "
						+ "from attendance A inner join employees E "
				+ "on E.emp_no = A.emp_no and A.emp_no=? and A.att_date=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setString(2, attDate);
		ResultSet rs = ps.executeQuery();
		
		AttendanceDto attendanceDto;
		if(rs.next()) {
			attendanceDto = new AttendanceDto();
			attendanceDto.setAttDate(rs.getString("att_date"));
			attendanceDto.setEmpName(rs.getString("emp_name"));
			attendanceDto.setEmpNo(rs.getString("emp_no"));
			attendanceDto.setAttAttend(rs.getString("att_attend"));
			attendanceDto.setAttLeave(rs.getString("att_leave"));
			attendanceDto.setAttTotaltime(rs.getFloat("att_totaltime"));
			attendanceDto.setAttOvertime(rs.getInt("att_overtime"));				
		}
		else {
			attendanceDto = null;
		}
	
		con.close();
		return attendanceDto;
	}

}
