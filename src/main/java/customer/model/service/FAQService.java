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

}
