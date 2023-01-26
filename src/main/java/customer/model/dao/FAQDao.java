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

import customer.model.dto.FAQ;
import customer.model.exception.FAQException;

public class FAQDao {

private Properties prop = new Properties();
	
	public FAQDao() {
		String path = FAQDao.class.getResource("/sql/faq/faq-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}		
	} // QuestionDao() end
	
	public int insertfaq(Connection conn, String title, String content) {
		int result =0;
		String sql = prop.getProperty("insertQuestion");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new FAQException("FAQ 등록 오류", e);
		}
		return result;
	} // insertfaq() end

	public List<FAQ> selectAllFAQ(Connection conn) {
		List<FAQ> faqList = new ArrayList<>();
		String sql = prop.getProperty("selectAllFAQ");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					FAQ faq = new FAQ();
					faq.setNo(rset.getInt("no"));
					faq.setTitle(rset.getString("title"));
					faq.setContent(rset.getString("content"));
					faqList.add(faq);
				}
			}
			
		} catch (SQLException e) {
			throw new FAQException("FAQ 조회 오류", e);
		}
		return faqList;
	} // selectAllFAQ() end

}
