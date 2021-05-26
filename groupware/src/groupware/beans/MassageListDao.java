package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MassageListDao {

	//수신자 번호 가져오는 메소드 : 수신자 이름을 통해 번호를 가져오는 메소드이다. 수신자 목록(list)에서 사용됨
	public MassageListDto getReceiver_no (String e2_name) throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select*from massage_list where e2_name=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, e2_name);
		
		ResultSet rs = ps.executeQuery();
		MassageListDto massageListDto; 
		
		if(rs.next()) {
			massageListDto= new MassageListDto();
//			massageListDto.setM_no(rs.getInt("m_no"));
//			massageListDto.setM_name(rs.getString("m_name"));
//			massageListDto.setM_date(rs.getDate("m_date"));
//			massageListDto.setM_content(rs.getString("m_content"));
//			massageListDto.setEmpNo(rs.getString("empNo"));
//			massageListDto.setEmp_name(rs.getString("emp_name"));//발신자 이름
//			massageListDto.setE2_name(rs.getString("e2_name"));
			massageListDto.setE2_no(rs.getString("e2_no"));

			
		}else {
			massageListDto=null;
		}
		con.close();
		return massageListDto;
		
		
	}
	
	
	//메세지 수신자 목록
	public List<MassageListDto> list_receiver(String m_receiver) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select*from massage_list where e2_no=? order by m_date desc";
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
			
			massageListDto.setEmp_name(rs.getString("emp_name"));//발신자 이름
			
			massageListDto.setE2_name(rs.getString("e2_name")); //수신자 이름
			
			
			list.add(massageListDto);
			
		}
		
		con.close();
		return list;
	
		
	}
	//메세지 발신자 목록
	public List<MassageListDto> list_sender(String empNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select*from massage_list where emp_no=? order by m_date desc";
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
			massageListDto.setE2_name(rs.getString("e2_name")); //수신자
			massageListDto.setEmp_name(rs.getString("emp_name"));//발신자
			
			list.add(massageListDto);
			
		}
		
		con.close();
		return list;
	
		
	}
	
	//detail : m_no를 통한 조회
	public MassageListDto detail (int m_no) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql ="select*from massage_list where m_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, m_no);
		
		ResultSet rs = ps.executeQuery();
		
		
		MassageListDto massageListDto = new MassageListDto();
		if(rs.next()) {
			massageListDto.setM_no(rs.getInt("m_no"));//번호
			massageListDto.setM_name(rs.getString("m_name"));//제목
			massageListDto.setEmp_name(rs.getString("emp_name"));//작성자
			massageListDto.setE2_no(rs.getString("e2_no"));//수신자 번호 : isReceiver 판단할 때 사용됨
			massageListDto.setE2_name(rs.getString("e2_name"));//수신자
			massageListDto.setM_date(rs.getDate("m_date"));//작성시간
			massageListDto.setM_content(rs.getString("m_content"));//작성내용
			
		}else {
			massageListDto=null;
		}
		con.close();
		return massageListDto;
		
		
	}
	
}
