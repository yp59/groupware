package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HolidayDao {
	
	// 휴가신청
	public void insert(HolidayDto holidayDto) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "insert into holiday values(?,?,?,?,?,?,sysdate)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,holidayDto.getHolNo());
		ps.setString(2,holidayDto.getEmpNo());
		ps.setString(3,holidayDto.getHolType());
		ps.setString(4, holidayDto.getHolContent());
		ps.setDate(5, holidayDto.getHolStart());
		ps.setDate(6,holidayDto.getHolEnd());
		
		ps.execute();
		con.close();
		
	}
	
	//휴가 리스트
	public List<HolidayDto> list(String empNo) throws Exception {
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from holiday where emp_no =?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ResultSet rs = ps.executeQuery();
		
		List<HolidayDto> list = new ArrayList<>();
		while(rs.next()) {
			HolidayDto holidayDto = new HolidayDto();
			holidayDto.setHolNo(rs.getInt("hol_no"));
			holidayDto.setEmpNo(rs.getString("emp_no"));
			holidayDto.setHolType(rs.getString("hol_type"));
			holidayDto.setHolContent(rs.getString("hol_content"));
			holidayDto.setHolStart(rs.getDate("hol_start"));
			holidayDto.setHolEnd(rs.getDate("hol_end"));
			holidayDto.setHolWriteDate(rs.getDate("hol_write_date"));
			
			list.add(holidayDto);
		}
	
		con.close();
		return list;
	}
	
	//휴가 수정
	public boolean edit(HolidayDto holidayDto) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "update holiday "
					+ "set hol_type=?, hol_content=?, hol_start=?, hol_end=?, hol_writer_date=sysdate "
					+ "where emp_no=? and hol_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,holidayDto.getHolType());
		ps.setString(2,holidayDto.getHolContent());
		ps.setDate(3, holidayDto.getHolStart());
		ps.setDate(4, holidayDto.getHolEnd());
		ps.setString(5,holidayDto.getEmpNo());
		ps.setInt(6, holidayDto.getHolNo());
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	//휴가 삭제
	public boolean delete(String empNo, int holNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "delete holiday where emp_no=? and hol_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setInt(2, holNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
}
