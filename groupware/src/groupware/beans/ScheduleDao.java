package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ScheduleDao {
	public static final String USERNAME = "kh75";
	public static final String PASSWORD ="kh75";
	
	//시퀀스 뽑기//시퀀스 번호 생성기능 
			public int getSequence() throws Exception {
			Connection con = jdbcUtils.getConnection();
			
			String sql ="select schedule_seq.nextval from dual"; //듀얼에 시퀀스 다음값 뽑아와라
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next(); //한 줄 읽어라
			
			int no =rs.getInt(1); //첫번째 줄을 담기
			
			con.close();
			return no;
		}
			
	//스케줄등록
	public void insert(ScheduleDto scheduleDto) throws Exception {
		Connection con =jdbcUtils.getConnection();
		String sql ="insert into schedule values (?,?,?,?,sysdate,?,'진행중',?)";
		PreparedStatement ps =con.prepareStatement(sql);
		
		ps.setInt(1, scheduleDto.getSc_no());
		ps.setString(2, scheduleDto.getEmpNo());
		ps.setString(3, scheduleDto.getSc_name());
		ps.setString(4, scheduleDto.getSc_content());
		ps.setString(5, scheduleDto.getSc_deadline());
		ps.setInt(6, scheduleDto.getSc_no());
		
		ps.execute();
		
		con.close();
	}
	
	
	
	//스케줄 디테일
	public ScheduleDto detail(int sc_no) throws Exception {
		Connection con=jdbcUtils.getConnection();
		String sql="select*from schedule where sc_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sc_no); 
		ResultSet rs= ps.executeQuery();
		
		ScheduleDto result;
		
		if(rs.next()) {
			result = new ScheduleDto();
			result.setSc_no(rs.getInt("sc_no"));
			result.setEmpNo(rs.getString("EMP_no"));
			result.setSc_name(rs.getString("sc_name"));
			result.setSc_content(rs.getString("sc_content"));
			result.setSc_made(rs.getString("sc_made"));
			result.setSc_deadline(rs.getString("sc_deadline"));
			result.setSc_state(rs.getString("sc_state"));
			
		}else {
			result=null;
		}
		
		con.close();
		
		return result;
		
		
	}
	
	//삭제 : 필요한 정보 - 스케줄번호, 작성자번호(사원번호)
	public boolean delete(ScheduleDto scheduleDto) throws Exception {
		Connection con=jdbcUtils.getConnection();
		String sql="delete schedule where sc_no=? and EMP_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, scheduleDto.getSc_no());
		ps.setString(2, scheduleDto.getEmpNo());
		
		int count=ps.executeUpdate();
		
		con.close();
		return count>0;
		
		
	}
	//이름과 내용 수정: 필요한 정보 - 스케줄번호, 작성자번호(사원번호)
	//			+ sc_content +sc_name
	public boolean edit(ScheduleDto scheduleDto) throws Exception {
		Connection con=jdbcUtils.getConnection();
		String sql="update schedule set sc_name=?, sc_content=? where sc_no=? and EMP_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, scheduleDto.getSc_name());
		ps.setString(2, scheduleDto.getSc_content());
		ps.setInt(3, scheduleDto.getSc_no());
		ps.setString(4, scheduleDto.getEmpNo());
		
		int count = ps.executeUpdate();
		con.close();
		return count>0;
	}

///////////////////////////////////////////////////////////////////////	
	//state 완료상태 변경 메소드: 필요한 정보 - 스케줄번호, 작성자번호(사원번호) + sc_state
	public boolean complete(ScheduleDto scheduleDto) throws Exception{
		Connection con=jdbcUtils.getConnection();
		String sql="update schedule set sc_state= ? where sc_no=? and EMP_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		String complete="완료";
		ps.setString(1,complete);
		ps.setInt(2, scheduleDto.getSc_no());
		ps.setString(3, scheduleDto.getEmpNo());
		
		int count= ps.executeUpdate();
		
		con.close();
		return count>0;
		
	}
	
	//state 진행중상태 변경 메소드: 필요한 정보 - 스케줄번호, 작성자번호(사원번호) + sc_state
		public boolean cancel(ScheduleDto scheduleDto) throws Exception{
			Connection con=jdbcUtils.getConnection();
			String sql="update schedule set sc_state= ? where sc_no=? and EMP_no=?";
			String ing ="진행중";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,ing);
			ps.setInt(2, scheduleDto.getSc_no());
			ps.setString(3, scheduleDto.getEmpNo());
			
			int count= ps.executeUpdate();
			
			con.close();
			return count>0;
			
		}
	
////////////////////////////////////////////////////////////////////////////////////	
	///////////////////////////////////////////////
	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
		//목록1 : ing
		public int getCount1() throws Exception {
			Connection con=jdbcUtils.getConnection();
			String sql ="select count(*)from schedule_ing";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			int count = rs.getInt(1);
			
			con.close();
			return count;
		}
		//검색1 : ing
		public int getCount1(String type, String keyword) throws Exception {
			Connection con=jdbcUtils.getConnection();
			String sql ="select count(*)from schedule_ing where instr(#1, ?)>0";
			sql=sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,keyword);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			con.close();
			return count;
		}
		
		
		//목록2 : end
		public int getCount2() throws Exception {
			Connection con=jdbcUtils.getConnection();
			String sql ="select count(*)from schedule_end";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			int count = rs.getInt(1);
			
			con.close();
			return count;
		}
		//검색2 :end
		public int getCount2(String type, String keyword) throws Exception {
			Connection con=jdbcUtils.getConnection();
			String sql ="select count(*)from schedule_end where instr(#1, ?)>0";
			sql=sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,keyword);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			con.close();
			return count;
		}
		
}