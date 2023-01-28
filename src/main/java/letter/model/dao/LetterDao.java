package letter.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import common.Attachment;
import common.OX;
import letter.model.dto.AF;
import letter.model.dto.Letter;
import letter.model.exception.LetterException;
import member.model.dto.MemberRole;

public class LetterDao {

	private Properties prop = new Properties();
	
	public LetterDao() {
		String path = LetterDao.class.getResource("/sql/letter/letter-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // LetterDao() end

	
	public Letter handleLetterResultSet(ResultSet rset) throws SQLException {
		Letter letter = new Letter();
		letter.setNo(rset.getInt("no"));
		letter.setWriter(rset.getString("writer"));
		letter.setAddressee(rset.getString("addressee"));
		letter.setDesignNo(rset.getInt("design_no"));
		letter.setFontNo(rset.getInt("font_no"));
		letter.setContent(rset.getString("content"));
		letter.setRegDate(rset.getDate("reg_date"));
		letter.setRead_check(OX.valueOf(rset.getString("read_check")));
		letter.setAnonymous(OX.valueOf(rset.getString("anonymous")));
		letter.setSendWho(AF.valueOf(rset.getString("send_who")));
		letter.setWriterRole(MemberRole.valueOf(rset.getString("member_role")));
		return letter;
	} // handleLetterResultSet() end

	
	public Attachment handleAttachResultSet(ResultSet rset) throws SQLException {
		Attachment attach = new Attachment();
		attach.setNo(rset.getInt("no"));
		attach.setAttachNo(rset.getInt("letter_no"));
		attach.setOriginalFilename(rset.getString("original_filename"));
		attach.setRenamedFilename(rset.getString("renamed_filename"));
		attach.setRegDate(rset.getDate("reg_date"));
		return attach;
	} // handleAttachResultSet() end

	
	public List<Letter> selectAllLetter(Connection conn, String nickname) {
		String sql = prop.getProperty("selectAllLetter");
		List<Letter> letterList = new ArrayList<>();
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, nickname);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next()) {
					letterList.add(handleLetterResultSet(rset));
				} // while() end
			}
		} catch (SQLException e) {
			throw new LetterException("편지 조회 오류", e);
		}
		return letterList;
	} // selectAllLetter() end


	public int insertLetter(Connection conn, Letter letter) {
		int result = 0;
		String sql = prop.getProperty("insertLetter");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, letter.getWriter());
			pstmt.setString(2, letter.getAddressee());
			pstmt.setInt(3, letter.getDesignNo());
			pstmt.setInt(4, letter.getFontNo());
			pstmt.setString(5, letter.getContent());
			pstmt.setString(6, letter.getGender());
			pstmt.setInt(7, letter.getAge());
			pstmt.setString(8, letter.getAnonymous().name());
			pstmt.setString(9, letter.getSendWho().name());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new LetterException("편지 보내기 오류", e);
		}
		return result;
	} // insertLetter() end


	public int selectLastLetterNo(Connection conn) {
		int letterNo = 0;
		String sql = prop.getProperty("selectLastLetterNo");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rset = pstmt.executeQuery()) {
			if (rset.next())
				letterNo = rset.getInt(1);
		} catch (SQLException e) {
			throw new LetterException("편지 번호 조회 오류", e);
		}
		return letterNo;
	} // selectLastLetterNo() end


	public int insertAttachment(Connection conn, Attachment attach) {
		int result = 0;
		String sql = prop.getProperty("insertAttachment");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, attach.getAttachNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new LetterException("편지 첨부파일 저장 오류", e);
		}
		return result;
	} // insertAttachment() end


	public Letter selectOneLetter(Connection conn, int letterNo) {
		String sql = prop.getProperty("selectOneLetter");
		Letter letter = null;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, letterNo);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				if (rset.next()) {
					letter = handleLetterResultSet(rset);
				} // if() end
			}
		} catch (SQLException e) {
			throw new LetterException("편지 한 건 조회 오류", e);
		}
		return letter;
	} // selectOneLetter() end


	public List<Attachment> selectAllAttachment(Connection conn, int letterNo) {
		String sql = prop.getProperty("selectAllAttachment");
		List<Attachment> attachList = new ArrayList<>();
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, letterNo);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next()) {
					attachList.add(handleAttachResultSet(rset));
				} // while() end
			}
		} catch (SQLException e) {
			throw new LetterException("첨부파일 조회 오류", e);
		}
		return attachList;
	} // selectAllAttachment() end
	
} // class end
