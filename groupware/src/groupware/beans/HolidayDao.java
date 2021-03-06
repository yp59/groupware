package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class HolidayDao {
	
	public static final String USERNAME = "kh75";
	public static final String PASSWORD = "kh75";
	
	//시퀀스 번호를 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select board_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);
		
		con.close();
		return no;
	}
	
	// 휴가신청
	public void insert(HolidayDto holidayDto) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "insert into holiday values(?,?,?,?,?,?,sysdate)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,holidayDto.getHolNo());
		ps.setString(2,holidayDto.getEmpNo());
		ps.setString(3,holidayDto.getHolType());
		ps.setString(4, holidayDto.getHolContent());
		ps.setString(5, holidayDto.getHolStart());
		ps.setString(6,holidayDto.getHolEnd());
		
		ps.execute();
		con.close();
		
	}
	
	//휴가 리스트
	public List<HolidayDto> list(String empNo,int startRow, int endRow) throws Exception {
		
		Connection con = jdbcUtils.getConnection();
		
		//사원 자신의 휴가 신청 내역 볼수 있도록 설정
		String sql = "select * from( "
						+ "select rownum rn, TMP.* from( "
								+"select * from holiday where emp_no =? order by hol_no desc "
						+")TMP "
						+") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<HolidayDto> list = new ArrayList<>();
		while(rs.next()) {
			HolidayDto holidayDto = new HolidayDto();
			holidayDto.setHolNo(rs.getInt("hol_no"));
			holidayDto.setEmpNo(rs.getString("emp_no"));
			holidayDto.setHolType(rs.getString("hol_type"));
			holidayDto.setHolContent(rs.getString("hol_content"));
			holidayDto.setHolStart(rs.getString("hol_start"));
			holidayDto.setHolEnd(rs.getString("hol_end"));
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
					+ "set hol_type=?, hol_content=?, hol_start=?, hol_end=? "
					+ "where emp_no=? and hol_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,holidayDto.getHolType());
		ps.setString(2,holidayDto.getHolContent());
		ps.setString(3, holidayDto.getHolStart());
		ps.setString(4, holidayDto.getHolEnd());
		ps.setString(5,holidayDto.getEmpNo());
		ps.setInt(6, holidayDto.getHolNo());
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	//휴가 삭제
	public boolean delete(int holNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "delete holiday where hol_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, holNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	//신청 내역 상세 보기 
	public HolidayDto get(String empNo, int holNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from holiday where emp_no =? and hol_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setInt(2, holNo);
		ResultSet rs = ps.executeQuery();
		
		HolidayDto holidayDto;
		if(rs.next()) {
			holidayDto = new HolidayDto();
			holidayDto.setHolNo(rs.getInt("hol_no"));
			holidayDto.setEmpNo(rs.getString("emp_no"));
			holidayDto.setHolType(rs.getString("hol_type"));
			holidayDto.setHolContent(rs.getString("hol_content"));
			holidayDto.setHolStart(rs.getString("hol_start"));
			holidayDto.setHolEnd(rs.getString("hol_end"));
			holidayDto.setHolWriteDate(rs.getDate("hol_write_date"));
			
		}
		else {
			holidayDto = null;
		}
	
		con.close();
		return holidayDto;
	}
	

	// 휴가 사용일수 계산 
	// + 주말일 경우 휴가 사용일 수에서 주말 제외한 일수만 반환하도록 수정
	public int count(String empNo, int holNo) throws Exception{
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select count(1) as count from("
						+ "select start_date + level -1 from("
								+ "select trunc(hol_start) start_date, trunc(hol_end) end_date "
								+ "from holiday where emp_no=? and hol_no=? )"
					 + "where to_char(start_date + level -1,'d') != 7 and to_char(start_date + level -1,'d') != 1"
				+ "connect by level <= end_date - start_date + 1)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setInt(2, holNo);
		
		ResultSet rs = ps.executeQuery();
		
		int count=0;
		
		if(rs.next()) {
			count = rs.getInt("count");
		}
		
		con.close();
		return count;
	}
	
	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
	public int getCount(String empNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		String sql = "select count(*) from holiday where emp_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
}
