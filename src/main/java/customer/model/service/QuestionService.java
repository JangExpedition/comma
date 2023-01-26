package customer.model.service;

import static common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import common.Attachment;
import customer.model.dao.QuestionDao;
import customer.model.dto.Question;

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

}
