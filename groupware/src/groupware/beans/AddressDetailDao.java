package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AddressDetailDao {
	public AddressDetailDto detail(String emp_no)throws Exception {
		Connection con =jdbcUtils.getConnection();
		String sql ="select*from address_detail where emp_no=?";
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setString(1, emp_no);
		ResultSet rs =ps.executeQuery();
		
		AddressDetailDto addressDetailDto;
		if(rs.next()) {
			addressDetailDto = new AddressDetailDto();
			addressDetailDto.setDepartment(rs.getString("department"));
			addressDetailDto.setPosi(rs.getString("posi"));
			addressDetailDto.setEmp_name(rs.getString("emp_name"));
			addressDetailDto.setEmp_phone(rs.getString("emp_phone"));
			addressDetailDto.setEmail(rs.getString("email"));
			addressDetailDto.setAddress(rs.getString("address"));
			addressDetailDto.setJoin_date(rs.getDate("join_date"));
			addressDetailDto.setEmp_no(rs.getString("emp_no"));
			
		}else {
			addressDetailDto =null;
		}
		
		con.close();
		return addressDetailDto;
		
		
		
	}
}
