package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class indirectAppDao {

	public void indirectInsert(indirectAppDto indirectappdto)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "insert into indirectapp values(indir_seq.nextval,?,?,?)";

		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, indirectappdto.getAppNo());
		ps.setString(2, indirectappdto.getReferrer());
		ps.setString(3, indirectappdto.getType());
		
		ps.executeUpdate();
		
		con.close();
	}
	
	//approvaldetail에서 기안서 내용 조회값(참조자 시행자 출력)
	public List<indirectAppDto> draftDoc(int appNo)throws Exception{//session id값으로 기안 목록 조회
		Connection con = jdbcUtils.getConnection();
		
		String sql= "select I.*,E.emp_name from indirectapp I"
				+ " inner join employees E"
				+ " on I.referrer = E.emp_no"
				+ " where app_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, appNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<indirectAppDto> list = new ArrayList<>();
		
		while(rs.next()) {
			indirectAppDto indirectappdto =new indirectAppDto();
			
			indirectappdto.setReferrerNo(rs.getInt(1));
			indirectappdto.setAppNo(rs.getInt(2));
			indirectappdto.setReferrer(rs.getString(3));
			indirectappdto.setType(rs.getString(4));
			indirectappdto.setEmpName(rs.getString(5));
			list.add(indirectappdto);
		}
		con.close();
		
		return list;
	}
}
