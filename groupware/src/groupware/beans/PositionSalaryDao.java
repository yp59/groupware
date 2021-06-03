package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	
	public PositionSalaryDto get(String empNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select P.*, E.emp_no ,E.emp_name from position_salary P inner join employees E "
					+ "on E.po_no = P.po_no and E.emp_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		
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
	
	public List<PositionSalaryDto> list() throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select P.*, E.emp_no ,E.emp_name from position_salary P inner join employees E on E.po_no = P.po_no";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		List<PositionSalaryDto> positionSalary = new ArrayList<>();
		PositionSalaryDto positionSalaryDto;
		while(rs.next()) {
			positionSalaryDto = new PositionSalaryDto();
			positionSalaryDto.setPoNo(rs.getInt("po_no"));
			positionSalaryDto.setSalaryPay(rs.getInt("salary_pay"));
			positionSalaryDto.setSalaryOvertime(rs.getInt("salary_overtime"));
			positionSalaryDto.setSalaryMeal(rs.getInt("salary_meal"));
			positionSalaryDto.setSalaryTransportation(rs.getInt("salary_transportation"));
			positionSalaryDto.setEmpName(rs.getString("emp_name"));
			positionSalaryDto.setEmpNo(rs.getString("emp_no"));
			
			positionSalary.add(positionSalaryDto);
		}
		
		con.close();
		return positionSalary;
		
	}

}
