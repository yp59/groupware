package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MassageFileDao {

	public void insert(MassageFileDto massageFileDto) throws Exception {
		
		Connection con =jdbcUtils.getConnection();
		
		String sql="insert into massage_file values (massage_file_seq.nextval,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,massageFileDto.getFile_upload_name());
		ps.setString(2, massageFileDto.getFile_save_name());
		ps.setString(3, massageFileDto.getFile_content_type());
		ps.setLong(4, massageFileDto.getFile_size());
		ps.setInt(5, massageFileDto.getFile_origin());
		
		ps.execute();
		con.close();
	}
	
	
	
	// 첨부 파일 정보 ( 내용 미포함) + 메시지(테이블) 단일조회
	public MassageFileDto detail(int m_no)throws Exception {
		Connection con= jdbcUtils.getConnection();
		String sql ="select m.m_no, m.m_name, e1.emp_name, e1.emp_no, e2.emp_name as e2_name, e2.emp_no as e2_no, "
				+ "m.m_date, m.m_content, mf.file_no, mf.file_upload_name, mf.file_save_name, mf.file_content_type, "
				+ "mf.file_size, mf.file_origin "
				+ "from massage m "
				+ "left outer join employees E1 on m.emp_no = e1.emp_no "
				+ "left outer join employees E2 on M.receiver_no= E2.emp_no "
				+ "left outer join massage_file mf on mf.file_origin = m.m_no "
				+ "where m_no=?";
		
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setInt(1, m_no);
		ResultSet rs =ps.executeQuery();
		
		
		MassageFileDto massageFileDto = new MassageFileDto();
		if(rs.next()) {
			massageFileDto.setM_no(rs.getInt("m_no"));
			massageFileDto.setM_name(rs.getString("m_name"));
			massageFileDto.setEmp_name(rs.getString("emp_name"));
			massageFileDto.setEmpNo(rs.getString("emp_no"));
			massageFileDto.setE2_name(rs.getString("e2_name"));
			massageFileDto.setE2_no(rs.getString("e2_no"));
			massageFileDto.setM_date(rs.getDate("m_date"));
			massageFileDto.setM_content(rs.getString("m_content"));
			massageFileDto.setFile_no(rs.getInt("file_no"));
			massageFileDto.setFile_upload_name(rs.getString("file_upload_name"));
			massageFileDto.setFile_save_name(rs.getString("file_save_name"));
			massageFileDto.setFile_content_type(rs.getString("file_content_type"));
			massageFileDto.setFile_size(rs.getLong("file_size"));
			massageFileDto.setFile_origin(rs.getInt("file_origin"));
				
		}else {
			
			massageFileDto=null;
			
		}
		con.close();
		return massageFileDto;
	}
	
	// 파일테이블 단일조회(int file_no)
	public MassageFileDto getByFileNo(int file_no) throws Exception {
		Connection con =jdbcUtils.getConnection();
		String sql ="select*from massage_file where file_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ResultSet rs = ps.executeQuery();
		
		MassageFileDto massageFileDto;
		if(rs.next()) {
			massageFileDto = new MassageFileDto();
			massageFileDto.setFile_no(rs.getInt("file_no"));
			massageFileDto.setFile_upload_name(rs.getString("file_upload_name"));
			massageFileDto.setFile_save_name(rs.getString("file_save_name"));
			massageFileDto.setFile_content_type(rs.getString("file_content_type"));
			massageFileDto.setFile_size(rs.getLong("file_size"));
			massageFileDto.setFile_origin(rs.getInt("file_origin"));
			
		}else {
			massageFileDto=null;
			
		}
		
		con.close();
		return massageFileDto;
		
	}
}
