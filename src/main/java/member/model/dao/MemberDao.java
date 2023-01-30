package member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import member.model.dto.Gender;
import member.model.dto.Member;
import member.model.dto.MemberRole;
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
	

	public List<Member> selectAllMember(Connection conn){
		List<Member> memberList = new ArrayList<>();
		String sql = prop.getProperty("selectAllMember");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					memberList.add(handleMemberResultSet(rset));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException("닉네임 가져오기 오류!", e);
		}
		
		return memberList;
	}
	
	private Member handleMemberResultSet(ResultSet rset) throws SQLException {
		Member member = new Member();
		member.setEmail(rset.getString("email"));
		member.setNickname(rset.getString("nickname"));
		member.setPassword(rset.getString("password"));
		member.setBirthday(rset.getDate("birthday"));
		member.setGender(Gender.valueOf(rset.getString("gender")));
		member.setEnrollDate(rset.getDate("enroll_date"));
		member.setMemberRole(MemberRole.valueOf(rset.getString("member_role")));
		member.setOriginalFilename(rset.getString("original_filename"));
		member.setRenamedFilename(rset.getString("renamed_filename"));
		member.setWarningCount(rset.getInt("warning_count"));
		member.setAge(rset.getInt("age"));
		
		return member;
	}


	public Member selectOneMember(Connection conn, String id) {
		Member member = null;
		String sql = prop.getProperty("selectOneMember");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, id);
			
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					member = handleMemberResultSet(rset);
				}
			}
		} catch (SQLException e) {
			throw new MemberException("로그인 실패!", e);
		}
		return member;
	}


	public int insertMember(Connection conn, Member member) {
		int result = 0;
		String sql = prop.getProperty("insertMember");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			
			pstmt.setString(1, member.getEmail());
			pstmt.setString(2, member.getNickname());
			pstmt.setString(3, member.getPassword());
			pstmt.setDate(4, member.getBirthday());
			pstmt.setString(5, member.getGender().toString());
			pstmt.setInt(6, member.getAge());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MemberException("회원가입오류!", e);
		}
		return result;
	}


	public List<Member> selectAllMemberWithOutMe(Connection conn, Map<String, Object> param) {
		List<Member> memberList = new ArrayList<>();
		String sql = prop.getProperty("selectAllMemberWithOutMe");
		// select * from member where nickname ^= ? and gender like ? and age between ? and ?
		
		String _gender = (String) param.get("gender");
		String gender = "X".equals(_gender) ? "" : _gender;
		System.out.println("_gender = " + _gender);
		System.out.println("gender = " + gender);
		
		int age = (int) param.get("age");
		int start = age != 0 ? age * 10 : 0;
		int end = age != 0 ? start + 9 : 150;
		System.out.println("age = " + age);
		System.out.println("start = " + start + ", end = " + end);
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, (String) param.get("writer"));
			pstmt.setString(2, gender + '%');
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					memberList.add(handleMemberResultSet(rset));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException("본인을 제외한 회원 목록 조회 오류!", e);
		}
		
		return memberList;
	} // selectAllMemberWithOutMe() end


	public int updateMember(Connection conn, Map<String, String> param) {
		int result = 0;
		String sql = prop.getProperty("updateMember");
		String updateType = param.get("updateType");
		String updateData = param.get("updateData");
		String who = param.get("who");
		sql = sql.replace("#", updateType);
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, updateData);
			pstmt.setString(2, who);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MemberException("회원정보 수정오류!", e);
		}
		return result;
	}


	public int deleteMember(Connection conn, String email) {
		int result = 0;
		String sql = prop.getProperty("deleteMember");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, email);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException("회원탈퇴 오류!", e);
		}
		return result;
	}


	public int updateMemberRole(Connection conn, String memberNick, String memberRole) {
		int result = 0;
		String sql = prop.getProperty("updateMemberRole");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberRole);
			pstmt.setString(2, memberNick);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException("회원 권한 변경 오류!", e);
		}
		return result;
	} // updateMemberRole() end


	public List<Member> selectFindMember(Connection conn, Map<String, Object> param) {
		List<Member> memberList = new ArrayList<>();
		String sql = prop.getProperty("selectFindMember");
		String type = (String) param.get("searchType");
		Object keyword = param.get("searchKeyword");
		
		sql = sql.replace("#", type);
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setObject(1, keyword);
			
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					memberList.add(handleMemberResultSet(rset));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException("관리자 닉네임 조회 오류!", e);
		}
		
		return memberList;
	} // selectFindMember() end


	public int updateWarningCount(Connection conn, Map<String, Object> param) {
		int result = 0;
		String sql = prop.getProperty("updateWarningCount");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, (int) param.get("warningCnt"));
			pstmt.setString(2, (String) param.get("memberNick"));
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException("회원 누적 신고 횟수 변경 오류!", e);
		}
		return result;
	} // updateWarningCount() end


	public Member selectOneMemberFromNick(Connection conn, String nickname) {
		Member member = null;
		String sql = prop.getProperty("selectOneMemberFromNick");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, nickname);
			
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					member = handleMemberResultSet(rset);
				}
			}
		} catch (SQLException e) {
			throw new MemberException("회원찾기 실패!", e);
		}
		return member;
	}


	public int deleteMemberNick(Connection conn, String memberNick) {
		int result = 0;
		String sql = prop.getProperty("deleteMemberNick");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberNick);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException("회원탈퇴 오류!", e);
		}
		return result;
	} // deleteMemberNick() end
}
