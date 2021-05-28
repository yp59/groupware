package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class SalaryDao {
	
	public void insert(SalaryDto salaryDto,String year, String month) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql= "insert into salary values(?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,salaryDto.getEmp_no());
		ps.setInt(2,salaryDto.getPo_no());
		
		PositionSalaryDao positionSalaryDao = new PositionSalaryDao();
		PositionSalaryDto positionSalaryDto = positionSalaryDao.get(salaryDto.getPo_no());
		
		AttendanceDao attendanceDao = new AttendanceDao();
		int overtime = attendanceDao.getOvertime(salaryDto.getEmp_no(),year,month);
		
		ps.setInt(3, positionSalaryDto.getSalaryPay());
		ps.setInt(4, positionSalaryDto.getSalaryOvertime() * overtime );
		ps.setInt(5, positionSalaryDto.getSalaryMeal());
		ps.setInt(6, positionSalaryDto.getSalaryTransportation());
		ps.setDate(7,salaryDto.getSalary_date());
		
		
		ps.execute();
		con.close();
	}
	
	
	
	//자신 월급 내역
			//1월,2월,3월, ... => 표? 'yyyy-mm' 2021년 5월달 월급 
	

}
