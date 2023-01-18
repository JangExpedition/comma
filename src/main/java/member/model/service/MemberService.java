package member.model.service;

import java.sql.Connection;
import java.util.List;
import static common.JdbcTemplate.*;

import member.model.dao.MemberDao;

public class MemberService {

	private MemberDao memberDao = new MemberDao();
	
	public List<String> selectAllNickname(){
		Connection conn = getConnection();
		List<String> nicks = memberDao.selectAllNickname(conn);
		close(conn);
		return nicks;
	}
}
