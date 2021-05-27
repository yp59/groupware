package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class approvalDao {

	public void approvalInsert(approvalDto approvaldto)throws Exception{
	Connection con = jdbcUtils.getConnection();	
	
	String sql = "insert into approval values(app_seq.nextval,?,?,?,?,?,?,?,?,?,?,'상신')";
		
	PreparedStatement ps =con.prepareStatement(sql);
	
	
	ps.setString(1,approvaldto.getDrafter());//
	ps.setInt(2,approvaldto.getMidApprovalNo());//
	ps.setInt(3,approvaldto.getFinalApprovalNo());//
	ps.setInt(4,approvaldto.getConsesusNo());//
	ps.setInt(5,approvaldto.getReferrerNo());//
	ps.setInt(6,approvaldto.getImplementerNo());//
	ps.setString(7, approvaldto.getAppTitle());//
	ps.setString(8, approvaldto.getAppContent());//
	ps.setString(9, approvaldto.getAppDateStart());//
	ps.setString(10, approvaldto.getAppDateEnd());
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
			approvaldto.setMidApprovalNo(rs.getInt(3));
			approvaldto.setFinalApprovalNo(rs.getInt(4));
			approvaldto.setConsesusNo(rs.getInt(5));
			approvaldto.setReferrerNo(rs.getInt(6));
			approvaldto.setImplementerNo(rs.getInt(7));
			approvaldto.setAppTitle(rs.getString(8));
			approvaldto.setAppContent(rs.getString(9));
			approvaldto.setAppDateStart(rs.getString(10));
			approvaldto.setAppDateEnd(rs.getString(11));
			approvaldto.setAppState(rs.getString(12));
			
			list.add(approvaldto);
		
		}
		return list;
	}
	
}
