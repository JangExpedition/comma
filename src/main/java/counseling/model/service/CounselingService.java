package counseling.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

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

	public List<Counseling> selectAllCounseling() {
		Connection conn = getConnection();
		List<Counseling> counselingList = counselingDao.selectAllCounseling(conn);
		close(conn);
		return counselingList;
	}

}
