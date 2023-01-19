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
	

	public List<Member> selectAllNickname(Connection conn){
		List<Member> memberList = new ArrayList<>();
		String sql = prop.getProperty("selectAllNickname");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					
					Member member = new Member();
					member.setNickname(rset.getString("nickname"));
					member.setPassword(rset.getString("password"));
					member.setGender(Gender.valueOf(rset.getString("gender")));
					member.setEmail(rset.getString("email"));
					member.setEnrollDate(rset.getDate("enroll_date"));
					member.setMemberRole(MemberRole.valueOf(rset.getString("member_role")));
					member.setWarningCount(rset.getInt("warning_count"));
					member.setOriginalFilename(rset.getString("original_filename"));
					member.setRenamedFilename(rset.getString("renamed_filename"));
					
					memberList.add(member);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException("닉네임 가져오기 오류!", e);
		}
		
		return memberList;
	}
}
