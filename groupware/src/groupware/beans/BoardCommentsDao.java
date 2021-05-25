package groupware.beans;

import java.io.Console;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardCommentsDao {
	public static final String USERNAME = "kh75";
	public static final String PASSWORD = "kh75";
	
	//댓글 등록 : 댓글내용, 원본글번호, 회원번호 --> 댓글정보
	public void insert(BoardCommentsDto boardCommentsDto) throws Exception {
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		String sql = "insert into comments values(com_seq.nextval, ?, ?, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardCommentsDto.getBoardNo());
		ps.setString(2, boardCommentsDto.getEmpNo());
		ps.setString(3, boardCommentsDto.getComContent());
		ps.execute();
		con.close();
	}
	
	//댓글 수정 : 댓글내용, 댓글번호, 회원번호 --> 댓글정보
	public boolean edit(BoardCommentsDto boardCommentsDto) throws Exception {
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		String sql = "update comments set com_content = ? where com_no = ? and emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardCommentsDto.getComContent());
		ps.setInt(2, boardCommentsDto.getComNo());
		ps.setString(3, boardCommentsDto.getEmpNo());
		int count = ps.executeUpdate();
		con.close();
		return count > 0;
	}
	
	//댓글 삭제 : 댓글번호, 회원번호 --> 댓글정보
	public boolean delete(BoardCommentsDto boardCommentsDto) throws Exception {
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		String sql = "delete comments where com_no = ? and emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardCommentsDto.getComNo());
		ps.setString(2, boardCommentsDto.getEmpNo());
		int count = ps.executeUpdate();
		con.close();
		return count > 0;
	}
	
	//댓글 리스트(사원번호)
	public List<BoardCommentsDto> list(int boardNo) throws Exception {
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		String sql = "select * from comments where board_no = ? order by com_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ResultSet rs = ps.executeQuery();
		
		List<BoardCommentsDto> boardCommentsList = new ArrayList<>();
		while(rs.next()) {
			BoardCommentsDto boardCommentsDto = new BoardCommentsDto();
			boardCommentsDto.setComNo(rs.getInt("com_no"));
			boardCommentsDto.setBoardNo(rs.getInt("board_no"));
			boardCommentsDto.setEmpNo(rs.getString("emp_no"));
			boardCommentsDto.setComContent(rs.getString("com_content"));
			boardCommentsDto.setDate(rs.getDate("com_date"));
			boardCommentsList.add(boardCommentsDto);
		}
		
		con.close();
		return boardCommentsList;
	}
	
	//댓글 리스트 (comments_view 사용, 이름연동)
		public List<BoardCommentsDto> list1(int boardNo) throws Exception {
			Connection con = jdbcUtils.con(USERNAME, PASSWORD);
			String sql = "select * from comments_view where board_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, boardNo);
			ResultSet rs = ps.executeQuery();
			
			List<BoardCommentsDto> boardCommentsList = new ArrayList<>();
			while(rs.next()) {
				BoardCommentsDto boardCommentsDto = new BoardCommentsDto();
				boardCommentsDto.setComNo(rs.getInt("com_no"));
				boardCommentsDto.setBoardNo(rs.getInt("board_no"));
				boardCommentsDto.setEmpNo(rs.getString("emp_no"));
				boardCommentsDto.setComContent(rs.getString("com_content"));
				boardCommentsDto.setDate(rs.getDate("com_date"));
				boardCommentsDto.setEmpName(rs.getString("emp_name"));
				boardCommentsList.add(boardCommentsDto);
			}
			
			con.close();
			return boardCommentsList;
		}
}
