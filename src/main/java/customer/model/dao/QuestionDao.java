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
import customer.model.dto.QuestionComment;
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
		question.setRowNo(rset.getInt("rnum"));
		question.setWriter(rset.getString("writer"));
		question.setTitle(rset.getString("title"));
		question.setContent(rset.getString("content"));
		question.setRegDate(rset.getDate("reg_date"));
		return question;
	} // handleQuestionResultSet() end


	public Attachment handleAttachmentResultSet(ResultSet rset) throws SQLException {
		Attachment attach = new Attachment();
		attach.setNo(rset.getInt("no"));
		attach.setAttachNo(rset.getInt("q_no"));
		attach.setOriginalFilename(rset.getString("original_filename"));
		attach.setRenamedFilename(rset.getString("renamed_filename"));
		attach.setRegDate(rset.getDate("reg_date"));
		return attach;
	} // handleAttachmentResultSet() end
	
	
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
					Attachment attach = handleAttachmentResultSet(rset);
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


	public QuestionComment selectQComment(Connection conn, int questionNo) {
		QuestionComment qComment = null;
		String sql = prop.getProperty("selectQComment");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, questionNo);
			
			try (ResultSet rset = pstmt.executeQuery()){
				if (rset.next()) {
					qComment = new QuestionComment();
					qComment.setNo(rset.getInt("no"));
					qComment.setQNo(rset.getInt("q_no"));
					qComment.setWriter(rset.getString("writer"));
					qComment.setContent(rset.getString("content"));
					qComment.setRegDate(rset.getDate("reg_date"));
				}
			}
			
		} catch (SQLException e) {
			throw new QuestionException("특정 문의 내역 댓글 조회 오류", e);
		}
		return qComment;
	} // selectQComment() end


	public int insertQuestionComment(Connection conn, QuestionComment qComment) {
		int result = 0;
		String sql = prop.getProperty("insertQuestionComment");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, qComment.getWriter());
			pstmt.setInt(2, qComment.getQNo());
			pstmt.setString(3, qComment.getContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("특정 문의 내역 댓글 등록 오류", e);
		}
		return result;
	} // insertQuestionComment() end


	public List<Question> selectFindMyQuestion(Connection conn, String nickname, String searchContent) {
		List<Question> questionList = new ArrayList<>();
		String sql = prop.getProperty("selectFindMyQuestion");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, '%' + searchContent + '%');
			pstmt.setString(2, nickname);
			
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Question question = handleQuestionResultSet(rset);
					questionList.add(question);
				}
			}
			
		} catch (SQLException e) {
			throw new QuestionException("나의 문의 내역 검색 결과 오류", e);
		}
		return questionList;
	} // selectFindMyQuestion() end


	public List<Question> selectFindQuestion(Connection conn, String searchContent) {
		List<Question> questionList = new ArrayList<>();
		String sql = prop.getProperty("selectFindQuestion");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, '%' + searchContent + '%');
			
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Question question = handleQuestionResultSet(rset);
					questionList.add(question);
				}
			}
			
		} catch (SQLException e) {
			throw new QuestionException("문의 내역 검색 결과 오류", e);
		}
		return questionList;
	} // selectFindQuestion() end


	public int updateQuestion(Connection conn, Question question) {
		int result = 0;
		String sql = prop.getProperty("updateQuestion");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, question.getTitle());
			pstmt.setString(2, question.getContent());
			pstmt.setInt(3, question.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("문의 내역 수정 오류", e);
		}
		return result;
	} // updateQuestion() end


	public Attachment selectOneAttachment(Connection conn, int attachNo) {
		Attachment attach = null;
		String sql = prop.getProperty("selectOneAttachment");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, attachNo);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				if (rset.next())
					attach = handleAttachmentResultSet(rset);
			 }
		} catch (SQLException e) {
			throw new QuestionException("특정 첨부파일 조회 오류", e);
		}
		return attach;
	} // selectOneAttachment() end


	public int deleteAttachment(Connection conn, int attachNo) {
		int result = 0;
		String sql = prop.getProperty("deleteAttachment");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, attachNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("특정 펌부파일 삭제 오류", e);
		}
		return result;
	} // deleteAttachment() end


	public int updateAttachment(Connection conn, Attachment attach) {
		int result =0;
		String sql = prop.getProperty("updateAttachment");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, attach.getOriginalFilename());
			pstmt.setString(2, attach.getRenamedFilename());
			pstmt.setInt(3, attach.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("문의 사항 첨부파일 수정 오류", e);
		}
		return result;
	} // updateAttachment() end


	public int deleteQuestion(Connection conn, int no) {
		int result = 0;
		String sql = prop.getProperty("deleteQuestion");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("문의 내역 삭제 오류", e);
		}
		return result;
	} // deleteQuestion() end


	public int updateQuestionComment(Connection conn, QuestionComment qComment) {
		int result = 0;
		String sql = prop.getProperty("updateQuestionComment");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, qComment.getWriter());
			pstmt.setString(2, qComment.getContent());
			pstmt.setInt(3, qComment.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("문의 내역 댓글 수정 오류", e);
		}
		return result;
	} // updateQuestionComment() end


	public int deleteQuestionComment(Connection conn, int qNo) {
		int result = 0;
		String sql = prop.getProperty("deleteQuestionComment");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, qNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new QuestionException("문의 내역 댓글 삭제 오류", e);
		}
		return result;
	} // deleteQuestionComment() end

}
