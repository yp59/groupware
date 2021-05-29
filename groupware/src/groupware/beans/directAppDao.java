package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}
