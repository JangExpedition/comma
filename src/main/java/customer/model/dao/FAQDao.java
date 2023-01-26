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


	public FAQ handleFaqResultSet(ResultSet rset) throws SQLException {
		FAQ faq = new FAQ();
		faq.setNo(rset.getInt("no"));
		faq.setTitle(rset.getString("title"));
		faq.setContent(rset.getString("content"));
		return faq;
	} // handleFaqResultSet() end
	
	
	public int insertFaq(Connection conn, FAQ faq) {
		int result =0;
		String sql = prop.getProperty("insertFaq");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, faq.getTitle());
			pstmt.setString(2, faq.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new FAQException("FAQ 등록 오류", e);
		}
		return result;
	} // insertFaq() end

	public List<FAQ> selectAllFAQ(Connection conn) {
		List<FAQ> faqList = new ArrayList<>();
		String sql = prop.getProperty("selectAllFAQ");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					FAQ faq = handleFaqResultSet(rset);
					faqList.add(faq);
				}
			}
			
		} catch (SQLException e) {
			throw new FAQException("FAQ 조회 오류", e);
		}
		return faqList;
	} // selectAllFAQ() end

	public List<FAQ> selectFindFaq(Connection conn, String searchContent) {
		List<FAQ> faqList = new ArrayList<>();
		String sql = prop.getProperty("selectFindFaq");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, '%' + searchContent + '%');
			pstmt.setString(2, '%' + searchContent + '%');
			
			try (ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					FAQ faq = handleFaqResultSet(rset);
					faqList.add(faq);
				}
			}
			
		} catch (SQLException e) {
			throw new FAQException("FAQ 조회 오류", e);
		}
		return faqList;
	} // selectFindFaq() end

}
