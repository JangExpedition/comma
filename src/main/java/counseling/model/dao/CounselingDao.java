package counseling.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import common.Attachment;
import common.Category;
import common.OX;
import counseling.model.dto.Counseling;
import counseling.model.dto.CounselingComment;
import counseling.model.exception.CounselingException;
import letter.model.exception.LetterException;
import member.model.dao.MemberDao;
import member.model.dto.Gender;

public class CounselingDao {
	
	Properties prop = new Properties();
	
	public CounselingDao() {
		String path = MemberDao.class.getResource("/sql/counseling/counseling-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int insertCounseling(Connection conn, Counseling counseling) {
		int result = 0;
		String sql = prop.getProperty("insertCounseling");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			//insert into counseling values(seq_cs_no.nextval, ?, ?, ?, default, default, ?, default, ?, ?, ?)
			pstmt.setString(1, counseling.getWriter());
			pstmt.setString(2, counseling.getTitle());
			pstmt.setString(3, counseling.getContent());
			pstmt.setString(4, counseling.getCategory().toString());
			pstmt.setString(5, counseling.getLimitGender().toString());
			pstmt.setInt(6, counseling.getLimitAge());
			pstmt.setString(7, counseling.getAnonymous().toString());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new CounselingException("고민게시글 등록오류!", e);
		}
		return result;
	}

	public List<Counseling> selectAllCounseling(Connection conn, Map<String, Object> param) {
		List<Counseling> counselingList = new ArrayList<>();
		String sql = prop.getProperty("selectAllCounseling");
		int page = (int) param.get("page");
		int limit = (int) param.get("limit");
		int start = (page-1)*limit+1;
		int end = page*limit;
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Counseling counseling = handleCounselingResultSet(rset);
					
					counselingList.add(counseling);
				}
			}
		} catch (SQLException e) {
			throw new CounselingException("게시글 불러오기 오류!", e);
		}
		return counselingList;
	}

	private Counseling handleCounselingResultSet(ResultSet rset) throws SQLException {
		Counseling counseling = new Counseling();
		counseling.setNo(rset.getInt("no"));
		counseling.setWriter(rset.getString("writer"));
		counseling.setTitle(rset.getString("title"));
		counseling.setContent(rset.getString("content"));
		counseling.setViews(rset.getInt("views"));
		counseling.setLike(rset.getInt("cs_like"));
		counseling.setCategory(Category.valueOf(rset.getString("category")));
		counseling.setRegDate(rset.getDate("reg_date"));
		counseling.setLimitGender(Gender.valueOf(rset.getString("limit_gender")));
		counseling.setLimitAge(rset.getInt("limit_age"));
		counseling.setAnonymous(OX.valueOf(rset.getString("anonymous")));
		return counseling;
	}

	public int getTotalCount(Connection conn) {
		int result = 0;
		String sql = prop.getProperty("getTotalCount");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					result = rset.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new CounselingException("게시물 총개수 조회 오류!", e);
		}
		return result;
	}

	public int selectLastCSNo(Connection conn) {
		int result = 0;
		String sql = prop.getProperty("selectLastCSNo");
		try(PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();) {
			if (rset.next())
				result = rset.getInt(1);
		} catch (SQLException e) {
			throw new CounselingException("게시글 번호 조회오류!", e);
		}
		return result;
	}

	public int insertAttachment(Connection conn, Attachment attach) {
		int result = 0;
		String sql = prop.getProperty("insertAttachment");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, attach.getAttachNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new LetterException("고민게시글 첨부파일 저장 오류", e);
		}
		return result;
	}

	public List<Attachment> selectAllCSAttachments(Connection conn) {
		List<Attachment> attachList = new ArrayList<>();
		String sql = prop.getProperty("selectAllCSAttachments");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Attachment attach = handleAttachmentResultSet(rset);
					
					attachList.add(attach);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return attachList;
	}

	private Attachment handleAttachmentResultSet(ResultSet rset) throws SQLException {
		Attachment attach = new Attachment();
		attach.setNo(rset.getInt("no"));
		attach.setAttachNo(rset.getInt("cs_no"));
		attach.setOriginalFilename(rset.getString("original_filename"));
		attach.setRenamedFilename(rset.getString("renamed_filename"));
		attach.setRegDate(rset.getDate("reg_date"));
		return attach;
	}

	public Counseling selectOneCS(Connection conn, int no) {
		Counseling counseling = null;
		String sql = prop.getProperty("selectOneCS");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					counseling = handleCounselingResultSet(rset);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return counseling;
	}

	public List<Attachment> selectAttachments(Connection conn, int no) {
		List<Attachment> attachList = new ArrayList<>();
		String sql = prop.getProperty("selectAttachments");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Attachment attach = handleAttachmentResultSet(rset);
					attachList.add(attach);
				}
			}
		} catch (SQLException e) {
			throw new CounselingException("게시글 첨부파일 조회오류!", e);
		}
		return attachList;
	}

	public int insertCsComment(Connection conn, CounselingComment csComment) {
		int result = 0;
		String sql = prop.getProperty("insertCsComment");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, csComment.getWriter());
			pstmt.setInt(2, csComment.getNo());
			pstmt.setString(3, csComment.getContent());
			pstmt.setString(4, csComment.getCommentLevel().toString());
			pstmt.setInt(5, csComment.getRefCommentNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new CounselingException("댓글등록 오류!", e);
		}
		return result;
	}

	public List<CounselingComment> selectCsComment(Connection conn, int no) {
		List<CounselingComment> csComments = new ArrayList<>();
		String sql = prop.getProperty("selectCsComment");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					CounselingComment csComment = new CounselingComment();
					csComment.setCommentNo(rset.getInt("no"));
					csComment.setNo(rset.getInt("cs_no"));
					csComment.setWriter(rset.getString("writer"));
					csComment.setContent(rset.getString("content"));
					csComment.setChoice(OX.valueOf(rset.getString("choice")));
					csComment.setCommentLevel(OX.valueOf(rset.getString("comment_level")));
					csComment.setRegDate(rset.getDate("reg_date"));
					csComment.setRefCommentNo(rset.getInt("ref_comment_no"));
					
					csComments.add(csComment);
				}
			}
		} catch (SQLException e) {
			throw new CounselingException("게시글 댓글 조회 오류!", e);
		}
		return csComments;
	}

	public int deleteCsComment(Connection conn, int csCommentNo) {
		int result = 0;
		String sql = prop.getProperty("deleteCsComment");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, csCommentNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CounselingException("댓글삭제 오류!", e);
		}
		return result;
	}

	public int readCountUp(Connection conn, int no) {
		int result = 0;
		String sql = prop.getProperty("readCountUp");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CounselingException("조회수 상승 오류!", e);
		}
		return result;
	}

	public int updateCounseling(Connection conn, Counseling counseling) {
		int result = 0;
		String sql = prop.getProperty("updateCounseling");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, counseling.getTitle());
			pstmt.setString(2, counseling.getContent());
			pstmt.setString(3, counseling.getCategory().toString());
			pstmt.setString(4, counseling.getLimitGender().toString());
			pstmt.setInt(5, counseling.getLimitAge());
			pstmt.setString(6, counseling.getAnonymous().toString());
			pstmt.setInt(7, counseling.getNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new CounselingException("게시물 수정 오류!", e);
		}
		return result;
	}

	public Attachment selectOneAttachment(Connection conn, int attachNo) {
		Attachment attach = null;
		String sql = prop.getProperty("selectOneAttachment");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, attachNo);
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					attach = handleAttachmentResultSet(rset);
				}
			}
		} catch (SQLException e) {
			throw new CounselingException("첨부파일 가져오기 오류!", e);
		}
		return attach;
	}

	public int deleteAttachment(Connection conn, int attachNo) {
		int result = 0;
		String sql = prop.getProperty("deleteAttachment");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, attachNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new CounselingException("첨부파일 삭제 오류!", e);
		}
		return result;
	}

	public int deleteCounseling(Connection conn, int no) {
		int result = 0;
		String sql = prop.getProperty("deleteCounseling");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new CounselingException("게시글 삭제 오류!", e);
		}
		return result;
	}

	public int adoptComment(Connection conn, int no, OX choice) {
		int result = 0;
		String sql = prop.getProperty("adoptComment");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, choice.toString());
			pstmt.setInt(2, no);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new CounselingException("댓글채택 오류!", e);
		}
		return result;
	}
}
