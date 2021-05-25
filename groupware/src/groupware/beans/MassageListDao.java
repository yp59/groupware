package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MassageListDao {

	
	//메세지 수신자 목록
	public List<MassageListDto> list_receiver(String m_receiver) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select*from massage_list where m_receiver=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, m_receiver);
		ResultSet rs = ps.executeQuery();
		
		List<MassageListDto> list = new ArrayList<>();
		
		while(rs.next()) {
			MassageListDto massageListDto = new MassageListDto();
			massageListDto.setM_no(rs.getInt("m_no"));
			massageListDto.setM_name(rs.getString("m_name"));
			massageListDto.setM_date(rs.getDate("m_date"));
			massageListDto.setM_content(rs.getString("m_content"));
			massageListDto.setE2_name(rs.getString("e2_name")); //수신자
			massageListDto.setEmp_name(rs.getString("emp_name"));//발신자
			
			list.add(massageListDto);
			
		}
		
		con.close();
		return list;
	
		
	}
	//메세지 발신자 목록
	public List<MassageListDto> list_sender(String empNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select*from massage_list where emp_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ResultSet rs = ps.executeQuery();
		
		List<MassageListDto> list = new ArrayList<>();
		
		while(rs.next()) {
			MassageListDto massageListDto = new MassageListDto();
			massageListDto.setM_no(rs.getInt("m_no"));
			massageListDto.setM_name(rs.getString("m_name"));
			massageListDto.setM_date(rs.getDate("m_date"));
			massageListDto.setM_content(rs.getString("m_content"));
			massageListDto.setM_receiver(rs.getString("m_receiver")); //수신자
			massageListDto.setEmp_name(rs.getString("emp_name"));//발신자
			
			list.add(massageListDto);
			
		}
		
		con.close();
		return list;
	
		
	}
	
}
