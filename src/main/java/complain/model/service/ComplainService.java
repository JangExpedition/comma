package complain.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

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

	public List<Complain> selectAllComplain() {
		Connection conn = getConnection();
		List<Complain> complainList = complainDao.selectAllComplain(conn);
		close(conn);
		return complainList;
	} // selectAllComplain() end

	public List<Complain> selectComplainFind(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Complain> complainList = complainDao.selectComplainFind(conn, param);
		close(conn);
		return complainList;
	} // selectComplainFind() end

}
