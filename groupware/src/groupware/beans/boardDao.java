package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class boardDao {

	public static final String USERNAME = "kh75";
	public static final String PASSWORD = "kh75";
	
	// 게시글 목록
	public List<boardDto> boardList()throws Exception{
		Connection con = jdbcUtils.getConnection();
		 
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
			boarddto.setComComments(rs.getInt("bo_comments"));
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	
	// 페이지네이션 1

	public List<boardDto> boardList(int startRow , int endRow)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from("
				+ " select rownum rn,TMP.* from ("
				+ " select"
				+ " B.*,E.emp_name"
				+ " from board B"
				+ " inner join employees E on E.emp_no = B.emp_no"
				+ " order by bo_date desc"
				+ " )TMP"
				+ " )where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		
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
			boarddto.setComComments(rs.getInt("bo_comments"));
			
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	
	// 페이지네이션 2
	public List<boardDto> boardList(int startRow , int endRow, String boType)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from("
				+ " select rownum rn,TMP.* from ("
				+ " select"
				+ " B.*,E.emp_name"
				+ " from board B"
				+ " inner join employees E on E.emp_no = B.emp_no"
				+ " where bo_type = ?"
				+ " order by bo_date desc"
				+ " )TMP"
				+ " )where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boType);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		
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
			boarddto.setComComments(rs.getInt("bo_comments"));
			
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	
	// 게시글 등록
	public void registration(boardDto boarddto)throws Exception{
		Connection con = jdbcUtils.getConnection();
		String sql = "insert into board values(board_seq.nextval,?,?,?,?,0,sysdate,0)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boarddto.getEmpNo());
		ps.setString(2, boarddto.getBoTitle());
		ps.setString(3, boarddto.getBoType());
		ps.setString(4, boarddto.getBoContent());
		
		ps.executeUpdate();
		
		con.close();
	}
	
	// 게시글 상세보기
	public boardDto detail(int boardNo)throws Exception{
		
		Connection con = jdbcUtils.getConnection();
		
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
			boarddto.setEmpName(rs.getString("emp_name"));
			boarddto.setComComments(rs.getInt("bo_comments"));
			
		}
		else {
			boarddto=null;
			}
		
		con.close();	
	
	return boarddto;
	}
	
	// 게시글 삭제
	public void Delete(int boardNo)throws Exception{
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = "delete board where board_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, boardNo);
		
		ps.executeUpdate();
		
		con.close();
		
	}
	
	// 게시글 수정
	public void edit(boardDto boarddto)throws Exception{
		
		Connection con = jdbcUtils.getConnection();
		
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
	// 게시판 조회수
	public boolean boCount(int boardNo, String empNo) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql = "update board "
							+ "set bo_count = bo_count + 1 "
							+ "where board_no = ? and emp_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ps.setString(2, empNo);
		int count = ps.executeUpdate(); 
		
		con.close();
		
		return count > 0;
	}
	
	// 게시판 검색 창-1
	public List<boardDto> boardSearch(String boType,String type,String keyword)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select BOT.* from(select B.*,E.emp_name from"
				+ " board B inner join employees E"
				+ " on B.emp_no = E.emp_no"
				+ " where bo_type = ?) BOT"
				+ " where instr("+type+",?)>0";//게시판 검색 시 타입을 선택해서 제목, 내용, 작성자를 검색 할 수 있다.
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, boType);
		ps.setString(2, keyword);
		
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
			boarddto.setComComments(rs.getInt("bo_comments"));
			
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	
	// 게시판 검색 창 - 2
	public List<boardDto> boardSearch(String type,String keyword)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select BOT.* from(select B.*,E.emp_name from"
				+ " board B inner join employees E"
				+ " on B.emp_no = E.emp_no"
				+ " ) BOT"
				+ " where instr("+type+",?)>0";//게시판 검색 시 타입이 전체일 경우 제목, 내용, 작성자를 검색 할 수 있다.
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, keyword);
		
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
			boarddto.setComComments(rs.getInt("bo_comments"));
			
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	
	// 게시판 검색 3
	public List<boardDto> boardSearch(String type,String keyword ,int startRow , int endRow)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql ="select * from("
				+ " select rownum rn,TMP.* from (" 
				+ " select BOT.* from(select B.*,E.emp_name from"
				+ " board B inner join employees E"
				+ " on B.emp_no = E.emp_no"
				+ " ) BOT"
				+ " where instr("+type+",?)>0"
				+ " )TMP"
				+ " )where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		
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
			boarddto.setComComments(rs.getInt("bo_comments"));
			
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	
	// 페이지 검색 4
	public List<boardDto> boardSearch(String boType,String type,String keyword, int startRow,int endRow)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql ="select * from("
				+ " select rownum rn,TMP.* from (" 
				+ " select BOT.* from(select B.*,E.emp_name from"
				+ " board B inner join employees E"
				+ " on B.emp_no = E.emp_no"
				+ " where bo_type = ?) BOT"
				+ " where instr("+type+",?)>0"
				+ " )TMP"
				+ " )where rn between ? and ?";//게시판 검색 시 타입을 선택해서 제목, 내용, 작성자를 검색 할 수 있다.
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, boType);
		ps.setString(2, keyword);
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
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
			boarddto.setComComments(rs.getInt("bo_comments"));
			
			list.add(boarddto);
		}
		
		con.close();
		
		return list;
	}
	
	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
		public int getCount() throws Exception {
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from board";//공지는 1페이지 상단에 나타나기 떄문에 제외하고 게시글 수 구한다.
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			con.close();
			
			return count;
		}
		
		public int getCount(String boType, String type, String keyword) throws Exception {
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from"
					+ " (select * from board B"
					+ " inner join employees E on B.emp_no=E.emp_no"
					+ " where bo_type = ?)"
					+ " where instr("+type+", ?) > 0";
		
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, boType);
			ps.setString(2, keyword);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			con.close();
			
			return count;
		}
		
		public int getCount(String type, String keyword) throws Exception {
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from"
					+ " (select * from board B"
					+ " inner join employees E on B.emp_no=E.emp_no)"
					+ " where instr("+type+", ?) > 0";
		
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, keyword);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			con.close();
			
			return count;
		}
		
		public int getCount(String boType) throws Exception {
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from board where bo_type=?";//공지는 1페이지 상단에 나타나기 떄문에 제외하고 게시글 수 구한다.
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, boType);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			con.close();
			
			return count;
		}
		
		//댓글 개수 갱신 기능
		public boolean refreshBoardComments(int boardNo) throws Exception {
			Connection con = jdbcUtils.getConnection();;
			String sql = "update board "
								+ "set bo_comments = ( select count(*) from comments where board_no = ? ) "
								+ "where board_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, boardNo);
			ps.setInt(2, boardNo);
			int count = ps.executeUpdate();
			con.close();
			return count > 0;
		}
		
		// 이전글 조회 기능
		public boardDto getPrevious(int boardNo) throws Exception {
			Connection con = jdbcUtils.getConnection();
			String sql = "select * from board "
							+ "where board_no = ( select max(board_no) from board where board_no < ? )";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, boardNo);
			ResultSet rs = ps.executeQuery();
			boardDto boarddto;
			if(rs.next()) {
				boarddto = new boardDto();
				boarddto.setBoardNo(rs.getInt("board_no"));
				boarddto.setEmpNo(rs.getString("emp_no"));
				boarddto.setBoTitle(rs.getString("bo_title"));
				boarddto.setBoType(rs.getString("bo_type"));
				boarddto.setBoContent(rs.getString("bo_content"));
				boarddto.setBoCount(rs.getInt("bo_count"));
				boarddto.setBoDate(rs.getString("bo_date"));
				boarddto.setComComments(rs.getInt("bo_comments"));
			}
			
			else {
			boarddto = null;	
			}
			
			con.close();
			
			return boarddto;
		}
		// 다음글 조회 기능
		public boardDto getNext(int boardNo) throws Exception {
			Connection con = jdbcUtils.getConnection();
			String sql = "select * from board "
							+ "where board_no = ( select min(board_no) from board where board_no > ? )";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, boardNo);
			ResultSet rs = ps.executeQuery();
			boardDto boarddto;
			if(rs.next()) {
				boarddto = new boardDto();
				boarddto.setBoardNo(rs.getInt("board_no"));
				boarddto.setEmpNo(rs.getString("emp_no"));
				boarddto.setBoTitle(rs.getString("bo_title"));
				boarddto.setBoType(rs.getString("bo_type"));
				boarddto.setBoContent(rs.getString("bo_content"));
				boarddto.setBoCount(rs.getInt("bo_count"));
				boarddto.setBoDate(rs.getString("bo_date"));
				boarddto.setComComments(rs.getInt("bo_comments"));
			}
			
			else {
			boarddto = null;	
			}
			
			con.close();
			
			return boarddto;
		}
		
		//자신이 작성한 게시글 조회 기능
		public List<boardDto> searchByWriter(String empNo, int startRow, int endRow) throws Exception {
			Connection con = jdbcUtils.getConnection();;
			
			String sql = "select * from("
					+ "select rownum rn, TMP.* from("
					+ "select * from board"
					+ " where emp_no = ?"
					+ "order by board_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
								
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, empNo);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			ResultSet rs = ps.executeQuery();
			
			List<boardDto> list = new ArrayList<>();
			while(rs.next()) {
				boardDto boarddto = new boardDto();
				boarddto.setBoardNo(rs.getInt("board_no"));
				boarddto.setEmpNo(rs.getString("emp_no"));
				boarddto.setBoTitle(rs.getString("bo_title"));
				boarddto.setBoType(rs.getString("bo_type"));
				boarddto.setBoContent(rs.getString("bo_content"));
				boarddto.setBoCount(rs.getInt("bo_count"));
				boarddto.setBoDate(rs.getString("bo_date"));
				boarddto.setComComments(rs.getInt("bo_comments"));
				list.add(boarddto);
			}
			
			con.close();
			
			return list;
		}
		
	//index 에 최근 공지 띄움	
	public List<boardDto> topNotice()throws Exception{
	Connection con = jdbcUtils.getConnection();
	
	String sql = "select * from("
			+ " select rownum rn , TMP.* from("
			+ " select B.bo_title,E.emp_name,B.bo_date,B.board_no"
			+ " from board B"
			+ " inner join employees E on"
			+ " B.emp_no = E.emp_no"
			+ " where bo_type = '공지'"
			+ " order by board_no desc)TMP"
			+ " )where rn between 1 and 3";
		
	PreparedStatement ps = con.prepareStatement(sql);
	
	ResultSet rs = ps.executeQuery();
	List<boardDto> list = new ArrayList<>();
	while(rs.next()) {
		boardDto boarddto = new boardDto();
		boarddto.setBoTitle(rs.getString(2));
		boarddto.setEmpName(rs.getString(3));
		boarddto.setBoDate(rs.getString(4));
		boarddto.setBoardNo(rs.getInt(5));
		list.add(boarddto);
	}
	return list;
	
	}
}
