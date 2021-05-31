package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SalaryDao {
	
	public void insert(SalaryDto salaryDto,String year, String month) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql= "insert into salary values(?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,salaryDto.getEmpNo());
		ps.setInt(2,salaryDto.getPoNo());
		
		PositionSalaryDao positionSalaryDao = new PositionSalaryDao();
		PositionSalaryDto positionSalaryDto = positionSalaryDao.get(salaryDto.getPoNo());
		
		AttendanceDao attendanceDao = new AttendanceDao();
		int overtime = attendanceDao.getOvertime(salaryDto.getEmpNo(),year,month);
		
		int totalSalary = salaryDto.getSalaryPay()+salaryDto.getSalaryOvertime()*overtime
		+salaryDto.getSalaryMeal()+salaryDto.getSalaryTransportation();
		
		ps.setInt(3, positionSalaryDto.getSalaryPay());
		ps.setInt(4, positionSalaryDto.getSalaryOvertime() * overtime );
		ps.setInt(5, positionSalaryDto.getSalaryMeal());
		ps.setInt(6, positionSalaryDto.getSalaryTransportation());
		ps.setString(7,salaryDto.getSalaryDate());
		ps.setInt(8,totalSalary);
		
		
		ps.execute();
		con.close();
	}
	
	
	
	//자신 월급 내역
	//1월,2월,3월, ... => 표? 'yyyy-mm' 2021년 5월달 월급
	public List<SalaryDto> list(String empNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from salary where emp_no=? order by salary_date desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		
		ResultSet rs = ps.executeQuery();
		List<SalaryDto> list = new ArrayList<>();
		while(rs.next()) {
			SalaryDto salaryDto = new SalaryDto();
			salaryDto.setEmpNo(rs.getString("emp_no"));
			salaryDto.setPoNo(rs.getInt("po_no"));
			salaryDto.setSalaryPay(rs.getInt("salary_pay"));
			salaryDto.setSalaryOvertime(rs.getInt("salary_overtime"));
			salaryDto.setSalaryMeal(rs.getInt("salary_meal"));
			salaryDto.setSalaryTransportation(rs.getInt("salary_transportation"));
			salaryDto.setSalaryDate(rs.getString("salary_date"));
			salaryDto.setSalaryTotal(rs.getInt("salary_total"));
			
			list.add(salaryDto);
		}
		
		con.close();
		return list;
	}
	
	// 급여 상세보기
	public SalaryDto get(String empNo, String salaryDate) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from salary where emp_no=? and salary_date = to_date(?,'yyyy-mm-dd')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setString(2, salaryDate);
		ResultSet rs = ps.executeQuery();
		
		SalaryDto salaryDto;
		if(rs.next()) {
			salaryDto = new SalaryDto();
			salaryDto.setEmpNo(rs.getString("emp_no"));
			salaryDto.setPoNo(rs.getInt("po_no"));
			salaryDto.setSalaryPay(rs.getInt("salary_pay"));
			salaryDto.setSalaryOvertime(rs.getInt("salary_overtime"));
			salaryDto.setSalaryMeal(rs.getInt("salary_meal"));
			salaryDto.setSalaryTransportation(rs.getInt("salary_transportation"));
			salaryDto.setSalaryDate(rs.getString("salary_date"));
			salaryDto.setSalaryTotal(rs.getInt("salary_total"));
		}
		else {
			salaryDto = null;
		}
	
		con.close();
		return salaryDto;
	}
	
	//년도 가져오기(화면 select에 추가)
	public List<String> getYear(String empNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select distinct(to_char(salary_date,'yyyy')) as year from salary where emp_no=? order by year";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ResultSet rs = ps.executeQuery();
		List<String> yearList = new ArrayList<>();
		while(rs.next()) {
			yearList.add(rs.getString("year"));
		}
		
		con.close();
		return yearList;
	}
	
	//월 가져오기(화면 select에 추가)
	public List<String> getMonth(String empNo) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select distinct(to_char(salary_date,'mm')) as month from salary where emp_no=? order by month";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ResultSet rs = ps.executeQuery();
		List<String> monthList = new ArrayList<>();
		while(rs.next()) {
			monthList.add(rs.getString("month"));
		}
		
		con.close();
		return monthList;
	}
	
	//검색 기능
	public List<SalaryDto> search(String empNo,String year, String month) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select salary_date, salary_total from salary "
			    		+"where instr(to_char(salary_date,'yyyy'),?)>0 and instr(to_char(salary_date,'mm'),?)>0 "
			    		+ "and emp_no= ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, year);
		ps.setString(2, month);
		ps.setString(3, empNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<SalaryDto> salaryList = new ArrayList<>();
		while(rs.next()) {
			SalaryDto salaryDto = new SalaryDto();
			salaryDto.setSalaryDate(rs.getString("salary_date"));
			salaryDto.setSalaryTotal(rs.getInt("salary_total"));
			
			salaryList.add(salaryDto);
		}
		
		con.close();
		return salaryList;
	}

}
