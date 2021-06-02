package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PositionHolidayDao {
	
	public int get(int poNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from position_holiday where po_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, poNo);
		ResultSet rs = ps.executeQuery();
		
		int poDay;
		if(rs.next()) {
			poDay = rs.getInt("po_day");
		}
		else {
			poDay = 0;
		}

		con.close();
		return poDay;
	}
}
