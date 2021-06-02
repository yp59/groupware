package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PositionSalaryDao {
	
	public PositionSalaryDto get(int poNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from position_salary where po_no =?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, poNo);
		
		ResultSet rs = ps.executeQuery();
		
		PositionSalaryDto positionSalaryDto;
		if(rs.next()) {
			positionSalaryDto = new PositionSalaryDto();
			positionSalaryDto.setPoNo(rs.getInt("po_no"));
			positionSalaryDto.setSalaryPay(rs.getInt("salary_pay"));
			positionSalaryDto.setSalaryOvertime(rs.getInt("salary_overtime"));
			positionSalaryDto.setSalaryMeal(rs.getInt("salary_meal"));
			positionSalaryDto.setSalaryTransportation(rs.getInt("salary_transportation"));
					
		}
		else {
			positionSalaryDto = null;
		}
		
		con.close();
		return positionSalaryDto;
		
	}

}
