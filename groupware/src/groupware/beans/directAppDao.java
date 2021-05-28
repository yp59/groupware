package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class directAppDao {

	public void directInsert(directAppDto directappdto)throws Exception{
		Connection con = jdbcUtils.getConnection();
		
		String sql = "insert into directapp values(dir_seq.nextval,?,'미결',?,'')";

		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, directappdto.getApproval());
		ps.setString(2, directappdto.getConsesus());
		
		ps.executeUpdate();
		
		con.close();
	}
}
