package customer.model.service;

import static common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import customer.model.dao.QuestionDao;
import customer.model.dto.Question;

public class QuestionService {

	private QuestionDao questionDao = new QuestionDao();
	public int insertQuestion(String writer, String title, String content) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result= questionDao.insertQuestion(conn,writer,title,content);
			commit(conn);
		} catch (Exception e){ 
			rollback(conn);
			throw e;
		}
		return result; 
	}
	public List<Question> selectAllQuestion() {
		Connection conn = getConnection();
		List<Question> questionList = questionDao.selectAllQuestion(conn);
		close(conn);
		return questionList;
	}

}
