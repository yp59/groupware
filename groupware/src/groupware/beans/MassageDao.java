package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MassageDao {
	
	//메세지 입력창
	
	public void insert(MassageDto massageDto) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql ="insert into  massage values (massage_seq.nextval,?,?,sysdate,?,?)";
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setString(1, massageDto.getEmpNo());
		ps.setString(2, massageDto.getM_name());
		ps.setString(3, massageDto.getM_content());
		ps.setString(4, massageDto.getReceiver_no());
		
		ps.execute();
		
		con.close();
		
		
	}
	
	
	
	//디테일 조회 detail
	public MassageDto detail (String empNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql ="select*from massage where emp_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		
		ResultSet rs = ps.executeQuery();
		
		
		MassageDto massageDto = new MassageDto();
		if(rs.next()) {
			massageDto.setM_no(rs.getInt("m_no"));
			massageDto.setEmpNo(rs.getString("emp_no"));
			massageDto.setM_date(rs.getDate("m_date"));
			massageDto.setM_content(rs.getString("m_content"));
			massageDto.setReceiver_no(rs.getString("receiver_no"));
		}else {
			massageDto=null;
		}
		con.close();
		return massageDto;
		
		
	}


	
}
