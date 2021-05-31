package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AddressListDao {
	public List<AddressListDto> list() throws Exception{
		Connection con =jdbcUtils.getConnection();
		String sql ="select*from address_list";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		List<AddressListDto> list = new ArrayList<>();
		
		
		
		while(rs.next()) {
			AddressListDto addressListDto = new AddressListDto();
			addressListDto.setDepartment(rs.getString("department"));
			addressListDto.setPosi(rs.getString("posi"));
			addressListDto.setEmp_name(rs.getString("emp_name"));
			addressListDto.setEmp_phone(rs.getString("emp_phone"));
			addressListDto.setEmail(rs.getString("email"));
			addressListDto.setEmp_no(rs.getString("emp_no"));
			
			list.add(addressListDto);
			
		}
		con.close();
		return list;
		
	}
	//페이지네이션 구현 : 1. 리스트
	public List<AddressListDto> list(int start_row, int end_row) throws Exception{
		Connection con =jdbcUtils.getConnection();
		String sql ="select * from( select rownum rn, TMP.* from( select*from address_list)TMP) where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start_row);
		ps.setInt(2, end_row);
		
		
		ResultSet rs = ps.executeQuery();
		
		List<AddressListDto> list = new ArrayList<>();
		
		
		
		while(rs.next()) {
			AddressListDto addressListDto = new AddressListDto();
			addressListDto.setDepartment(rs.getString("department"));
			addressListDto.setPosi(rs.getString("posi"));
			addressListDto.setEmp_name(rs.getString("emp_name"));
			addressListDto.setEmp_phone(rs.getString("emp_phone"));
			addressListDto.setEmail(rs.getString("email"));
			addressListDto.setEmp_no(rs.getString("emp_no"));
			
			list.add(addressListDto);
			
		}
		con.close();
		return list;
		
	}
	//페이지네이션 구현 : 2. 검색
	public List<AddressListDto> search(String type, String keyword ,int start_row, int end_row) throws Exception{
		Connection con =jdbcUtils.getConnection();
		String sql ="select*from( "
						+ "select rownum rn, TMP. * from( "
						+ "select*from address_list where instr(#1,?)>0 "
						+ ")TMP) "
					+ "where rn between ? and ?";
		sql=sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, start_row);
		ps.setInt(3, end_row);
		
		
		ResultSet rs = ps.executeQuery();
		
		List<AddressListDto> list = new ArrayList<>();
		
		
		
		while(rs.next()) {
			AddressListDto addressListDto = new AddressListDto();
			addressListDto.setDepartment(rs.getString("department"));
			addressListDto.setPosi(rs.getString("posi"));
			addressListDto.setEmp_name(rs.getString("emp_name"));
			addressListDto.setEmp_phone(rs.getString("emp_phone"));
			addressListDto.setEmail(rs.getString("email"));
			addressListDto.setEmp_no(rs.getString("emp_no"));
			
			list.add(addressListDto);
			
		}
		con.close();
		return list;
		
	}
	
	//페이지블럭 계산 위한 카운트기능 : 1. list
	public int getCount() throws Exception {
		Connection con=jdbcUtils.getConnection();
		String sql ="select count(*)from address_list";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	//페이지블럭 계산 위한 카운트기능 : 2. search
			public int getCount(String type, String keyword) throws Exception {
				Connection con=jdbcUtils.getConnection();
				String sql ="select count(*)from address_list where instr(#1, ?)>0";
				sql=sql.replace("#1", type);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1,keyword);
				ResultSet rs = ps.executeQuery();
				rs.next();
				int count = rs.getInt(1);
				
				con.close();
				return count;
		}
}
