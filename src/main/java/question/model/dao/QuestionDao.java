package question.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

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

}
