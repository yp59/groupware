package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}
