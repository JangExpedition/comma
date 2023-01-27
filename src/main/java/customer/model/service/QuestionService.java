package customer.model.service;

import static common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import common.Attachment;
import customer.model.dao.QuestionDao;
import customer.model.dto.Question;
import customer.model.dto.QuestionComment;

public class QuestionService {

	private QuestionDao questionDao = new QuestionDao();
	
	public int insertQuestion(Question question) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result= questionDao.insertQuestion(conn, question);
			int questionNo = questionDao.selectQuestionNo(conn);
			
			List<Attachment> questionAattachList = question.getAttachments();
			if (!questionAattachList.isEmpty()) {
				for (Attachment attach : questionAattachList) {
					attach.setAttachNo(questionNo);
					result = questionDao.insertAttachQuestion(conn, attach);
				}
			}
			
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	} // insertQuestion() end
	
	public List<Question> selectAllQuestion() {
		Connection conn = getConnection();
		List<Question> questionList = questionDao.selectAllQuestion(conn);
		close(conn);
		return questionList;
	} // selectAllQuestion() end
	
	public List<Question> selectMyAllQuestion(String nickname) {
		Connection conn = getConnection();
		List<Question> questionList = questionDao.selectMyAllQuestion(conn, nickname);
		close(conn);
		return questionList;
	} // selectMyAllQuestion() end

	public Question selectOneQuestion(int questionNo) {
		Connection conn = getConnection();
		Question question = questionDao.selectOneQuestion(conn, questionNo);
		List<Attachment> attachList = questionDao.selectAttachment(conn, questionNo);
		question.setAttachments(attachList);
		close(conn);
		return question;
	} // selectOneQuestion() end

	public QuestionComment selectQComment(int questionNo) {
		Connection conn = getConnection();
		QuestionComment qComment = questionDao.selectQComment(conn, questionNo);
		close(conn);
		return qComment;
	} // selectQComment() end

	public int insertQuestionComment(QuestionComment qComment) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result= questionDao.insertQuestionComment(conn, qComment);
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	} // insertQueationComment() end

	public List<Question> selectFindQuestion(String nickname, String searchContent) {
		Connection conn = getConnection();
		List<Question> questionList = questionDao.selectFindQuestion(conn, nickname, searchContent);
		close(conn);
		return questionList;
	} // selectFindQuestion() end

	public int updateQuestion(Question question) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result= questionDao.updateQuestion(conn, question);
			
			List<Attachment> attachments = question.getAttachments();
			if (!attachments.isEmpty()) {
				for (Attachment attach : attachments) {
					attach.setAttachNo(question.getNo());
					result = questionDao.insertAttachQuestion(conn, attach);
				}
			}
			
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	} // updateQuestion() end

	public Attachment selectOneAttachment(int attachNo) {
		Connection conn = getConnection();
		Attachment attach = questionDao.selectOneAttachment(conn, attachNo);
		close(conn);
		return attach;
	} // selectOneAttachment() end

	public int deleteAttachment(int attachNo) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result= questionDao.deleteAttachment(conn, attachNo);
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	} // deleteAttachment() end

	public List<Attachment> selectAttachment(int no) {
		Connection conn = getConnection();
		List<Attachment> attachments = questionDao.selectAttachment(conn, no);
		close(conn);
		return attachments;
	} // selectAttachment() end

	public int deleteQuestion(int no) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result= questionDao.deleteQuestion(conn, no);
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	} // deleteQuestion() end

	public int updateQuestionComment(QuestionComment qComment) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result= questionDao.updateQuestionComment(conn, qComment);
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	} // updateQuestionComment() end

	public int deleteQuestionComment(int qNo) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result= questionDao.deleteQuestionComment(conn, qNo);
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	} // deleteQuestionComment() end

}
