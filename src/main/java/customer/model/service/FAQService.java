package customer.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import customer.model.dao.FAQDao;
import customer.model.dto.FAQ;

public class FAQService {

	private FAQDao faqDao = new FAQDao();
	
	public List<FAQ> selectAllFAQ() {
		Connection conn = getConnection();
		List<FAQ> faqList = faqDao.selectAllFAQ(conn);
		close(conn);
		return faqList;
	} // selectAllFAQ() end

	public int insertFaq(FAQ faq) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = faqDao.insertFaq(conn, faq);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			e.printStackTrace();
		} finally {
			close(conn);
		}
		
		return result;
	} // insertFaq() end

	public List<FAQ> selectFindFaq(String searchContent) {
		Connection conn = getConnection();
		List<FAQ> faqList = faqDao.selectFindFaq(conn, searchContent);
		close(conn);
		return faqList;
	} // selectFindFaq() end

}
