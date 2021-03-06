package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SalaryAuthorityDao {

	//급여 입력
	public void insert(SalaryDto salaryDto) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql= "insert into salary values(?,?,?,?,?,?,to_char(sysdate,'yyyy-mm-dd'),?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,salaryDto.getEmpNo());
		ps.setInt(2,salaryDto.getPoNo());
		
		AttendanceDao attendanceDao = new AttendanceDao();
		int overtime = attendanceDao.getOvertime(salaryDto.getEmpNo());
		
		int totalSalary = salaryDto.getSalaryPay()+salaryDto.getSalaryOvertime()*overtime
		+salaryDto.getSalaryMeal()+salaryDto.getSalaryTransportation();
		
		ps.setInt(3, salaryDto.getSalaryPay());
		ps.setInt(4, salaryDto.getSalaryOvertime() * overtime );
		ps.setInt(5, salaryDto.getSalaryMeal());
		ps.setInt(6, salaryDto.getSalaryTransportation());
		ps.setInt(7,totalSalary);
		
		
		ps.execute();
		con.close();
	}
	
	//일괄 급여 지급 (입력)
	public void insertAll(List<employeesDto> employeesList, String attDate) throws Exception {
		Connection con = jdbcUtils.getConnection();
		AttendanceDao attendanceDao = new AttendanceDao();	
		
		//리스트 요소마다 가져와서 값넣기
		for(int i=0; i<employeesList.size(); i++) {
			if(attendanceDao.isAttend(employeesList.get(i).getEmpNo(), attDate)>0) { //이번달에 출근을 했다면 attDate:'yyyy-mm'
				String sql= "insert into salary values(?,?,?,?,?,?,to_char(sysdate,'yyyy-mm-dd'),?)";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1,employeesList.get(i).getEmpNo()); 
				ps.setInt(2,employeesList.get(i).getPono());
				
				int overtime = attendanceDao.getOvertime(employeesList.get(i).getEmpNo());
				
				PositionSalaryDao positionSalaryDao = new PositionSalaryDao();
				PositionSalaryDto positionSalaryDto = positionSalaryDao.get(employeesList.get(i).getPono());
				
				int totalSalary = positionSalaryDto.getSalaryPay()+positionSalaryDto.getSalaryOvertime()*overtime
				+positionSalaryDto.getSalaryMeal()+positionSalaryDto.getSalaryTransportation();
				
				ps.setInt(3, positionSalaryDto.getSalaryPay());
				ps.setInt(4, positionSalaryDto.getSalaryOvertime() * overtime );
				ps.setInt(5, positionSalaryDto.getSalaryMeal());
				ps.setInt(6, positionSalaryDto.getSalaryTransportation());
				ps.setInt(7,totalSalary);
				
				ps.execute();
			}
		}
		
		con.close();
	}
	
	//관리자에게 보여주는 내역
	public List<SalaryDto> list(int startRow, int endRow) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from("
						+ "select rownum rn, TMP.* from("
							+"select S.*, E.emp_name from salary S inner join employees E "
							+ "on E.emp_no = S.emp_no order by salary_date desc"
						+ ")TMP"
					+ ") where rn between ? and ?";
		
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		
		ResultSet rs = ps.executeQuery();
		List<SalaryDto> list = new ArrayList<>();
		while(rs.next()) {
			SalaryDto salaryDto = new SalaryDto();
			salaryDto.setEmpNo(rs.getString("emp_no"));
			salaryDto.setEmpName(rs.getString("emp_name"));
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
		
		String sql = "select S.*, E.emp_name,p.posi from salary S inner join employees E "
					+ "on E.emp_no = S.emp_no inner join position P on E.po_no = P.po_no "
					+ "and S.emp_no=? and salary_date = to_date(?,'yyyy-mm-dd')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setString(2, salaryDate);
		ResultSet rs = ps.executeQuery();
		
		SalaryDto salaryDto;
		if(rs.next()) {
			salaryDto = new SalaryDto();
			salaryDto.setEmpNo(rs.getString("emp_no"));
			salaryDto.setEmpName(rs.getString("emp_name"));
			salaryDto.setPoNo(rs.getInt("po_no"));
			salaryDto.setPosi(rs.getString("posi"));
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
	
	public boolean delete(String empNo,String salaryDate) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "delete salary where emp_no=? and salary_date=to_date(?,'yyyy-mm-dd')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setString(2, salaryDate);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	// 급여 수정 
	public boolean edit(SalaryDto salaryDto) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "update salary "
					+ " set salary_pay=?, salary_overtime=?, salary_meal=?, salary_transportation=?,"
					+ " salary_total=? "
					+ " where emp_no=? and salary_date = to_date(?,'yyyy-mm-dd')";
		PreparedStatement ps = con.prepareStatement(sql);
		
		AttendanceDao attendanceDao = new AttendanceDao();
		int overtime = attendanceDao.getOvertime(salaryDto.getEmpNo());
		ps.setInt(1, salaryDto.getSalaryPay());
		ps.setInt(2, salaryDto.getSalaryOvertime()*overtime);
		ps.setInt(3,salaryDto.getSalaryMeal());
		ps.setInt(4, salaryDto.getSalaryTransportation());
		
		int totalSalary = salaryDto.getSalaryPay()+salaryDto.getSalaryOvertime()*overtime
				+salaryDto.getSalaryMeal()+salaryDto.getSalaryTransportation();
		
		ps.setInt(5,totalSalary);
		ps.setString(6, salaryDto.getEmpNo());
		ps.setString(7, salaryDto.getSalaryDate());
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	//년도 가져오기(화면 select에 추가)
	public List<String> getYear() throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select distinct(to_char(salary_date,'yyyy')) as year from salary "
				+ "order by year";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<String> yearList = new ArrayList<>();
		while(rs.next()) {
			yearList.add(rs.getString("year"));
		}
		
		con.close();
		return yearList;
	}
	
	//연도와 월 가져오기(화면 select에 추가)
	public List<String> getMonth() throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select to_char(salary_date,'yyyy-mm') as month from salary "
				+ "order by month";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<String> monthList = new ArrayList<>();
		while(rs.next()) {
			monthList.add(rs.getString("month"));
		}
		
		con.close();
		return monthList;
	}
	
	//검색 기능
	public SalaryDto search(String year, String month) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select S.*, E.emp_name from salary S inner join employees E "
							+ "on E.emp_no = S.emp_no "
							+"and instr(to_char(salary_date,'yyyy'),?)>0 and instr(to_char(salary_date,'mm'),?)>0 ";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, year);
		ps.setString(2, month);
		
		ResultSet rs = ps.executeQuery();
		
		SalaryDto salaryDto = null;
		if(rs.next()) {
			salaryDto = new SalaryDto();
			salaryDto.setEmpNo(rs.getString("emp_no"));
			salaryDto.setEmpName(rs.getString("emp_name"));
			salaryDto.setSalaryDate(rs.getString("salary_date"));
			salaryDto.setSalaryTotal(rs.getInt("salary_total"));
			
		}
		con.close();
		return salaryDto;
	}
	
	//연도별, 월별 검색 기능
	public List<SalaryDto> searchList(String year, String month, int startRow, int endRow) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from( "
						+ "select rownum rn, TMP.* from( " 
							+"select S.*, E.emp_name from salary S inner join employees E "
							+"on E.emp_no = S.emp_no "
				    		+"and instr(to_char(salary_date,'yyyy'),?)>0 or instr(to_char(salary_date,'mm'),?)>0 "
				    		+ "and E.emp_no = S.emp_no "
				    	+ ")TMP "
					+ ") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, year);
		ps.setString(2, month);
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
		
		
		ResultSet rs = ps.executeQuery();
		
		List<SalaryDto> salaryList = new ArrayList<>();
		while(rs.next()) {
			SalaryDto salaryDto = new SalaryDto();
			salaryDto.setEmpNo(rs.getString("emp_no"));
			salaryDto.setEmpName(rs.getString("emp_name"));
			salaryDto.setSalaryDate(rs.getString("salary_date"));
			salaryDto.setSalaryTotal(rs.getInt("salary_total"));
			
			salaryList.add(salaryDto);
		}
		
		con.close();
		return salaryList;
	}

	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
	public int getCount() throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select count(*) from salary";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public int getCount1(String year, String month) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select count(*) from salary "
	    		+"where instr(to_char(salary_date,'yyyy'),?)>0 and instr(to_char(salary_date,'mm'),?)>0 ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, year);
		ps.setString(2, month);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public int getCount2(String year, String month) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select count(*) from salary "
	    		+"where instr(to_char(salary_date,'yyyy'),?)>0 or instr(to_char(salary_date,'mm'),?)>0 ";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, year);
		ps.setString(2, month);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}

}
