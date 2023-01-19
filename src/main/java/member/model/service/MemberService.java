package member.model.service;

import java.sql.Connection;
import java.util.List;
import static common.JdbcTemplate.*;

import member.model.dao.MemberDao;
import member.model.dto.Member;

public class MemberService {

	private MemberDao memberDao = new MemberDao();
	
	public List<Member> selectAllNickname(){
		Connection conn = getConnection();
		List<Member> memberList = memberDao.selectAllNickname(conn);
		close(conn);
		return memberList;
	}
}
