package member.model.service;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.eclipse.jdt.internal.compiler.classfmt.ComponentInfoWithTypeAnnotation;

import common.OX;
import letter.model.dao.LetterDao;
import letter.model.dto.AF;
import letter.model.dto.Letter;

import static common.JdbcTemplate.*;

import member.model.dao.MemberDao;
import member.model.dto.Member;

public class MemberService {

	private MemberDao memberDao = new MemberDao();
	
	public List<Member> selectAllMember(){
		Connection conn = getConnection();
		List<Member> memberList = memberDao.selectAllMember(conn);
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
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}

	public List<Member> selectAllMemberWithOutMe(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> memberList = memberDao.selectAllMemberWithOutMe(conn, param);
		close(conn);
		return memberList;
	} // selectAllMemberWithOutMe() end

	public int updateMember(Map<String, String> param) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.updateMember(conn, param);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int deleteMember(String email) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.deleteMember(conn, email);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int updateMemberRole(String memberNick, String memberRole) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = memberDao.updateMemberRole(conn, memberNick, memberRole);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	} // updateMemberRole() end

	public List<Member> selectFindMember(String searchNick) {
		Connection conn = getConnection();
		List<Member> memberList = memberDao.selectFindMember(conn, searchNick);
		close(conn);
		return memberList;
	} // selectFindMember() end

	public int updateWarningCount(Map<String, Object> param) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = memberDao.updateWarningCount(conn, param);
			
			result = new LetterDao().insertLetter(conn, new Letter(0, "admin1", (String) param.get("memberNick"), 1, 1, (String) param.get("content"), null, null, "X", 0, OX.X, AF.F));
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	} // updateWarningCount() end
}
