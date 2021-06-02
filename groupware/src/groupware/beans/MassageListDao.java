package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MassageListDao {

//	//수신자 번호 가져오는 메소드 : 수신자 이름을 통해 번호를 가져오는 메소드이다. 수신자 목록(list)에서 사용됨
//	public employeesDto getReceiver_no (String e2_name) throws Exception{
//		Connection con = jdbcUtils.getConnection();
//		
//		String sql = "select emp_no from employees where emp_name=?";
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setString(1, e2_name);
//		
//		ResultSet rs = ps.executeQuery();
//		employeesDto  empDto; 
//		
//		if(rs.next()) {
//			empDto= new employeesDto ();
////			massageListDto.setM_no(rs.getInt("m_no"));
////			massageListDto.setM_name(rs.getString("m_name"));
////			massageListDto.setM_date(rs.getDate("m_date"));
////			massageListDto.setM_content(rs.getString("m_content"));
////			massageListDto.setEmpNo(rs.getString("empNo"));
////			massageListDto.setEmp_name(rs.getString("emp_name"));//발신자 이름
////			massageListDto.setE2_name(rs.getString("e2_name"));
//			empDto.setEmpNo(rs.getString("e2_no"));
//
//			
//		}else {
//			empDto=null;
//		}
//		con.close();
//		return empDto;
//		
//		
//	} 
	//위의 메소드는 employeesDao로 옮김.
	
	
	//메세지 수신자 목록 : 페이지네이션으로 변경
	public List<MassageListDto> list_receiver(String e2_no, int start_row, int end_row) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select*from( "
						+ "select rownum rn, TMP.* from ( "
						+ "select*from massage_list where e2_no=? order by m_date desc "
						+ ")TMP "
					+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, e2_no);
		ps.setInt(2, start_row);
		ps.setInt(3, end_row);
		ResultSet rs = ps.executeQuery();
		
		List<MassageListDto> list = new ArrayList<>();
		   
		while(rs.next()) { //
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
	
	
	
	
	//메세지 발신자 목록 :페이지네이션으로 변경
	public List<MassageListDto> list_sender(String empNo, int start_row, int end_row) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select*from( "
						+ "select rownum rn, TMP.* from ( "
							+ "select*from massage_list where emp_no=? order by m_date desc "
						+ ")TMP "
					+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ps.setInt(2, start_row);
		ps.setInt(3, end_row);
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
//	public MassageListDto detail (int m_no) throws Exception {
//		Connection con = jdbcUtils.getConnection();
//		
//		String sql ="select*from massage_list where m_no=? ";
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setInt(1, m_no);
//		
//		ResultSet rs = ps.executeQuery();
//		
//		
//		MassageListDto massageListDto = new MassageListDto();
//		if(rs.next()) {
//			massageListDto.setM_no(rs.getInt("m_no"));//번호
//			massageListDto.setM_name(rs.getString("m_name"));//제목
//			massageListDto.setEmp_name(rs.getString("emp_name"));//작성자
//			massageListDto.setE2_no(rs.getString("e2_no"));//수신자 번호 : isReceiver 판단할 때 사용됨
//			massageListDto.setE2_name(rs.getString("e2_name"));//수신자
//			massageListDto.setM_date(rs.getDate("m_date"));//작성시간
//			massageListDto.setM_content(rs.getString("m_content"));//작성내용
//			
//		}else {
//			massageListDto=null;
//		}
//		con.close();
//		return massageListDto;
//		
//		
//	}
	
}
