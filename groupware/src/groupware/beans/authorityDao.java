package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class authorityDao {

	final static String USERNAME = "kh75";
	final static String PASSWORD = "kh75";
	
	public int authorityLevel(String empNo)throws Exception{//권한1(관리자 권한)을 가지고 있으면 수정 삭제 가능
																//권한도 세션으로 붙여두면 좋을거같다.(구현)
		Connection con = jdbcUtils.con(USERNAME, PASSWORD);
		
		String sql = "select E.emp_no,E.emp_name,E.po_no,P.posi,PA.aut_no"
				+ " from employees E inner join position P"
				+ " on e.po_no=p.po_no"
				+ " inner join position_authority \"PA\""
				+ " on P.po_no= PA.po_no"
				+ " where emp_no = ?"; //이너조인으로 테이블 타서 authority 쪽 테이블 보는 sql 구문
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1,empNo);
		
		ResultSet rs = ps.executeQuery();
		
		
		authorityDto authoritydto = null ;
		

		if(rs.next()) {
		
			authoritydto = new authorityDto();
		//	authoritydto.setEmpNo(rs.getString(1));
		//	authoritydto.setEmpName(rs.getString(2));
		//	authoritydto.setPoNo(rs.getInt(3));
		//	authoritydto.setPosi(rs.getString(4));
			authoritydto.setAutNo(rs.getInt(5));
		}
			con.close();
		
			return authoritydto.getAutNo();
		}
		//권한을 번호로 부여해서 직급에 따라 그룹웨어에서 할 수 있는 범위를 넓혀준다.
		//게시판 toDoList 휴가 전자결제 등 모든 테이블에서 사용할 수 있게 끔 패키지로 따로 빼두었습니다.
}
