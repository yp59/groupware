package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class approvalDao {

	public void approvalInsert(approvalDto approvaldto)throws Exception{
	Connection con = jdbcUtils.getConnection();	
	
	String sql = "insert into approval values(app_seq.nextval,?,?,?,?,?,'상신')";
		//결재 상태 기본 상신으로 설정
	PreparedStatement ps =con.prepareStatement(sql);
	
	ps.setString(1,approvaldto.getDrafter());
	ps.setString(2, approvaldto.getAppTitle());
	ps.setString(3, approvaldto.getAppContent());
	ps.setString(4, approvaldto.getAppDateStart());
	ps.setString(5, approvaldto.getAppDateEnd());
	
	ps.executeUpdate();
	
	
	con.close();
	}
	
	public int pkKeyValue(String drafter)throws Exception{//approval PK값을 구해서 direct indirect 외래키 넣을 값을 구한다.
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select max(app_no) from"
				+ " approval where drafter= ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, drafter);
		
		ResultSet rs = ps.executeQuery();
		
		int number;
		
		if(rs.next()) {
			number =rs.getInt("max(app_no)");//집계함수 coulmn값 주의
		}
		else {
			number = 0;
		}
			
		con.close();
		
		return number;
	}
	
	public List<approvalDto> approvalList(String id)throws Exception{//session id값으로 기안 목록 조회
		Connection con = jdbcUtils.getConnection();
		
		String sql= "select A.*,E.emp_name from approval A inner join"
				+ 	" employees E on E.emp_no = A.drafter"
				+ 	" where A.drafter = ?"
				+ 	" order by app_date_start desc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		List<approvalDto> list = new ArrayList<>();
		
		while(rs.next()) {
			approvalDto approvaldto = new approvalDto();
			
			approvaldto.setAppNo(rs.getInt(1));
			approvaldto.setDrafter(rs.getString(2));
			approvaldto.setAppTitle(rs.getString(3));
			approvaldto.setAppContent(rs.getString(4));
			approvaldto.setAppDateStart(rs.getString(5));
			approvaldto.setAppDateEnd(rs.getString(6));
			approvaldto.setAppState(rs.getString(7));
			approvaldto.setEmpName(rs.getString(8));
			list.add(approvaldto);
		
		}
		con.close();
		return list;
	}
	
	public List<approvalDto> approvalList(String id, int startRow, int endRow)throws Exception{//session id값으로 기안 목록 조회
		Connection con = jdbcUtils.getConnection();
		
		String sql= "select * from ("
				+ " select rownum rn, A.*, E.emp_name"
				+ " from approval A"
				+ " inner join employees E on"
				+ " A.drafter = E.emp_no"
				+ " where A.drafter = ?)"
				+ " where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, id);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		
		ResultSet rs = ps.executeQuery();
		
		List<approvalDto> list = new ArrayList<>();
		
		while(rs.next()) {
			approvalDto approvaldto = new approvalDto();
			
			approvaldto.setAppNo(rs.getInt(2));//rownum 이 column 1이므로 2부터 시작
			approvaldto.setDrafter(rs.getString(3));
			approvaldto.setAppTitle(rs.getString(4));
			approvaldto.setAppContent(rs.getString(5));
			approvaldto.setAppDateStart(rs.getString(6));
			approvaldto.setAppDateEnd(rs.getString(7));
			approvaldto.setAppState(rs.getString(8));
			approvaldto.setEmpName(rs.getString(9));
			list.add(approvaldto);
		
		}
		con.close();
		return list;
	}
	
	
	//메인 결재현황 리스트
	public List<approvalDto> approvalMainList(String id, int startRow, int endRow)throws Exception{//session id값으로 기안 목록 조회
		Connection con = jdbcUtils.getConnection();
		
		String sql= "select * from("
				+ "	select rownum rn,TMP.* from ("
				+ "	select A.*,D.type,E.emp_name from approval A"
				+ " inner join directapp D"
				+ " on D.app_no = A.app_no"
				+ " inner join employees E"
				+ " on A.drafter = E.emp_no"
				+ " where D.approval = ?"
				+ "	)TMP"
				+ "	)where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, id);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		
		ResultSet rs = ps.executeQuery();
		
		List<approvalDto> list = new ArrayList<>();
		
		while(rs.next()) {
			approvalDto approvaldto = new approvalDto();
			
			approvaldto.setAppNo(rs.getInt(2));//rownum 이 column 1이므로 2부터 시작
			approvaldto.setDrafter(rs.getString(3));
			approvaldto.setAppTitle(rs.getString(4));
			approvaldto.setAppContent(rs.getString(5));
			approvaldto.setAppDateStart(rs.getString(6));
			approvaldto.setAppDateEnd(rs.getString(7));
			approvaldto.setAppState(rs.getString(8));
			approvaldto.setDirType(rs.getString(9));
			approvaldto.setEmpName(rs.getString(10));
			list.add(approvaldto);
		
		}
		con.close();
		return list;
	}
	
	public List<approvalDto> approvalSearch(String id , String keyword, int startRow, int endRow)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql= "select * from ("
				+ " select rownum rn, A.*, E.emp_name"
				+ " from approval A"
				+ " inner join employees E on"
				+ " A.drafter = E.emp_no"
				+ " where A.drafter = ? and instr(app_title,?)>0)"
				+ " where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, keyword);
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
		
		ResultSet rs = ps.executeQuery();
		
		List<approvalDto> list = new ArrayList<>();
		
		while(rs.next()) {
			approvalDto approvaldto = new approvalDto();
			
			approvaldto.setAppNo(rs.getInt(2));//rownum 이 column 1이므로 2부터 시작
			approvaldto.setDrafter(rs.getString(3));
			approvaldto.setAppTitle(rs.getString(4));
			approvaldto.setAppContent(rs.getString(5));
			approvaldto.setAppDateStart(rs.getString(6));
			approvaldto.setAppDateEnd(rs.getString(7));
			approvaldto.setAppState(rs.getString(8));
			approvaldto.setEmpName(rs.getString(9));
			list.add(approvaldto);
		
		}
		con.close();
		
		return list;
	}
	
	//결재 메인 검색
	public List<approvalDto> approvalMainSearch(String id , String keyword, int startRow, int endRow)throws Exception{
		Connection con = jdbcUtils.getConnection();

		String sql= "select * from("
				+ "	select rownum rn,TMP.* from ("
				+ "	select A.*,D.type,E.emp_name from approval A"
				+ " inner join directapp D"
				+ " on D.app_no = A.app_no"
				+ " inner join employees E"
				+ " on A.drafter = E.emp_no"
				+ " where D.approval = ? and instr(A.app_title,?)>0"
				+ "	)TMP"
				+ "	)where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, keyword);
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
		
		ResultSet rs = ps.executeQuery();
		
		List<approvalDto> list = new ArrayList<>();
		
		while(rs.next()) {
			approvalDto approvaldto = new approvalDto();
			
			approvaldto.setAppNo(rs.getInt(2));//rownum 이 column 1이므로 2부터 시작
			approvaldto.setDrafter(rs.getString(3));
			approvaldto.setAppTitle(rs.getString(4));
			approvaldto.setAppContent(rs.getString(5));
			approvaldto.setAppDateStart(rs.getString(6));
			approvaldto.setAppDateEnd(rs.getString(7));
			approvaldto.setAppState(rs.getString(8));
			approvaldto.setDirType(rs.getString(9));
			approvaldto.setEmpName(rs.getString(10));
			list.add(approvaldto);
		
		}
		con.close();
		
		return list;
	}
	
	
	//작성한 기안서 수 출력
	public int getCount(String id)throws Exception{
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select count(*) from approval where drafter = ?";
	
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		int count;
		if(rs.next()) {
			count = rs.getInt(1);
		}
		else {
			count=0;
		}
	return count;
	}
	//작성한 기안서 수 중 검색한 문서 출력
	public int getCount(String id, String keyword)throws Exception{//검색한 기안서의 수를 출력
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select count(*) from approval where instr(app_title,?)>0 and approval = ?";
	
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, keyword);
		ps.setString(2, id);
		ResultSet rs = ps.executeQuery();
		
		int count;
		if(rs.next()) {
			count = rs.getInt(1);
		}
		else {
			count=0;
		}
	return count;
	}

	//결재할 기안서 수 출력
		public int getMainCount(String id)throws Exception{
			
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from directapp where approval = ?";
		
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			int count;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			else {
				count=0;
			}
		return count;
		}
		//결재할 기안서 중 검색한 문서 수 출력
		public int getMainCount(String id, String keyword)throws Exception{//검색한 기안서의 수를 출력
			
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from approval A"
					+ " inner join directapp D"
					+ " on A.app_no = D.app_no"
					+ " where instr(A.app_title,?)>0 and D.approval = ?";
		
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, keyword);
			ps.setString(2, id);
			ResultSet rs = ps.executeQuery();
			
			int count;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			else {
				count=0;
			}
		return count;
		}
	
}
