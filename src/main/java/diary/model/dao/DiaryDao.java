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
					Diary diary = new Diary();
					
					diary.setNo(rset.getInt("no"));
					diary.setWriter(rset.getString("writer"));
					diary.setContent(rset.getString("content"));
					diary.setDesignNo(rset.getInt("design_no"));
					diary.setFontNo(rset.getInt("font_no"));
					diary.setOriginalFilename(rset.getString("original_filename"));
					diary.setRenamedFilename(rset.getString("renamed_filename"));
					diary.setRegDate(rset.getDate("reg_date"));
					
					diaryList.add(diary);
				}
				
			}
		} catch (SQLException e) {
			throw new DiaryException("일기장 등록오류!", e);
		}
		return diaryList;
	}
	
} // class end
