package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class directAppDao {

	public void directInsert(directAppDto directappdto)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "insert into directapp values(dir_seq.nextval,?,?,'미결',?,'')";

		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, directappdto.getAppNo());
		ps.setString(2, directappdto.getApproval());
		ps.setString(3, directappdto.getConsesus());
		
		ps.executeUpdate();
		
		con.close();
	}
	
	//approvaldetail에서 기안서 내용 조회값(결재자 합의자 출력)
	public List<directAppDto> draftDoc(int appNo)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql= "select D.*, E.emp_name from"
				+ " directapp D inner join employees E"
				+ " on D.approval = E.emp_no"
				+ " where D.app_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, appNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<directAppDto> list = new ArrayList<>();
		
		while(rs.next()) {
			directAppDto directappdto =new directAppDto();
			directappdto.setApprovalNo(rs.getInt(1));
			directappdto.setAppNo(rs.getInt(2));
			directappdto.setApproval(rs.getString(3));
			directappdto.setType(rs.getString(4));
			directappdto.setConsesus(rs.getString(5));
			directappdto.setAppDate(rs.getString(6));
			directappdto.setEmpName(rs.getString(7));

			list.add(directappdto);
		}
		con.close();
		
		return list;
	}
	
	
public List<directAppDto> sequence(int appNo)throws Exception{//전체 결재자 순서
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = "select * from ("
				+ "    select rownum rn,TMP.* from("
				+ "            select * from("
				+ "                        select D.*,E.po_no from directapp D"
				+ "                        inner join employees E"
				+ "                        on D.approval = E.emp_no"
				+ "                        where D.app_no =? and consesus ='1'"
				+ "                        order by po_no desc)"
				+ "                        union all"
				+ "            select * from"
				+ "                        ( select D.*,E.po_no from directapp D"
				+ "                        inner join employees E"
				+ "                        on D.approval = E.emp_no"
				+ "                        where D.app_no =? and consesus ='0'"
				+ "                        order by po_no desc)"
				+ "                         )"
				+ "                         TMP)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, appNo);
		ps.setInt(2, appNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<directAppDto> list = new ArrayList<>();
		
		while(rs.next()) {
			directAppDto directappdto =new directAppDto();
			directappdto.setRowNo(rs.getInt(1));
			directappdto.setApprovalNo(rs.getInt(2));
			directappdto.setAppNo(rs.getInt(3));
			directappdto.setApproval(rs.getString(4));
			directappdto.setType(rs.getString(5));
			directappdto.setConsesus(rs.getString(6));
			directappdto.setAppDate(rs.getString(7));
			directappdto.setPoNo(rs.getInt(8));
			
			list.add(directappdto);
			
		}
		return list;
	}

public directAppDto sequence(int appNo,String id)throws Exception{//내 결재 위치 
	
	Connection con = jdbcUtils.getConnection();
	
	String sql = "select * from ("
			+ "    select rownum rn,TMP.* from("
			+ "            select * from("
			+ "                        select D.*,E.po_no from directapp D"
			+ "                        inner join employees E"
			+ "                        on D.approval = E.emp_no"
			+ "                        where D.app_no =? and consesus ='1'"
			+ "                        order by po_no desc)"
			+ "                        union all"
			+ "            select * from"
			+ "                        ( select D.*,E.po_no from directapp D"
			+ "                        inner join employees E"
			+ "                        on D.approval = E.emp_no"
			+ "                        where D.app_no =? and consesus ='0'"
			+ "                        order by po_no desc)"
			+ "                         )"
			+ "                         TMP) where approval = ?";
	
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setInt(1, appNo);
	ps.setInt(2, appNo);
	ps.setString(3, id);
	ResultSet rs = ps.executeQuery();
	
	
	directAppDto directappdto =new directAppDto();
	while(rs.next()) {
		
		directappdto.setRowNo(rs.getInt(1));
		directappdto.setApprovalNo(rs.getInt(2));
		directappdto.setAppNo(rs.getInt(3));
		directappdto.setApproval(rs.getString(4));
		directappdto.setType(rs.getString(5));
		directappdto.setConsesus(rs.getString(6));
		directappdto.setAppDate(rs.getString(7));
		directappdto.setPoNo(rs.getInt(8));
	
	}
	return directappdto;
}

}
