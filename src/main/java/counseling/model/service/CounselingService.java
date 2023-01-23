package counseling.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import counseling.model.dao.CounselingDao;
import counseling.model.dto.Counseling;

public class CounselingService {
	private CounselingDao counselingDao = new CounselingDao();

	public int insertCounseling(Counseling counseling) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.insertCounseling(conn, counseling);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Counseling> selectAllCounseling(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Counseling> counselingList = counselingDao.selectAllCounseling(conn, param);
		close(conn);
		return counselingList;
	}

	public int getTotalCount() {
		Connection conn = getConnection();
		int result = counselingDao.getTotalCount(conn);
		close(conn);
		return result;
	}

}
