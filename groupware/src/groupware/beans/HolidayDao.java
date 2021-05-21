package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

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

}
