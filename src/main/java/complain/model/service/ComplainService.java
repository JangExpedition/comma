package complain.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;

import complain.model.dao.ComplainDao;
import complain.model.dto.Complain;

public class ComplainService {

	private ComplainDao complainDao = new ComplainDao();
	
	public int insertComplain(Complain complain) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = complainDao.insertComplain(conn, complain);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	} // insertComplain() end

}
