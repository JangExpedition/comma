package customer.model.dao;

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
import customer.model.dto.Question;
import customer.model.exception.QuestionException;

public class QuestionDao {

private Properties prop = new Properties();
	
	public QuestionDao() {
		String path = QuestionDao.class.getResource("/sql/question/question-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}		
	} // QuestionDao() end

	
	public Question handleQuestionResultSet(ResultSet rset) throws SQLException {
		Question question = new Question();
		question.setNo(rset.getInt("no"));
		question.setWriter(rset.getString("writer"));
		question.setTitle(rset.getString("title"));
		question.setContent(rset.getString("content"));
		question.setRegDate(rset.getDate("reg_date"));
		return question;
	} // handleQuestionResultSet() end
	
	
	public int insertQuestion(Connection conn, Question question) {
		int result =0;
		String sql = prop.getProperty("insertQuestion");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, question.getWriter());
			pstmt.setString(2, question.getTitle());
			pstmt.setString(3, question.getContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("문의 사항 등록 오류", e);
		}
		return result;
	} // insertQuestion() end

	
	public List<Question> selectAllQuestion(Connection conn) {
		List<Question> questionList = new ArrayList<>();
		String sql = prop.getProperty("selectAllQuestion");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Question question = handleQuestionResultSet(rset);
					questionList.add(question);
				}
			}
			
		} catch (SQLException e) {
			throw new QuestionException("문의 내역 조회 오류", e);
		}
		return questionList;
	} // selectAllQuestion() end

	
	public List<Question> selectMyAllQuestion(Connection conn, String nickname) {
		List<Question> questionList = new ArrayList<>();
		String sql = prop.getProperty("selectMyAllQuestion");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, nickname);
			
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Question question = handleQuestionResultSet(rset);
					questionList.add(question);
				}
			}
			
		} catch (SQLException e) {
			throw new QuestionException("특정 사용자 문의 내역 조회 오류", e);
		}
		return questionList;
	} // selectMyAllQuestion() end


	public int selectQuestionNo(Connection conn) {
		int questionNo = 0;
		String sql = prop.getProperty("selectQuestionNo");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rset = pstmt.executeQuery()) {
			if (rset.next())
				questionNo = rset.getInt(1);
		
		} catch (SQLException e) {
			throw new QuestionException("문의 사항 번호 조회 오류", e);
		}
		return questionNo;
	} // selectOneQuestion() end


	public int insertAttachQuestion(Connection conn, Attachment attach) {
		int result =0;
		String sql = prop.getProperty("insertAttachQuestion");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, attach.getAttachNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("문의 사항 첨부파일 등록 오류", e);
		}
		return result;
	} // insertAttachQuestion() end


	public List<Attachment> selectAttachment(Connection conn, int questionNo) {
		List<Attachment> attachList = new ArrayList<>();
		String sql = prop.getProperty("selectAttachment");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, questionNo);
			
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Attachment attach = new Attachment();
					attach.setNo(rset.getInt("no"));
					attach.setAttachNo(rset.getInt("q_no"));
					attach.setOriginalFilename(rset.getString("original_filename"));
					attach.setRenamedFilename(rset.getString("renamed_filename"));
					attach.setRegDate(rset.getDate("reg_date"));
					attachList.add(attach);
				}
			}
			
		} catch (SQLException e) {
			throw new QuestionException("특정 문의 내역 첨부파일 조회 오류", e);
		}
		return attachList;
	} // selectAttachment() end


	public Question selectOneQuestion(Connection conn, int questionNo) {
		Question question = null;
		String sql = prop.getProperty("selectOneQuestion");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, questionNo);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				if (rset.next())
					question = handleQuestionResultSet(rset);
			 }
		} catch (SQLException e) {
			throw new QuestionException("특정 문의 내역 조회 오류", e);
		}
		return question;
	} // selectOneQuestion() end

}
