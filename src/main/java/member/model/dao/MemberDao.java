package member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import member.model.exception.MemberException;

public class MemberDao {
	
	Properties prop = new Properties();
	
	public MemberDao() {
		String path = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	public List<String> selectAllNickname(Connection conn){
		List<String> nicks = new ArrayList<>();
		String sql = prop.getProperty("selectAllNickname");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					String nick = rset.getString("nickname");
					nicks.add(nick);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException("닉네임 가져오기 오류!", e);
		}
		
		return nicks;
	}
}
