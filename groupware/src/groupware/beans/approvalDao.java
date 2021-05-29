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
			
			list.add(approvaldto);
		
		}
		con.close();
		return list;
	}
	
}
