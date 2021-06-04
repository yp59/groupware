package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ScheduleIngDao {
	public static final String USERNAME = "kh75";
	public static final String PASSWORD = "kh75";

	// 진행중 목록 조회
	public List<ScheduleIngDto> list_ing() throws Exception {
		Connection con = jdbcUtils.getConnection();
		String sql = "select*from schedule_ing";

		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<ScheduleIngDto> list = new ArrayList<>();

		while (rs.next()) {
			ScheduleIngDto scheduleIngDto = new ScheduleIngDto();
			scheduleIngDto.setSc_no(rs.getInt("sc_no"));
			scheduleIngDto.setEmpNo(rs.getString("emp_no"));
			scheduleIngDto.setSc_name(rs.getString("sc_name"));
//			scheduleIngDto.setSc_content(rs.getString("sc_content"));
			scheduleIngDto.setSc_made(rs.getString("sc_made"));
			scheduleIngDto.setSc_deadline(rs.getString("sc_deadline"));
			scheduleIngDto.setSc_state(rs.getString("sc_state"));
			scheduleIngDto.setEmpName(rs.getString("emp_name"));
			scheduleIngDto.setDep_name(rs.getString("dep_name"));

			list.add(scheduleIngDto);
		}
		con.close();
		return list;

	}

	// 진행중 목록 페이지네이션
	public List<ScheduleIngDto> list_ing_pagination(int startRow1, int endRow1) throws Exception {
		Connection con = jdbcUtils.getConnection();
		String sql = "select * from(" + "select rownum rn, TMP.* from(" + "select*from schedule_ing " + ")TMP"
				+ ") where rn between ? and ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow1);
		ps.setInt(2, endRow1);

		ResultSet rs = ps.executeQuery();

		List<ScheduleIngDto> list = new ArrayList<>();

		while (rs.next()) {
			ScheduleIngDto scheduleIngDto = new ScheduleIngDto();
			scheduleIngDto.setSc_no(rs.getInt("sc_no"));
			scheduleIngDto.setEmpNo(rs.getString("emp_no"));
			scheduleIngDto.setSc_name(rs.getString("sc_name"));
//			scheduleIngDto.setSc_content(rs.getString("sc_content"));
			scheduleIngDto.setSc_made(rs.getString("sc_made"));
			scheduleIngDto.setSc_deadline(rs.getString("sc_deadline"));
			scheduleIngDto.setSc_state(rs.getString("sc_state"));
			scheduleIngDto.setEmpName(rs.getString("emp_name"));
			scheduleIngDto.setDep_name(rs.getString("dep_name"));

			list.add(scheduleIngDto);
		}
		con.close();
		return list;

	}

	// 진행중 검색 페이지네이션
	public List<ScheduleIngDto> search(String type1, String keyword1, int startRow1, int endRow1) throws Exception {
		Connection con = jdbcUtils.getConnection();
		String sql = "select * from(" + "select rownum rn, TMP.* from( "
				+ "select*from schedule_ing where instr(#1, ?)>0 " + ")TMP" + ") where rn between ? and ?";
		sql = sql.replace("#1", type1);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword1);
		ps.setInt(2, startRow1);
		ps.setInt(3, endRow1);

		ResultSet rs = ps.executeQuery();

		List<ScheduleIngDto> list = new ArrayList<>();

		while (rs.next()) {
			ScheduleIngDto scheduleIngDto = new ScheduleIngDto();
			scheduleIngDto.setSc_no(rs.getInt("sc_no"));
			scheduleIngDto.setEmpNo(rs.getString("emp_no"));
			scheduleIngDto.setSc_name(rs.getString("sc_name"));
//			scheduleIngDto.setSc_content(rs.getString("sc_content"));
			scheduleIngDto.setSc_made(rs.getString("sc_made"));
			scheduleIngDto.setSc_deadline(rs.getString("sc_deadline"));
			scheduleIngDto.setSc_state(rs.getString("sc_state"));
			scheduleIngDto.setEmpName(rs.getString("emp_name"));
			scheduleIngDto.setDep_name(rs.getString("dep_name"));

			list.add(scheduleIngDto);
		}
		con.close();
		return list;

	}
	
	//index 의 schedule_ing
	public List<ScheduleIngDto> index_schedule()throws Exception {
		Connection con =jdbcUtils.getConnection();
		String sql = "select * from(" + "select rownum rn, TMP.* from( "
				+ "select*from schedule_ing  " + ")TMP" + ") where rn between 1 and 3";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<ScheduleIngDto> list = new ArrayList<>();

		while (rs.next()) {
			ScheduleIngDto scheduleIngDto = new ScheduleIngDto();
			scheduleIngDto.setSc_no(rs.getInt("sc_no"));
			scheduleIngDto.setEmpNo(rs.getString("emp_no"));
			scheduleIngDto.setSc_name(rs.getString("sc_name"));
//			scheduleIngDto.setSc_content(rs.getString("sc_content"));
			scheduleIngDto.setSc_made(rs.getString("sc_made"));
			scheduleIngDto.setSc_deadline(rs.getString("sc_deadline"));
			scheduleIngDto.setSc_state(rs.getString("sc_state"));
			scheduleIngDto.setEmpName(rs.getString("emp_name"));
			scheduleIngDto.setDep_name(rs.getString("dep_name"));

			list.add(scheduleIngDto);
		}
		con.close();
		return list;
	}
}
