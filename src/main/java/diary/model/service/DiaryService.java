package diary.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import diary.model.dao.DiaryDao;
import diary.model.dto.Diary;
import member.model.dto.Member;

public class DiaryService {

	private DiaryDao diaryDao = new DiaryDao();

	public int insertDiary(Diary diary) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = diaryDao.insertDiary(conn, diary);
			commit(conn);
		} catch(Exception e){
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Diary> selectAllDiary(Member member) {
		Connection conn = getConnection();
		List<Diary> diaryList = diaryDao.selectAllDiary(conn, member);
		close(conn);
		return diaryList;
	}

	public Diary selectOneDiary(int diaryNo) {
		Connection conn = getConnection();
		Diary diary = diaryDao.selectOneDiary(conn, diaryNo);
		close(conn);
		return diary;
	}

	public int deleteDiary(int diaryNo) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = diaryDao.deleteDiary(conn, diaryNo);
			commit(conn);
		} catch(Exception e){
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int upDateDiary(Diary diary) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = diaryDao.upDateDiary(conn, diary);
			commit(conn);
		} catch(Exception e){
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
} // class end
