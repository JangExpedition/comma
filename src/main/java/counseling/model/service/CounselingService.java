package counseling.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import common.Attachment;
import common.OX;
import counseling.model.dao.CounselingDao;
import counseling.model.dto.Counseling;
import counseling.model.dto.CounselingComment;
import counseling.model.dto.LikeCounseling;

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
		return selectOneCS(no, true);
	}

	public Counseling selectOneCS(int no, boolean hasRead) {
		Connection conn = getConnection();
		if(!hasRead) readCountUp(no, conn);
		Counseling counseling = counselingDao.selectOneCS(conn, no);
		List<Attachment> attachList = counselingDao.selectAttachments(conn, no);
		counseling.setAttachments(attachList);
		close(conn);
		return counseling;
	}
	
	public void readCountUp(int no, Connection conn) {
		try {
			int result = counselingDao.readCountUp(conn, no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
	}

	public int insertCsComment(CounselingComment csComment) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.insertCsComment(conn, csComment);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<CounselingComment> selectCsComment(int no) {
		Connection conn = getConnection();
		List<CounselingComment> csComments = counselingDao.selectCsComment(conn, no);
		close(conn);
		return csComments;
	}

	public int deleteCsComment(int csCommentNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = counselingDao.deleteCsComment(conn, csCommentNo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int updateCounseling(Counseling counseling) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.updateCounseling(conn, counseling);
			
			List<Attachment> counselingAttachList = counseling.getAttachments();
			if (!counselingAttachList.isEmpty()) {
				for (Attachment attach : counselingAttachList) {
					attach.setAttachNo(counseling.getNo());
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

	public Attachment selectOneAttachment(int attachNo) {
		Connection conn = getConnection();
		Attachment attach = counselingDao.selectOneAttachment(conn, attachNo);
		close(conn);
		return attach;
	}

	public int deleteAttachment(int attachNo) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.deleteAttachment(conn, attachNo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Attachment> selectAttachment(int no) {
		Connection conn = getConnection();
		List<Attachment> attachList = counselingDao.selectAttachments(conn, no);
		close(conn);
		return attachList;
	}

	public int deleteCounseling(int no) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.deleteCounseling(conn, no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int adoptComment(int no, OX choice) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.adoptComment(conn, no, choice);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int updateLikeCounseling(int csNo, String memNick) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.updateLikeCounseling(conn, csNo);
			
			result = counselingDao.insertLikeCounseling(conn, csNo, memNick);
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<LikeCounseling> selectAllLikeCs(int no) {
		Connection conn = getConnection();
		List<LikeCounseling> likeList = counselingDao.selectAllLikeCs(conn, no);
		close(conn);
		return likeList;
	}

	public int updateunlikeCounseling(int csNo, String memNick) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = counselingDao.updateunlikeCounseling(conn, csNo);
			
			result = counselingDao.deleteLikeCounseling(conn, csNo, memNick);
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

}
