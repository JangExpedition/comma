package question.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import question.model.dto.Question;
import question.model.exception.QuestionException;

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
	
	public int insertQuestion(Connection conn, String writer, String title, String content) {
		int result =0;
		String sql = prop.getProperty("insertQuestion");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, writer);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new QuestionException("문의 사항 등록 오류", e);
		}
		return result;
	}

	public List<Question> selectAllQuestion(Connection conn) {
		List<Question> questionList = new ArrayList<>();
		String sql = prop.getProperty("selectAllQuestion");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Question question = new Question();
					question.setNo(rset.getInt("no"));
					question.setWriter(rset.getString("writer"));
					question.setTitle(rset.getString("title"));
					question.setContent(rset.getString("content"));
					question.setRegDate(rset.getDate("reg_date"));
					questionList.add(question);
				}
			}
			
		} catch (SQLException e) {
			throw new QuestionException("문의 사항 조회 오류", e);
		}
		return questionList;
	}

}
