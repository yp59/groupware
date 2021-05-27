package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MassageDao {
	
	//메세지 입력창 (입력 메소드)
	
	public void insert(MassageDto massageDto) throws Exception {
		Connection con = jdbcUtils.getConnection();
		
		String sql ="insert into  massage values (massage_seq.nextval,?,?,sysdate,?,?)";
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setString(1, massageDto.getEmpNo()); //발신자번호
		ps.setString(2, massageDto.getM_name());//쪽지제목
		ps.setString(3, massageDto.getM_content());//쪽지내용
		ps.setString(4, massageDto.getReceiver_no());//수신자번호
		
		ps.execute();
		
		con.close();
		
		
	}
	
	
	
	//디테일 조회 detail --> massageListDao 에 생성

	//수신함 리스트 페이지네이션 블록 count 구하기 
	public int getCount_receiverList(String e2_no)throws Exception {
		Connection con =jdbcUtils.getConnection();
		
		String sql ="select count(*)from massage_list where e2_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, e2_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
		
		
	}
	
	//발신함 리스트 페이지네이션 블록 count 구하기 
	public int getCount_senderList(String empNo)throws Exception {
		Connection con =jdbcUtils.getConnection();
		
		String sql ="select count(*)from massage_list where emp_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, empNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
		
		
	}

	
}
