package diary.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import diary.model.dto.Diary;
import diary.model.exception.DiaryException;
import member.model.dto.Member;

public class DiaryDao {

	private Properties prop = new Properties();
	
	public DiaryDao() {
		String path = DiaryDao.class.getResource("/sql/diary/diary-query.properties").getPath();
		
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}		
	} // DiaryDao() end

	public int insertDiary(Connection conn, Diary diary) {
		int result = 0;
		String sql = prop.getProperty("insertDiary");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, diary.getWriter());
			pstmt.setString(2, diary.getContent());
			pstmt.setString(3, diary.getOriginalFilename());
			pstmt.setString(4, diary.getRenamedFilename());
			pstmt.setString(5, diary.getRegDate());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new DiaryException("일기장 등록오류!", e);
		}
		
		return result;
	}

	public List<Diary> selectAllDiary(Connection conn, Member member) {
		List<Diary> diaryList = new ArrayList<>();
		String sql  = prop.getProperty("selectAllDiary");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, member.getNickname());
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Diary diary = handleDiaryResultSet(rset);
					
					diaryList.add(diary);
				}
				
			}
		} catch (SQLException e) {
			throw new DiaryException("일기장 목록 가져오기 오류!", e);
		}
		return diaryList;
	}

	private Diary handleDiaryResultSet(ResultSet rset) throws SQLException {
		Diary diary = new Diary();
		
		diary.setNo(rset.getInt("no"));
		diary.setWriter(rset.getString("writer"));
		diary.setContent(rset.getString("content"));
		diary.setDesignNo(rset.getInt("design_no"));
		diary.setFontNo(rset.getInt("font_no"));
		diary.setOriginalFilename(rset.getString("original_filename"));
		diary.setRenamedFilename(rset.getString("renamed_filename"));
		diary.setRegDate(rset.getDate("reg_date").toString());
		return diary;
	}

	public Diary selectOneDiary(Connection conn, int diaryNo) {
		Diary diary = null;
		String sql  = prop.getProperty("selectOneDiary");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, diaryNo);
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					diary = handleDiaryResultSet(rset);
				}
				
			}
		} catch (SQLException e) {
			throw new DiaryException("일기장 조회오류!", e);
		}
		return diary;
	}

	public int deleteDiary(Connection conn, int diaryNo) {
		int result = 0;
		String sql = prop.getProperty("deleteDiary");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, diaryNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new DiaryException("일기장 삭제오류!", e);
		}
		
		return result;
	}

	public int upDateDiary(Connection conn, Diary diary) {
		int result = 0;
		String sql = prop.getProperty("upDateDiary");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, diary.getContent());
			pstmt.setString(2, diary.getOriginalFilename());
			pstmt.setString(3, diary.getRenamedFilename());
			pstmt.setInt(4, diary.getNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new DiaryException("일기장 삭제오류!", e);
		}
		
		return result;
	}
	
} // class end
