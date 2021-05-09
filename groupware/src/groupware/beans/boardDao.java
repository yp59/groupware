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
		
		String sql = "select B.*,E.emp_name from board B "
				+ "inner join employees E "
				+ "on E.emp_no = B.emp_no order by bo_date desc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		List<boardDto> list= new ArrayList();
		while(rs.next()) {
			boardDto boarddto = new boardDto();
			boarddto.setBoardNo(rs.getInt("board_no"));
			boarddto.setEmpNo(rs.getString("emp_no"));
			boarddto.setBoTitle(rs.getString("bo_title"));
			boarddto.setBoType(rs.getString("bo_type"));
			boarddto.setBoContent(rs.getString("bo_content"));
			boarddto.setBoCount(rs.getInt("bo_count"));
			boarddto.setBoDate(rs.getString("bo_date"));
			boarddto.setEmpName(rs.getString("emp_name"));
			
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	public void registration(boardDto boarddto)throws Exception{
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		//글 작성자 자동으로 찾게 해야함 아직 로그인 구현 못해서 못만듬 (구현 완료)
		String sql = "insert into board values(board_seq.nextval,?,?,?,?,0,sysdate)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boarddto.getEmpNo());
		ps.setString(2, boarddto.getBoTitle());
		ps.setString(3, boarddto.getBoType());
		ps.setString(4, boarddto.getBoContent());
		
		ps.executeUpdate();
		
		con.close();
	}
	
	public boardDto detail(int boardNo)throws Exception{
		
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "select"
				+ " B.*,E.emp_name"
				+ " from board B"
				+ " inner join employees E on E.emp_no = B.emp_no"
				+ " where board_no =?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, boardNo);
		
		ResultSet rs = ps.executeQuery();
		
		boardDto boarddto;
		if(rs.next()) {
			boarddto= new boardDto();
			
			boarddto.setBoardNo(rs.getInt(1));
			boarddto.setEmpNo(rs.getString(2));// 21/05/09 게시판 수정 삭제 권한 
			boarddto.setBoTitle(rs.getString(3));
			boarddto.setBoType(rs.getString(4));
			boarddto.setBoContent(rs.getString(5));
			boarddto.setBoCount(rs.getInt(6));
			boarddto.setBoDate(rs.getString(7));
			boarddto.setEmpName(rs.getString(8));
			
		}
		else {
			boarddto=null;
			}
		
		con.close();	
	
	return boarddto;
	}
	
	public void Delete(int boardNo)throws Exception{
		
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "delete board where board_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, boardNo);
		
		ps.executeUpdate();
		
		con.close();
		
	}
	
	public void edit(boardDto boarddto)throws Exception{
		
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "update board set"
				+ " bo_title=?,"
				+ " bo_type=?,"
				+ " bo_content=?"
				+ " where board_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, boarddto.getBoTitle());
		ps.setString(2, boarddto.getBoType());
		ps.setString(3, boarddto.getBoContent());
		ps.setInt(4, boarddto.getBoardNo());
		
		ps.executeUpdate();
		
		con.close();
	}
	
	public void BoConunt(int boardNo) throws Exception {
		
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "update board set bo_count = bo_count + 1 where board_No =" + boardNo;
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		con.close();
	}
	
	
}
