package counseling.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import common.Attachment;
import counseling.model.dao.CounselingDao;
import counseling.model.dto.Counseling;

public class CounselingService {
	private CounselingDao counselingDao = new CounselingDao();

	public int insertCounseling(Counseling counseling) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.insertCounseling(conn, counseling);
			
			int counselingNo = counselingDao.selectLastCSNo(conn); 
			
			
			List<Attachment> counselingAttachList = counseling.getAttachments();
			if (!counselingAttachList.isEmpty()) {
				for (Attachment attach : counselingAttachList) {
					attach.setAttachNo(counselingNo);
					result = counselingDao.insertAttachment(conn, attach);
				}
			}
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

	public List<Attachment> selectAllCSAttachments() {
		Connection conn = getConnection();
		List<Attachment> attachList = counselingDao.selectAllCSAttachments(conn);
		close(conn);
		return attachList;
	}

	public Counseling selectOneCS(int no) {
		Connection conn = getConnection();
		Counseling counseling = counselingDao.selectOneCS(conn, no);
		List<Attachment> attachList = counselingDao.selectAttachments(conn, no);
		counseling.setAttachments(attachList);
		close(conn);
		return counseling;
	}

}
