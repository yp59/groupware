package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class boardDao {

	public static final String USERNAME = "kh75";
	public static final String PASSWORD = "kh75";
	
	public List<boardDto> boardList()throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "select * from board";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		List<boardDto> list= new ArrayList();
		while(rs.next()) {
			boardDto boarddto = new boardDto();
			boarddto.setBoardNo(rs.getInt("board_no"));
			boarddto.setEmpNo(rs.getInt("emp_no"));
			boarddto.setBoTitle(rs.getString("bo_title"));
			boarddto.setBoType(rs.getString("bo_type"));
			boarddto.setBoContent(rs.getString("bo_content"));
			boarddto.setBoCount(rs.getInt("bo_count"));
			boarddto.setBoDate(rs.getString("bo_date"));

			list.add(boarddto);
		}
		
		return list;
	}
}
