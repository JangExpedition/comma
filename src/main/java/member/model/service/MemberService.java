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

	public Member selectOneMember(String id) {
		Connection conn = getConnection();
		Member member = memberDao.selectOneMember(conn, id);
		close(conn);
		return member;
	}

	public int insertMember(Member member) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.insertMember(conn, member);
			commit(conn);
		}catch (Exception e) {
			e.printStackTrace();
			rollback(conn);
		}finally {
			close(conn);
		}
		return result;
	}
}
