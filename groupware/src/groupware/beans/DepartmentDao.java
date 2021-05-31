package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDao {
	
	
	//dep_name->dep_no 뽑아오는 메소드 :insertServlet 에서 사용
	public int getDep_no(String dep_name) throws Exception{
		
		Connection con = jdbcUtils.getConnection();
		String sql ="select dep_no from department where dep_name=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dep_name);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int dep_no=rs.getInt(1); // 이 코드가 맞는지 안맞는지 헷갈림..
		
		con.close();
		return dep_no;
		
	}
	
	public List<DepartmentDto> list()throws Exception {
		Connection con = jdbcUtils.getConnection();
		String sql ="select*from department";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs =ps.executeQuery();
		
		List<DepartmentDto> list = new ArrayList<>();
		while(rs.next()) {
			DepartmentDto departmentDto= new DepartmentDto();
			departmentDto.setDep_no(rs.getInt("dep_no"));
			departmentDto.setDep_name(rs.getString("dep_name"));
			
			list.add(departmentDto);
		}
		con.close();
		return list;
	}
}
