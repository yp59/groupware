package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ScheduleEndDao {
	
	public static final String USERNAME ="kh75";
	public static final String PASSWORD ="kh75";
	
	//완료 목록 조회
	public List<ScheduleEndDto> list_end () throws Exception {
		Connection con =jdbcUtils.getConnection();
		String sql ="select*from schedule_end";
		
		PreparedStatement ps =con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<ScheduleEndDto> list = new ArrayList<>();
		
		while(rs.next()) {
			ScheduleEndDto scheduleEndDto = new ScheduleEndDto();
			scheduleEndDto.setSc_no(rs.getInt("sc_no"));
			scheduleEndDto.setEmpNo(rs.getString("emp_no"));
			scheduleEndDto.setSc_name(rs.getString("sc_name"));
//			scheduleEndDto.setSc_content(rs.getString("sc_content"));
			scheduleEndDto.setSc_made(rs.getString("sc_made"));
			scheduleEndDto.setSc_deadline(rs.getString("sc_deadline"));
			scheduleEndDto.setSc_state(rs.getString("sc_state"));
			scheduleEndDto.setEmpName(rs.getString("emp_name"));
			scheduleEndDto.setDep_name(rs.getString("dep_name"));
			
			list.add(scheduleEndDto);
		}
			con.close();
			return list;
		
		
		
		
	}
	//완료 목록 페이지 네이션
	public List<ScheduleEndDto> list_end_pagination (int startRow2, int endRow2) throws Exception {
		Connection con =jdbcUtils.getConnection();
		String sql ="select * from("
				+ "select rownum rn, TMP.* from("
				+ "select*from schedule_end "
			+ ")TMP"
		+ ") where rn between ? and ?";
		
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setInt(1, startRow2);
		ps.setInt(2, endRow2);
		
	
		ResultSet rs = ps.executeQuery();
		
		List<ScheduleEndDto> list = new ArrayList<>();
		
		while(rs.next()) {
			ScheduleEndDto scheduleEndDto = new ScheduleEndDto();
			scheduleEndDto.setSc_no(rs.getInt("sc_no"));
			scheduleEndDto.setEmpNo(rs.getString("emp_no"));
			scheduleEndDto.setSc_name(rs.getString("sc_name"));
//			scheduleEndDto.setSc_content(rs.getString("sc_content"));
			scheduleEndDto.setSc_made(rs.getString("sc_made"));
			scheduleEndDto.setSc_deadline(rs.getString("sc_deadline"));
			scheduleEndDto.setSc_state(rs.getString("sc_state"));
			scheduleEndDto.setEmpName(rs.getString("emp_name"));
			scheduleEndDto.setDep_name(rs.getString("dep_name"));
			
			list.add(scheduleEndDto);
		}
			con.close();
			return list;
		
	}
	//완료 검색 페이지네이션
	public List<ScheduleEndDto> search (String type2, String keyword2, int startRow2, int endRow2) throws Exception {
		Connection con =jdbcUtils.getConnection();
		String sql ="select*from( "
						+ "select rownum rn, TMP.*from( "
						+ "select*from schedule_end "
						+ "where instr(#1,?)>0 "
					+ ") TMP "
					+ ") where rn between ? and ?";
		sql = sql.replace("#1", type2);
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setString(1, keyword2);
		ps.setInt(2, startRow2);
		ps.setInt(3, endRow2);
		
	
		ResultSet rs = ps.executeQuery();
		
		List<ScheduleEndDto> list = new ArrayList<>();
		
		while(rs.next()) {
			ScheduleEndDto scheduleEndDto = new ScheduleEndDto();
			scheduleEndDto.setSc_no(rs.getInt("sc_no"));
			scheduleEndDto.setEmpNo(rs.getString("emp_no"));
			scheduleEndDto.setSc_name(rs.getString("sc_name"));
//			scheduleEndDto.setSc_content(rs.getString("sc_content"));
			scheduleEndDto.setSc_made(rs.getString("sc_made"));
			scheduleEndDto.setSc_deadline(rs.getString("sc_deadline"));
			scheduleEndDto.setSc_state(rs.getString("sc_state"));
			scheduleEndDto.setEmpName(rs.getString("emp_name"));
			scheduleEndDto.setDep_name(rs.getString("dep_name"));
			
			list.add(scheduleEndDto);
		}
			con.close();
			return list;
		
	}
}
