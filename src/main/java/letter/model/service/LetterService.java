package letter.model.service;

import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import letter.model.dao.LetterDao;
import letter.model.dto.Letter;

public class LetterService {

	private LetterDao letterDao = new LetterDao();

	public List<Letter> selectAllLetter(String nickname) {
		Connection conn = getConnection();
		List<Letter> letterList = letterDao.selectAllLetter(conn, nickname);
		close(conn);
		return letterList;
	} // selectAllLetter() end

	public int insertLetter(Letter letter) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = letterDao.insertLetter(conn, letter);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	} // insertLetter() end
	
} // class end
