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
		
		String sql= "select * from ("
				+ "    select rownum rn ,X.* from("
				+ "        select  * from("
				+ "                     select * from("
				+ "                                select * from("
				+ "                                        select TMP.* from ("
				+ "                                            select A.*,D.type,E.emp_name from approval A"
				+ "                                             inner join directapp D"
				+ "                                         on D.app_no = A.app_no"
				+ "                                        inner join employees E"
				+ "                                            on A.drafter = E.emp_no"
				+ "                                             where D.approval = ?"
				+ "                                        )TMP"
				+ "                                )"
				+ "                    ) union all"
				+ "                        select * from("
				+ "                            select * from("
				+ "                            select TMP.* from ("
				+ "                            select A.*,I.type,E.emp_name from approval A"
				+ "                            inner join indirectapp I"
				+ "                             on I.app_no = A.app_no"
				+ "                        inner join employees E"
				+ "                            on A.drafter = E.emp_no"
				+ "                             where i.referrer = ?"
				+ "                        )TMP"
				+ "                    )"
				+ "                )"
				+ "        )order by app_date_start desc "
				+ "        )X"
				+ ") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, id);
		ps.setString(2, id);
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

		String sql= "select * from ("
				+ "    select rownum rn,X.* from("
				+ "    select * from("
				+ "        select * from("
				+ "                select * from("
				+ "                            select TMP.* from ("
				+ "                            select A.*,D.type,E.emp_name from approval A"
				+ "                            inner join directapp D"
				+ "                            on D.app_no = A.app_no"
				+ "                             inner join employees E"
				+ "                            on A.drafter = E.emp_no"
				+ "                            where D.approval = ? and instr(A.app_title,?)>0"
				+ "                            )TMP"
				+ "                     )"
				+ "                )union all"
				+ "                          "
				+ "            select * from("
				+ "                select * from("
				+ "                            select TMP.* from ("
				+ "                            select A.*,I.type,E.emp_name from approval A"
				+ "                            inner join indirectapp I"
				+ "                            on I.app_no = A.app_no"
				+ "                             inner join employees E"
				+ "                            on A.drafter = E.emp_no"
				+ "                            where I.referrer = ? and instr(A.app_title,?)>0"
				+ "                            )TMP"
				+ "                         )"
				+ "                    )"
				+ "                    )order by app_date_start desc"
				+ "                )X"
				+ ")where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, keyword);
		ps.setString(3, id);
		ps.setString(4, keyword);
		ps.setInt(5, startRow);
		ps.setInt(6, endRow);
		
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
		con.close();
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
		con.close();
	return count;
	}

	//결재할 기안서 수 출력
		public int getMainCount(String id)throws Exception{
			
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from ("
					+ " select * from("
					+ " select type from directapp where approval = ?"
					+ " )union all"
					+ " select type from("
					+ " select * from indirectapp where referrer = ?)"
					+ ")";
		
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, id);
			ps.setString(2, id);
			ResultSet rs = ps.executeQuery();
			
			int count;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			else {
				count=0;
			}
			con.close();
		return count;
		}
		//결재할 기안서 중 검색한 문서 수 출력
		public int getMainCount(String id, String keyword)throws Exception{//검색한 기안서의 수를 출력
			
			Connection con = jdbcUtils.getConnection();
			
			String sql = "select count(*) from("
					+ " select * from("
					+ " select D.app_no from approval A"
					+ "				 inner join directapp D"
					+ "				on A.app_no = D.app_no"
					+ "			where instr(A.app_title,?)>0 and D.approval = ?)"
					+ "            union all"
					+ "            select * from("
					+ " select i.app_no from approval A"
					+ "				 inner join indirectapp I"
					+ "				on A.app_no = I.app_no"
					+ "			where instr(A.app_title,?)>0 and I.referrer = ?))";
		
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, keyword);
			ps.setString(2, id);
			ps.setString(3, keyword);
			ps.setString(4, id);
			ResultSet rs = ps.executeQuery();
			
			int count;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			else {
				count=0;
			}
			con.close();
		return count;
		}
	
/*	시퀀스 전체 값 
 * public List<approvalDto> sequence(int appNo)throws Exception{
		
		Connection con = jdbcUtils.getConnection();
		
		String sql = " select * from ("
				+ "    select rownum rn,TMP.* from("
				+ "            select * from("
				+ "                        select A.*,D.approval,D.type,D.consesus,D.app_date,E.po_no from directapp D"
				+ "                        inner join  approval A "
				+ "                        on A.app_no = D.app_no"
				+ "                        inner join employees E"
				+ "                        on D.approval = E.emp_no"
				+ "                        where A.app_no =? and consesus ='1'"
				+ "                        order by po_no desc)"
				+ "                        "
				+ "				union all"
				+ "            select * from"
				+ "                        ( select A.*,D.approval,D.type,D.consesus,D.app_date,E.po_no from directapp D"
				+ "                        inner join approval A "
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
		
		List<approvalDto> list = new ArrayList<>();
		
		while(rs.next()) {
			approvalDto approvaldto = new approvalDto();
			approvaldto.setRowNum(rs.getInt(1));
			approvaldto.setAppNo(rs.getInt(2));
			approvaldto.setDrafter(rs.getString(3));
			approvaldto.setAppTitle(rs.getString(4));
			approvaldto.setAppContent(rs.getString(5));
			approvaldto.setAppDateStart(rs.getString(6));
			approvaldto.setAppDateEnd(rs.getString(7));
			approvaldto.setAppState(rs.getString(8));
			approvaldto.setApproval(rs.getString(9));
			approvaldto.setDirType(rs.getString(10));
			approvaldto.setConsesus(rs.getString(11));
			approvaldto.setApp_date(rs.getString(12));
			approvaldto.setPoNo(rs.getInt(13));
			
			list.add(approvaldto);
			
		}
		con.close();
		return list;
	}*/
		
		//approvaldetail에서 기안서 내용 조회값
		public approvalDto draftDoc(int appNo)throws Exception{//session id값으로 기안 목록 조회
			Connection con = jdbcUtils.getConnection();
			
			String sql= "select A.*,E.emp_name from approval A"
					+ " inner join employees E"
					+ " on A.drafter = E.emp_no"
					+ " where app_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1, appNo);
			
			ResultSet rs = ps.executeQuery();
			
			approvalDto approvaldto = new approvalDto();
			
			while(rs.next()) {
				
				approvaldto.setAppNo(rs.getInt(1));
				approvaldto.setDrafter(rs.getString(2));
				approvaldto.setAppTitle(rs.getString(3));
				approvaldto.setAppContent(rs.getString(4));
				approvaldto.setAppDateStart(rs.getString(5));
				approvaldto.setAppDateEnd(rs.getString(6));
				approvaldto.setAppState(rs.getString(7));
				approvaldto.setEmpName(rs.getString(8));
			
			}
			con.close();
			return approvaldto;
		}
		
}
