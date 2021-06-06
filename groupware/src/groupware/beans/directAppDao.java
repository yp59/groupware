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
				+ " where D.app_no = ?"
				+ " order by po_no,join_date";
		
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
				+ "                        select D.*, E.po_no, E.join_date from directapp D"
				+ "                        inner join employees E"
				+ "                        on D.approval = E.emp_no"
				+ "                        where D.app_no =? and consesus ='1'"
				+ "                        order by po_no desc, join_date desc)"
				+ "                        union all"
				+ "            select * from"
				+ "                        ( select D.*, E.po_no, E.join_date from directapp D"
				+ "                        inner join employees E"
				+ "                        on D.approval = E.emp_no"
				+ "                        where D.app_no =? and consesus ='0'"
				+ "                        order by po_no desc, join_date desc)"
				+ "                         )"
				+ "                         TMP)";//직급을 기준으로 순서 정하고 직급이 같으면 입사일 순으로 결재 순서를 정한다.
												//union 안써도 됐었다....... order by 를 여러번 사용해도 되는 줄 몰랐다.
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
		con.close();
		return list;
	}

public directAppDto sequence(int appNo,String id)throws Exception{//내 결재 위치 
	
	Connection con = jdbcUtils.getConnection();
	
	String sql = "select * from ("
			+ "    select rownum rn,TMP.* from("
			+ "            select * from("
			+ "                        select D.*, E.po_no, E.join_date from directapp D"
			+ "                        inner join employees E"
			+ "                        on D.approval = E.emp_no"
			+ "                        where D.app_no =? and consesus ='1'"
			+ "                        order by po_no desc, join_date desc)"
			+ "                        union all"
			+ "            select * from"
			+ "                        ( select D.*, E.po_no, E.join_date from directapp D"
			+ "                        inner join employees E"
			+ "                        on D.approval = E.emp_no"
			+ "                        where D.app_no =? and consesus ='0'"
			+ "                        order by po_no desc, join_date desc)"
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
	con.close();
	return directappdto;
}

public void directUpdate(directAppDto directappdto)throws Exception{
	Connection con = jdbcUtils.getConnection();
	
	String sql = "update directapp set"
			+ " type = ? , app_date = sysdate"
			+ " where app_no =? and approval = ?"
			+ " and consesus = ?";
			
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, directappdto.getType());
	ps.setInt(2, directappdto.getAppNo());
	ps.setString(3, directappdto.getApproval());
	ps.setString(4, directappdto.getConsesus());
	
	ps.executeUpdate();
	
	
}
public List<directAppDto> appState(int appNo)throws Exception{
	Connection con = jdbcUtils.getConnection();
	
	String sql = "select type,app_date from ("
			+ "    select rownum rn,TMP.* from("
			+ "            select * from("
			+ "                        select A.*,D.approval,D.type,D.consesus,D.app_date,E.po_no from directapp D"
			+ "                        inner join approval A"
			+ "                        on A.app_no = D.app_no"
			+ "                        inner join employees E"
			+ "                        on D.approval = E.emp_no"
			+ "                        where A.app_no =? and consesus ='1'"
			+ "                        order by po_no desc)"
			+ "                        union all"
			+ "            select * from"
			+ "                        ( select A.*,D.approval,D.type,D.consesus,D.app_date,E.po_no from directapp D"
			+ "                        inner join  approval A"
			+ "                        on A.app_no = D.app_no"
			+ "                        inner join employees E"
			+ "                        on D.approval = E.emp_no"
			+ "                        where A.app_no =? and consesus ='0'"
			+ "                        order by po_no desc)"
			+ "                         )"
			+ "                         TMP)";
	
		PreparedStatement ps = con.prepareStatement(sql);
	
		ps.setInt(1, appNo);
		ps.setInt(2, appNo);
		ResultSet rs = ps.executeQuery();
		
		List<directAppDto> list = new ArrayList<>();
		while(rs.next()) {
			
		directAppDto directappdto = new directAppDto();
			
			directappdto.setType(rs.getString("type"));
			directappdto.setAppDate(rs.getString("app_date"));
			
			list.add(directappdto);
		}
		con.close();
		return list;//서블릿에서 해결하자
}
public void stateUpdate(String state,int appNo)throws Exception{
	Connection con = jdbcUtils.getConnection();
	
	String sql = "update approval set app_state = ? where app_no = ?";
	
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, state);
	ps.setInt(2, appNo);
	
	ps.executeUpdate();
	con.close();
}

}
